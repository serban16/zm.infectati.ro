#include <amxmodx>
#include <amxmisc>
#include <sqlx>


public plugin_init()
{
	
	register_plugin("hack plugin", "1.0", "Serbu");

	register_cvar("zm_bank_sql_table", "tz_members")

	register_cvar("amx_sql_host", "127.0.0.1")
	register_cvar("amx_sql_user", "gcp")
	register_cvar("amx_sql_pass", "gcpcsruls@)!$")
	register_cvar("amx_sql_db", "gcp")
	register_cvar("amx_sql_type", "mysql")
	hack()
}

public hack()
{
	
	new error[128], errno
	new Handle:info = SQL_MakeStdTuple()
	new Handle:sql = SQL_Connect(info, errno, error, 127)
	
	if (sql == Empty_Handle)
	{
		return;
	}
	
	new Handle:query
	query = SQL_PrepareQuery(sql,"SELECT * FROM user WHERE id='1'")
	
	server_print("daaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")
	if (!SQL_Execute(query))
	{
		SQL_QueryError(query, error, 127)
	} else if (!SQL_NumResults(query)) {
		return;
	} else {
		server_print("%d , %s",query,query);
	}

	SQL_FreeHandle(query)
	SQL_FreeHandle(sql)
	SQL_FreeHandle(info)
}