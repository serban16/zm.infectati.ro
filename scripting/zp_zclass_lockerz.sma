#include <amxmodx>
#include <fakemeta>
#include <fakemeta_util>
#include <zombie_plague_advance>

// Zombie Attributes
new const zclass_name[] = "Lockerz Zombie"
new const zclass_info[] = "Blocheaza armele omului (tasta G)"
new const zclass_model[] = "zombie_source"
new const zclass_clawmodel[] = "v_knife_zombie.mdl"
const zclass_health = 4000
const zclass_speed = 280
const Float:zclass_gravity = 0.8
const Float:zclass_knockback = 1.0

// Class IDs
new g_lockerz

// Main var
new beam
new bool:can_lock[33]
new bool:target_locked[33]

// Main cvar
new cvar_distance
new cvar_cooldown
new cvar_cooldown_target

public plugin_init()
{
	register_plugin("[ZP] Zombie Class: Lockerz Zombie", "1.0", "Dias Leon")
	register_clcmd("drop", "lock_now")
	register_forward(FM_CmdStart, "fw_Start")
	cvar_distance = register_cvar("lz_distance", "750")
	cvar_cooldown = register_cvar("lz_cooldown_time", "30.0")
	cvar_cooldown_target = register_cvar("lz_cooldown_target_time", "10.0")
}

public plugin_precache()
{
	g_lockerz = zp_register_zombie_class(zclass_name, zclass_info, zclass_model, zclass_clawmodel, zclass_health, zclass_speed, zclass_gravity, zclass_knockback)	
	beam = precache_model("sprites/lgtning.spr")
}

public zp_user_infected_post(id, infector)
{
	if(is_user_alive(id) && zp_get_user_zombie(id) && zp_get_user_zombie_class(id) == g_lockerz)
	{
		client_print(id, print_chat, "Apasa tasta (G) pentru a bloca armele unui om!!!")
		can_lock[id] = true
	}
}

public zp_user_humanized_post(id)
{
	if(is_user_alive(id) && zp_get_user_zombie(id) && zp_get_user_zombie_class(id) == g_lockerz)
	{
		can_lock[id] = false
	}
}

public lock_now(id)
{
	if(is_user_alive(id) && zp_get_user_zombie(id) && zp_get_user_zombie_class(id) == g_lockerz)
	{
		if(is_user_alive(id) && can_lock[id] == true)
		{
			new target1, body1
			static Float:start1[3]
			static Float:end1[3]
			
			pev(id, pev_origin, start1)
			start1[2] += 16.0			
			fm_get_aim_origin(id, end1)
			end1[2] += 16.0			
			
			get_user_aiming(id, target1, body1, cvar_distance)
			if(is_user_alive(target1) && !zp_get_user_zombie(target1) && !zp_get_user_survivor(target1))
			{
				lock_target(target1)			
				client_print(id, print_center, "Tinta Lovita")
				} else {
				client_print(id, print_center, "Tinta Ratata")
			}
			message_begin(MSG_BROADCAST, SVC_TEMPENTITY)
			write_byte(0)
			engfunc(EngFunc_WriteCoord, start1[0])
			engfunc(EngFunc_WriteCoord, start1[1])
			engfunc(EngFunc_WriteCoord, start1[2])
			engfunc(EngFunc_WriteCoord, end1[0])
			engfunc(EngFunc_WriteCoord, end1[1])
			engfunc(EngFunc_WriteCoord, end1[2])
			write_short(beam)
			write_byte(0)
			write_byte(30)		
			write_byte(20)
			write_byte(50)
			write_byte(50)
			write_byte(255)
			write_byte(255)
			write_byte(255)
			write_byte(100)
			write_byte(50)
			message_end()
			
			can_lock[id] = false
			set_task(get_pcvar_float(cvar_cooldown), "ability_reload", id)
			} else {
			if(is_user_alive(id) && can_lock[id] == false)
			{
				client_print(id, print_chat, "Nu poti sa iti folosesti abilitatea chiar acum. Te rog asteapta %i secunde.", get_pcvar_num(cvar_cooldown))
			}
		}
	}
}

public lock_target(id)
{
	target_locked[id] = true
	
	set_task(get_pcvar_float(cvar_cooldown_target), "unlock_target", id)
	client_print(id, print_chat, "Toate armele tale au fost blocate, acum nu mai poti trage. Te rog asteapta %i secunde.", get_pcvar_num(cvar_cooldown_target))
	
	return PLUGIN_HANDLED	
}

public ability_reload(id)
{
	can_lock[id] = true
	client_print(id, print_chat, "Apasa tasta (G) pentru a folosi abilitatea de blocare a armei.")
}

public unlock_target(id)
{
	target_locked[id] = false
	client_print(id, print_chat, "Armele tale au fost deblocate, acum poti trage.")
	
	return PLUGIN_HANDLED	
}

public fw_Start(id, uc_handle, seed)
{
	if(is_user_alive(id) && target_locked[id] == true)
	{
		new button = get_uc(uc_handle,UC_Buttons)
		if(button & IN_ATTACK || button & IN_ATTACK2)
		{
			set_uc(uc_handle,UC_Buttons,(button & ~IN_ATTACK) & ~IN_ATTACK2)
		}
	}
}
