#include <amxmodx> 
#include <orpheu> 
#include <fakemeta> 

new CvarAdminFreeLookFlag; 

public plugin_init() 
{ 
    register_plugin( "Admin Free Look" , "Arkshine", "2.0" ); 
     
    CvarAdminFreeLookFlag = register_cvar( "amx_adminfreelookflag", "d" ); 

    OrpheuRegisterHook( OrpheuGetFunction( "Observer_IsValidTarget", "CBasePlayer" ), "Observer_IsValidTarget" ); 
} 

public Observer_IsValidTarget( const observer, const index, const bool:checkTeam ) 
{ 
    if( is_user_connected(observer) && checkTeam && get_user_flags( observer ) & get_pcvar_flags( CvarAdminFreeLookFlag ) )  
    { 
        OrpheuSetParam( 3, false );
    } 
} 