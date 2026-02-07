#include <amxmodx>
#include <amxmisc>
#include <engine>
#include <zombie_plague_advance>

#define PLUGIN "[ZP] Class : Mega Jumper Zombie"
#define VERSION "1.1.8"
#define AUTHOR "The_Thing aka Fry"

//#define FOR_ADMINS
#if defined FOR_ADMINS
    #define ADMINACCESS ADMIN_LEVEL_A
#endif


new Jumpnum[33] = false 
new bool:canJump[33] = false

new g_maxjumps

new const zclass7_name[] = { "Jumper" }
new const zclass7_info[] = { "Multi-Saritura(x6)" }
new const zclass7_model[] = { "scary_zombie" }
new const zclass7_clawmodel[] = { "v_scary_zombie.mdl" }
const zclass7_health = 3700
const zclass7_speed = 280
const Float:zclass7_gravity = 0.7
const Float:zclass7_knockback = 1.0

new g_zclass7_mega

public plugin_precache()
{
    register_cvar("zp_zclass_mega_jumper_zombie",VERSION,FCVAR_SERVER|FCVAR_EXTDLL|FCVAR_UNLOGGED|FCVAR_SPONLY)

    g_maxjumps = register_cvar("zp_zombie_maxjumps", "5")
    
    g_zclass7_mega = zp_register_zombie_class(zclass7_name,zclass7_info,zclass7_model,zclass7_clawmodel,zclass7_health,zclass7_speed,zclass7_gravity,zclass7_knockback)
}

public client_putinserver(id)
{
    Jumpnum[id] = 0
    canJump[id] = false
}

public client_disconnect(id)
{
    Jumpnum[id] = 0
    canJump[id] = false
}


public zp_user_infected_post(player, infector)
{
    if (zp_get_user_zombie_class(player) == g_zclass7_mega)
    {
        canJump[player] = true
        Jumpnum[player] = true
    }
}

public client_PreThink(id)
{
    if (!is_user_alive(id) || !zp_get_user_zombie(id))
        return PLUGIN_CONTINUE
    
    if (zp_get_user_zombie_class(id) != g_zclass7_mega)
        return PLUGIN_CONTINUE
    
    #if defined FOR_ADMINS
        if( !( get_user_flags(id) & ADMINACCESS) )
            return PLUGIN_CONTINUE
    #endif
    
    
    new nbut = get_user_button(id)
    new obut = get_user_oldbutton(id)
    
    if (( nbut & IN_JUMP) && !(get_entity_flags(id) & FL_ONGROUND) && !(obut & IN_JUMP))
    {
        if (Jumpnum[id] < get_pcvar_num(g_maxjumps))
        {
            canJump[id] = true 
            Jumpnum[id]++
            return PLUGIN_CONTINUE
        }
        
    }
    if ((nbut & IN_JUMP) && (get_entity_flags(id) & FL_ONGROUND))
    {
        Jumpnum[id] = 0
        return PLUGIN_CONTINUE
    }
    return PLUGIN_CONTINUE
}

public client_PostThink(id)
{
    if (!is_user_alive(id) || !zp_get_user_zombie(id)) 
        return PLUGIN_CONTINUE
    
    if (zp_get_user_zombie_class(id) != g_zclass7_mega)
        return PLUGIN_CONTINUE
    
    #if defined FOR_ADMINS
        if( !( get_user_flags(id) & ADMINACCESS) )
            return PLUGIN_CONTINUE
    #endif
    
    if (canJump[id] == true)
    {
        new Float:velocity[3]    
        entity_get_vector(id,EV_VEC_velocity,velocity)
        velocity[2] = random_float(265.0,285.0)
        entity_set_vector(id,EV_VEC_velocity,velocity)
        canJump[id] = false
        return PLUGIN_CONTINUE
    }
    return PLUGIN_CONTINUE
}