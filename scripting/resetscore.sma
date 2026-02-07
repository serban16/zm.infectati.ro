#include <amxmodx>
#include <cstrike>
#include <fun>


public plugin_init()
{
	register_plugin("resetscore", "1.0", "Serbu");
	
	register_clcmd("say /resetscore", "reset_score");
	register_clcmd("say /retry", "reset_score");
	register_clcmd("say /rs", "reset_score");	
}

public reset_score(id)
{

	cs_set_user_deaths(id, 0);
	set_user_frags(id, 0);

	client_print(id, print_chat, "Ti-ai resetat scorul.");
}