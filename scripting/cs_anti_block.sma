#include <amxmodx>
#include <fakemeta>

new bool:g_bSemiclip[33][33];
new g_iTeam[33]
new bool:g_bSolid[33]
new bool:g_bHasSemiclip[33]
new Float:g_fOrigin[33][3]

new bool:g_bSemiclipEnabled

new g_iForwardId[3]
new g_iMaxPlayers
new g_iCvar[6]
new distance

public plugin_init()
{
    register_plugin("[ZP] Sub-Plugin: Semiclip", "0.2", "Maslyak, 93()|29!/<")
    
    g_iCvar[0] = register_cvar("cs_semiclip_enabled", "1")
    g_iCvar[1] = register_cvar("cs_semiclip_team", "1")
    g_iCvar[2] = register_cvar("cs_semiclip_transparency", "75")
    g_iCvar[3] = register_cvar("cs_semiclip_button", "0")
    g_iCvar[5] = register_cvar("cs_semiclip_distance", "125")
    
    register_forward(FM_ClientCommand, "fwdClientCommand")
    
    if (get_pcvar_num(g_iCvar[0]))
    {
        g_iForwardId[0] = register_forward(FM_PlayerPreThink, "fwdPlayerPreThink")
        g_iForwardId[1] = register_forward(FM_PlayerPostThink, "fwdPlayerPostThink")
        g_iForwardId[2] = register_forward(FM_AddToFullPack, "fwdAddToFullPack_Post", 1)
        
        g_bSemiclipEnabled = true
    }
    else
        g_bSemiclipEnabled = false
    
    g_iMaxPlayers = get_maxplayers()
    
    distance = get_pcvar_num(g_iCvar[5])
}

public fwdPlayerPreThink( plr )
{
	static id;
	
	if( is_user_alive( plr ) )
	{
		for( id = 1 ; id <= g_iMaxPlayers ; id++ )
		{
			if( pev( id, pev_solid ) == SOLID_SLIDEBOX && g_bSemiclip[plr][id] && id != plr )
			{
				set_pev( id, pev_solid, SOLID_NOT );
				g_bHasSemiclip[id] = true;
			}
		}
	}
}

public fwdPlayerPostThink(plr)
{
    static id
    
    for(id = 1; id <= g_iMaxPlayers; id++)
    {
        if (g_bHasSemiclip[id])
        {
            set_pev(id, pev_solid, SOLID_SLIDEBOX)
            g_bHasSemiclip[id] = false
        }
    }
    
    return FMRES_IGNORED
}

public fwdAddToFullPack_Post(es_handle, e, ent, host, hostflags, player, pset)
{
    if (player)
    {
        if (g_bSolid[host] && g_bSolid[ent] && get_distance_f(g_fOrigin[host], g_fOrigin[ent]) <= distance)
        {
            if (get_pcvar_num(g_iCvar[1]) && g_iTeam[host] != g_iTeam[ent])
                return FMRES_IGNORED
            
            if (get_pcvar_num(g_iCvar[3]) && !(pev(host, pev_button) & IN_USE))
                return FMRES_IGNORED
            
            set_es(es_handle, ES_Solid, SOLID_NOT)
            
            if (get_pcvar_num(g_iCvar[2]))
            {
                new transparency = get_pcvar_num(g_iCvar[2])
                
                set_es(es_handle, ES_RenderMode, kRenderTransAlpha)
                set_es(es_handle, ES_RenderAmt, transparency)
            }
        }
    }
    
    return FMRES_IGNORED
}

public fwdClientCommand(plr)
{
    if (!get_pcvar_num(g_iCvar[0]) && g_bSemiclipEnabled)
    {
        unregister_forward(FM_PlayerPreThink, g_iForwardId[0])
        unregister_forward(FM_PlayerPostThink, g_iForwardId[1])
        unregister_forward(FM_AddToFullPack, g_iForwardId[2], 1)
        
        g_bSemiclipEnabled = false
    }
    else if (get_pcvar_num(g_iCvar[0]) && !g_bSemiclipEnabled)
    {
        g_iForwardId[0] = register_forward(FM_PlayerPreThink, "fwdPlayerPreThink")
        g_iForwardId[1] = register_forward(FM_PlayerPostThink, "fwdPlayerPostThink")
        g_iForwardId[2] = register_forward(FM_AddToFullPack, "fwdAddToFullPack_Post", 1)
        
        g_bSemiclipEnabled = true
    }
}