#include <amxmodx>
#include <fakemeta>
#include <zombie_plague_advance>

// Classic Zombie Attributes
new const zclass1_name[] = { "Zombie Clasic" }
new const zclass1_info[] = { "Echilibrat" }
new const zclass1_model[] = { "zombie_source" }
new const zclass1_clawmodel[] = { "v_knife_zombie.mdl" }
const zclass1_health = 4200
const zclass1_speed = 320
const Float:zclass1_gravity = 0.75
const Float:zclass1_knockback = 1.24


public plugin_precache()
{
	register_plugin("[ZP] Clasic Zombie", "1.0", "Serbu")
	
	// Register all classes
	zp_register_zombie_class(zclass1_name, zclass1_info, zclass1_model, zclass1_clawmodel, zclass1_health, zclass1_speed, zclass1_gravity, zclass1_knockback)
}
