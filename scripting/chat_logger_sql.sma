/*

	Chat Logger SQL
	Version 0.5
	AUTHOR: aake (aake4@hotmail.com)
	Website : http://naputtaja.no-ip.org
	
        This plugin save chat message to MySQL Database

        Installing the plugin:
        1. Copy chat_logger_sql.amxx file to plugins folder
        2. Add line chat_logger_sql.amxx to plugins.ini file
*/

#include <amxmodx>
#include <amxmisc>
#include <cstrike>
#include <sqlx>


#define PLUGINNAME	"Chat Logger SQL"
#define VERSION		"0.8b"
#define AUTHOR		"naputtaja"
#define table           "amx_chat_log"
#define MAXLEN 511
#define MAX_WORDS 150

// SQL Settings
new Handle:g_SqlX
new Handle:g_SqlConnection
new g_error[512]
new g_No_Save_Words[MAX_WORDS][20]
new g_No_Save_Num

new const TEAMNAME[_:CsTeams][] = {"*DEAD*", "(Terrorist)", "(Counter-Terrorist)", "*SPEC*"}



public check_sql()
{

    new host[64], user[64], pass[64], db[64],errorcode

    get_cvar_string("amx_sql_host", host, 63)
    get_cvar_string("amx_sql_user", user, 63)
    get_cvar_string("amx_sql_pass", pass, 63)
    get_cvar_string("amx_sql_db", db, 63)

    g_SqlX = SQL_MakeDbTuple(host, user, pass, db)
    g_SqlConnection = SQL_Connect(g_SqlX,errorcode,g_error,511);
  
    if (!g_SqlConnection) {
        console_print(0,"Chat log SQL: Could not connect to SQL database.!")
        return log_amx("Chat log SQL: Could not connect to SQL database.")
    }
    
     new query_create[1001]
     format(query_create,1000,"CREATE TABLE IF NOT EXISTS `%s`(`id` int(11) NOT NULL auto_increment,`name` varchar(100) NOT NULL default '',`authid` varchar(100) NOT NULL default '',`ip` varchar(100) NOT NULL default '',`alive` int(11) NOT NULL default '0', `team` varchar(100) NOT NULL default '',`date` date NOT NULL default '0000-00-00',`time` time NOT NULL default '00:00:00',`cmd` varchar(100) NOT NULL default '',`message` text NOT NULL,PRIMARY KEY  (`id`));",table)
     SQL_ThreadQuery(g_SqlX,"QueryHandle",query_create)
    
     console_print(0,"[AMXX SQL] Connected!")
     return PLUGIN_CONTINUE 
}

public chat_log_sql(id) 
{
    if(is_user_bot(id)) return
   

    
    static datestr[11]
    new authid[16],name[32],ip[16],timestr[9]
    new cmd[9] 
    
    if(!is_user_connected(id)) return
    
    
    
    read_argv(0,cmd,8) 
    
    new message[192] 
    read_args(message,191)
    remove_quotes(message)
    
     new i = 0
     while ( i < g_No_Save_Num )
     {
	if ( containi ( message, g_No_Save_Words[i++] ) != -1 )return
     }

     new CsTeams:team = cs_get_user_team(id)
     get_user_authid(id,authid,15)  
     get_user_name(id,name,31)
     get_user_ip(id, ip, 15, 1)
     
     get_time("%Y.%m.%d", datestr, 10)
     get_time("%H:%M:%S", timestr, 8)

     new query[1001]
     format(query,1000,"INSERT into %s (name,authid,ip,alive,team,date,time,message,cmd) values ('%s','%s','%s','%d','%s','%s','%s','%s','%s')",table,name,authid,ip,is_user_alive(id),TEAMNAME[_:team],datestr,timestr,message,cmd) 
     SQL_ThreadQuery(g_SqlX,"QueryHandle",query)
} 


public QueryHandle(FailState,Handle:Query,Error[],Errcode,Data[],DataSize)
{
    if(FailState == TQUERY_CONNECT_FAILED)
	return log_amx("Chat log SQL: Could not connect to SQL database.")
    
    else if(FailState == TQUERY_QUERY_FAILED)
        return log_amx("Chat log SQL: Query failed")
        
    if(Errcode)
        return log_amx("Chat log SQL: Error on query: %s",Error)
    
    new DataNum
    while(SQL_MoreResults(Query))
    {
        DataNum = SQL_ReadResult(Query,0)
        server_print("zomg, some data: %s",DataNum)
        SQL_NextRow(Query)
    }
    return PLUGIN_CONTINUE
}

readList()
{
	new Configsdir[64]
	new NoSaveWords_file[64]
	get_configsdir( Configsdir, 63 )
	format(NoSaveWords_file, 63, "%s/ChatLoggerSQL_NoSaveWords.ini", Configsdir )

	if ( !file_exists(NoSaveWords_file) )
	{
		return log_amx("Chat log SQL: ChatLoggerSQL_NoSaveWords.ini  File not found")
		server_print ( "====================================================================" )
		server_print ( "[Chat Logger Sql] loaded ChatLoggerSQL_NoSaveWords.ini File not found", g_No_Save_Num )
		server_print ( "====================================================================" )
	}
	
	
	new len, i=0
	while( i < MAX_WORDS && read_file( NoSaveWords_file, i , g_No_Save_Words[g_No_Save_Num], 19, len ) )
	{
		i++
		if( g_No_Save_Words[g_No_Save_Num][0] == ';' || len == 0 )
			continue
		g_No_Save_Num++
	}

	i=0

	server_print ( "======================================================" )
	server_print ( "[Chat Logger Sql] loaded %d No Save words", g_No_Save_Num )
	server_print ( "======================================================" )
	
	return PLUGIN_CONTINUE

}

public plugin_end() 
{ 
	SQL_FreeHandle(g_SqlConnection)
	return
} 

public plugin_init()
{
	register_plugin(PLUGINNAME, VERSION, AUTHOR)
	register_cvar("amx_chat_logger",VERSION,FCVAR_SERVER|FCVAR_EXTDLL|FCVAR_UNLOGGED|FCVAR_SPONLY)

	register_clcmd("say", "chat_log_sql")
	register_clcmd("say_team", "chat_log_sql")
	readList()
	set_task(0.1, "check_sql")
	return PLUGIN_CONTINUE 
}
