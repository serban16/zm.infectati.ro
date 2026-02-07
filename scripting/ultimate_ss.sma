#include <amxmodx>
#include <amxmisc>
#include <cstrike>

new player
new ip[32]
new finish;

new maxscreens  //nr maxim de poze facute unui player
new screeninterval  //intervalul (din cate in cate) secunde i se face poza (tip float)
new design  //sa apara ca ia fost facuta o poza lui cutarica in mai multe feluri
new site //siteul/forumul unde sa posteze pozele
public plugin_init() 
{ 
	register_plugin("Ultimate SS", "1.2", "Unknown")
	
	register_concmd("amx_ss", "concmd_screen", ADMIN_LEVEL_A, "<nume> <nr_poze>")
	
	maxscreens = register_cvar("amx_ss_max", "5")
	screeninterval = register_cvar("amx_ss_interval", "1.0")
	design = register_cvar("amx_ss_design", "0")
	site = register_cvar("amx_ss_site","www.infectati.ro")
}

public concmd_screen(id, level, cid)
{
	if(!cmd_access(id, level, cid, 3))   //daca ala care face poze nu este admin sa apara U dont have acces to this cmd
	{
		return PLUGIN_HANDLED
	}
	
	new arg1[24], arg2[4]
	read_argv(1, arg1, 23)
	read_argv(2, arg2, 3)
	
	new screens = str_to_num(arg2)
	new maxss = get_pcvar_num(maxscreens)
	
	if(screens > maxss)   //prea multe poze check
	{
		console_print(id, "[Ultimate SS] Prea multe poze!")
		
		return PLUGIN_HANDLED
	}
	
	player = cmd_target(id, arg1, 1) 
	if (!player)   //a iesit playerul/nici nu a existat
	{
		return PLUGIN_HANDLED
	}
	finish = screens
	
	new Float:interval = get_pcvar_float(screeninterval)	//pentru fiecare poza din nr de poze "amx_ss nickname nr_de_poze" punem set_task la interval
	new array[2]
	array[0] = id //salvam datele intrun vector ca sa le folosim la ss_propriuzis
	array[1] = player
	set_task(interval, "ss_propriuzis", 0, array,2, "a", screens)
        
	return PLUGIN_HANDLED
}
 
public ss_propriuzis(array[2])
{
	//luam datele din vector si le punem corespunzator
	new player = array[1]
	new id = array[0]
	
	//luam timpul,numele adminului,numele playerului pentru simtul estetic si ca sa nu ne dea playerul alte poze
	new timestamp[32], timestampmsg[128], name[32], adminname[32]
	get_time("%m/%d/%Y - %H:%M:%S", timestamp, 31)
	get_user_name(player, name, 31)
	get_user_name(id, adminname, 31)
	get_user_ip(player, ip, 31)
	        
	//Clasic Design
	if(get_pcvar_num(design) == 0)
	{
		client_print(player, print_chat, "[Ultimate SS] Poza facuta jucatorului ^"%s^" de adminul ^"%s^" **", name, adminname)
		client_cmd(player, "snapshot") //ss
	}
	//Doar Playerului
	else if(get_pcvar_num(design) == 1)
	{
		client_print(player, print_chat, "[Ultimate SS] Poza facuta jucatorului ^"%s^" de adminul ^"%s^" (%s) **", name, adminname, timestamp)
		client_cmd(player, "snapshot") //ss
	}
	//HUD Message doar Playerului
	else if(get_pcvar_num(design) == 2)
	{
		set_hudmessage(player, 255, 0, -1.0, 0.3, 0, 0.25, 1.0, 0.0, 0.0, 4)
		format(timestampmsg, 127, "[Ultimate SS] ORA: - %s [0N|LY]", timestamp)
		show_hudmessage(player, timestampmsg)
		
		client_cmd(player, "snapshot")  //ss
	}
	//Full
	else if(get_pcvar_num(design) == 3)
	{
		//HUD Timestamp Message
		set_hudmessage(player, 255, 0, -1.0, 0.3, 0, 0.25, 1.0, 0.0, 0.0, 4)
		format(timestampmsg, 127, "[Ultimate SS] PLAYER %s ORA: - %s [0N|LY]",name,timestamp)
		show_hudmessage(player, timestampmsg)
	    
		client_print(0, print_chat, "[Ultimate SS] Poza facut jucatorului ^"%s^" de admin ^"%s^" (%s) **", name, adminname, timestamp)
		
		client_cmd(player, "snapshot") //ss
	}
	console_print(id, "[Ultimate SS] IP-ul lui: %s este %s!",name,ip)
	finish = finish - 1;
	
	if(finish == 0)
	{
		client_cmd(player, "kill")
		cs_set_user_team(player,CS_TEAM_SPECTATOR);
		new forum[51];
		get_pcvar_string(site,forum,50)
		client_print(player, print_chat, "[Ultimate SS] Posteaza Pozele pe: %s pentru unban", forum)
	}
	
	return PLUGIN_CONTINUE;
}