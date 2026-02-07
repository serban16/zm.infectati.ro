/*  AMXModX Script
*
*   Title:    Restrict Names
*   Author:   Brad Jones
*
*   Current Version:   1.2
*   Release Date:      2005-09-27
*
*   This plugin will check a player's name when they enter the server and also if 
*   they change their name mid-game.  If the player's name matches a regex restriction
*   the player will be punished as per the cvar, 'namerest_punishment' or per a 
*   regex-specific punishment can be acheived by placing it in the restrictnames.ini 
*   file as in: "regex" "reason" "punishmentType" "punishmentOption".  The "punishmentOption"
*   field is only needed if "punishmentType" is "0" (rename) or "2" (ban).  The value of 
*   "punishmentOption" should be the new name for a player for a rename punishment or the
*   ban length for a ban punishment.
*
*   Much appreciated help and some code came from JTP10181.
*
*
*   CVARS:
*
*	  restnames_check_names <0|1> (default: 1)
*   A value of 1 will turn this plugin on. A value of 0 will turn it off.
*
*   restnames_amxban <0|1> (default: 0)
*   Indicates method of banning players.
*   0: ban via 'banid'
*   1: ban via 'amx_ban' (use only if you have the amx_bans plugin installed)
*
*   restnames_check_bots <0|1> (default: 1)
*   A value of 1 will check bots for name violations. A value of 0 will not check bots.
*
*   restnames_log_cnt <0..11> (default: 2)
*   Indicates the number of previous month's logs to retain. The current month is always retained.
*
*   CONFIG FILE (.\configs\restrictnames.ini):
*
*   Each line in the file must be in the following format:
*   "regex" "reason" "punishmentType" "punishmentOption"
*   
*   "regex" is the regex phrase that detects a restricted name.
*   "reason" is the text that is displayed to the user to indicate why they're being punished.
*   "punishmentType" is the method used to punish a player
*      0 = rename to custom name indicated by punishmentOption
*      1 = kick the player
*      2 = ban the player
*   "punishmentOption" is only used if the punishment type is rename or ban.
*      - if punishmentType is 0 (rename), punishmentOption should be the new name for the player (if not provided, the player will be kicked)
*      - if punishmentType is 2 (ban), punishmentOption should be the ban length in minutes (0 is permanent and the ban is also permanent if not provided)
*
*
*   VERSIONS:
*
*   2005-09-30   1.2a  - Fixed compilation error on 1.01 and lower versions of AMXX.  Thanks to "ohswildcats".
*                      - Added option to not check immune players for name violations.  Thanks to "Hawk552".
*
*   2005-09-27   1.2   - Added log pruning functionality. New CVAR "restnames_log_cnt" indicates how many months
*                        of previous logs to keep. Only the most recent month to be deleted will be.
*                      - Fixed issue where a player would be warned of impending punishment and then leave the 
*                        server before punishment commenced.  Players are no longer warned.  Thanks to JTP10181
*                        for discovering this issue.
*
*   2005-09-06   1.1   - Will now ban when "restnames_amxban" is set to 1.
*                      - Separate log file is being created in the .\logs directory detailing punishments
*                        with more information than before. Punishments were previously being logged in 
*                        the amxx log file.
*                      - Will not check name if the user is HLTV.
*                      - CVAR (restnames_check_bots) added to indicate whether to check bots for name violations.
*                      - Removed CVARs "restnames_ban_time" and "restnames_default_name".
*                      - All RENAME punishments now have to have the new name provided as
*                        the "punishmentOption" segment in the config file.  If not provided,
*                        the player will be kicked.
*                      - All BAN punishments now need to provide the ban length as 
*                        the "punishmentOption" segment in the config file.  If not provided,
*                        the ban is permanent.
*
*   2005-08-29   1.0   Initial release.
*/


/*-----------------------------------------------------------
COMPILER OPTIONS
-----------------------------------------------------------*/
//-----------------------------------------------------------
// Set the flag that indicates if a player has immunity from
// name violation checking, when restnames_immunity is 1.
#define IMMUNITY ADMIN_IMMUNITY
//-----------------------------------------------------------


#include <amxmodx>
#include <amxmisc>
#include <amxconst>
#include <fun>
#include <regex>

new const PLUGIN[]   = "Restrict Names"
new const VERSION[]  = "1.2a"
new const AUTHOR[]   = "Brad Jones"

new const FILESTEM[] = "restrictnames"

// max number of words in word list
#define MAX_PHRASE 63
// max length of each phrase
#define MAX_PHRASE_LEN 96
// max length of each reason
#define MAX_REASON_LEN 128
// max length of each reason
#define MAX_PUNISH_LEN 6
// max length of new name (if punishment is rename)
#define MAX_NAME_LEN 28
// max length of each config line
#define MAX_CONFIG_LINE_LEN 96 + 128 + 6 + 28 + 2 // MAX_PHRASE_LEN + MAX_REASON_LEN + MAX_PUNISH_LEN + MAX_NAME_LEN + 3 spaces (between phrase/reason, reason/punish, punish/newname)

new phrase[MAX_PHRASE][MAX_PHRASE_LEN + 1]
new reason[MAX_PHRASE][MAX_REASON_LEN + 1]     // there should be one 'player friendly' reason for each regex
new punish[MAX_PHRASE] = { -1, ... }           // each regex has it's own punishment
new punishOption[MAX_PHRASE][MAX_NAME_LEN + 1] // 'rename' punishments should supply a base name for the player

new phraseNum = 0

new g_cLogFile[32]

new bool:g_aPunishQueue[33]	// keeps track of punishments so announcement isn't made multiple times

public plugin_init()
{
	register_plugin(PLUGIN, VERSION, AUTHOR)
	
	register_cvar("restnames_debug", "-1")
	register_cvar("restnames_version", VERSION, FCVAR_SERVER|FCVAR_SPONLY)

	register_dictionary("restrictnames.txt")
	
	register_cvar("restnames_check_names", "1") // 0=don't check names, 1=check names
	register_cvar("restnames_amxban", "0")      // 0=ban with 'banid', 1=ban with 'amx_ban'
	register_cvar("restnames_check_bots", "1")	// 0=don't check bots, 1=check bots for name violations
	register_cvar("restnames_log_cnt", "2")     // must be set between 1 and 11. indicates how many previous months of log files to retain
	register_cvar("restnames_immunity", "0")    // 0=all players are checked for violations, 1=everyone except admins
	
//BUGGY:	register_concmd("restnames_reloadconfig", "read_config", ADMIN_LEVEL_A, "- reloads the name restriction phrases")

	maintain_log_files()
	read_config()
}

public client_putinserver(id)
{
	g_aPunishQueue[id] = false	
	set_task(30.0,"delayed__client_putinserver",id)
}        

public delayed__client_putinserver(id)
{
	new playerName[32]
	get_user_name(id, playerName, 31)
	return validate_name(id, playerName)
}

public client_infochanged(id)
{
	new playerName[32]
	get_user_info(id, "name", playerName, 31)

	if (get_user_team(id) > 0) validate_name(id, playerName)

	return PLUGIN_CONTINUE
} 

public read_config()
{
	// Reset the global variables to make sure we're reading clean.
	for (new phraseIdx = 0; phraseIdx < MAX_PHRASE; phraseIdx++ )
	{
		copy(phrase[phraseIdx], MAX_PHRASE_LEN, "")
		copy(reason[phraseIdx], MAX_REASON_LEN, "")
		copy(punishOption[phraseIdx], MAX_NAME_LEN, "")
		punish[phraseIdx] = -1
	}
	
	new iLen, line = 0
	new filename[128]

	get_configsdir(filename,128)
	format(filename, 127, "%s/%s.ini", filename, FILESTEM)

	if (file_exists(filename))
	{
		// Loop through file, reading in each line, stop if we run
		// out of space in our phrase list or the file is empty

		new configLine[MAX_CONFIG_LINE_LEN]
		new punishment[MAX_PUNISH_LEN]
//		new punishOption[MAX_NAME_LEN]

		while ((phraseNum < MAX_PHRASE) && (line = read_file(filename, line, configLine, MAX_CONFIG_LINE_LEN, iLen)))
		{
			if (iLen > 0)
			{
				parse(configLine, phrase[phraseNum], MAX_PHRASE_LEN - 1, reason[phraseNum], MAX_REASON_LEN, punishment, MAX_PUNISH_LEN, punishOption[phraseNum], MAX_NAME_LEN)

				punish[phraseNum] = str_to_num(punishment)

				if (punish[phraseNum] == 0 && strlen(punishOption[phraseNum]) == 0)
					punish[phraseNum] = 1 

				++phraseNum
			}			
		}
		log_amx("%L", LANG_SERVER, "CONFIG_LOADED", phraseNum, filename)
	}
	else
	{
		log_amx("%L", LANG_SERVER, "CONFIG_LOAD_ERROR", filename)
	}
}

public maintain_log_files()
{
	// get the current month number
	new cCurrentMonth[3]
	get_time("%m", cCurrentMonth, 2)
	
	// set the current log file
	format(g_cLogFile, 31, "%s%s.log", FILESTEM, cCurrentMonth, 31)
	
	// delete old log file
	new iPrevMonthsToKeep = min(max(get_cvar_num("restnames_log_cnt"), 0), 11) // must keep between 0 and 11 months
	if (iPrevMonthsToKeep < 11) // always retain the current month
	{
		new iCurrentMonth = str_to_num(cCurrentMonth)
		new iMonthToDelete = constraint_offset(1, 12, iCurrentMonth, (-iPrevMonthsToKeep - 1))
		new cLogToDelete[128]
		get_localinfo("amxx_logdir", cLogToDelete, 127)
		
		if (iMonthToDelete < 10)
			format(cLogToDelete, 127, "%s/%s0%d.log", cLogToDelete, FILESTEM, iMonthToDelete)
		else
			format(cLogToDelete, 127, "%s/%s%d.log", cLogToDelete, FILESTEM, iMonthToDelete)

		if (file_exists(cLogToDelete)) delete_file(cLogToDelete)
	}
}

public validate_name(id, playerName[])
{
	if (get_cvar_num("restnames_check_names") && !is_user_hltv(id))
	{
		if (get_cvar_num("restnames_immunity") && get_user_flags(id) & IMMUNITY)
			return true
		
		if (is_user_bot(id) && !get_cvar_num("restnames_check_bots"))
			return true
		
		if (g_aPunishQueue[id])
			return false

		new phraseIdx
		new matchingSegment[32]
		if (is_name_bad(playerName, phraseIdx, matchingSegment))
		{
			g_aPunishQueue[id] = true

			// Punish the player.
			switch(punish[phraseIdx])
			{
				case 0: rename_player(id, reason[phraseIdx], punishOption[phraseIdx])
				case 1: kick_player(id, reason[phraseIdx])
				case 2: ban_player(id, reason[phraseIdx], punishOption[phraseIdx])
			}

			// If the player was renamed, give personal notification of reason.
			if (punish[phraseIdx] == 0)
			{
				set_hudmessage(255,255,110,-1.0,0.35,0,3.0,5.0,0.1,0.1, 2)
				show_hudmessage(id, "%L", id, "RENAME_NOTIFY_PLAYER", reason[phraseIdx])
			}
			
			// Log the transgression.
			switch (punish[phraseIdx])
			{
				case 0: log_to_file(g_cLogFile, "%L", LANG_SERVER, "RENAME_LOG_ENTRY", playerName, matchingSegment, phraseIdx + 1, phrase[phraseIdx], reason[phraseIdx])
				case 1: log_to_file(g_cLogFile, "%L", LANG_SERVER, "KICK_LOG_ENTRY", playerName, matchingSegment, phraseIdx + 1, phrase[phraseIdx], reason[phraseIdx])
				case 2: log_to_file(g_cLogFile, "%L", LANG_SERVER, "BAN_LOG_ENTRY", playerName, matchingSegment, phraseIdx + 1, phrase[phraseIdx], reason[phraseIdx])
			}

			// Notify the masses that there was a scofflaw in our midst.
			switch (punish[phraseIdx])
			{
				case 0: client_print(0, print_chat, "%L", LANG_PLAYER, "RENAME_NOTIFY_ALL", playerName, reason[phraseIdx])
				case 1: client_print(0, print_chat, "%L", LANG_PLAYER, "KICK_NOTIFY_ALL", playerName, reason[phraseIdx])
				case 2: client_print(0, print_chat, "%L", LANG_PLAYER, "BAN_NOTIFY_ALL", playerName, reason[phraseIdx])
			}
			
			g_aPunishQueue[id] = false
			
			return false
		}
	}
	return true
}

public is_name_bad(const playerName[], &phraseIdx, matchingSegment[])
{
	new Regex:regexid
	new num, error[5], lplayerName[32]

	copy(lplayerName, 31, playerName)
	strtolower(lplayerName)

	for (new i = 0 ; i < phraseNum ; i++)
	{
		regexid = regex_match(lplayerName, phrase[i], num, error, 4)
		if ( (regexid >= REGEX_OK) )
		{
			regex_substr(regexid, 0, matchingSegment, 31)
			phraseIdx = i
			regex_free(regexid)
			return true
		}
	}
	return false
}

public rename_player(id, reasonMatch[], newName[])
{
	new name[33]
	format(name, 32, "%s (%i)", newName, id)

	if (is_user_alive(id))
	//		client_cmd(id, "name ^"%s^"", name)
		set_user_info(id, "name", name)
	else if (is_user_connected(id))
	{
		spawn(id)
	//		client_cmd(id, "name ^"%s^"", name)
		set_user_info(id, "name", name)
		user_kill(id, 1)
	}
}

public kick_player(id, reasonMatch[])
{
	new userid = get_user_userid(id)
	server_cmd("kick #%d %L", userid, id, "KICK_REASON", reasonMatch)
}

public ban_player(id, reasonMatch[], banLengthStr[])
{
	new userid = get_user_userid(id)
	new banLength = str_to_num(banLengthStr)
	new banReason[256]

	format(banReason, 255, "%L", id, "BAN_REASON", reasonMatch)

	if(!get_cvar_num("restnames_amxban"))
	{
		server_cmd("banid %i #%i;writeid", banLength, userid)
		server_cmd("kick #%i %s", userid, banReason)
	}
	else
	{
		new authid[32]
		get_user_authid(id, authid, 31)
		server_cmd("amx_ban %i %s %s", banLength, authid, banReason)
	}
}

#if !defined AMXX_VERSION_NUM
public abs(x)
{
   return x>0 ? x : -x;
} 

public constraint_offset(low, high, seed, offset)
{
   new numElements = high - low + 1;
   offset += seed - low;
   
   if (offset >= 0)
      return low + (offset % numElements);
   else
      return high - (abs(offset) % numElements) + 1;
   return 0;    // Makes the compiler happy -_-
}
#endif