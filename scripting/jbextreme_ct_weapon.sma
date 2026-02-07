#include <amxmodx>
#include <fun>
#include <hamsandwich>
#include <cstrike>

#define PLUGIN "JailBreak Extreme By IIaku"
#define VERSION "1.0"
#define AUTHOR "SKYPE:csper55555"


public plugin_init() {
	register_plugin(PLUGIN, VERSION, AUTHOR)
	RegisterHam(Ham_Spawn, "player", "runda", 1);
}
public runda(id){
	set_task(0.1, "menu", id)
}
public menu(id)
{
	if (cs_get_user_team(id) == CS_TEAM_CT)
	{
	new menu = menu_create("\y[JB]Weapon by IIaku","wybor_menu")
	
	menu_additem(menu,"\wAK47 ","1",0)
	menu_additem(menu,"\wM4A1 ","2",0)
	menu_additem(menu,"\wTMP ","3",0)
	menu_additem(menu,"\wMAC10 ","4",0)
	menu_additem(menu,"\wXM1014 ","5",0)
	menu_additem(menu,"\wSG552 ","6",0)
	menu_additem(menu,"\wAWP ","7",0)
	menu_setprop(menu,MPROP_EXIT,MEXIT_ALL)
	menu_display(id,menu,0)
}
}
public wybor_menu(id,menu,item)
{

    if(item==MENU_EXIT)
    {
        menu_destroy(menu)
        return PLUGIN_HANDLED
    }

    new data[6], iName[64]
    new access, callback

    menu_item_getinfo(menu, item, access, data,5, iName, 63, callback);

    new key = str_to_num(data)

    switch(key)
    {
        case 2 : {
		strip_user_weapons(id)
		give_item(id, "weapon_knife")
		give_item(id, "weapon_deagle")
		give_item(id, "weapon_m4a1")
		give_item(id, "ammo_50ae")
		give_item(id, "ammo_50ae")
		give_item(id, "ammo_50ae")
		give_item(id, "ammo_50ae")
		give_item(id, "ammo_50ae")
		give_item(id, "ammo_556nato")
		give_item(id, "ammo_556nato")
		give_item(id, "ammo_556nato")
		give_item(id, "item_kevlar")
	}
        case 1 : {
		strip_user_weapons(id)
		give_item(id, "weapon_knife")
		give_item(id, "weapon_ak47")
		give_item(id, "weapon_deagle")
		give_item(id, "ammo_50ae")
		give_item(id, "ammo_50ae")
		give_item(id, "ammo_50ae")
		give_item(id, "ammo_50ae")
		give_item(id, "ammo_50ae")
		give_item(id, "ammo_762nato")
		give_item(id, "ammo_762nato")
		give_item(id, "ammo_762nato")
		give_item(id, "item_kevlar")
	}
        case 3 : {
		strip_user_weapons(id)
		give_item(id, "weapon_knife")
		give_item(id, "weapon_deagle")
		give_item(id, "weapon_tmp")
		give_item(id, "ammo_9mm")
		give_item(id, "ammo_9mm")
		give_item(id, "ammo_9mm")
		give_item(id, "ammo_9mm")
		give_item(id, "ammo_50ae")
		give_item(id, "ammo_50ae")
		give_item(id, "ammo_50ae")
		give_item(id, "ammo_50ae")
		give_item(id, "ammo_50ae")
		give_item(id, "item_kevlar")
	}
	case 4 :{
		strip_user_weapons(id)
		give_item(id, "weapon_knife")
		give_item(id, "weapon_deagle")
		give_item(id, "weapon_mac10")
		give_item(id, "ammo_45acp")
		give_item(id, "ammo_45acp")
		give_item(id, "ammo_45acp")
		give_item(id, "ammo_45acp")
		give_item(id, "ammo_45acp")
		give_item(id, "ammo_45acp")
		give_item(id, "ammo_45acp")
		give_item(id, "ammo_45acp")
		give_item(id, "ammo_50ae")
		give_item(id, "ammo_50ae")
		give_item(id, "ammo_50ae")
		give_item(id, "ammo_50ae")
		give_item(id, "ammo_50ae")
		give_item(id, "item_kevlar")
	}
	case 5 : {
		strip_user_weapons(id)
		give_item(id, "weapon_knife")
		give_item(id, "weapon_deagle")
		give_item(id, "weapon_xm1014")
		give_item(id, "ammo_buckshot")
		give_item(id, "ammo_buckshot")
		give_item(id, "ammo_buckshot")
		give_item(id, "ammo_buckshot")
		give_item(id, "ammo_buckshot")
		give_item(id, "ammo_50ae")
		give_item(id, "ammo_50ae")
		give_item(id, "ammo_50ae")
		give_item(id, "ammo_50ae")
		give_item(id, "ammo_50ae")
		give_item(id, "item_kevlar")
	}
	case 6 : {
		strip_user_weapons(id)
		give_item(id, "weapon_knife")
		give_item(id, "weapon_deagle")
		give_item(id, "weapon_sg552")
		give_item(id, "ammo_556nato")
		give_item(id, "ammo_556nato")
		give_item(id, "ammo_556nato")
		give_item(id, "ammo_556nato")
		give_item(id, "ammo_50ae")
		give_item(id, "ammo_50ae")
		give_item(id, "ammo_50ae")
		give_item(id, "ammo_50ae")
		give_item(id, "ammo_50ae")
		give_item(id, "item_kevlar")
	}
	case 7 : {
		strip_user_weapons(id)
		give_item(id, "weapon_knife")
		give_item(id, "weapon_deagle")
		give_item(id, "weapon_awp")
		give_item(id, "ammo_338magnum")
		give_item(id, "ammo_338magnum")
		give_item(id, "ammo_338magnum")
		give_item(id, "ammo_50ae")
		give_item(id, "ammo_50ae")
		give_item(id, "ammo_50ae")
		give_item(id, "ammo_50ae")
		give_item(id, "ammo_50ae")
		
		give_item(id, "item_kevlar")
	}
    }
    return PLUGIN_HANDLED
}  
/*
		strip_user_weapons(id)
		give_item(id, "weapon_knife")
		give_item(id, "weapon_deagle")
		give_item(id, "ammo_50ae")
		give_item(id, "ammo_50ae")
		give_item(id, "ammo_50ae")
		
		give_item(id, "item_kevlar")
*/
