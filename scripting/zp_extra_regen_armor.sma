#include <amxmodx>
#include <fakemeta>
#include <zombie_plague_advance>

const g_buy_armor = 100
const g_max_regen = 100
const g_add_regen_armor = 10

new g_item

public plugin_init()
{
	register_plugin("[ZP] Extra Item: Regeneration Armor", "0.1", "WPMG Team")
	register_event("HLTV", "Event_RoundStart", "a", "1=0", "2=0")

	g_item = zp_register_extra_item("Regenerare Armura (o runda)", 15, ZP_TEAM_HUMAN)
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

public zp_extra_item_selected(id, item)
{
	if(item == g_item)
	{
		set_pev(id, pev_armorvalue, float(g_buy_armor))
		set_task(1.0, "regeneration", id, _, _, "b")
		client_printcolor(id, "^4[ZP] ^1Acum armura ta se regenereaza^3", g_add_regen_armor)
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


/*================================================================================
 [Stock]
=================================================================================*/

stock client_printcolor(const id, const input[], any:...)
{
	new iCount = 1, iPlayers[32]
	static szMsg[191]

	vformat(szMsg, charsmax(szMsg), input, 3)
	replace_all(szMsg, 190, "/g", "^4")
	replace_all(szMsg, 190, "/y", "^1")
	replace_all(szMsg, 190, "/ctr", "^1")
	replace_all(szMsg, 190, "/w", "^0")

	if(id) iPlayers[0] = id
	else get_players(iPlayers, iCount, "ch")
	for (new i = 0; i < iCount; i++)
	{
		if(is_user_connected(iPlayers[i]))
		{
			message_begin(MSG_ONE_UNRELIABLE, get_user_msgid("SayText"), _, iPlayers[i])
			write_byte(iPlayers[i])
			write_string(szMsg)
			message_end()
		}
	}
}