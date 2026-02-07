#include <amxmodx>
#include <amxmisc>
#include <nvault>
#include <zombie_plague_advance>
#include <sqlx>

#define CMDTARGET_OBEY_IMMUNITY (1<<0)
#define CMDTARGET_ALLOW_SELF	(1<<1)
#define CMDTARGET_ONLY_ALIVE	(1<<2)
#define CMDTARGET_NO_BOTS		(1<<3)

#define FLAG_A (1<<0)
#define FLAG_B (1<<1)
#define FLAG_C (1<<2)
#define FLAG_D (1<<3)
#define FLAG_E (1<<4)
#define FLAG_K (1<<10)

new amx_password_field_string[30]
new g_user_privileges[33]
enum _:database_items
{
	auth[50],
	password[50],
	accessflags,
	flags
}
new bank_database[database_items]
new Array:database_holder

enum pcvar
{
	enable = 0,
	cap,
	cap2,
	cap3,
	cap4,
	cap5,
	start,
	advertise,
	deposit,
	withdraw,
	account,
	savetype,
	bot
}

new gvault, g_msgSayText, pcvars[pcvar], bankstorage[33]

public plugin_init()
{
	
	register_plugin("[ZP] Sub Plugin: Ultimate Bank", "2.3", "93()|29!/<, Random1, Serbu");
	register_dictionary("zp_bank.txt")
	get_cvar_string("amx_password_field", amx_password_field_string, charsmax(amx_password_field_string))
	
	gvault = nvault_open("Zombie Bank Ultimate");
	g_msgSayText = get_user_msgid("SayText")
	register_concmd("amx_reloadbank", "reload_bank", ADMIN_CFG)
	register_concmd("amx_giveeuro", "CmdGiveAP", FLAG_E, "- amx_giveeuro <nume> <cantitate>");
	register_concmd("amx_removeeuro", "CmdRemoveAP", FLAG_E, "- amx_removeeuro <nume> <cantitate>");
	
	pcvars[enable] =	register_cvar("zp_bank", "1");
	pcvars[cap] =		register_cvar("zp_bank_limit", "500");
	pcvars[cap2] =		register_cvar("zp_bank_admin_limit", "1000");
	pcvars[cap3] =		register_cvar("zp_bank_admin2_limit", "1500");
	pcvars[cap4] =		register_cvar("zp_bank_admin3_limit", "2000");
	pcvars[cap5] =		register_cvar("zp_bank_admin4_limit", "2500");
	pcvars[start] =		register_cvar("zp_bank_blockstart", "0");
	pcvars[advertise] =	register_cvar("zp_bank_ad_delay", "0")
	pcvars[deposit] =	register_cvar("zp_bank_deposit", "1")
	pcvars[withdraw] =	register_cvar("zp_bank_withdraw", "1")
	pcvars[account] =	register_cvar("zp_bank_account", "1")
	pcvars[savetype] =	register_cvar("zp_bank_save_type", "1")
	pcvars[bot] =		register_cvar("zp_bank_bot_support", "1")
	
	if (get_pcvar_num(pcvars[cap]) > 2147483646)
	{
		set_pcvar_num(pcvars[cap], 2147483646);
		server_print("[%L] %L", LANG_PLAYER, "BANK_PREFIX", LANG_PLAYER, "BANK_LIMIT");
	}
	else if (get_pcvar_num(pcvars[cap]) < 1)
		set_pcvar_num(pcvars[cap], 1);
		
	if (get_pcvar_num(pcvars[cap2]) > 2147483646)
	{
		set_pcvar_num(pcvars[cap2], 2147483646);
		server_print("[%L] %L", LANG_PLAYER, "BANK_PREFIX", LANG_PLAYER, "BANK_LIMIT");
	}
	else if (get_pcvar_num(pcvars[cap2]) < 1)
		set_pcvar_num(pcvars[cap2], 1);
		
	if (get_pcvar_num(pcvars[cap3]) > 2147483646)
	{
		set_pcvar_num(pcvars[cap3], 2147483646);
		server_print("[%L] %L", LANG_PLAYER, "BANK_PREFIX", LANG_PLAYER, "BANK_LIMIT");
	}
	else if (get_pcvar_num(pcvars[cap3]) < 1)
		set_pcvar_num(pcvars[cap3], 1);
	
	if (get_pcvar_num(pcvars[cap4]) > 2147483646)
	{
		set_pcvar_num(pcvars[cap4], 2147483646);
		server_print("[%L] %L", LANG_PLAYER, "BANK_PREFIX", LANG_PLAYER, "BANK_LIMIT");
	}
	else if (get_pcvar_num(pcvars[cap4]) < 1)
		set_pcvar_num(pcvars[cap4], 1);
	
	if (get_pcvar_num(pcvars[cap5]) > 2147483646)
	{
		set_pcvar_num(pcvars[cap5], 2147483646);
		server_print("[%L] %L", LANG_PLAYER, "BANK_PREFIX", LANG_PLAYER, "BANK_LIMIT");
	}
	else if (get_pcvar_num(pcvars[cap5]) < 1)
		set_pcvar_num(pcvars[cap5], 1);
	
	register_clcmd("say", "handle_say");
	register_clcmd("say_team", "handle_say");
	register_cvar("zm_bank_sql_table", "tz_members")

	register_cvar("amx_sql_host", "127.0.0.1")
	register_cvar("amx_sql_user", "serbu")
	register_cvar("amx_sql_pass", "parola-baza-de-date")
	register_cvar("amx_sql_db", "icp")
	register_cvar("amx_sql_type", "mysql")
	
	reload_bank()
	register_logevent( "RoundStart", 2, "1=Round_Start" );
}

public plugin_cfg()
{
	// Plugin is disabled
	if (!get_pcvar_num(pcvars[enable]))
		return;
	
	// Get configs dir
	new cfgdir[32]
	get_configsdir(cfgdir, charsmax(cfgdir))
	
	// Execute config file (zp_rewards.cfg)
	server_cmd("exec %s/zp_bank.cfg", cfgdir)
}

public reload_bank() {
	
	if(database_holder) ArrayDestroy(database_holder)
	database_holder = ArrayCreate(database_items)
	
	new table[32], error[128], type[12], errno
	
	new Handle:info = SQL_MakeStdTuple()
	new Handle:sql = SQL_Connect(info, errno, error, 127)
	
	get_cvar_string("zm_bank_sql_table", table, 31)
	
	SQL_GetAffinity(type, 11)
	
	if (sql == Empty_Handle)
	{
		server_print("[AMXX] %L", LANG_SERVER, "SQL_CANT_CON", error)
		return PLUGIN_HANDLED
	}

	new Handle:query
	
	if (equali(type, "sqlite"))
	{
		if (!sqlite_TableExists(sql, table))
		{
			SQL_QueryAndIgnore(sql, "CREATE TABLE %s ( auth TEXT NOT NULL DEFAULT '', password TEXT NOT NULL DEFAULT '', access_zm_bank TEXT NOT NULL DEFAULT '', flags TEXT NOT NULL DEFAULT '' )", table)
		}

		query = SQL_PrepareQuery(sql, "SELECT auth, password, access_zm_bank, flags FROM %s", table)
	} else {
		SQL_QueryAndIgnore(sql, "CREATE TABLE IF NOT EXISTS `%s` ( `auth` VARCHAR( 32 ) NOT NULL, `password` VARCHAR( 32 ) NOT NULL, `access_zm_bank` VARCHAR( 32 ) NOT NULL, `flags` VARCHAR( 32 ) NOT NULL ) COMMENT = 'AMX Mod X Admins'", table)
		query = SQL_PrepareQuery(sql,"SELECT `auth`,`password`,`access_zm_bank`,`flags` FROM `%s`", table)
	}

	if (!SQL_Execute(query))
	{
		SQL_QueryError(query, error, 127)
		server_print("[AMXX] %L", LANG_SERVER, "SQL_CANT_LOAD_ADMINS", error)
	} else if (!SQL_NumResults(query)) {
		server_print("[AMXX] %L", LANG_SERVER, "NO_ADMINS")
	} else {
		
		
		/** do this incase people change the query order and forget to modify below */
		new qcolAuth = SQL_FieldNameToNum(query, "auth")
		new qcolPass = SQL_FieldNameToNum(query, "password")
		new qcolAccess = SQL_FieldNameToNum(query, "access_zm_bank")
		new qcolFlags = SQL_FieldNameToNum(query, "flags")
		
		new AuthData[44];
		new Password[44];
		new Access[32];
		new Flags[32];
		
		while (SQL_MoreResults(query))
		{
			SQL_ReadResult(query, qcolAuth, AuthData, sizeof(AuthData)-1);
			SQL_ReadResult(query, qcolPass, Password, sizeof(Password)-1);
			SQL_ReadResult(query, qcolAccess, Access, sizeof(Access)-1);
			SQL_ReadResult(query, qcolFlags, Flags, sizeof(Flags)-1);
			
			
			bank_database[auth] = AuthData
			bank_database[password] = Password
			bank_database[accessflags] = read_flags(Access)
			bank_database[flags] = read_flags(Flags)
			
			ArrayPushArray(database_holder, bank_database)
	
			SQL_NextRow(query)
		}
	
		SQL_FreeHandle(query)
		SQL_FreeHandle(sql)
		SQL_FreeHandle(info)
	}
	
	return PLUGIN_HANDLED
}

public set_flags(id) {
	
	static ip[31], name[51], index, client_password[30], size, log_flags[11]
	get_user_ip(id, ip, 30, 1)
	get_user_name(id, name, 50)
	get_user_info(id, amx_password_field_string, client_password, charsmax(client_password))
	
	g_user_privileges[id] = 0
	size = ArraySize(database_holder)
	
	for(index=0; index < size ; index++) {
		ArrayGetArray(database_holder, index, bank_database)
		if(bank_database[flags] & FLAG_D) {
			if(equal(ip, bank_database[auth])) {
				if(!(bank_database[flags] & FLAG_E)) {
					if(equal(client_password, bank_database[password]))
						g_user_privileges[id] = bank_database[accessflags]
					else if(bank_database[flags] & FLAG_A) {
						server_cmd("kick #%d ^"%L^"", get_user_userid(id), id, "BANK_PAS")
						break
					}
				}
				else g_user_privileges[id] = bank_database[accessflags]
				get_flags(bank_database[accessflags], log_flags, 10)
				break
			}
		}
		else {
			if(bank_database[flags] & FLAG_K) {
				if((bank_database[flags] & FLAG_B && contain(name, bank_database[auth]) != -1) || equal(name, bank_database[auth])) {
					if(!(bank_database[flags] & FLAG_E)) {
						if(equal(client_password, bank_database[password]))
							g_user_privileges[id] = bank_database[accessflags]
						else if(bank_database[flags] & FLAG_A) {
							server_cmd("kick #%d ^"%L^"", get_user_userid(id), id, "BANK_PAS")
							break
						}
					}
					else g_user_privileges[id] = bank_database[accessflags]
					get_flags(bank_database[accessflags], log_flags, 10)
					break
				}
			}
			else {
				if((bank_database[flags] & FLAG_B && containi(name, bank_database[auth]) != -1) || equali(name, bank_database[auth])) {
					if(!(bank_database[flags] & FLAG_E)) {
						if(equal(client_password, bank_database[password]))
							g_user_privileges[id] = bank_database[accessflags]
						else if(bank_database[flags] & FLAG_A) {
							server_cmd("kick #%d ^"%L^"", get_user_userid(id), id, "BANK_PAS")
							break
						}
					}
					else g_user_privileges[id] = bank_database[accessflags]
					get_flags(bank_database[accessflags], log_flags, 10)
					break
				}
			}
		}
	}
}

public advertise_loop(id)
{
	if (is_user_connected(id))
	{
		if (((g_user_privileges[id] & FLAG_A) && (g_user_privileges[id] & FLAG_B) && (g_user_privileges[id] & FLAG_C) && (g_user_privileges[id] & FLAG_D)) && (get_pcvar_num(pcvars[cap5])))
			zp_colored_print(id, "^x04[%L]^x01 %L", LANG_PLAYER, "BANK_PREFIX", LANG_PLAYER, "BANK_INFO2", get_pcvar_num(pcvars[cap5]));
		else if (((g_user_privileges[id] & FLAG_A) && (g_user_privileges[id] & FLAG_B)) && (g_user_privileges[id] & FLAG_C) && (get_pcvar_num(pcvars[cap4])))
			zp_colored_print(id, "^x04[%L]^x01 %L", LANG_PLAYER, "BANK_PREFIX", LANG_PLAYER, "BANK_INFO2", get_pcvar_num(pcvars[cap4]));
		else if (((g_user_privileges[id] & FLAG_A) && (g_user_privileges[id] & FLAG_B)) && (get_pcvar_num(pcvars[cap3])))
			zp_colored_print(id, "^x04[%L]^x01 %L", LANG_PLAYER, "BANK_PREFIX", LANG_PLAYER, "BANK_INFO2", get_pcvar_num(pcvars[cap3]));
		else if ((g_user_privileges[id] & FLAG_A) && (get_pcvar_num(pcvars[cap2])))
			zp_colored_print(id, "^x04[%L]^x01 %L", LANG_PLAYER, "BANK_PREFIX", LANG_PLAYER, "BANK_INFO2", get_pcvar_num(pcvars[cap2]));
		else if (get_pcvar_num(pcvars[cap]))
			zp_colored_print(id, "^x04[%L]^x01 %L", LANG_PLAYER, "BANK_PREFIX", LANG_PLAYER, "BANK_INFO1", get_pcvar_num(pcvars[cap]));
		
		if (get_pcvar_num(pcvars[deposit]))
			zp_colored_print(id, "^x04[%L]^x01 %L", LANG_PLAYER, "BANK_PREFIX", LANG_PLAYER, "BANK_INFO_DPS");
		else
			zp_colored_print(id, "^x04[%L]^x01 %L", LANG_PLAYER, "BANK_PREFIX", LANG_PLAYER, "BANK_INFO_AS");
	
		if (get_pcvar_num(pcvars[withdraw]))
			zp_colored_print(id, "^x04[%L]^x01 %L", LANG_PLAYER, "BANK_PREFIX", LANG_PLAYER, "BANK_INFO_WD");
	
		set_task(get_pcvar_float(pcvars[advertise]), "advertise_loop", id);
	}
}

public plugin_end()
	nvault_close(gvault);

public handle_say(id)
{
	if (!get_pcvar_num(pcvars[enable]))
		return PLUGIN_CONTINUE;
		
	new error[128], errno
	new Handle:info = SQL_MakeStdTuple()
	new Handle:sql = SQL_Connect(info, errno, error, 127)
	
	if (sql == Empty_Handle)
	{
		return PLUGIN_HANDLED;
	}
	new name[32];
	get_user_name(id, name, 31);
	new Handle:query
	query = SQL_PrepareQuery(sql,"SELECT * FROM zp_bank WHERE auth = '%s'", name)
	
	if (!SQL_Execute(query))
	{
		SQL_QueryError(query, error, 127)
	} else if (!SQL_NumResults(query)) {
		return PLUGIN_CONTINUE;
	} else {
	
	new banca = SQL_ReadResult(query, 2);
	
	SQL_FreeHandle(query)
	SQL_FreeHandle(sql)
	SQL_FreeHandle(info)
	
	new text[70], arg1[32], arg2[32], arg3[6];
	read_args(text, sizeof(text) - 1);
	remove_quotes(text);
	arg1[0] = '^0';
	arg2[0] = '^0';
	arg3[0] = '^0';
	parse(text, arg1, sizeof(arg1) - 1, arg2, sizeof(arg2) - 1, arg3, sizeof(arg3) - 1);

	//strip forward slash if present
	if (equali(arg1, "/", 1))
		format(arg1, 31, arg1[1]);
	
	// if the chat line has more than 2 words, we're not interested at all
	if (arg3[0])
		return PLUGIN_CONTINUE;
	
	if (equali(arg1, "depoziteaza", 7) || equali(arg1, "salveaza", 4) || equali(arg1, "depozit", 5))
	{
		if (!get_pcvar_num(pcvars[deposit]))
		{
			zp_colored_print(id, "^x04[%L]^x01 %L", id, "BANK_PREFIX", id, "BANK_DNA");
			
			return PLUGIN_CONTINUE;
		}
		
		if (isdigit(arg2[0]) || arg2[0] == '-' && isdigit(arg2[1]))
		{
			new amount = str_to_num(arg2);
			if (amount <= 0)
			{
				zp_colored_print(id, "^x04[%L]^x01 %L", id, "BANK_PREFIX", id, "BANK_VGZ");
				
				return PLUGIN_CONTINUE;
			}
			if((g_user_privileges[id] & FLAG_A) && (g_user_privileges[id] & FLAG_B) && (g_user_privileges[id] & FLAG_C) && (g_user_privileges[id] & FLAG_D))
				store_packs_admin5(id, amount);
			else if((g_user_privileges[id] & FLAG_A) && (g_user_privileges[id] & FLAG_B) && (g_user_privileges[id] & FLAG_C))
				store_packs_admin4(id, amount);
			else if((g_user_privileges[id] & FLAG_A) && (g_user_privileges[id] & FLAG_B))
				store_packs_admin3(id, amount);
			else if(g_user_privileges[id] & FLAG_A)
				store_packs_admin2(id, amount);
			else
				store_packs(id, amount);
			
			return PLUGIN_HANDLED;
		}
		else if (equali(arg2, "tot"))
		{
			if((g_user_privileges[id] & FLAG_A) && (g_user_privileges[id] & FLAG_B) && (g_user_privileges[id] & FLAG_C) && (g_user_privileges[id] & FLAG_D))
				store_packs_admin5(id, 0);
			else if((g_user_privileges[id] & FLAG_A) && (g_user_privileges[id] & FLAG_B) && (g_user_privileges[id] & FLAG_C))
				store_packs_admin4(id, 0);
			else if((g_user_privileges[id] & FLAG_A) && (g_user_privileges[id] & FLAG_B))
				store_packs_admin3(id, 0);
			else if(g_user_privileges[id] & FLAG_A)
				store_packs_admin2(id, 0);
			else
				store_packs(id, 0);
			
			return PLUGIN_HANDLED;
		}
		else if (!arg2[0])
		{
			zp_colored_print(id, "^x04[%L]^x01 %L", id, "BANK_PREFIX", id, "BANK_HELP_DPS");
			
			return PLUGIN_CONTINUE;
		}
		
		return PLUGIN_CONTINUE;
	}
	else if (equali(arg1, "extrage", 8) || equali(arg1, "take", 4) || equali(arg1, "withdraw", 8))
	{
		if (!get_pcvar_num(pcvars[withdraw]))
		{
			zp_colored_print(id, "^x04[%L]^x01 %L", id, "BANK_PREFIX", id, "BANK_WNA");
			
			return PLUGIN_CONTINUE;
		}
		
		if (isdigit(arg2[0]) || arg2[0] == '-' && isdigit(arg2[1]))
		{
			new amount = str_to_num(arg2);
			if (amount <= 0)
			{
				zp_colored_print(id, "^x04[%L]^x01 %L", id, "BANK_PREFIX", id, "BANK_VGZ");
				
				return PLUGIN_CONTINUE;
			}
			take_packs(id, amount);
			
			return PLUGIN_HANDLED;
		}
		else if (equali(arg2, "tot", 3) || equali(arg2, "all", 10))
		{
			take_packs(id, 0);
			
			return PLUGIN_HANDLED;
		}
		else if (!arg2[0])
		{
			zp_colored_print(id, "^x04[%L]^x01 %L", id, "BANK_PREFIX", id, "BANK_HELP_WD");
			
			return PLUGIN_CONTINUE;
		}
		
		return PLUGIN_CONTINUE;
	}
	else if (equali(arg1, "cont", 6) || equali(arg1, "banca", 7) || equali(arg1, "bank", 4))
	{
		if (!arg2[0])
		{
			zp_colored_print(id, "^x04[%L]^x01 %L", id, "BANK_PREFIX", id, "BANK_INFO_CHK1", banca);
			
			return PLUGIN_HANDLED;
		}
	}
	}
	return PLUGIN_CONTINUE;
}

public client_connect(id)
{
	new error[128], errno
	new Handle:info = SQL_MakeStdTuple()
	new Handle:sql = SQL_Connect(info, errno, error, 127)
	
	if (sql == Empty_Handle)
	{
		server_print("[AMXX] %L", LANG_SERVER, "SQL_CANT_CON", error)
		return PLUGIN_HANDLED;
	}
	new name[32];
	get_user_name(id, name, 31);
	new Handle:query
	query = SQL_PrepareQuery(sql,"SELECT * FROM zp_bank WHERE auth = '%s'", name)
	
	if (!SQL_Execute(query))
	{
		SQL_QueryError(query, error, 127)
	} else if (!SQL_NumResults(query)) {
		SQL_QueryAndIgnore(sql,"INSERT INTO zp_bank(auth,cantitate) VALUES ('%s','0');", name)
	}
	
	SQL_FreeHandle(query)
	SQL_FreeHandle(sql)
	SQL_FreeHandle(info)
	
	if (get_pcvar_num(pcvars[advertise]))
		set_task(get_pcvar_float(pcvars[advertise]), "advertise_loop", id);
	set_flags(id)
	return PLUGIN_HANDLED;
}
//public zp_user_disconnect_pre(id)
public client_disconnect(id)
{
	if (!get_pcvar_num(pcvars[enable]))
		return;
	
	if (is_user_bot(id) && !get_pcvar_num(pcvars[bot]) || !zp_get_user_ammo_packs(id))
		return;
	else if((g_user_privileges[id] & FLAG_A) && (g_user_privileges[id] & FLAG_B) && (g_user_privileges[id] & FLAG_C) && (g_user_privileges[id] & FLAG_D))
		store_packs_admin5(id, 0);
	else if((g_user_privileges[id] & FLAG_A) && (g_user_privileges[id] & FLAG_B) && (g_user_privileges[id] & FLAG_C))
		store_packs_admin4(id, 0);
	else if((g_user_privileges[id] & FLAG_A) && (g_user_privileges[id] & FLAG_B))
		store_packs_admin3(id, 0);
	else if(g_user_privileges[id] & FLAG_A)
		store_packs_admin2(id, 0);
	else
		store_packs(id, 0);
	
}

//public zp_user_connect_post(id)
public client_putinserver(id)
{
	if (!get_pcvar_num(pcvars[enable]))
		return;
	
	if (!get_pcvar_num(pcvars[withdraw]))
	{
		if (!bankstorage[id] || is_user_bot(id) && !get_pcvar_num(pcvars[bot]))
			return;
		
		take_packs(id, 0)
	}
}

store_packs_admin5(id, amnt)
{
	if (!get_pcvar_num(pcvars[enable]))
		return;
	
	new temp = zp_get_user_ammo_packs(id);
	new limit = get_pcvar_num(pcvars[cap5]);
	
	if (!temp)
	{
		zp_colored_print(id, "^x04[%L]^x01 %L", id, "BANK_PREFIX", id, "BANK_NAPTD")
		
		return;
	}
	
	new error[128], errno
	new Handle:info = SQL_MakeStdTuple()
	new Handle:sql = SQL_Connect(info, errno, error, 127)
	
	if (sql == Empty_Handle)
	{
		return;
	}
	new name[32];
	get_user_name(id, name, 31);
	new Handle:query
	query = SQL_PrepareQuery(sql,"SELECT * FROM zp_bank WHERE auth = '%s'", name)
	
	if (!SQL_Execute(query))
	{
		SQL_QueryError(query, error, 127)
	} else if (!SQL_NumResults(query)) {
		return;
	} else {
	
	new banca = SQL_ReadResult(query, 2);
	
	new fill = limit - banca;	
	
	if (amnt == 0)
	{
		if (banca + temp <= limit)
		{
			new bancuta = banca + temp
			
			SQL_QueryAndIgnore(sql,"UPDATE zp_bank SET cantitate = '%d' WHERE auth = '%s'", bancuta, name)
			
			zp_colored_print(id, "^x04[%L]^x01 %L", id, "BANK_PREFIX", id, "BANK_DPST", temp)
			zp_set_user_ammo_packs(id, 0);
		}
		else
		{
			zp_colored_print(id, "^x04[%L]^x01 %L", id, "BANK_PREFIX", id, "BANK_CPCT", limit);
			if (!fill)
			{
				zp_colored_print(id, "^x04[%L]^x01 %L", id, "BANK_PREFIX", id, "BANK_NDPST");
				
				return;
			}
			else
			{
				new bancuta2 = banca + fill
				
				SQL_QueryAndIgnore(sql,"UPDATE zp_bank SET cantitate = '%d' WHERE auth = '%s'", bancuta2, name)
				
				zp_set_user_ammo_packs(id, temp - fill);
				zp_colored_print(id, "^x04[%L]^x01 %L", id, "BANK_PREFIX", id, "BANK_PADPST", fill);
			}
		}
	}
	else if (amnt > 0)
	{		
		if (temp >= amnt)
		{			
			if (banca + amnt <= limit)
			{
				
				new bancuta3 = banca + amnt
				
				SQL_QueryAndIgnore(sql,"UPDATE zp_bank SET cantitate = '%d' WHERE auth = '%s'", bancuta3, name)
				
				zp_set_user_ammo_packs(id, temp - amnt);
				zp_colored_print(id, "^x04[%L]^x01 %L", id, "BANK_PREFIX", id, "BANK_DPST", amnt)
			}
			else
			{
				zp_colored_print(id, "^x04[%L]^x01 %L", id, "BANK_PREFIX", id, "BANK_CPCT", limit);
				if (!fill)
				{
					zp_colored_print(id, "^x04[%L]^x01 %L", id, "BANK_PREFIX", id, "BANK_NDPST");
					
					return;
				}
				else
				{
					new bancuta4 = banca + fill
					
					SQL_QueryAndIgnore(sql,"UPDATE zp_bank SET cantitate = '%d' WHERE auth = '%s'", bancuta4, name)
					
					zp_set_user_ammo_packs(id, temp - fill);
					zp_colored_print(id, "^x04[%L]^x01 %L", id, "BANK_PREFIX", id, "BANK_PDPST", fill, amnt);
				}
			}
		}
		else
		{
			zp_colored_print(id, "^x04[%L]^x01 %L", id, "BANK_PREFIX", id, "BANK_ASTDG", amnt, temp);
			
			return;
		}
	}
	}
	SQL_FreeHandle(query)
	SQL_FreeHandle(sql)
	SQL_FreeHandle(info)
}

store_packs_admin4(id, amnt)
{
	if (!get_pcvar_num(pcvars[enable]))
		return;
	
	new temp = zp_get_user_ammo_packs(id);
	new limit = get_pcvar_num(pcvars[cap4]);
	
	if (!temp)
	{
		zp_colored_print(id, "^x04[%L]^x01 %L", id, "BANK_PREFIX", id, "BANK_NAPTD")
		
		return;
	}
	
	new error[128], errno
	new Handle:info = SQL_MakeStdTuple()
	new Handle:sql = SQL_Connect(info, errno, error, 127)
	
	if (sql == Empty_Handle)
	{
		return;
	}
	new name[32];
	get_user_name(id, name, 31);
	new Handle:query
	query = SQL_PrepareQuery(sql,"SELECT * FROM zp_bank WHERE auth = '%s'", name)
	
	if (!SQL_Execute(query))
	{
		SQL_QueryError(query, error, 127)
	} else if (!SQL_NumResults(query)) {
		return;
	} else {
	
	new banca = SQL_ReadResult(query, 2);
	
	new fill = limit - banca;	
	
	if (amnt == 0)
	{
		if (banca + temp <= limit)
		{
			new bancuta = banca + temp
			
			SQL_QueryAndIgnore(sql,"UPDATE zp_bank SET cantitate = '%d' WHERE auth = '%s'", bancuta, name)
			
			zp_colored_print(id, "^x04[%L]^x01 %L", id, "BANK_PREFIX", id, "BANK_DPST", temp)
			zp_set_user_ammo_packs(id, 0);
		}
		else
		{
			zp_colored_print(id, "^x04[%L]^x01 %L", id, "BANK_PREFIX", id, "BANK_CPCT", limit);
			if (!fill)
			{
				zp_colored_print(id, "^x04[%L]^x01 %L", id, "BANK_PREFIX", id, "BANK_NDPST");
				
				return;
			}
			else
			{
				new bancuta2 = banca + fill
				
				SQL_QueryAndIgnore(sql,"UPDATE zp_bank SET cantitate = '%d' WHERE auth = '%s'", bancuta2, name)
				
				zp_set_user_ammo_packs(id, temp - fill);
				zp_colored_print(id, "^x04[%L]^x01 %L", id, "BANK_PREFIX", id, "BANK_PADPST", fill);
			}
		}
	}
	else if (amnt > 0)
	{		
		if (temp >= amnt)
		{			
			if (banca + amnt <= limit)
			{
				
				new bancuta3 = banca + amnt
				
				SQL_QueryAndIgnore(sql,"UPDATE zp_bank SET cantitate = '%d' WHERE auth = '%s'", bancuta3, name)
				
				zp_set_user_ammo_packs(id, temp - amnt);
				zp_colored_print(id, "^x04[%L]^x01 %L", id, "BANK_PREFIX", id, "BANK_DPST", amnt)
			}
			else
			{
				zp_colored_print(id, "^x04[%L]^x01 %L", id, "BANK_PREFIX", id, "BANK_CPCT", limit);
				if (!fill)
				{
					zp_colored_print(id, "^x04[%L]^x01 %L", id, "BANK_PREFIX", id, "BANK_NDPST");
					
					return;
				}
				else
				{
					new bancuta4 = banca + fill
					
					SQL_QueryAndIgnore(sql,"UPDATE zp_bank SET cantitate = '%d' WHERE auth = '%s'", bancuta4, name)
					
					zp_set_user_ammo_packs(id, temp - fill);
					zp_colored_print(id, "^x04[%L]^x01 %L", id, "BANK_PREFIX", id, "BANK_PDPST", fill, amnt);
				}
			}
		}
		else
		{
			zp_colored_print(id, "^x04[%L]^x01 %L", id, "BANK_PREFIX", id, "BANK_ASTDG", amnt, temp);
			
			return;
		}
	}
	}
	SQL_FreeHandle(query)
	SQL_FreeHandle(sql)
	SQL_FreeHandle(info)
}

store_packs_admin3(id, amnt)
{
	if (!get_pcvar_num(pcvars[enable]))
		return;
	
	new temp = zp_get_user_ammo_packs(id);
	new limit = get_pcvar_num(pcvars[cap3]);
	
	if (!temp)
	{
		zp_colored_print(id, "^x04[%L]^x01 %L", id, "BANK_PREFIX", id, "BANK_NAPTD")
		
		return;
	}
	
	new error[128], errno
	new Handle:info = SQL_MakeStdTuple()
	new Handle:sql = SQL_Connect(info, errno, error, 127)
	
	if (sql == Empty_Handle)
	{
		return;
	}
	new name[32];
	get_user_name(id, name, 31);
	new Handle:query
	query = SQL_PrepareQuery(sql,"SELECT * FROM zp_bank WHERE auth = '%s'", name)
	
	if (!SQL_Execute(query))
	{
		SQL_QueryError(query, error, 127)
	} else if (!SQL_NumResults(query)) {
		return;
	} else {
	
	new banca = SQL_ReadResult(query, 2);
	
	new fill = limit - banca;	
	
	if (amnt == 0)
	{
		if (banca + temp <= limit)
		{
			new bancuta = banca + temp
			
			SQL_QueryAndIgnore(sql,"UPDATE zp_bank SET cantitate = '%d' WHERE auth = '%s'", bancuta, name)
			
			zp_colored_print(id, "^x04[%L]^x01 %L", id, "BANK_PREFIX", id, "BANK_DPST", temp)
			zp_set_user_ammo_packs(id, 0);
		}
		else
		{
			zp_colored_print(id, "^x04[%L]^x01 %L", id, "BANK_PREFIX", id, "BANK_CPCT", limit);
			if (!fill)
			{
				zp_colored_print(id, "^x04[%L]^x01 %L", id, "BANK_PREFIX", id, "BANK_NDPST");
				
				return;
			}
			else
			{
				new bancuta2 = banca + fill
				
				SQL_QueryAndIgnore(sql,"UPDATE zp_bank SET cantitate = '%d' WHERE auth = '%s'", bancuta2, name)
				
				zp_set_user_ammo_packs(id, temp - fill);
				zp_colored_print(id, "^x04[%L]^x01 %L", id, "BANK_PREFIX", id, "BANK_PADPST", fill);
			}
		}
	}
	else if (amnt > 0)
	{		
		if (temp >= amnt)
		{			
			if (banca + amnt <= limit)
			{
				
				new bancuta3 = banca + amnt
				
				SQL_QueryAndIgnore(sql,"UPDATE zp_bank SET cantitate = '%d' WHERE auth = '%s'", bancuta3, name)
				
				zp_set_user_ammo_packs(id, temp - amnt);
				zp_colored_print(id, "^x04[%L]^x01 %L", id, "BANK_PREFIX", id, "BANK_DPST", amnt)
			}
			else
			{
				zp_colored_print(id, "^x04[%L]^x01 %L", id, "BANK_PREFIX", id, "BANK_CPCT", limit);
				if (!fill)
				{
					zp_colored_print(id, "^x04[%L]^x01 %L", id, "BANK_PREFIX", id, "BANK_NDPST");
					
					return;
				}
				else
				{
					new bancuta4 = banca + fill
					
					SQL_QueryAndIgnore(sql,"UPDATE zp_bank SET cantitate = '%d' WHERE auth = '%s'", bancuta4, name)
					
					zp_set_user_ammo_packs(id, temp - fill);
					zp_colored_print(id, "^x04[%L]^x01 %L", id, "BANK_PREFIX", id, "BANK_PDPST", fill, amnt);
				}
			}
		}
		else
		{
			zp_colored_print(id, "^x04[%L]^x01 %L", id, "BANK_PREFIX", id, "BANK_ASTDG", amnt, temp);
			
			return;
		}
	}
	}
	SQL_FreeHandle(query)
	SQL_FreeHandle(sql)
	SQL_FreeHandle(info)
}

store_packs_admin2(id, amnt)
{
	if (!get_pcvar_num(pcvars[enable]))
		return;
	
	new temp = zp_get_user_ammo_packs(id);
	new limit = get_pcvar_num(pcvars[cap2]);
	
	if (!temp)
	{
		zp_colored_print(id, "^x04[%L]^x01 %L", id, "BANK_PREFIX", id, "BANK_NAPTD")
		
		return;
	}
	
	new error[128], errno
	new Handle:info = SQL_MakeStdTuple()
	new Handle:sql = SQL_Connect(info, errno, error, 127)
	
	if (sql == Empty_Handle)
	{
		return;
	}
	new name[32];
	get_user_name(id, name, 31);
	new Handle:query
	query = SQL_PrepareQuery(sql,"SELECT * FROM zp_bank WHERE auth = '%s'", name)
	
	if (!SQL_Execute(query))
	{
		SQL_QueryError(query, error, 127)
	} else if (!SQL_NumResults(query)) {
		return;
	} else {
	
	new banca = SQL_ReadResult(query, 2);
	
	new fill = limit - banca;	
	
	if (amnt == 0)
	{
		if (banca + temp <= limit)
		{
			new bancuta = banca + temp
			
			SQL_QueryAndIgnore(sql,"UPDATE zp_bank SET cantitate = '%d' WHERE auth = '%s'", bancuta, name)
			
			zp_colored_print(id, "^x04[%L]^x01 %L", id, "BANK_PREFIX", id, "BANK_DPST", temp)
			zp_set_user_ammo_packs(id, 0);
		}
		else
		{
			zp_colored_print(id, "^x04[%L]^x01 %L", id, "BANK_PREFIX", id, "BANK_CPCT", limit);
			if (!fill)
			{
				zp_colored_print(id, "^x04[%L]^x01 %L", id, "BANK_PREFIX", id, "BANK_NDPST");
				
				return;
			}
			else
			{
				new bancuta2 = banca + fill
				
				SQL_QueryAndIgnore(sql,"UPDATE zp_bank SET cantitate = '%d' WHERE auth = '%s'", bancuta2, name)
				
				zp_set_user_ammo_packs(id, temp - fill);
				zp_colored_print(id, "^x04[%L]^x01 %L", id, "BANK_PREFIX", id, "BANK_PADPST", fill);
			}
		}
	}
	else if (amnt > 0)
	{		
		if (temp >= amnt)
		{			
			if (banca + amnt <= limit)
			{
				
				new bancuta3 = banca + amnt
				
				SQL_QueryAndIgnore(sql,"UPDATE zp_bank SET cantitate = '%d' WHERE auth = '%s'", bancuta3, name)
				
				zp_set_user_ammo_packs(id, temp - amnt);
				zp_colored_print(id, "^x04[%L]^x01 %L", id, "BANK_PREFIX", id, "BANK_DPST", amnt)
			}
			else
			{
				zp_colored_print(id, "^x04[%L]^x01 %L", id, "BANK_PREFIX", id, "BANK_CPCT", limit);
				if (!fill)
				{
					zp_colored_print(id, "^x04[%L]^x01 %L", id, "BANK_PREFIX", id, "BANK_NDPST");
					
					return;
				}
				else
				{
					new bancuta4 = banca + fill
					
					SQL_QueryAndIgnore(sql,"UPDATE zp_bank SET cantitate = '%d' WHERE auth = '%s'", bancuta4, name)
					
					zp_set_user_ammo_packs(id, temp - fill);
					zp_colored_print(id, "^x04[%L]^x01 %L", id, "BANK_PREFIX", id, "BANK_PDPST", fill, amnt);
				}
			}
		}
		else
		{
			zp_colored_print(id, "^x04[%L]^x01 %L", id, "BANK_PREFIX", id, "BANK_ASTDG", amnt, temp);
			
			return;
		}
	}
	}
	SQL_FreeHandle(query)
	SQL_FreeHandle(sql)
	SQL_FreeHandle(info)
}

store_packs(id, amnt)
{
	if (!get_pcvar_num(pcvars[enable]))
		return;
	
	new temp = zp_get_user_ammo_packs(id);
	new limit = get_pcvar_num(pcvars[cap]);
	
	if (!temp)
	{
		zp_colored_print(id, "^x04[%L]^x01 %L", id, "BANK_PREFIX", id, "BANK_NAPTD")
		
		return;
	}
	
	new error[128], errno
	new Handle:info = SQL_MakeStdTuple()
	new Handle:sql = SQL_Connect(info, errno, error, 127)
	
	if (sql == Empty_Handle)
	{
		return;
	}
	new name[32];
	get_user_name(id, name, 31);
	new Handle:query
	query = SQL_PrepareQuery(sql,"SELECT * FROM zp_bank WHERE auth = '%s'", name)
	
	if (!SQL_Execute(query))
	{
		SQL_QueryError(query, error, 127)
	} else if (!SQL_NumResults(query)) {
		return;
	} else {
	
	new banca = SQL_ReadResult(query, 2);
	
	new fill = limit - banca;	
	
	if (amnt == 0)
	{
		if (banca + temp <= limit)
		{
			new bancuta = banca + temp
			
			SQL_QueryAndIgnore(sql,"UPDATE zp_bank SET cantitate = '%d' WHERE auth = '%s'", bancuta, name)
			
			zp_colored_print(id, "^x04[%L]^x01 %L", id, "BANK_PREFIX", id, "BANK_DPST", temp)
			zp_set_user_ammo_packs(id, 0);
		}
		else
		{
			zp_colored_print(id, "^x04[%L]^x01 %L", id, "BANK_PREFIX", id, "BANK_CPCT", limit);
			if (!fill)
			{
				zp_colored_print(id, "^x04[%L]^x01 %L", id, "BANK_PREFIX", id, "BANK_NDPST");
				
				return;
			}
			else
			{
				new bancuta2 = banca + fill
				
				SQL_QueryAndIgnore(sql,"UPDATE zp_bank SET cantitate = '%d' WHERE auth = '%s'", bancuta2, name)
				
				zp_set_user_ammo_packs(id, temp - fill);
				zp_colored_print(id, "^x04[%L]^x01 %L", id, "BANK_PREFIX", id, "BANK_PADPST", fill);
			}
		}
	}
	else if (amnt > 0)
	{		
		if (temp >= amnt)
		{			
			if (banca + amnt <= limit)
			{
				
				new bancuta3 = banca + amnt
				
				SQL_QueryAndIgnore(sql,"UPDATE zp_bank SET cantitate = '%d' WHERE auth = '%s'", bancuta3, name)
				
				zp_set_user_ammo_packs(id, temp - amnt);
				zp_colored_print(id, "^x04[%L]^x01 %L", id, "BANK_PREFIX", id, "BANK_DPST", amnt)
			}
			else
			{
				zp_colored_print(id, "^x04[%L]^x01 %L", id, "BANK_PREFIX", id, "BANK_CPCT", limit);
				if (!fill)
				{
					zp_colored_print(id, "^x04[%L]^x01 %L", id, "BANK_PREFIX", id, "BANK_NDPST");
					
					return;
				}
				else
				{
					new bancuta4 = banca + fill
					
					SQL_QueryAndIgnore(sql,"UPDATE zp_bank SET cantitate = '%d' WHERE auth = '%s'", bancuta4, name)
					
					zp_set_user_ammo_packs(id, temp - fill);
					zp_colored_print(id, "^x04[%L]^x01 %L", id, "BANK_PREFIX", id, "BANK_PDPST", fill, amnt);
				}
			}
		}
		else
		{
			zp_colored_print(id, "^x04[%L]^x01 %L", id, "BANK_PREFIX", id, "BANK_ASTDG", amnt, temp);
			
			return;
		}
	}
	}
	SQL_FreeHandle(query)
	SQL_FreeHandle(sql)
	SQL_FreeHandle(info)
}

take_packs(id, amnt)
{
	if (!get_pcvar_num(pcvars[enable]))
		return;
		
	new error[128], errno
	new Handle:info = SQL_MakeStdTuple()
	new Handle:sql = SQL_Connect(info, errno, error, 127)
	
	if (sql == Empty_Handle)
	{
		return;
	}
	new name[32];
	get_user_name(id, name, 31);
	new Handle:query
	query = SQL_PrepareQuery(sql,"SELECT * FROM zp_bank WHERE auth = '%s'", name)
	
	if (!SQL_Execute(query))
	{
		SQL_QueryError(query, error, 127)
	} else if (!SQL_NumResults(query)) {
		return;
	} else {
	
	new banca = SQL_ReadResult(query, 2);
	
	if (!banca)
	{
		zp_colored_print(id, "^x04[%L]^x01 %L", id, "BANK_PREFIX", id, "BANK_NPIA")
		
		return;
	}
	
	if (amnt == 0)
	{
		zp_set_user_ammo_packs(id, zp_get_user_ammo_packs(id) + banca);
		zp_colored_print(id, "^x04[%L]^x01 %L", id, "BANK_PREFIX", id, "BANK_WALL", banca)
		
		SQL_QueryAndIgnore(sql,"UPDATE zp_bank SET cantitate = '0' WHERE auth = '%s'", name)
	}
	else if (amnt > 0)
	{
		if (banca >= amnt)
		{
			zp_set_user_ammo_packs(id, zp_get_user_ammo_packs(id) + amnt);
			
			new bancuta = banca - amnt;
			
			SQL_QueryAndIgnore(sql,"UPDATE zp_bank SET cantitate = '%d' WHERE auth = '%s'", bancuta, name)
			
			zp_colored_print(id, "^x04[%L]^x01 %L", id, "BANK_PREFIX", id, "BANK_WAM", amnt)
		}
		else
		{
			zp_colored_print(id, "^x04[%L]^x01 %L", id, "BANK_PREFIX", id, "BANK_ASGB", amnt, banca);
			
			return;
		}
	}
	}
	SQL_FreeHandle(query)
	SQL_FreeHandle(sql)
	SQL_FreeHandle(info)
}

public client_infochanged(id)
{
	if (is_user_connected(id))
	{
		new newname [ 32 ], oldname [ 32 ]
		get_user_info( id, "name", newname, 31 )
		get_user_name( id, oldname, 31 )

		if (!equal(oldname,newname))
		{
			if((g_user_privileges[id] & FLAG_A) && (g_user_privileges[id] & FLAG_B) && (g_user_privileges[id] & FLAG_C) && (g_user_privileges[id] & FLAG_D))
				store_packs_admin5(id, 0);
			else if((g_user_privileges[id] & FLAG_A) && (g_user_privileges[id] & FLAG_B) && (g_user_privileges[id] & FLAG_C))
				store_packs_admin4(id, 0);
			else if((g_user_privileges[id] & FLAG_A) && (g_user_privileges[id] & FLAG_B))
				store_packs_admin3(id, 0);
			else if(g_user_privileges[id] & FLAG_A)
				store_packs_admin2(id, 0);
			else
				store_packs(id, 0);

		}
	}
}

public CmdGiveAP ( id, level, cid )
{
	if(g_user_privileges[id] & FLAG_E)
	{

		new target[32], ammo[4];
		read_argv(1, target, 31);
		read_argv(2, ammo, 3);
		new player = cmd_target(id, target, CMDTARGET_NO_BOTS | CMDTARGET_ALLOW_SELF);
		
		if (!player)
		{
			client_print ( id, print_console, "%L", LANG_PLAYER, "BANK_UNK" );
			return PLUGIN_HANDLED;
		}
		new name[32], name2[32];
		get_user_name(id, name, 31);
		get_user_name(player, name2, 31);
		new packs = str_to_num(ammo);
		
		if (packs > 999)
			zp_set_user_ammo_packs ( player, 10 * (zp_get_user_ammo_packs(player) + packs ) );
		else
			zp_set_user_ammo_packs ( player, zp_get_user_ammo_packs(player) + packs );
		console_print(id, "%L", LANG_PLAYER, "BANK_ADD", name, ammo);
	
		if(get_pcvar_float(pcvars[advertise]))
		{
			zp_colored_print(id, "^x04[%L]^x01 %L", id, "BANK_PREFIX", id, "BANK_LOG_ADD", name, name2, ammo)
			log_amx("%L", LANG_PLAYER, "BANK_LOG_ADD", name, name2, ammo);
		}
	}
	else
		console_print(id, "%L", LANG_PLAYER, "BANK_NOT_ACC")
	return PLUGIN_HANDLED;
}

public CmdRemoveAP ( id, level, cid )
{
	if(g_user_privileges[id] & FLAG_E)
	{

		new target[32], ammo[4];
		read_argv(1, target, 31);
		read_argv(2, ammo, 3);
		new player = cmd_target(id, target, CMDTARGET_NO_BOTS | CMDTARGET_ALLOW_SELF);
		
		if (!player)
		{
			client_print ( id, print_console, "%L", LANG_PLAYER, "BANK_UNK" );
			return PLUGIN_HANDLED;
		}
		new name[32], name2[32];
		get_user_name(id, name, 31);
		get_user_name(player, name2, 31);
		new packs = str_to_num(ammo);
		
		if (zp_get_user_ammo_packs(player) < packs)
		{
			client_print ( id, print_console, "%L", LANG_PLAYER, "BANK_SMALL" );
			log_amx("%L", LANG_PLAYER, "BANK_LOG_REM2", name, name2);
			zp_set_user_ammo_packs ( player, 0 );
		}
		else
		{
			zp_set_user_ammo_packs ( player, zp_get_user_ammo_packs(player) - packs );
			console_print(id, "%L", LANG_PLAYER, "BANK_REM", name, ammo);
			if(get_pcvar_float(pcvars[advertise]))
			{
				zp_colored_print(id, "^x04[%L]^x01 %L", id, "BANK_PREFIX", id, "BANK_LOG_REM", name, name2, ammo)
				log_amx("%L", LANG_PLAYER, "BANK_LOG_REM", name, name2, ammo);
			}
		}
	}
	else
		console_print(id, "%L", LANG_PLAYER, "BANK_NOT_ACC")
	return PLUGIN_HANDLED;
}
public RoundStart( )
	reload_bank()
// Colored chat print by MeRcyLeZZ
zp_colored_print(target, const message[], any:...)
{
	static buffer[512], i, argscount
	argscount = numargs()
	
	// Send to everyone
	if (!target)
	{
		static player
		for (player = 1; player <= get_maxplayers(); player++)
		{
			// Not connected
			if (!is_user_connected(player))
				continue;
			
			// Remember changed arguments
			static changed[5], changedcount // [5] = max LANG_PLAYER occurencies
			changedcount = 0
			
			// Replace LANG_PLAYER with player id
			for (i = 2; i < argscount; i++)
			{
				if (getarg(i) == LANG_PLAYER)
				{
					setarg(i, 0, player)
					changed[changedcount] = i
					changedcount++
				}
			}
			
			// Format message for player
			vformat(buffer, charsmax(buffer), message, 3)
			
			// Send it
			message_begin(MSG_ONE_UNRELIABLE, g_msgSayText, _, player)
			write_byte(player)
			write_string(buffer)
			message_end()
			
			// Replace back player id's with LANG_PLAYER
			for (i = 0; i < changedcount; i++)
				setarg(changed[i], 0, LANG_PLAYER)
		}
	}
	// Send to specific target
	else
	{
		// Format message for player
		vformat(buffer, charsmax(buffer), message, 3)
		
		// Send it
		message_begin(MSG_ONE, g_msgSayText, _, target)
		write_byte(target)
		write_string(buffer)
		message_end()
	}
}