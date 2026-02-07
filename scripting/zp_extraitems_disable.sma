#include <amxmodx>
#include <zombie_plague_advance>

#define PLUGIN "Extra_items_disabled"
#define VERSION "1.0"
#define AUTHOR "Serbu"

public plugin_init()
{
	register_plugin(PLUGIN, VERSION, AUTHOR)
}

public zp_extra_item_selected(id, itemid)
{
    if (zp_is_sniper_round())
        return PLUGIN_CONTINUE;
    
    client_print(id, print_chat, "[ZP] Elementele extra sunt dezactivate in modul 'Sniper'.")
    return ZP_PLUGIN_HANDLED;
}