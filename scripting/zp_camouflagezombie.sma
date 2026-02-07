#include <amxmodx>
#include <fakemeta>
#include <zombie_plague_advance>

#define SUCTION_MODEL_NUM 4
new MODEL_NUM[SUCTION_MODEL_NUM][] =
{
"sas","gign","vip_1","hunk"
}

new const zclass_name[] = {"Zombie Camuflat"}
new const zclass_info[] = {"Arata ca omul normal"}
new const zclass_clawmodel[] = {"v_knife.mdl"}
const zclass_health = 2700
const zclass_speed = 260
const Float:zclass_gravity = 0.90
const Float:zclass_knockback = 1.0



public plugin_precache()
{
	register_plugin("[ZP] Zombie Camuflat", "1.0", "Serbu")
	zp_register_zombie_class(zclass_name, zclass_info, MODEL_NUM[random(SUCTION_MODEL_NUM)], zclass_clawmodel, zclass_health, zclass_speed, zclass_gravity, zclass_knockback)
}