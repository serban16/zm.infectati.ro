#include < amxmodx >
#include < engine >
#include < CC_ColorChat >

#pragma semicolon 1

#define PLUGIN "Zapada Pe Server"
#define VERSION "1.0"

new const g_szTag[ ] = "[Fury.csdevil.ro]";

new bool:g_bUserSeeSnow[ 33 ];

public plugin_init( )
{
	register_plugin( PLUGIN, VERSION, "Askhanar" );
	register_clcmd( "say /snow", "ClCmdSaySnow" );
	
	register_clcmd( "amx_snow", "ClCmdAmxSnow" );
	set_cvar_string("sv_skyname" , "snow");
}

public plugin_precache( )
	create_entity( "env_snow" );
	
public client_putinserver( id )
{
	if( is_user_bot( id ) || is_user_hltv( id ) )
		return 0;
		
	g_bUserSeeSnow[ id ] = true;
	set_task( 1.0, "SetUserWeather", id + 112233 );
	client_cmd( id, "cl_weather 1" );
	
	return 0;
}

public SetUserWeather( id )
{
	id -= 112233;
	if( !is_user_connected( id ) ) return 1;
	client_cmd( id, "cl_weather 1" );
	
	return 0;
}

public ClCmdSaySnow( id )
{
	if( g_bUserSeeSnow[ id ] )
	{
		client_cmd( id, "cl_weather 0" );
		g_bUserSeeSnow[ id ] = false;
		ColorChat( id, RED, "^x04%s^x01 Ce pacat, ninsoarea s-a oprit !", g_szTag );
	}
	else if( !g_bUserSeeSnow[ id ] )
	{
		client_cmd( id, "cl_weather 1" );
		g_bUserSeeSnow[ id ] = true;
		ColorChat( id, RED, "^x04%s^x01 Spre bucuria ta, a inceput sa ninga iar !", g_szTag );
	}
	
	return 1;
}

public ClCmdAmxSnow( id )
{
	
	if( !( get_user_flags( id ) & ADMIN_KICK ) )
		return 1;
		
	new szArg[ 3 ];
	read_argv( 1, szArg, sizeof ( szArg ) -1 );
	
	new iArg = clamp( str_to_num( szArg ), 0, 3 );
	
	new szName[ 32 ];
	get_user_name( id, szName, sizeof ( szName ) -1 );
	switch( iArg )
	{
		case 0:
		{
			
			client_cmd( 0,"cl_weather 0" );
			ColorChat( 0, RED,"^x04%s^x01 Adminul^x03 %s^x01 a oprit ninsoarea !", g_szTag, szName );
			return 0;
		}
		case 1:
		{
			client_cmd( 0,"cl_weather 1" );
			ColorChat( 0, RED,"^x04%s^x01 Adminul^x03 %s^x01 a setat ninsoarea lina !", g_szTag, szName );
			return 0;
		}
		case 2:
		{
			client_cmd( 0,"cl_weather 2" );
			ColorChat( 0, RED,"^x04%s^x01 Adminul^x03 %s^x01 a setat ninsoarea moderata !", g_szTag, szName );
			return 0;
		}
			
		case 3:
		{
			client_cmd( 0,"cl_weather 3" );
			ColorChat( 0, RED,"^x04%s^x01 Adminul^x03 %s^x01 a setat ninsoarea abundenta !", g_szTag, szName );
			return 0;
		}
		
	}
	
	return 1;
}