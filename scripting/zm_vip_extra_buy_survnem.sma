#include <amxmodx>
#include <zombie_plague_advance>
#include <zmvip>

#define PLUGIN "[ZP] S/N Buy"
#define VERSION "1.1"
#define AUTHOR "aaarnas"

new g_msgSayText
new nemesis, survivor
new g_bought[33], bought
new cvar_n_price, cvar_s_price, cvar_limit_all, cvar_everytime, cvar_show_bought, cvar_allow_times

public plugin_init() {
	register_plugin(PLUGIN, VERSION, AUTHOR)
	cvar_everytime = register_cvar("zp_allow_buy", "2")
	cvar_allow_times = register_cvar("zp_allow_times", "1")
	cvar_limit_all = register_cvar("zp_limit_for_all", "1")
	cvar_n_price = register_cvar("zp_nemesis_price", "35")
	cvar_s_price = register_cvar("zp_survivor_price", "35")
	cvar_show_bought = register_cvar("zp_show_who_bought", "1")
	
	g_msgSayText = get_user_msgid("SayText")
	
	// Extra items
	nemesis = zv_register_extra_item("Cumpara Asasin", "o runda", get_pcvar_num(cvar_n_price), 0)
	survivor = zv_register_extra_item("Cumpara Supravietuitor","o runda", get_pcvar_num(cvar_s_price), 0)
}

public zp_round_ended()
	bought = false

public zv_extra_item_selected(id, itemid) {
	
	new value = get_pcvar_num(cvar_everytime)
	
	if(itemid == nemesis) {
		
		if(get_pcvar_num(cvar_limit_all) && bought) {
			client_printcolor(id, "/g[ZP] Nu poti cumpara Asasin aceasta runda.Incearca runda viitoare.")
			return ZV_PLUGIN_HANDLED
		}
		if(g_bought[id] >= get_pcvar_num(cvar_allow_times)) {
			client_printcolor(id, "/g[ZP] Poti cumpara Asasin doar odata pe mapa.")
			return ZV_PLUGIN_HANDLED
		}
		if(value == 2) {
			zp_make_user_assassin(id)
			new name[64]
			get_user_name(id, name, 63)
			client_printcolor(0, "/g[ZP] %s /ya cumparat Asasin", name)
			log_amx("%s a cumparat Asasin", name)
			g_bought[id]++
		}
		else if(zp_has_round_started() == value) {
			zp_make_user_assassin(id)
			if(get_pcvar_num(cvar_show_bought)) {
				new name[64]
				get_user_name(id, name, 63)
				client_printcolor(0, "/g[ZP] %s /ya cumparat Asasin", name)
				g_bought[id]++
				bought = true
			}
		}
		else {
			client_printcolor(id, "/g[ZP] /yPoti sa cumperi de %s ori.", value ? "round started":"round not started")
			return ZV_PLUGIN_HANDLED
		}
	}
	else if(itemid == survivor) {
		
		if(get_pcvar_num(cvar_limit_all) && bought) {
			client_printcolor(id, "/g[ZP] Nu poti cumpara Supravietuitor aceasta runda.Incearca runda viitoare.")
			return ZV_PLUGIN_HANDLED
		}
		if(g_bought[id] >= get_pcvar_num(cvar_allow_times)) {
			client_printcolor(id, "/g[ZP] Poti cumpara Supravietuitor doar odata pe mapa.")
			return ZV_PLUGIN_HANDLED
		}
		if(value == 2) {
			zp_make_user_survivor(id)
			new name[64]
			get_user_name(id, name, 63)
			client_printcolor(0, "/g[ZP] %s /ya cumparat supravietuitor", name)
			log_amx("%s a cumparat supravietuitor", name)
			g_bought[id]++
		}
		else if(zp_has_round_started() == value) {
			zp_make_user_survivor(id)
			if(get_pcvar_num(cvar_show_bought)) {
				new name[64]
				get_user_name(id, name, 63)
				client_printcolor(0, "/g[ZP] %s /ya cumparat supravietuitor", name)
				g_bought[id]++
				bought = true
			}
		}
		else {
			client_printcolor(id, "/g[ZP] /yPoti cumpara supravituitor doar de %s ori.", value ? "round started":"round not started")
			return ZV_PLUGIN_HANDLED
		}
	}
	return 1
}

stock client_printcolor(const id, const input[], any:...)
{
	new iCount = 1, iPlayers[32]
	
	static szMsg[191]
	vformat(szMsg, charsmax(szMsg), input, 3)
	
	replace_all(szMsg, 190, "/g", "^4") // green txt
	replace_all(szMsg, 190, "/y", "^1") // orange txt
	replace_all(szMsg, 190, "/ctr", "^3") // team txt
	replace_all(szMsg, 190, "/w", "^0") // team txt
	
	if(id) iPlayers[0] = id
	else get_players(iPlayers, iCount, "ch")
		
	for (new i = 0; i < iCount; i++)
	{
		if (is_user_connected(iPlayers[i]))
		{
			message_begin(MSG_ONE_UNRELIABLE, g_msgSayText, _, iPlayers[i])
			write_byte(iPlayers[i])
			write_string(szMsg)
			message_end()
		}
	}
}
