#include <amxmodx>
#include <fakemeta>
#include <zombie_plague_advance>
#include <zmvip>

const g_buy_armor = 200
const g_max_regen = 200
const g_add_regen_armor = 10

new g_item


public plugin_init()
{
	register_plugin("[ZP] Extra Item: Regeneration Armor", "0.1", "WPMG Team")
	register_event("HLTV", "Event_RoundStart", "a", "1=0", "2=0")

	g_item = zv_register_extra_item("Regenerare Armura", "o runda", 15, ZV_TEAM_HUMAN)
}

/*================================================================================
 [Client Disconnect]
=================================================================================*/

public client_disconnect(id)
{
	if(task_exists(id))
		remove_task(id)
}

/*================================================================================
 [Main Event]
=================================================================================*/

public Event_RoundStart()
{
	for( new i = 1; i < 33 ; i++ )
		remove_task(i)
}

/*================================================================================
 [Extra Item Selected]
=================================================================================*/

public zv_extra_item_selected(id, itemid)
{
	if(itemid == g_item)
	{
		set_pev(id, pev_armorvalue, float(g_buy_armor))
		set_task(1.0, "regeneration", id, _, _, "b")
		client_print(id, print_chat, "[ZP] Acum armura ta se regenereaza.")
	}
}

/*================================================================================
 [Infection]
=================================================================================*/

public zp_user_infected_post(id, infector, nemesis)
	remove_task(id)

/*================================================================================
 [Regeneration]
=================================================================================*/

public regeneration(id)
{
	if(is_user_alive(id) || !zp_get_user_zombie(id))
		set_pev(id, pev_armorvalue, float(min(pev(id, pev_armorvalue) + g_add_regen_armor, g_max_regen)))
}