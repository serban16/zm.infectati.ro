#include <amxmodx>
#include <amxmisc>

#define PLUGIN "CFG RangChat"
#define VERSION "1.0"
#define AUTHOR "aNNakin"

enum Color {
	NORMAL = 1,
	GREEN,
	TEAM_COLOR,
	GREY,
	RED,
	BLUE,
}

new TeamName[ ][ ] = {
	"",
	"TERRORIST",
	"CT",
	"SPECTATOR"
}


#define	GROUPS 5

new const g_Flags[ GROUPS ][ ] = {
	"Owner",
	"Co-Owner",
	"Administrator",
	"Co-Administrator",
	"Mini-Admin"
}
new const g_Groups[ GROUPS ][ ] = {
	"abcdefghijklmnopqrstux",
	"bcdefghijklmnopqrstu",
	"cdefgijmn",
	"cdefijm",
	"cefij"
}

new g_FlagsValue[ GROUPS ];

new bool:g_IsConnected[ 33 ];
new SayText, TeamInfo, g_maxplayers;

public plugin_init ( )
{
	register_plugin ( PLUGIN, VERSION, AUTHOR );
	
	register_clcmd ( "say /who", "hook_say" );
	register_clcmd ( "say /admin", "hook_say" );
	register_clcmd ( "say /admins", "hook_say" );
	
	for ( new i; i < GROUPS; i++ )
		g_FlagsValue[ i ] = read_flags ( g_Flags[ i ] );
	
	SayText = get_user_msgid ( "SayText" );
	TeamInfo = get_user_msgid ( "TeamInfo" );
	g_maxplayers = get_maxplayers ( );
}

public client_putinserver ( e_Index ) g_IsConnected[ e_Index ] = true;
public client_disconnect ( e_Index ) g_IsConnected[ e_Index ] = false;

public hook_say ( e_Index )
{
	static s_Said[ 192 ];
	read_args ( s_Said, charsmax ( s_Said ) );
	
	if ( equal ( s_Said, "" ) )
		return PLUGIN_CONTINUE;
	remove_quotes ( s_Said );
	
	static s_Name[ 32 ], i;
	get_user_name ( e_Index, s_Name, 31 );
	
	for ( i = 0; i < GROUPS; i++ )
		if ( get_user_flags ( e_Index ) == g_FlagsValue[ i ] )
	{
		ColorChat ( 0, TEAM_COLOR, "^x03%s^x01 (^x04%s^x01): %s", s_Name, g_Groups[ i ], s_Said );
		break;
	}
	
	return ( i < GROUPS ) ? PLUGIN_HANDLED : PLUGIN_CONTINUE;
}

public ColorChat ( id, Color:type, const msg[], { Float, Sql, Result, _ }:... ) {
	static message[ 256 ];
	
	switch ( type )
	{
		case NORMAL:
			message[ 0 ] = 0x01;
		case GREEN:
			message[ 0 ] = 0x04;
		default:
		message[ 0 ] = 0x03;
	}
	
	vformat ( message[ 1 ], 251, msg, 4 );
	message[ 192 ] = '^0';
	
	new team, ColorChange, index, MSG_Type;
	
	if ( id )
	{
		MSG_Type = MSG_ONE;
		index = id;
	}
	else
	{
		index = FindPlayer ( );
		MSG_Type = MSG_ALL;
	}
	
	team = get_user_team ( index );	
	ColorChange = ColorSelection ( index, MSG_Type, type );
	
	ShowColorMessage ( index, MSG_Type, message );
	
	if ( ColorChange )
		Team_Info ( index, MSG_Type, TeamName[ team ] );
}

ShowColorMessage ( id, type, message[] ) {
	message_begin ( type, SayText, _, id );
	write_byte ( id )		
	write_string ( message );
	message_end ( );	
}

Team_Info ( id, type, team[] ) {
	message_begin ( type, TeamInfo, _, id );
	write_byte ( id );
	write_string ( team );
	message_end ( );
	
	return 1;
}

ColorSelection ( index, type, Color:Type ) {
	switch ( Type )
	{
		case RED:
			return Team_Info ( index, type, TeamName[ 1 ] );
		case BLUE:
			return Team_Info ( index, type, TeamName[ 2 ] );
		case GREY:
			return Team_Info ( index, type, TeamName[ 0 ] );
	}
	return 0;
}

public FindPlayer ( )
{	
	for ( new i = 1; i <= g_maxplayers; i++ )
		if ( g_IsConnected[ i ] )
		return i;
	
	return -1;
}