#include < amxmodx >
#include < orpheu_stocks >
#include < orpheu_memory >

#define set_mp_pdata(%1,%2)  ( OrpheuMemorySetAtAddress( g_pGameRules, %1, 1, %2 ) )

new g_pGameRules;

public plugin_init() 
{
    register_plugin( "Instant Round Restart", "0.0.1", "Juice" );
    register_concmd( "amx_restartround", "cmdRestart", -1, "Restart the round instantly" );
}

public plugin_precache()
{
    OrpheuRegisterHook( OrpheuGetFunction("InstallGameRules"),"OnInstallGameRules", OrpheuHookPost );
}

public OnInstallGameRules()
{
    g_pGameRules = OrpheuGetReturn();
}

public cmdRestart( id )
{
    client_print( id, print_center, "The game will restart in 0.1 SECOND" );
    RestartRound( .delay = 0.1 ); // RoundTerminating from arkshine's Round Terminator
}