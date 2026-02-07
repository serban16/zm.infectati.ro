#include <amxmodx>
#include <fun>
#include <zombieplague>

new const item_name[] = "Viata 1000"
new g_itemid_buyhp
new hpamount

public plugin_init() 
{
	register_plugin("[ZP] Buy Health Points", "1.0", "T[h]E Dis[as]teR")
	hpamount = register_cvar("zp_buyhp_amount", "1000")
	g_itemid_buyhp = zp_register_extra_item(item_name, 5, ZP_TEAM_HUMAN & ZP_TEAM_ZOMBIE)
}
public zp_extra_item_selected(id,itemid)
{
	if(!is_user_alive(id))
	
	return PLUGIN_HANDLED;
	
	if(itemid==g_itemid_buyhp)
	{
			set_user_health(id,get_user_health(id)+get_pcvar_num(hpamount));
			zp_set_user_ammo_packs(id, zp_get_user_ammo_packs(id) - 5);
			client_print(id, print_chat,"[ZP] Ai cumparat 1000 viata!");
	}
	return PLUGIN_CONTINUE;
}