#include <amxmodx>
#include <fun>
#include <fakemeta>
#include <zombie_plague_advance>

#define PLUGIN "[ZP] Class - Tank"
#define VERSION "1.0"
#define AUTHOR "HoRRoR"


new const zclass_name[] = { "Asistenta" }
new const zclass_info[] = { "Poate orbi inamicul(tasta e)" }
new const zclass_model[] = { "asistenta_infectata" }
new const zclass_clawmodel[] = { "v_asistenta_infectata.mdl" }
const zclass_health = 3800
const zclass_speed = 250
const Float:zclass_gravity = 0.80
const Float:zclass_knockback = 0.90

new g_zclass_tank
new g_chance[33]
new g_msgScreenFade
const FFADE_IN = 0x0000
const FFADE_STAYOUT = 0x0004
const UNIT_SECOND = (1<<12)

new g_maxplayers
new is_cooldown_time[33] = 0
new is_cooldown[33] = 0

// --- config ------------------------ //
new Float:g_revenge_cooldown = 30.0 //cooldown time
// ----------------------------------- //

public plugin_precache()
{
	g_zclass_tank = zp_register_zombie_class(zclass_name, zclass_info, zclass_model, zclass_clawmodel, zclass_health, zclass_speed, zclass_gravity, zclass_knockback)
}

public plugin_init() 
{
	register_plugin(PLUGIN, VERSION, AUTHOR)
	g_msgScreenFade = get_user_msgid("ScreenFade")
	g_maxplayers = get_maxplayers()
	register_logevent("roundStart", 2, "1=Round_Start")
}

public client_damage(attacker,victim,id)
{
	if(!is_user_connected(id))
	{
		new button = pev(id, pev_button)
		if ((zp_get_user_zombie_class(id) == g_zclass_tank) && (button & IN_USE) && (is_cooldown[victim] == 0))
		{
			g_chance[victim] = random_num(0,999)
			message_begin(MSG_ONE, g_msgScreenFade, _, attacker)
			write_short(4) // duration
			write_short(4) // hold time
			write_short(FFADE_STAYOUT) // fade type
			write_byte(0) // red
			write_byte(0) // green
			write_byte(0) // blue
			write_byte(255) // alpha
			message_end()
			set_user_health(victim, get_user_health(victim) + ( get_user_health(victim) / 10 ) )
			
			set_task(4.0,"wake_up",attacker)
			set_task(1.0, "ShowHUD", victim, _, _, "a",is_cooldown_time[victim])
			set_task(g_revenge_cooldown,"reset_cooldown",victim)
			is_cooldown[victim] = 1
			
		}
	}
}

public reset_cooldown(id)
{
	if ((zp_get_user_zombie_class(id) == g_zclass_tank))
	{
		is_cooldown[id] = 0
		is_cooldown_time[id] = floatround(g_revenge_cooldown)
		new text[100]
		format(text,99,"^x04[ZP]^x01 Abilitatea ta de a orbi este pregatita.")
		message_begin(MSG_ONE,get_user_msgid("SayText"),{0,0,0},id) 
		write_byte(id) 
		write_string(text) 
		message_end()
	}
}

public ShowHUD(id)
{
	if(is_user_alive(id))
	{
		is_cooldown_time[id] = is_cooldown_time[id] - 1;
		set_hudmessage(200, 100, 0, 0.75, 0.92, 0, 1.0, 1.1, 0.0, 0.0, -1)
		show_hudmessage(id, "Orbire in: %d",is_cooldown_time[id])
	}else{
		remove_task(id)
	}
}

public wake_up(id)
{
	message_begin(MSG_ONE, g_msgScreenFade, _, id)
	write_short(UNIT_SECOND) // duration
	write_short(0) // hold time
	write_short(FFADE_IN) // fade type
	write_byte(0) // red
	write_byte(0) // green
	write_byte(0) // blue
	write_byte(255) // alpha
	message_end()
}

public zp_user_infected_post(id, infector)
{
	if ((zp_get_user_zombie_class(id) == g_zclass_tank))
	{
		
		new text[100]
		
		is_cooldown[id] = 0
		is_cooldown_time[id] = floatround(g_revenge_cooldown)
		
		new note_cooldown = floatround(g_revenge_cooldown)
		format(text,99,"^x04[ZP]^x01 Abilitatea ta de a orbi pote fi folosita la un interval de 30 de secunde.",note_cooldown)
		message_begin(MSG_ONE,get_user_msgid("SayText"),{0,0,0},id) 
		write_byte(id) 
		write_string(text) 
		message_end()
		
	}
}

public zp_user_humanized_post(id)
{
	remove_task(id)
	is_cooldown[id] = 0
}

public roundStart()
{
	for (new i = 1; i <= g_maxplayers; i++)
	{
		is_cooldown[i] = 0
		is_cooldown_time[i] = floatround(g_revenge_cooldown)
		remove_task(i)
	}
}