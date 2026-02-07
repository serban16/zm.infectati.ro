#include <amxmodx>
#include <fakemeta>
#include <zombie_plague_advance>
#include <zmvip>

// Classic Zombie Attributes
new const zclass1_name[] = { "Boss Zombie" }
new const zclass1_info[] = { "Only VIP" }
new const zclass1_model[] = { "zombie_source" }
new const zclass1_clawmodel[] = { "v_knife_zombie.mdl" }
const zclass1_health = 5750
const zclass1_speed = 310
const Float:zclass1_gravity = 0.90
const Float:zclass1_knockback = 1.24

new g_zclass_crow;

public plugin_precache()
{
	register_plugin("[ZP] Clasic Zombie", "1.0", "Serbu")
	
	// Register all classes
		g_zclass_crow = zp_register_zombie_class(zclass1_name, zclass1_info, zclass1_model, zclass1_clawmodel, zclass1_health, zclass1_speed, zclass1_gravity, zclass1_knockback)
}



public zp_user_infected_pre(id) {
	if(zv_get_user_flags(id) == 0) {
		if(zp_get_user_next_class(id) == g_zclass_crow) {
			zp_set_user_zombie_class(id, 0)
		}
	}
}  