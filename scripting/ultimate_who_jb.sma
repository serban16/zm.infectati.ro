#include <amxmodx>
#include <amxmisc>

#define PLUGIN			"ULTIMATE WHO"
#define VERSION			"1.1"
#define AUTHOR			"P.Of.Pw"

#define CharsMax(%1)		sizeof %1 - 1
#define time_shower		1.0

#define GROUPS_NAME 6
#define GROUPS_ACCESS 6

#define RRR			255
#define GGG			255
#define BBB			255
#define time_hud		12.0

#define motd_msg		"Admini Online"

#define who_meniu_ad_group_msg	"\y-=[Admini]=- \r-=[Online]=-^n"
#define who_meniu_admin_msg	"\y-=[Admini]=- \w-=[Online]=-^n^n"

#define who_meniu_ad_group_msg_bottom	"^n\wPt a iesi apasati \y0 \w sau \y5"
#define who_meniu_admin_msg_bottom	"^n\wPt a iesi apasati \r0 \w sau \r5"

#define	who_console_top		"=========== Admini Online ==========="
#define	who_console_bottom 	"================================"

new GroupNames[GROUPS_NAME][] = {
	"Owner",
	"Co-Owner",
	"Moderator",
	"Administrator",
	"Co-Administrator",
	"Mini-Admin"
}

new GroupFlags[GROUPS_ACCESS][] = {
	"abcdefghijklmnopqrstu",
	"bcdefghijklmnopqrstu",
	"cdefgjklmno",
	"cdefgijmn",
	"cdefijm",
	"cefij"
}

new GroupFlagsValue[GROUPS_NAME]

new who_type, who_typemeniu, who_typtable

public plugin_init() 
{
   
	register_plugin(PLUGIN, VERSION, AUTHOR)
   
	for(new p_of_pw = 0 ; p_of_pw < GROUPS_NAME ; p_of_pw++)
		GroupFlagsValue[p_of_pw] = read_flags(GroupFlags[p_of_pw])
   
	register_clcmd("say", "cmdSay")
	register_clcmd("say_team", "cmdSay")
	
	who_type	= register_cvar("cmd_who","3")
	who_typemeniu	= register_cvar("who_typemeniu","1")
	who_typtable	= register_cvar("who_typetable","2")
}

public cmdSay(id)
{
	new say[192]
	read_args(say,192)
	if(( containi(say, "who") != -1 || containi(say, "admin") != -1 || containi(say, "admins") != -1  || contain(say, "/who") != -1 || contain(say, "/admin") != -1 || contain(say, "/admins") != -1))
		set_task(time_shower,"cmdULTMWho",id)
	return PLUGIN_CONTINUE
}

public cmdULTMWho(id)
{
	switch(get_pcvar_num(who_type))
	{
		case 1: who_meniu(id)
		
		case 2: who_motd(id)
		
		case 3: who_table(id)
		
		case 4: who_hud(id)
		
		case 5: who_console(id)
		
	}
	return 0
}

who_meniu(id)
{
	switch(get_pcvar_num(who_typemeniu))
	{
		case 1: who_meniu_admin_groups(id)
		
		case 2: who_meniu_admin(id)
	}
	return 0
}
who_meniu_admin_groups(id)
{
	new sPlayers[32], iNum, iPlayer
	new sName[32]
	new szMenu[256], nLen, keys
	
	nLen = format(szMenu[nLen], 255, who_meniu_ad_group_msg)
	get_players(sPlayers, iNum, "ch")
   
	for(new p_of_pw = 0; p_of_pw < GROUPS_NAME ; p_of_pw++)
	{   
		nLen += format(szMenu[nLen], 255-nLen,"\r%s^n", GroupNames[p_of_pw])
     
		for(new a = 0; a < iNum ; a++)
		{   
			iPlayer = sPlayers[a]
         
			if(get_user_flags(iPlayer) == GroupFlagsValue[p_of_pw])
			{
				get_user_name(iPlayer, sName, sizeof sName - 1)
				nLen += format(szMenu[nLen], 255-nLen,"\w%s^n", sName)
			}   
		}
	}
	nLen += format(szMenu[nLen], 255-nLen, who_meniu_ad_group_msg_bottom)
	keys = (1<<0|1<<1|1<<2|1<<3|1<<4|1<<5|1<<6|1<<9)
	show_menu(id,keys,szMenu,-1)
	return 0
}

who_meniu_admin(id)
{
	new sPlayers[32], iNum, iPlayer
	new sName[32]
	new szMenu[256], nLen, keys
   
	nLen = format(szMenu[nLen], 255, who_meniu_admin_msg)
  
	get_players(sPlayers, iNum, "ch")
	for(new p_of_pw = 0; p_of_pw < GROUPS_NAME ; p_of_pw++)
	{
		for(new a = 0; a < iNum ; a++)
		{   
			iPlayer = sPlayers[a]
         
			if(get_user_flags(iPlayer) == GroupFlagsValue[p_of_pw])
			{
				get_user_name(iPlayer, sName, sizeof sName - 1)
				nLen += format(szMenu[nLen], 255-nLen,"\r%s^n", sName)
			}   
		}
	}
	nLen += format(szMenu[nLen], 255-nLen, who_meniu_admin_msg_bottom)
	keys = (1<<0|1<<1|1<<2|1<<3|1<<4|1<<5|1<<6|1<<9)
	show_menu(id,keys,szMenu,-1)
	return 0
}

who_motd(id)
{
	new sPlayers[32], iNum, iPlayer
	new sName[32], sBuffer[1024]
	new iLen
	
	iLen = formatex(sBuffer, sizeof sBuffer - 1, "<body bgcolor=#000000><font color=#7b68ee><pre>")
   
	get_players(sPlayers, iNum, "ch")
   
	for(new p_of_pw = 0; p_of_pw < GROUPS_NAME ; p_of_pw++)
	{   
		iLen += formatex(sBuffer[iLen], CharsMax(sBuffer) - iLen, "<center><h5><font color=^"red^">%s^n</font></h5></center>", GroupNames[p_of_pw])
     
		for(new a = 0; a < iNum ; a++)
		{   
			iPlayer = sPlayers[a]
         
			if(get_user_flags(iPlayer) == GroupFlagsValue[p_of_pw])
			{
				get_user_name(iPlayer, sName, sizeof sName - 1)
				iLen += formatex(sBuffer[iLen], CharsMax(sBuffer) - iLen, "<center>%s^n</center>", sName)
			}
		}		
	}
	show_motd(id, sBuffer, motd_msg)
	return 0

}

who_table(id)
{
	switch(get_pcvar_num(who_typtable))
	{
		case 1: table_style_one(id)
		
		case 2: table_style_two(id)
	}
	return 0
}
table_style_one(id)
{
	new sPlayers[32], iNum, iPlayer
	new sName[32], sBuffer[1024]
	new iLen
	
	iLen = formatex(sBuffer, sizeof sBuffer - 1, "<body bgcolor=#000000><font color=#7b68ee><pre>")
	iLen += formatex(sBuffer[iLen], CharsMax(sBuffer) - iLen, "<center><h3><b><font color=^"red^">NUME			-	ACCES</font></h3></b></center>")
	
	get_players(sPlayers, iNum, "ch")
   
	for(new p_of_pw = 0; p_of_pw < GROUPS_NAME ; p_of_pw++)
	{
		for(new a = 0; a < iNum ; a++)
		{   
			iPlayer = sPlayers[a]
		
			if(get_user_flags(iPlayer) == GroupFlagsValue[p_of_pw])
			{
				get_user_name(iPlayer, sName, sizeof sName - 1)
				iLen += formatex(sBuffer[iLen], CharsMax(sBuffer) - iLen, "<center><h4><font color=^"white^">%s		%s^n</font></h4></center>", sName, GroupNames[p_of_pw])
			}
		}		
	}
	show_motd(id, sBuffer, motd_msg)
	return 0
}
table_style_two(id)
{
	new sPlayers[32], iNum, iPlayer
	new sName[32], sBuffer[1024]
	new iLen
	
	iLen = formatex(sBuffer, sizeof sBuffer - 1, "<body bgcolor=#000000><font color=#7b68ee><pre>")
	
	iLen += formatex(sBuffer[iLen], CharsMax(sBuffer) - iLen, "<html><head><title>a</title></head>")
	iLen += formatex(sBuffer[iLen], CharsMax(sBuffer) - iLen, "<br><br><center><body><table border>")
	iLen += formatex(sBuffer[iLen], CharsMax(sBuffer) - iLen, "<tr><td><h3><b><font color=^"red^">NUME</td><td></h3></b> <h3><b><font color=^"red^">ACCES</td></h3></font></b></center>")
	
	get_players(sPlayers, iNum, "ch")
   
	for(new p_of_pw = 0; p_of_pw < GROUPS_NAME ; p_of_pw++)
	{
		for(new a = 0; a < iNum ; a++)
		{   
			iPlayer = sPlayers[a]
		
			if(get_user_flags(iPlayer) == GroupFlagsValue[p_of_pw])
			{
				get_user_name(iPlayer, sName, sizeof sName - 1)
				iLen += formatex(sBuffer[iLen], CharsMax(sBuffer) - iLen, "<center><tr><td><h4><b><font color=^"white^">%s<td></b></h4> <h4><b><font color=^"white^">%s </td></h4></font></b></center>", sName, GroupNames[p_of_pw])
			}
		}		
	}
	iLen += formatex(sBuffer[iLen], CharsMax(sBuffer) - iLen, "</table></body></html>")
	show_motd(id, sBuffer, motd_msg)
	return 0
}

who_hud(id)
{
	new sPlayers[32], iNum, iPlayer
	new sName[32], sBuffer[1024]
	new iLen
	
	get_players(sPlayers, iNum, "ch")
   
	for(new p_of_pw = 0; p_of_pw < GROUPS_NAME ; p_of_pw++)
	{   
		iLen += formatex(sBuffer[iLen], CharsMax(sBuffer) - iLen, "=== %s ===^n", GroupNames[p_of_pw])
     
		for(new a = 0; a < iNum ; a++)
		{   
			iPlayer = sPlayers[a]
         
			if(get_user_flags(iPlayer) == GroupFlagsValue[p_of_pw])
			{
				get_user_name(iPlayer, sName, sizeof sName - 1)
				iLen += formatex(sBuffer[iLen], CharsMax(sBuffer) - iLen, "%s^n", sName)
			}
		}		
	}
	set_hudmessage(RRR, GGG, BBB, 0.02, 0.24, 0, 6.0, time_hud)
	show_hudmessage(id, sBuffer)
	return 0
}

who_console(id)
{
	new sPlayers[32], iNum, iPlayer
	new sName[32]

	get_players(sPlayers, iNum)
	console_print(id, who_console_top)
	for(new p_of_pw = 0; p_of_pw < GROUPS_NAME; p_of_pw++) 
	{
		for(new a = 0; a < iNum ; a++)
		{
			
			iPlayer = sPlayers[a]
			get_user_name(iPlayer, sName, sizeof sName - 1)
			if(get_user_flags(iPlayer) == GroupFlagsValue[p_of_pw]) 
				console_print(id, "= %d = %s : %s", p_of_pw+1, GroupNames[p_of_pw], sName)
			
			
		}
	}
	console_print(id, who_console_bottom)
	return 0
}