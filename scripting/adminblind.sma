#include < amxmodx >
#include < amxmisc >

#pragma semicolon 1

#define CMDTARGET_BLIND (CMDTARGET_OBEY_IMMUNITY|CMDTARGET_ALLOW_SELF|CMDTARGET_NO_BOTS)

new bool:g_bBlind [ 33 ] ;
new gmsgScreenFade ;
new admin [ 33 ] ;

public plugin_init ( )
{
	register_plugin	( "Blind Command" , "Ultimate" , "-Hattrick-" ) ;
	register_dictionary	( "adminblind.txt" ) ;
	register_event	( "ScreenFade" , "Event_ScreenFade", "b" ) ;
	register_event	( "DeathMsg" , "hook_death","a" ) ;
	register_concmd	( "amx_blind" , "amx_blind" , ADMIN_BAN , "<nick or #userid>" ) ;
	register_concmd	( "amx_unblind" , "amx_unblind" , ADMIN_BAN , "<nick or #userid>" ) ;
	gmsgScreenFade =	get_user_msgid ( "ScreenFade" ) ;
}

public client_putinserver ( id )
{
	g_bBlind [ id ] = false ;
}

public amx_blind ( id , level , cid )
{ 
	if ( !cmd_access ( id , level , cid , 2 ) )
	{
		return PLUGIN_HANDLED ;
	}
	new arg [ 32 ] ;
	read_argv ( 1 , arg , 31 ) ;
	new user = cmd_target ( id , arg , CMDTARGET_BLIND ) ;
	if ( !user )
	{
		return PLUGIN_HANDLED ;
	}
	new name2 [ 32 ] ;
	new name [ 32 ] ;
	new ip [ 32 ] ;
	get_user_name ( id , name , 31 ) ;
	get_user_name ( user , name2 , 31 ) ;
	get_user_ip ( user , ip , 31 , 1 ) ;
  	admin [ user ] = id ;
	if ( g_bBlind [ user ] )
	{
		client_print ( id , print_console , "%L" , LANG_PLAYER , "AB_ALREADY_BLINDED" , name2 ) ;
		return PLUGIN_HANDLED ;
	}
	else
	{
		g_bBlind [ user ] = true ;
		Fade_To_Black ( user ) ;
	}
	client_print ( id , print_console , "%L" , LANG_PLAYER , "AB_PLAYER_IP_BLINDED" , name2 , ip ) ;
	client_cmd ( id , "amx_chat ^"%s^" blinded" , name2 ) ;
	return PLUGIN_HANDLED ;
}

public amx_unblind ( id , level , cid )
{ 
	if ( !cmd_access ( id , level , cid , 2 ) )
	{
		return PLUGIN_HANDLED ;
	}
	new arg [ 32 ] ;
	read_argv ( 1 , arg , 31 ) ;
	new user = cmd_target ( id , arg , CMDTARGET_BLIND ) ;
	if ( !user )
	{
		return PLUGIN_HANDLED ;
	}
	new name2 [ 32 ] ;
	new name [ 32 ] ;
	new ip [ 32 ] ;
	get_user_name ( id , name , 31 ) ;
	get_user_name ( user , name2 , 31 ) ;
	get_user_ip ( user , ip , 31 , 1 ) ;
	if ( g_bBlind [ user ] )
	{
		g_bBlind [ user ] = false ;
		Reset_Screen ( user ) ;
	}
	else
	{
		client_print ( id , print_console , "%L" , LANG_PLAYER , "AB_ALREADY_UNBLINDED" , name2 ) ;
		return PLUGIN_HANDLED ;
	}
	console_print ( id , "%L" , LANG_PLAYER , "AB_PLAYER_IP_UNBLINDED" , name2 , ip ) ;
	client_cmd ( id , "amx_chat ^"%s^" unblinded" , name2 ) ;
	return PLUGIN_HANDLED ;
}

public Event_ScreenFade ( id )
{
	if ( g_bBlind [ id ] )
	{
		Fade_To_Black ( id ) ;
	}
}

Fade_To_Black ( id )
{
	message_begin ( MSG_ONE_UNRELIABLE , gmsgScreenFade , _ , id ) ;
	write_short ( ( 1<<3 ) | ( 1<<8 ) | ( 1<<10 ) ) ;
	write_short ( ( 1<<3 ) | ( 1<<8 ) | ( 1<<10 ) ) ;
	write_short ( ( 1<<0 ) | ( 1<<2 ) ) ;
	write_byte ( 0 ) ;
	write_byte ( 255 ) ;
	write_byte ( 0 ) ;
	write_byte ( 255 ) ;
	message_end ( ) ;
}

Reset_Screen ( id )
{
	message_begin ( MSG_ONE_UNRELIABLE , gmsgScreenFade , _ , id ) ;
	write_short ( 1<<2 ) ;
	write_short ( 0 ) ;
	write_short ( 0 ) ;
	write_byte ( 0 ) ;
	write_byte ( 0 ) ;
	write_byte ( 0 ) ;
	write_byte ( 0 ) ;
	message_end ( ) ;
}

public hook_death ( )
{
	new killer = read_data ( 1 ) ;
	new message [ 552 ] ;
	new maxtext [ 256 ] ;
	new numeserver [ 64 ] ;
	new fo_logfile [ 64 ] ;
	new timp [ 64 ] ;
	new forum [ 51 ] ;
	new numeadmin [ 32 ] ;
	new numeblindat [ 32 ] ;
	new ipadmin [ 32 ] ;
	new ipcodat [ 32 ] ;
	new authid2 [ 32 ] ;
	new inum	;
	get_user_name ( admin [ killer ] , numeadmin , 31 ) ;
	get_user_name ( killer , numeblindat , 31 ) ;
	get_user_ip ( admin [ killer ] , ipadmin , 31 , 1 ) ;
	get_user_ip ( killer , ipcodat , 31 , 1 ) ;
	get_user_authid ( killer , authid2 , 31) ;
	get_cvar_string ( "hostname" , numeserver , 63 ) ; 
	get_configsdir ( fo_logfile, 63 ) ;
	get_time ( "[%d/%m/%Y-%H:%M:%S]" , timp , 63 ) ;
	if ( g_bBlind [ killer ] )
	{
		format ( message , 551 , "KILL AFTER BLIND^nRESPECT AND YOU WILL BE RESPECTED" ) ;
		format ( maxtext , 255 , "%s %s(%s) - %s(%s)" , timp , numeadmin , ipadmin , numeblindat , ipcodat ) ;
		format ( fo_logfile , 63 , "%s/blind-log.txt" , fo_logfile ) ;
		for ( new i = 0 ; i < inum ; ++i )
		client_cmd ( killer , "say %L" , LANG_PLAYER , "AB_I_MAKE_KILL_AFTER_BLIND" ) ;
		client_cmd ( killer , "wait" ) ;
		client_cmd ( killer , "say %L" , LANG_PLAYER , "AB_I_MAKE_KILL_AFTER_BLIND" ) ;
		write_file ( fo_logfile , maxtext , -1 ) ;
		set_hudmessage ( 255 , 255 , 0 , 0.47 , 0.55 , 0 , 6.0 , 12.0 , 0.1 , 0.2 , 1 ) ;
		show_hudmessage ( 0 , message ) ;
		client_cmd ( 0 , "spk ^"vox/bizwarn coded user apprehend^"" ) ;
		client_print ( killer , print_chat , "%L" , LANG_PLAYER , "AB_PHOTO_MAKE_ON" , numeserver ) ;
		client_print ( killer, print_chat , "%L" , LANG_PLAYER , "AB_YOUR_NAME_YOUR_IP" , numeblindat , ipcodat ) ;
		client_print ( killer, print_chat , "%L" , LANG_PLAYER , "AB_ADMIN_NAME_ADMIN_IP" , numeadmin , ipadmin ) ;
		client_print ( killer , print_chat , "%L" , LANG_PLAYER , "AB_HOUR_CRUSH" , timp ) ;
		client_print ( killer, print_chat , "%L" , LANG_PLAYER , "AB_VIZIT_FOR_UNBAN" , forum ) ;
		client_cmd ( killer , "snapshot;wait;snapshot" ) ;
		client_print ( killer , print_console , "%L" , LANG_PLAYER , "AB_HEADER") ;
		client_print ( killer, print_console , "%L" , LANG_PLAYER , "AB_PHOTO_MAKE_ON" , numeserver ) ;
		client_print ( killer , print_console , "%L" , LANG_PLAYER , "AB_YOUR_NAME_YOUR_IP" , numeblindat , ipcodat ) ;
		client_print ( killer , print_console , "%L" , LANG_PLAYER , "AB_ADMIN_NAME_ADMIN_IP" , numeadmin ) ;
		client_print ( killer , print_console , "%L" , LANG_PLAYER , "AB_HOUR_CRUSH" , timp ) ;
		client_print ( killer , print_console , "%L" , LANG_PLAYER , "AB_VIZIT_FOR_UNBAN" , forum ) ;
		client_print ( killer , print_console , "%L" , LANG_PLAYER , "AB_HEADER" ) ;
	}
}