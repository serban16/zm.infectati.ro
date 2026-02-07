#include <amxmodx>
#include <sqlx>
#include <csx>

new Result:result

public plugin_init()
{
	register_plugin("SQL Stats","1.1","Serbu");

	register_cvar("zm_rank_sql_table", "tz_members")
	
	register_cvar("zm_rank_sql_host", "localhost")
	register_cvar("zm_rank_sql_user", "serbu")
	register_cvar("zm_rank_sql_pass", "parola-baza-de-date")
	register_cvar("zm_rank_sql_db", "icp")
	register_cvar("zm_rank_sql_type", "mysql")
	
}

public client_disconnect(id)
{

	new name[32];
	get_user_name(id,name,32);
	
	new stats[8], body[8]
	new rank = get_user_stats(id, stats, body);
	
	new table[32], error[128], errno
	
	new Handle:info = SQL_MakeStdTuple()
	new Handle:sql = SQL_Connect(info, errno, error, 127)
	
	get_cvar_string("zm_rank_sql_table", table, 31)
	
	if (sqlite_TableExists(sql, table))
		SQL_QueryAndIgnore(sql, "UPDATE `tz_members` SET `zm_kills` = '%d', `zm_deaths` = '%d', `zm_rank` = '%d' WHERE `auth` = '%s'", stats[0], stats[1], rank, name)
	
	}	

stock Float:accuracy(stats[8])
{
	if(!stats[4])
		return ( 0.0 );
	new Float:result
	result = 100.0 * float( stats[5] ) / float( stats[4] );
	return (result > 100.0) ? 100.0 : result
}

stock Float:effec(stats[8])
{
	if(!stats[0])
		return ( 0.0 );
	new Float:result
	result = 100.0 * float( stats[0] ) / float( stats[0] + stats[1] );
	return (result > 100.0) ? 100.0 : result
}