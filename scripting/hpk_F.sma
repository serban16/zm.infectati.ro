#include <amxmodx>
#include <amxmisc>

#define PLUGIN "High Ping Mode"
#define VERSION "0.2"
#define AUTHOR "FireW@ll"

new ipserver, portserver;
new Ping[33], exemple[33], hpk_tests, hpk_delay, hpk_check, hpk_ping, hpk_mode, hpk_ban_minute, hpk_ban_mode;


public plugin_init()
{
	
	register_plugin(PLUGIN,VERSION,AUTHOR);
	register_dictionary("hpk_F.txt");
	
	hpk_ping = register_cvar("hpk_ping","180");
	hpk_check = register_cvar("hpk_check","12");
	hpk_tests = register_cvar("hpk_tests","2");
	hpk_delay = register_cvar("hpk_delay","25");
	hpk_mode = register_cvar("hpk_mode","1");
	
	// redirect cvars
	ipserver = register_cvar("hpk_ip_server","localhost");
	portserver = register_cvar("hpk_port_server","27015");
	
	// ban cvars
	hpk_ban_minute = register_cvar("hpk_ban_time","2");
	hpk_ban_mode = register_cvar("hpk_ban_mode","1");
	check()
}

public check()
{
	
	if(get_pcvar_num(hpk_check) < 5) 
		set_pcvar_num(hpk_check, 5)
		
	if(get_pcvar_num(hpk_tests) < 3) 
		set_pcvar_num(hpk_tests, 3)
}

public client_disconnect(id) 
	remove_task(id)


public client_putinserver(id)
{    
	Ping[id] = 0 
	exemple[id] = 0

	if(!is_user_bot(id)) 
	{
		new param[1]
		param[0] = id 
		set_task(12.0, "mesaj", id, param, 1)
    
		if(get_pcvar_num(hpk_tests) != 0)
		{
			set_task(float(get_pcvar_num(hpk_delay)), "taskSetting", id, param , 1)
		}
		else 
		{	    
			set_task(float(get_pcvar_num(hpk_tests)), "checkPing", id, param, 1, "b")
		}
	}
} 

public mesaj(param[])
	client_print(param[0], print_chat, "%L", param[0], "MESSAGE", get_pcvar_num(hpk_ping))


	
public taskSetting(param[])
{
	static name[32];
	get_user_name(param[0], name, 31)
	set_task(float(get_pcvar_num(hpk_tests)), "checkPing", param[0], param, 1, "b")
}


public checkPing(param[]) 
{ 
	new id = param[0] 
	
	if(get_user_flags(id) & ADMIN_IMMUNITY) 
	{
		client_print(id, print_chat, "%L", id, "IMMUNITY");
		remove_task(id);
		return 0;
	}
	
	static ip[32], p, l;
	
	get_user_ip(id, ip, 31);
	get_user_ping(id ,p ,l );
	
	Ping[id] += p
	
	++exemple[id]
	if((exemple[id] > get_pcvar_num(hpk_tests)) && (Ping[id] / exemple[id] > get_pcvar_num(hpk_ping))) 
	
	switch(get_pcvar_num(hpk_mode))
	{
		case 1:	kickPlayer(id);
		case 2:	RedirectPlayer(id);
		case 3: BanPlayer(id);
			
	}
	return 0;
}


kickPlayer(id)
{ 
	static name[32], ip[32];
	
	new userid = get_user_userid(id);
	
	get_user_name(id, name, 31);
	get_user_ip(id, ip, 31);
	
	client_print(0, print_chat, "%L", LANG_PLAYER, "KICKPLAYER", name, ip, (Ping[id] / exemple[id]), get_pcvar_num(hpk_ping));
	
	server_cmd("kick #%d ^"Ai lag prea mare. Peste 120^"", userid);

}


RedirectPlayer(id)
{
	static name[32], ip[32], ip_[64], port_[64];
	
	new userid = get_user_userid(id);
	
	get_user_name(id, name, 31);
	get_user_ip(id, ip, 31);
	
	get_pcvar_string(ipserver, ip_, 63);
	get_pcvar_string(portserver, port_, 63);
	
	client_print(0, print_chat,"%L", LANG_PLAYER, "REDIRECTPLAYER" ,name, ip,  (Ping[id] / exemple[id]), get_pcvar_num(hpk_ping), ip_, port_)
	
	client_cmd(id,"connect %s:%s",ip_, port_)
	
	log_amx("%L", 0,"LOG_REDIRECT", name, userid, ip, (Ping[id] / exemple[id]), ip_, port_)
}

BanPlayer(id)
{
	static ip[32], name[32], steamid[32];
	
	new userid = get_user_userid(id);
	new minute = get_pcvar_num(hpk_ban_minute);
	
	get_user_name(id, name, 31)
	get_user_ip(id, ip, 31);
	get_user_authid(id, steamid, 31);
	
	client_print(0, print_chat,"%L", LANG_PLAYER,"BANPLAYER", name, ip, (Ping[id] / exemple[id]), get_pcvar_num(hpk_ping), minute);
	
	switch(get_pcvar_num(hpk_ban_mode))
	{
		case 1:	server_cmd("kick #%d addip ^"%s^" ^"%s^";wait;writeip", userid, minute, ip)
		case 2:	server_cmd("kick #%d banid ^"%s^" ^"%s^";wait;writeid", userid, minute,  steamid)
	}
	log_amx("%L", 0,"LOG_BAN", name, userid, ip, (Ping[id] / exemple[id]))
}
