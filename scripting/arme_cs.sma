#include <amxmodx>
#include <amxmisc>
#include <cstrike>
#include <fun>
#include <engine>

#define PLUGIN "CS Arme"
#define VERSION "1.0"
#define AUTHOR "Serbu"

new CurrentRound

#define MINI ADMIN_KICK
#define CO-ADMIN ADMIN_BAN
#define ADMIN ADMIN_LEVEL_B
#define OWNER ADMIN_IMMUNITY

new bool:HasC4[33]

public plugin_init()
{
	register_plugin(PLUGIN, VERSION, AUTHOR)
	register_logevent("LogEvent_RoundStart", 2, "1=Round_Start" );
}

public LogEvent_RoundStart()
{
	CurrentRound++;
	new players[32], player, pnum;
	get_players(players, pnum, "a");
	new szMapName[ 11 ];
	get_mapname( szMapName, 10 );
	for(new i = 0; i < pnum; i++)
	{
		player = players[i];
		if(is_user_alive(player))
		{
			if((CurrentRound >= 2) && !equal( szMapName, "1hp" )  && !equal( szMapName, "35hp" ))
			{
				Showrod(player);
			}
		}
	}
	return PLUGIN_HANDLED
}

public Showrod(id) {


	if ((get_user_flags(id) & MINI) && (get_user_flags(id) & CO-ADMIN) && (get_user_flags(id) & ADMIN) && (get_user_flags(id) & OWNER))
	{
		new menu = menu_create("\yArme Admin:", "option_menu")
	
		menu_additem(menu, "\w1.M4A1 + Deagle ", "1", 0)
	
		menu_additem(menu, "\w2.AK47 + Deagle ", "2", 0)
		
		menu_additem(menu, "\w3.Shotgun + Deagle ", "3", 0)
		
		menu_additem(menu, "\w4.AWP + Deagle ", "4", 0)
	
		menu_setprop(menu, MPROP_EXIT, MEXIT_ALL)
	
		menu_display(id, menu, 0)
		
		if (user_has_weapon(id, CSW_C4) && get_user_team(id) == 1)
			HasC4[id] = true;
		else
			HasC4[id] = false;
			
		if (HasC4[id])
		{
			give_item(id, "weapon_c4");
			cs_set_user_plant( id );
		}
	}
	else if ((get_user_flags(id) & MINI) && (get_user_flags(id) & CO-ADMIN) && (get_user_flags(id) & ADMIN))
	{
		new menu = menu_create("\yArme Admin:", "option_menu")
	
		menu_additem(menu, "\w1.M4A1 + Deagle ", "1", 0)
	
		menu_additem(menu, "\w2.AK47 + Deagle ", "2", 0)
		
		menu_additem(menu, "\w3.Shotgun + Deagle ", "3", 0)
	
		menu_setprop(menu, MPROP_EXIT, MEXIT_ALL)
	
		menu_display(id, menu, 0)	
	}
	else if ((get_user_flags(id) & MINI) && (get_user_flags(id) & CO-ADMIN))
	{
		new menu = menu_create("\yArme Admin:", "option_menu")
	
		menu_additem(menu, "\w1.M4A1 + Deagle ", "1", 0)
	
		menu_additem(menu, "\w2.AK47 + Deagle ", "2", 0)
	
		menu_setprop(menu, MPROP_EXIT, MEXIT_ALL)
	
		menu_display(id, menu, 0)	
	}
	else if (get_user_flags(id) & MINI)
	{
	
		new menu = menu_create("\yArme Admin:", "option_menu")
	
		menu_additem(menu, "\wM4A1 + Deagle ", "1", 0)
	
		menu_setprop(menu, MPROP_EXIT, MEXIT_ALL)
	
		menu_display(id, menu, 0)
	}
}

public option_menu(id, menu, item)
{
	if (item == MENU_EXIT)
	{
		menu_destroy(menu)
		return PLUGIN_HANDLED
	}

	new data[6], names[64], access, callback
	
	menu_item_getinfo(menu, item, access, data,5, names, 63, callback)
   
	new key = str_to_num(data)
	
	switch(key)
	{
		case 1:
		{
            
			give_item(id,"weapon_m4a1")
			give_item(id,"ammo_556nato")
			give_item(id,"ammo_556nato")
			give_item(id,"ammo_556nato")
			give_item(id,"weapon_deagle")
			give_item(id,"weapon_knife")
			give_item(id,"ammo_50ae")
			give_item(id,"ammo_50ae")
			give_item(id,"ammo_50ae")
			give_item(id,"ammo_50ae")
			give_item(id,"ammo_50ae")
			give_item(id,"ammo_50ae")
			give_item(id,"ammo_50ae")
			give_item(id,"weapon_hegrenade")
			give_item(id, "weapon_flashbang");
			give_item(id, "weapon_flashbang");
			give_item(id, "item_assaultsuit");
			give_item(id, "item_thighpack");
			client_print(id, print_center, "Ai primit gratuit M4A1 si Deagle")
			

		}
		case 2:
		{
            
			give_item(id,"weapon_ak47")
			give_item(id,"ammo_762nato")
			give_item(id,"ammo_762nato")
			give_item(id,"ammo_762nato")
			give_item(id,"weapon_deagle")
			give_item(id,"weapon_knife")
			give_item(id,"ammo_50ae")
			give_item(id,"ammo_50ae")
			give_item(id,"ammo_50ae")
			give_item(id,"ammo_50ae")
			give_item(id,"ammo_50ae")
			give_item(id,"ammo_50ae")
			give_item(id,"ammo_50ae")
			give_item(id,"weapon_hegrenade")
			give_item(id, "weapon_flashbang");
			give_item(id, "weapon_flashbang");
			give_item(id, "item_assaultsuit");
			give_item(id, "item_thighpack");
			client_print(id, print_center, "Ai primit gratuit AK47 si Deagle")
			

		}
		case 3:
		{
            
			give_item(id,"weapon_xm1014")
			give_item(id,"ammo_buckshot")
			give_item(id,"ammo_buckshot")
			give_item(id,"ammo_buckshot")
			give_item(id,"ammo_buckshot")
			give_item(id,"weapon_deagle")
			give_item(id,"weapon_knife")
			give_item(id,"ammo_50ae")
			give_item(id,"ammo_50ae")
			give_item(id,"ammo_50ae")
			give_item(id,"ammo_50ae")
			give_item(id,"ammo_50ae")
			give_item(id,"ammo_50ae")
			give_item(id,"ammo_50ae")
			give_item(id,"weapon_hegrenade")
			give_item(id, "weapon_flashbang");
			give_item(id, "weapon_flashbang");
			give_item(id, "item_assaultsuit");
			give_item(id, "item_thighpack");
			client_print(id, print_center, "Ai primit gratuit Shotgun si Deagle")
			

		}
		case 4:
		{
            
			give_item(id,"weapon_awp")
			give_item(id,"ammo_338magnum")
			give_item(id,"ammo_338magnum")
			give_item(id,"ammo_338magnum")
			give_item(id,"weapon_deagle")
			give_item(id,"weapon_knife")
			give_item(id,"ammo_50ae")
			give_item(id,"ammo_50ae")
			give_item(id,"ammo_50ae")
			give_item(id,"ammo_50ae")
			give_item(id,"ammo_50ae")
			give_item(id,"ammo_50ae")
			give_item(id,"ammo_50ae")
			give_item(id,"weapon_hegrenade")
			give_item(id, "weapon_flashbang");
			give_item(id, "weapon_flashbang");
			give_item(id, "item_assaultsuit");
			give_item(id, "item_thighpack");
			client_print(id, print_center, "Ai primit gratuit AWP si Deagle")
			

		}
	}
	menu_destroy(menu)
	return PLUGIN_HANDLED
}