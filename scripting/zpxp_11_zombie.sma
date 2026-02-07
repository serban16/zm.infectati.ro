#include <amxmodx>
#include <fakemeta>
#include <zombie_plague_advance>
#include <zombiexp>

#define PLUGIN "[ZP] Class : Predator"
#define VERSION "1.0.8"
#define AUTHOR "Fry!"

new const zclass_name[] = "Predator"
new const zclass_info[] = "Se face invizibil(tasta ctrl)"
new const zclass_model[] = "depredador2"
new const zclass_clawmodel[] = "claws.mdl"
const zclass_health = 5000
const zclass_speed = 659
const Float:zclass_gravity = 0.80
const Float:zclass_knockback = 1.50
const zclass_level = 11 // level required to use

new g_zclass_ai_zombie, g_ai_zombie_invisible

public plugin_init() 
{
	register_plugin(PLUGIN, VERSION, AUTHOR)
	
	g_ai_zombie_invisible = register_cvar("zp_ai_zombie_invisibility", "0")
	
	register_forward(FM_PlayerPreThink, "fm_PlayerPreThink")
}

public plugin_precache()
{
	g_zclass_ai_zombie = zp_register_zombie_class(zclass_name, zclass_info, zclass_model, zclass_clawmodel, zclass_health, zclass_speed, zclass_gravity, zclass_knockback)
}

public zp_user_infected_post(player, infector)
{
	if (zp_get_user_zombie_class(player) == g_zclass_ai_zombie)
	{
		if ((pev(player, pev_flags) & FL_DUCKING))
		{
			set_pev(player, pev_renderfx, kRenderFxGlowShell)
			set_pev(player, pev_rendermode, kRenderTransAlpha)
			set_pev(player, pev_renderamt, get_pcvar_float(g_ai_zombie_invisible))
		}
	}
	return PLUGIN_CONTINUE
}

public fm_PlayerPreThink(id)
{
	if (!is_user_alive(id) || !zp_get_user_zombie(id))
		return FMRES_IGNORED
		
	if (zp_get_user_zombie_class(id) != g_zclass_ai_zombie)
		return FMRES_IGNORED
	
	if (!(pev(id, pev_flags) & FL_DUCKING))
	{
		set_pev(id, pev_renderfx, kRenderFxNone)
		set_pev(id, pev_rendermode, kRenderNormal)
		set_pev(id, pev_renderamt, 255.0)
	}
		
	else
	{
		set_pev(id, pev_renderfx, kRenderFxGlowShell)
		set_pev(id, pev_rendermode, kRenderTransAlpha)
		set_pev(id, pev_renderamt, get_pcvar_float(g_ai_zombie_invisible))
	}

	return FMRES_IGNORED
}