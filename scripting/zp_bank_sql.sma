#include <amxmodx>
#include <amxmisc>
#include <zombieplague>

#define USING_SQL
#if defined USING_SQL
	#include <sqlx>
#else
	#include <nvault>
#endif

stock const ZP_BANK_FMT[] = "^x04[ZP-BANK]^x01 %L"

new g_iAmmoPacks[33]
new g_iSessionMovement[33]
new g_szAuth[33][36]
new cvAnnounceTime
new cvBankMax

#if defined USING_SQL
new g_szSQLTable[64], Handle:g_hSQLTuple, g_szQuery[128]

LoadClient(id, szAuth[])
{
	formatex(g_szQuery, charsmax(g_szQuery),
		"SELECT amount FROM `%s` WHERE auth='%s'", 
		g_szSQLTable, szAuth)

	new cData[37]
	cData[0] = id
	copy(cData[1], charsmax(cData)-1, szAuth)
	
	SQL_ThreadQuery(g_hSQLTuple, "LoadClient_QueryHandler", g_szQuery, cData, strlen(cData[1]))
}

public LoadClient_QueryHandler(iFailState, Handle:hQuery, szError[], iErrnum, cData[], iSize, Float:fQueueTime)
{
	if(iFailState != TQUERY_SUCCESS)
	{
		log_amx("LoadClient(): SQL Error #%d - %s", iErrnum, szError)
		return
	}
	
	new id = cData[0]
	static szAuth[36]
	copy(szAuth, charsmax(szAuth), cData[1])
	
	new iAmmoPacks = 0
	if(SQL_NumResults(hQuery))
		iAmmoPacks = SQL_ReadResult(hQuery, 0)
		//SQL_QueryAndIgnore("INSERT INTO `%s` SET auth='%s'", g_szSQLTable, szAuth)
	
	g_iAmmoPacks[id] = iAmmoPacks
		
	SayText(id, id, ZP_BANK_FMT, id, "ZP_BANK_LOAD", iAmmoPacks, szAuth)
}

SaveClient(id, szAuth[])
{
	new iDifference = g_iSessionMovement[id]
	
	formatex(g_szQuery, charsmax(g_szQuery),
		"INSERT INTO `%s` SET auth='%s', amount=%d ON DUPLICATE KEY UPDATE amount=amount+(%d)",
		g_szSQLTable, szAuth, iDifference, iDifference)
	
	SQL_ThreadQuery(g_hSQLTuple, "SaveClient_QueryHandler", g_szQuery)
}

public SaveClient_QueryHandler(iFailState, Handle:hQuery, szError[], iErrnum, iData[], iSize, Float:fQueueTime)
{
	if(iFailState != TQUERY_SUCCESS)
		log_amx("SaveClient(): SQL Error #%d - %s", iErrnum, szError)
}

#else
new g_hVault

LoadClient(id, szAuth[])
{
	static szValue[32], iTimestamp
	new iValue = 0
	if(nvault_lookup(g_hVault, szAuth, szValue, charsmax(szValue), iTimestamp) && is_str_num(szValue))
		iValue = (g_iAmmoPacks[id] = str_to_num(szValue))
		
	SayText(id, id, ZP_BANK_FMT, id, "ZP_BANK_LOAD", iValue, szAuth)
}

SaveClient(id, szAuth[])
{
	static szValue[32]
	num_to_str(g_iAmmoPacks[id] + g_iSessionMovement[id], szValue, charsmax(szValue))
	
	nvault_set(g_hVault, szAuth, szValue)
}
#endif

public plugin_init()
{
	register_plugin("[ZP] Ammo Bank", "1.0", "danielkza")
	
	register_clcmd("say", "Command_Say")
	register_dictionary("zp_bank.txt")
	
	cvAnnounceTime	= register_cvar("zp_bank_announce_time", "60")
	cvBankMax		= register_cvar("zp_bank_max", "2000")
	
	Task_Announce()
	
#if defined USING_SQL
	new configsDir[64]
	get_configsdir(configsDir, 63)
	
	// Declare standard SQL cvars so we don't depend on admin.amxx
	register_cvar("amx_sql_host", "localhost")
	register_cvar("amx_sql_user", "serbu")
	register_cvar("amx_sql_pass", "parola-baza-de-date")
	register_cvar("amx_sql_db", "icp")
	register_cvar("amx_sql_type", "mysql")
	
	new cvTable = register_cvar("zp_bank_table", "zp_bank")
	// Execute SQL configs. You must put zp_bank_table in there
	server_cmd("exec %s/sql.cfg", configsDir)
	server_exec()
	
	get_pcvar_string(cvTable, g_szSQLTable, charsmax(g_szSQLTable))
	g_hSQLTuple = SQL_MakeStdTuple()
	
	new iError, szError[256]
	new Handle:hSQLConnection = SQL_Connect(g_hSQLTuple, iError, szError, charsmax(szError))
	if(hSQLConnection != Empty_Handle)
	{
		SQL_QueryAndIgnore(hSQLConnection,
			"CREATE TABLE IF NOT EXISTS `%s` (\
				auth VARCHAR(36) NOT NULL PRIMARY KEY, \
				amount INT(10) UNSIGNED NOT NULL DEFAULT 0 \
			) ENGINE=MyISAM DEFAULT CHARSET=utf8;",
			g_szSQLTable )
		
		SQL_FreeHandle(hSQLConnection)
	}
	else
		log_amx("plugin_init(): SQL Error #%d - %s", iError, szError)
	
#else
	g_hVault = nvault_open("zp_bank")
	if(g_hVault == INVALID_HANDLE)
		set_fail_state("Can't create/load vault 'zp_bank'")

#endif
}

public plugin_end()
{
	// Client's should have already been saved by now (client_disconnect is called before plugin_end).
	// But it costs nothing to be sure.
	new iPlayers[32], iNum
	get_players(iPlayers, iNum)
	
	new iPlayer
	for(new i=0; i < iNum;i++)
	{
		iPlayer = iPlayers[i]
		SaveClient(iPlayer, g_szAuth[iPlayer])
	}
	
#if defined USING_SQL
	SQL_FreeHandle(g_hSQLTuple)
	
#else
	nvault_close(g_hVault)
	
#endif
}

public client_putinserver(id)
{
	static szAuth[36]
	get_user_authid(id, szAuth, charsmax(szAuth))
	copy(g_szAuth[id], charsmax(g_szAuth[]), szAuth)
	
	LoadClient(id, szAuth)	
}

public client_disconnect(id)
{	
	SaveClient(id,  g_szAuth[id])
	
	g_szAuth[id][0] = 0
	g_iAmmoPacks[id] = 0
	g_iSessionMovement[id] = 0
}

new msgSayText = -1
stock bool:SayText(const receiver, sender, const msg[], any:...)
{
	if(msgSayText == -1)
		msgSayText = get_user_msgid("SayText")
		
	if(msgSayText)
	{	
		if(!sender)
			sender = receiver
		
		static buffer[512]
		vformat(buffer,charsmax(buffer),msg,4)
		
		if(receiver)
			message_begin(MSG_ONE_UNRELIABLE,msgSayText,_,receiver)
		else
			message_begin(MSG_BROADCAST,msgSayText)
		
		write_byte(sender)
		write_string(buffer)
		message_end()
		
		return true
	}
	
	return false
}


public Task_Announce()
{
	static iPlayers[32], iNum, iPlayer
	get_players(iPlayers, iNum)
	
	for(new i=0; i < iNum;i++)
	{
		iPlayer = iPlayers[i]
		SayText(iPlayer, iPlayer, ZP_BANK_FMT, LANG_PLAYER, "ZP_BANK_ANNOUNCE")
	}
	
	set_task(get_pcvar_float(cvAnnounceTime), "Task_Announce")
}

enum
{
	CMD_DEPOSIT = 1,
	CMD_WITHDRAW,
	CMD_INFO
}

public Command_Say(id)
{
	static szArgs[32]
	read_args(szArgs, charsmax(szArgs))
	remove_quotes(szArgs)
	
	static szArg1[32], szArg2[32]
	parse(szArgs, szArg1, charsmax(szArg1), szArg2, charsmax(szArg2))
	
	new iCommand = 0
	if(equali(szArg1, "/deposit"))
		iCommand = CMD_DEPOSIT
	else if(equali(szArg1, "/withdraw"))
		iCommand = CMD_WITHDRAW
	else if(equali(szArg1, "/bank"))
		iCommand = CMD_INFO
	
	if(iCommand)
	{
		if(iCommand == CMD_INFO)
			Command_Info(id)
		else
		{
			new iValue = str_to_num(szArg2)
			if(iValue <= 0)
				SayText(id, id, ZP_BANK_FMT, id, "ZP_BANK_INVALID_AMOUNT")
			
			else if(iCommand == CMD_DEPOSIT)
				Command_Deposit(id, iValue)
			else
				Command_Withdraw(id, iValue)
		}
		
		return PLUGIN_HANDLED
		
	}
	
	return PLUGIN_CONTINUE
}

Command_Info(id)
{
	SayText(id, id, ZP_BANK_FMT, id, "ZP_BANK_LOAD", g_iAmmoPacks[id] + g_iSessionMovement[id], g_szAuth[id])
}
	
Command_Deposit(id, iDeposit)
{
	new iCurrentAmount = zp_get_user_ammo_packs(id)
	if(!iCurrentAmount)
	{
		SayText(id, id, ZP_BANK_FMT, "ZP_BANK_NO_AMMO")
		return
	}
	
	if(iDeposit > iCurrentAmount)
		iDeposit = iCurrentAmount
	
	new iCurrent = g_iAmmoPacks[id] + g_iSessionMovement[id]
	new iSum = iCurrent + iDeposit
	new iBankMax = get_pcvar_num(cvBankMax)
	
	if(iBankMax && iSum > iBankMax)
	{
		iDeposit = iBankMax - iCurrent
		iSum = iBankMax
	
		SayText(id, id, ZP_BANK_FMT, id, "ZP_BANK_MAX", iBankMax)
	}
	
	if(iDeposit)
	{
		g_iSessionMovement[id] += iDeposit
		
		SayText(id, id, ZP_BANK_FMT, id, "ZP_BANK_DEPOSIT", iDeposit, iSum) //
		zp_set_user_ammo_packs(id, iCurrentAmount - iDeposit)
	}
}


Command_Withdraw(id, iWithdraw)
{
	new iDeposited = g_iAmmoPacks[id] + g_iSessionMovement[id]
	if(!iDeposited)
	{
		SayText(id, id, ZP_BANK_FMT, id, "ZP_BANK_EMPTY")
		return
	}
	
	if(iWithdraw > iDeposited)
		iWithdraw = iDeposited
	
	g_iSessionMovement[id] -= iWithdraw
	
	SayText(id, id, ZP_BANK_FMT, id, "ZP_BANK_WITHDRAW", iWithdraw, iDeposited - iWithdraw)
	zp_set_user_ammo_packs(id, zp_get_user_ammo_packs(id) + iWithdraw)
}