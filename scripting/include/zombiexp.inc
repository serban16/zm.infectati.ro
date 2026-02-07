/*================================================================================
	Zombie XP Include
=================================================================================*/

/*#if defined _zombieplague_included
  #endinput
#endif
#define _zombieplague_included
*/

//registers human class plugins
native zpxp_register_human_class(const name[], const info[], const model[], const weapons[], hp, speed, Float:gravity, level)

//registers zombie classes (vital so our mod can see whats available + level)
native zpxp_register_zombie_class(const name[], const info[], const model[], const clawmodel[], hp, speed, Float:gravity, Float:knockback, level)

//checking for human registers
native zp_get_user_human_class(id)

//same as event_round_start, for human plugins
forward zp_round_started_human(id)

/*================================================================================
	For giving guns to humans, here is what you need to know

-----Primary Guns-----
"weapon_galil", "weapon_famas", "weapon_m4a1", 	"weapon_ak47", "weapon_sg552", "weapon_aug", "weapon_scout",
"weapon_m3", "weapon_xm1014", "weapon_tmp", "weapon_mac10", "weapon_ump45", "weapon_mp5navy", "weapon_p90"

-----Secondary Guns-----
"weapon_glock18", "weapon_usp", "weapon_p228", "weapon_deagle", "weapon_fiveseven", "weapon_elite"

-----Additional Items-----
"weapon_hegrenade", "weapon_flashbang", "weapon_smokegrenade"

=================================================================================*/

enum
{
	WEAPON_GALIL = 1,
	WEAPON_FAMAS,
	WEAPON_M4A1,
	WEAPON_AK47,
	WEAPON_SG552,
	WEAPON_AUG,
	WEAPON_SCOUT,
	WEAPON_M3,
	WEAPON_XM1040,
	WEAPON_TMP,
	WEAPON_MAC10,
	WEAPON_UMP45,
	WEAPON_MP5NAVY,
	WEAPON_P90,
	WEAPON_GLOCK18,
	WEAPON_USP,
	WEAPON_P228,
	WEAPON_DEAGLE,
	WEAPON_FIVESEVEN,
	WEAPON_ELITE,
	WEAPON_HEGRENADE,
	WEAPON_FLASHBANG,
	WEAPON_SMOKEGRENADE
}