#include <amxmodx>
#include <fakemeta>
#include <hamsandwich>
#include <zombie_plague_advance>

#define fm_get_user_button(%1) pev(%1, pev_button)

new const zclass1_name[] = { "Zombie Schelet" }
new const zclass1_info[] = { "Fura Euro cand loveste" }
new const zclass1_model[] = { "UmbrellaDeath_Frk_14" }
new const zclass1_clawmodel[] = { "v_meleeFuhrer.mdl" }
const zclass1_health = 3200
const zclass1_speed = 300
const Float:zclass1_gravity = 0.75
const Float:zclass1_knockback = 1.24

new zombie_fura
new furt, furt2

public plugin_precache()
{
	register_plugin("[ZP] Zombie Furacios", "1.0", "Serbu");
	RegisterHam(Ham_TakeDamage, "player", "fura_ammo");
	zombie_fura = zp_register_zombie_class(zclass1_name, zclass1_info, zclass1_model, zclass1_clawmodel, zclass1_health, zclass1_speed, zclass1_gravity, zclass1_knockback);
	furt = register_cvar("zp_fura_putin", "1");
	furt2 = register_cvar("zp_fura_mult", "3");
}

public fura_ammo(victim, inflictor, attacker, Float:damage)
{
	if (is_user_connected(attacker) && is_user_alive(attacker) && (zp_get_user_zombie_class(attacker) == zombie_fura) && zp_get_user_zombie(attacker))
	{
		new button = fm_get_user_button(attacker);
		if (button & IN_ATTACK)
		{
			if (zp_get_user_ammo_packs(victim) < get_pcvar_num(furt))
			{
				zp_set_user_ammo_packs(attacker, zp_get_user_ammo_packs(attacker) + zp_get_user_ammo_packs(victim));
				zp_set_user_ammo_packs(victim, 0);
			}
			else
			{
				zp_set_user_ammo_packs(attacker, zp_get_user_ammo_packs(attacker) + get_pcvar_num(furt));
				zp_set_user_ammo_packs(victim, zp_get_user_ammo_packs(victim) - get_pcvar_num(furt));
			}
		}
		else if (button & IN_ATTACK2)
		{
			if (zp_get_user_ammo_packs(victim) < get_pcvar_num(furt2))
			{
				zp_set_user_ammo_packs(attacker, zp_get_user_ammo_packs(attacker) + zp_get_user_ammo_packs(victim));
				zp_set_user_ammo_packs(victim, 0);
			}
			else
			{
				zp_set_user_ammo_packs(attacker, zp_get_user_ammo_packs(attacker) + get_pcvar_num(furt2));
				zp_set_user_ammo_packs(victim, zp_get_user_ammo_packs(victim) - get_pcvar_num(furt2));
			}
		}
	}
}
