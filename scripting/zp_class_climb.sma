#include <amxmodx>
#include <fakemeta>
#include <fakemeta_util>
#include <zombie_plague_advance>

#define fm_get_user_button(%1) pev(%1, pev_button)

new Float:g_wallorigin[100][3]

new cvar_zp_wallclimb
new g_zclass_climb

// Climb Zombie Atributes
new const zclass_name[] = {"Alien"}
new const zclass_info[] = {"Se urca pe pereti(ctrl+space)"}
new const zclass_model[] = {"zombie_alien3"}
new const zclass_clawmodel[] = {"alienclaws.mdl"}
const zclass_health = 4400
const zclass_speed = 300
const Float:zclass_gravity = 0.70
const Float:zclass_knockback = 1.5

public plugin_init()
{
	register_plugin("[ZP] Wallclimb ", "1.0", "Python1320/Cheap_Suit, Plagued by Dabbi, Serbu")
	register_forward(FM_PlayerPreThink, "fwd_playerprethink")
	register_forward(FM_Touch, "fwd_touch")
	cvar_zp_wallclimb = register_cvar("zp_wallclimb", "1")
}

public plugin_precache()
{
	g_zclass_climb = zp_register_zombie_class(zclass_name, zclass_info, zclass_model, zclass_clawmodel, zclass_health, zclass_speed, zclass_gravity, zclass_knockback)
}

public fwd_playerprethink(id)
{
	new button = fm_get_user_button(id)
	
	if((get_pcvar_num(cvar_zp_wallclimb) == 1) && is_user_alive(id) && (button & IN_JUMP) && (button & IN_DUCK) && (zp_get_user_zombie_class(id) == g_zclass_climb) && zp_get_user_zombie(id))
		wallclimb(id)
	else if((get_pcvar_num(cvar_zp_wallclimb) == 2) && is_user_alive(id) && (button & IN_USE) && (zp_get_user_zombie_class(id) == g_zclass_climb) && zp_get_user_zombie(id))
		wallclimb(id)
}

public fwd_touch(id)
{
	if(is_user_alive(id) && pev_valid(id))
		pev(id, pev_origin, g_wallorigin[id])
} 

public wallclimb(id)
{
	new button = fm_get_user_button(id)
	static Float:origin[3]
	pev(id, pev_origin, origin)

	if(get_distance_f(origin, g_wallorigin[id]) > 25.0)
		return FMRES_IGNORED
		
	if(button & IN_FORWARD)
	{
		static Float:velocity[3]
		velocity_by_aim(id, 120, velocity)
		fm_set_user_velocity(id, velocity)
	}
	else if(button & IN_BACK)
	{
		static Float:velocity[3]
		velocity_by_aim(id, -120, velocity)
		fm_set_user_velocity(id, velocity)
	}
	return FMRES_IGNORED
}	