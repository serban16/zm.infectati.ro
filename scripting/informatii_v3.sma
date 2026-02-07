#include <amxmodx>
#include <amxmisc>

#define PLUGIN "Informatii"
#define VERSION "3.0"
#define AUTHOR "Serbu"

public plugin_init()
{
   register_plugin(PLUGIN, VERSION, AUTHOR)
 
   register_clcmd("say /ajutor","ajutor")
   register_clcmd("say_team /ajutor","ajutor")
   register_clcmd("say /informatii","informatii")
   register_clcmd("say_team /informatii","informatii")
   register_clcmd("say /info","informatii")
   register_clcmd("say_team /info","informatii")
   register_clcmd("say /preturi","preturi")
   register_clcmd("say_team /preturi","preturi")
   register_clcmd("say /pret","preturi")
   register_clcmd("say_team /pret","preturi")
   register_clcmd("say /contact","contact")
   register_clcmd("say_team /contact","contact")
   register_clcmd("say /forum","forum")
   register_clcmd("say_team /forum","forum")
   register_clcmd("say /anunt","anunt")
   register_clcmd("say_team /anunt","anunt")
   register_clcmd("say /vot","vot")
   register_clcmd("say_team /vot","vot")
   register_clcmd("say /voteaza","vot")
   register_clcmd("say_team /voteaza","vot")

}

public client_connect(id)
{
	set_task(20.0, "dispInfo", id)
}

public dispInfo(id)
{
	client_print(id, print_chat, "Daca ai probleme scrie in CHAT '/ajutor'")
}

public ajutor(id)
{
	new menu = menu_create("\yRaspunsuri pentru intrebari frecvente:", "option_menu")
	
	menu_additem(menu, "\wCum se planteaza laserele?", "1", 0)
	menu_additem(menu, "\wCum se foloseste Jetpack+Bazooka?", "2", 0)
	menu_additem(menu, "\wCum se face Predatorul invizibil?", "3", 0)
	menu_additem(menu, "\wCum se urca Alien-ul pe pereti?", "4", 0)
	menu_additem(menu, "\wCum fura Scheletul Euro?", "5", 0)
	menu_additem(menu, "\wCum devii V.I.P.?", "6", 0)
	
	menu_setprop(menu, MPROP_EXIT, MEXIT_ALL)
	
	menu_display(id, menu, 0)
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
			show_motd(id,"/addons/amxmodx/configs/informatii/laser.html","Informatii Laser")
			key = (0<<1|1<<1|1<<2|1<<3|1<<4|1<<5|1<<6|1<<7|1<<8)
		}
		case 2:
		{
			show_motd(id,"/addons/amxmodx/configs/informatii/jetpack.html","Jetpack+Bazooka")
			key = (0<<1|1<<1|1<<2|1<<3|1<<4|1<<5|1<<6|1<<7|1<<8)
		}
		case 3:
		{
			show_motd(id,"/addons/amxmodx/configs/informatii/predator.html","Predator")
			key = (0<<1|1<<1|1<<2|1<<3|1<<4|1<<5|1<<6|1<<7|1<<8)
		}
		case 4:
		{
			show_motd(id,"/addons/amxmodx/configs/informatii/alien.html","Alien")
			key = (0<<1|1<<1|1<<2|1<<3|1<<4|1<<5|1<<6|1<<7|1<<8)
		}
		case 5:
		{
			show_motd(id,"/addons/amxmodx/configs/informatii/schelet.html","Schelet")
			key = (0<<1|1<<1|1<<2|1<<3|1<<4|1<<5|1<<6|1<<7|1<<8)
		}
		case 6:
		{
			show_motd(id,"/addons/amxmodx/configs/informatii/devin.html","V.I.P.")
			key = (0<<1|1<<1|1<<2|1<<3|1<<4|1<<5|1<<6|1<<7|1<<8)
		}
	}
	menu_destroy(menu)
	return PLUGIN_HANDLED
}

public informatii(id)
{
	new meniu = menu_create("\yAlege o optiune:", "optiuni_menu")
	
	menu_additem(meniu, "\wPreturi", "1", 0)
	menu_additem(meniu, "\wForum", "2", 0)
	menu_additem(meniu, "\wContact", "3", 0)
	menu_additem(meniu, "\wVoteaza server-ul", "4", 0)
	
	menu_setprop(meniu, MPROP_EXIT, MEXIT_ALL)
	
	menu_display(id, meniu, 0)
}
	
public optiuni_menu(id, meniu, item)
{
	if (item == MENU_EXIT)
	{
		menu_destroy(meniu)
		return PLUGIN_HANDLED
	}

	new data[6], names[64], access, callback
	
	menu_item_getinfo(meniu, item, access, data,5, names, 63, callback)
   
	new key = str_to_num(data)
	
	switch(key)
	{
		case 1:
		{
			show_motd(id,"/addons/amxmodx/configs/informatii/preturi.html","preturi")
			key = (0<<1|1<<1|1<<2|1<<3|1<<4|1<<5|1<<6|1<<7|1<<8)
		}
		case 2:
		{
			show_motd(id,"/addons/amxmodx/configs/informatii/forum.html","forum")
			key = (0<<1|1<<1|1<<2|1<<3|1<<4|1<<5|1<<6|1<<7|1<<8)
		}
		case 3:
		{
			show_motd(id,"/addons/amxmodx/configs/informatii/contact.html","contact")
			key = (0<<1|1<<1|1<<2|1<<3|1<<4|1<<5|1<<6|1<<7|1<<8)
		}
		case 4:
		{
			show_motd(id,"/addons/amxmodx/configs/informatii/vot.html","vot")
			key = (0<<1|1<<1|1<<2|1<<3|1<<4|1<<5|1<<6|1<<7|1<<8)
		}
	}
	menu_destroy(meniu)
	return PLUGIN_HANDLED
}

public preturi(id)
{
	show_motd(id,"/addons/amxmodx/configs/informatii/preturi.html","preturi")
}

public contact(id)
{
	show_motd(id,"/addons/amxmodx/configs/informatii/contact.html","contact")
}

public forum(id)
{
	show_motd(id,"/addons/amxmodx/configs/informatii/forum.html","forum")
}

public anunt(id)
{
	show_motd(id,"/addons/amxmodx/configs/informatii/anunt.html","anunt")
}

public vot(id)
{
	show_motd(id,"/addons/amxmodx/configs/informatii/vot.html","vot")
}

