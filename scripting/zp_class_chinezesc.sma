#include <amxmodx>
#include <hamsandwich>
#include <zombie_plague_advance>

new const zclass14_name[] = {"Chinezesc"}
new const zclass14_info[] = {"Damage x5"}
new const zclass14_model[] = {"chinezesc"}
new const zclass14_clawmodel[] = {"chinezesc1.mdl"}
const zclass14_health = 4600
const zclass14_speed = 330
const Float:zclass14_gravity = 0.65
const Float:zclass14_knockback = 2.50

new g_zclass14
new witch_dmg

public plugin_init()
{
	RegisterHam(Ham_TakeDamage, "player", "fw_TakeDamage")
	witch_dmg = register_cvar("zp_witch_damage", "5.5")
}
public plugin_precache()
{
	register_plugin("[ZP] Zombie Chinezesc", "1.0", "Serbu")
	g_zclass14 = zp_register_zombie_class(zclass14_name, zclass14_info, zclass14_model, zclass14_clawmodel, zclass14_health, zclass14_speed, zclass14_gravity, zclass14_knockback)
}

public fw_TakeDamage(victim, inflictor, attacker, Float:damage)
{
	if ( is_user_alive( attacker ) && zp_get_user_zombie_class(attacker) == g_zclass14 && zp_get_user_zombie(attacker) )
	{			
		SetHamParamFloat(4, damage * get_pcvar_float( witch_dmg ) )
	}
}
