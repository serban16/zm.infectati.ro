#include < amxmodx >
#include < nvault_util >
#include < CC_ColorChat >

#pragma semicolon 1


#define PLUGIN "FMU Back-UP"
#define VERSION "1.0"

#define	BACKUP_TASK	332211

new const g_szFurienModUltimateFile[ ] = "FurienModUltimate";
new const g_szTag[ ] = "[Furien Mod Ultimate]";

public plugin_init( )
{
	register_plugin( PLUGIN, VERSION, "Askhanar" );
	register_clcmd( "say /generatebackup", "ClCmdGenerateBackUP" );
	
	set_task( 90.0, "GenerateBackUP", BACKUP_TASK );
	
}

public ClCmdGenerateBackUP( id )
{
	if( !UserHasFullAcces(  id  ) )
	{
		ColorChat( id, RED, "^x04%s^x03 NU^x01 ai acces la aceasta comanda.", g_szTag );
		return 1;
	}
	
	remove_task( BACKUP_TASK );
	GenerateBackUP( );
	
	return 0;
}

public GenerateBackUP( )
{
	ColorChat( 0, RED, "^x04%s^x01 In^x03 10^x01 secunde, serverul va genera un fisier de tip^x03 BACK-UP^x01.", g_szTag );
	ColorChat( 0, RED, "^x04%s^x01 Fiti ingaduitori, se poate crea putin lag.", g_szTag );
	ColorChat( 0, RED, "^x04%s^x01 Cei ce nu inteleg termenul^x03 BACK-UP^x01 ignorati acest mesaj.", g_szTag );
	client_cmd( 0, "spk ^"fvox/warning.wav^"" );
	set_task( 10.0, "CreateBackUP" );
}

public CreateBackUP( )
{
	
	new iKeyPos, szKey[ 32 ], szKeyValue[ 64 ], iKeyTimeStamp;

	new iVaultToRead = nvault_util_open( g_szFurienModUltimateFile );
	new iVaultEntryes = nvault_util_count( iVaultToRead );
	
	new szCurentDateAndTime[ 32 ], szVaultToWrite[ 64 ];
	get_time("%d-%m-%Y_%H-%M-%S", szCurentDateAndTime ,sizeof ( szCurentDateAndTime ) -1 );
	
	formatex( szVaultToWrite, sizeof ( szVaultToWrite ) -1, "%s_BAK_%s", g_szFurienModUltimateFile, szCurentDateAndTime );
	new iVaultToWrite = nvault_open( szVaultToWrite );
	
	for ( new iCurrent = 1 ; iCurrent <= iVaultEntryes ; iCurrent++ )
	{
		
		iKeyPos = nvault_util_read( iVaultToRead , iKeyPos , szKey , sizeof ( szKey ) -1, szKeyValue , sizeof ( szKeyValue ) , iKeyTimeStamp );
		nvault_set( iVaultToWrite, szKey, szKeyValue );
		nvault_touch( iVaultToWrite, szKey, iKeyTimeStamp );
		
		//server_print( "[%d din %d] Key=%s Value=%s Timestamp=%d" , iCurrent , iVaultEntryes , szKey , szKeyValue ,  iKeyTimeStamp );
	}
	
	nvault_close( iVaultToWrite );
	nvault_util_close( iVaultToRead );
	
	ColorChat( 0, RED, "^x04%s^x01 Fisierul^x03 %s^x01 a fost generat cu succes.", g_szTag, szVaultToWrite );
	ColorChat( 0, RED, "^x04%s^x01 Va puteti relua jocul.", g_szTag );
}


stock bool:UserHasFullAcces(  id  )
{
	if( get_user_flags(  id  )  ==  read_flags( "abcdefghijklmnopqrstu"  )
		|| get_user_flags(  id  )  ==  read_flags( "abcdefghijklmnopqrstuvxy"  )  )
		return true;
	
	return false;
	
}