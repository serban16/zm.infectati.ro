#include <amxmodx>
#include <hamsandwich>
#include <engine>
#include <zombie_plague_advance>

#define PLUGIN	"[ZP] Addon : Laser Destroy Preventer"
#define AUTHOR	"Hezerf"
#define VERSION	"1.2"

public plugin_init()
{
	register_plugin(PLUGIN, VERSION, AUTHOR)
	RegisterHam(Ham_TakeDamage,"func_breakable","fw_TakeDamage");
}

public fw_TakeDamage(victim, inflictor, attacker, Float:damage, damage_type)
{
	new sz_classname[32]
	entity_get_string( victim , EV_SZ_classname , sz_classname , 31 )
	if(!equali(sz_classname,"lasermine"))
	{
		return HAM_IGNORED;
	}
	if(is_user_connected(attacker) && zp_get_user_zombie(attacker))
	{
		return HAM_IGNORED;
	}
	return HAM_SUPERCEDE;
}