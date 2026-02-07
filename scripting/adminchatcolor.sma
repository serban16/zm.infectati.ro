/*
	AMX Mod X
	Admin Chat Plugin by faenix
	
	Replaces original chat plugin with one that displays green admin names
*/

#include <amxmodx>
#include <amxmisc>

new g_msgSayText
new funcType[32], funcCallType[32]
new normalChat[32] // handle recursiveness, to temporarily switch back to normal chat using /

public plugin_init() {
	register_plugin("Admin Chat", "1.2", "faenix")
	
	register_concmd("amx_say", "adminSay", ADMIN_CHAT, "<text> - Displays colored admin message to all")
	register_concmd("amx_chat", "adminChat", ADMIN_CHAT, "<text> - Displays colored message only to other admins")
	register_concmd("amx_psay", "adminPSay", ADMIN_CHAT, "<name or #userid> <text> - Send a message to only one user")
	register_concmd("amx_namegreen", "toggleGreen", ADMIN_CHAT, "<1 or 0> - Should regular chat of an admin be green")
	
	register_clcmd("say", "chatSay", 0, "@<text> - Displays colored admin message to all")
	register_clcmd("say_team", "chatTeamSay", 0, "@<text> - Diplays colored message only to other admins")
	
	register_cvar("sv_namegreen", "1")
	
	g_msgSayText = get_user_msgid("SayText")
}

public showAdminChat(id) {	
	new message[192], players[32], numPlayers, adminName[32]
	read_args(message, 191)
	remove_quotes(message)
	get_players(players, numPlayers, "c") // skip bots
	get_user_name(id, adminName, 31)
	
	new adminMsg[192]
	if (funcType[id] == 0) // called using say or amx_say
		format(adminMsg, 191, "^x01(ALL) ^x04%s ^x01: %s", adminName, message[funcCallType[id]])
	else // called using say_team or amx_chat
		format(adminMsg, 191, "^x01(ADMINS) ^x04%s ^x01: %s", adminName, message[funcCallType[id]])
	
	for (new i = 0; i <= numPlayers; i++) {
		if (!is_user_connected(players[i]))
			continue
		
		// if say_team or amx_chat, send only to other admins
		if (funcType[id] == 1 && !(get_user_flags(players[i]) & ADMIN_CHAT))
			continue

		message_begin(MSG_ONE, g_msgSayText, {0,0,0}, players[i])
		write_byte(players[i])
		write_string(adminMsg)
		message_end()
	}

	return PLUGIN_HANDLED_MAIN
}

public chatSay(id) {
	if (!access(id, ADMIN_CHAT)) return PLUGIN_CONTINUE
	
	if (normalChat[id]) {
		normalChat[id] = 0
		return PLUGIN_CONTINUE
	}
	
	funcCallType[id] = 1 // function called with say
	funcType[id] = 0 // tell function we are sending message to all
	
	new chat[1]
	read_argv(1, chat, 1)
	if (chat[0] == '@') {
		showAdminChat(id)
		return PLUGIN_HANDLED_MAIN
	}
		
	if (get_cvar_num("sv_namegreen")) {
		if (chat[0] == '/') {
			new message[192]
			read_args(message, 191)
			remove_quotes(message)
			normalChat[id] = 1
			client_cmd(id, "say %s", message[1]) // recursive
			return PLUGIN_HANDLED_MAIN
		}
		greenChat(id)
		return PLUGIN_HANDLED_MAIN
	}
	
	return PLUGIN_CONTINUE
}

public chatTeamSay(id) {
	if (!access(id, ADMIN_CHAT)) return PLUGIN_CONTINUE
	
	if (normalChat[id]) {
		normalChat[id] = 0
		return PLUGIN_CONTINUE
	}
	
	funcCallType[id] = 1 // function called with say
	funcType[id] = 1 // tell function we are sending message only to admins or team

	new chat[1]
	read_argv(1, chat, 1)
	if (chat[0] == '@') {
		showAdminChat(id)
		return PLUGIN_HANDLED_MAIN
	}
	
	if (get_cvar_num("sv_namegreen")) {
		if (chat[0] == '/') {
			new message[192]
			read_args(message, 191)
			remove_quotes(message)
			normalChat[id] = 1
			client_cmd(id, "say_team %s", message[1]) // recursive
			return PLUGIN_HANDLED_MAIN
		}
		greenChat(id)
		return PLUGIN_HANDLED_MAIN
	}
	return PLUGIN_CONTINUE
}

public adminSay(id, level, cid) {
	if (!cmd_access(id, level, cid, 1)) return PLUGIN_HANDLED_MAIN
	
	funcCallType[id] = 0 // function called with amx_say
	funcType[id] = 0 // tell function we are sending message to all
	showAdminChat(id)
	return PLUGIN_HANDLED_MAIN
}

public adminChat(id, level, cid) {
	if (!cmd_access(id, level, cid, 1)) return PLUGIN_HANDLED_MAIN
	
	funcCallType[id] = 0 // function called with amx_chat
	funcType[id] = 1 // tell function we are sending message only to admins
	showAdminChat(id)
	return PLUGIN_HANDLED_MAIN
}

public adminPSay(id, level, cid) {
	if (!cmd_access(id, level, cid, 3)) return PLUGIN_HANDLED_MAIN
	new name[32], length
	read_argv(1, name, 31)
	length = strlen(name) + 1
	
	new msgId = cmd_target(id, name, 0)
	if (!msgId) return PLUGIN_HANDLED_MAIN
	
	new message[192], msgToName[32], adminName[32]
	read_args(message, 191)
	format(message, 191, "%s", message[length])
	remove_quotes(message)
	get_user_name(msgId, msgToName, 31)
	get_user_name(id, adminName, 31)
	
	new showTo[192], showFrom[192]
	format(showTo, 191, "^x01(PRIVATE TO) ^x03%s ^x01: %s", msgToName, message)
	format(showFrom, 191, "^x01(PRIVATE FROM) ^x04%s ^x01: %s", adminName, message)
	
	message_begin(MSG_ONE, g_msgSayText, {0,0,0}, id)
	write_byte(id)
	write_string(showTo)
	message_end()
	
	message_begin(MSG_ONE, g_msgSayText, {0,0,0}, msgId)
	write_byte(msgId)
	write_string(showFrom)
	message_end()
	
	return PLUGIN_HANDLED_MAIN
}

public greenChat(id) {
	new adminMsg[192], message[192], players[32], numPlayers, adminName[32], adminTeam, isAlive
	read_args(message, 191)
	remove_quotes(message)
	if (strlen(message) == 0) return PLUGIN_HANDLED_MAIN
	get_players(players, numPlayers, "c") // skip bots
	get_user_name(id, adminName, 31)
	isAlive = is_user_alive(id)
	adminTeam = get_user_team(id)
	
	if (funcType[id]) { // Sent a team message
		if (adminTeam == 1)
			format(adminMsg, 191, "^x01(Terrorist)")
		else if (adminTeam == 2)
			format(adminMsg, 191, "^x01(Counter-Terrorist)")
	}
	
	if (!isAlive) {
		if (adminTeam == 0) {
			if (funcType[id])
				format(adminMsg, 191, "^x01(Spectator)%s", adminMsg)
			else
				format(adminMsg, 191, "^x01*SPEC*%s", adminMsg)
		} else
			format(adminMsg, 191, "^x01*DEAD*%s", adminMsg)
	}
	
	if (strlen(adminMsg) == 0)
		format(adminMsg, 191, "^x01^x04%s ^x01:  %s", adminName, message)
	else
		format(adminMsg, 191, "^x01%s ^x04%s ^x01:  %s", adminMsg, adminName, message)
	
	for (new i = 0; i <= numPlayers; i++) {
		if (!is_user_connected(players[i]))
			continue
		
		if (isAlive != is_user_alive(players[i]))
			continue
		if (funcType[id] == 1 && get_user_team(players[i]) != adminTeam)
			continue

		message_begin(MSG_ONE, g_msgSayText, {0,0,0}, players[i])
		write_byte(players[i])
		write_string(adminMsg)
		message_end()
	}
	return PLUGIN_HANDLED_MAIN
}

public toggleGreen(id, level, cid) {
	if (!cmd_access(id, level, cid, 1))
		return PLUGIN_HANDLED_MAIN
	new val[1], numval
	read_argv(1,val,1)
	numval = str_to_num(val)
	set_cvar_num("sv_namegreen", numval)
	
	if (numval == 0)
		console_print(id, "[AMXX] Green admin names have been turned off")
	else if (numval == 1)
		console_print(id, "[AMXX] Green admin names is now enabled")
		
	return PLUGIN_HANDLED_MAIN
}