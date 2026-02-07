#include <amxmodx>
#include <amxmisc> 

public plugin_init()
{
    register_plugin("ReclamaHud","1.0","Serbu")
    set_task(1.0, "show_timer",0,"",0,"b")
    return PLUGIN_CONTINUE
}

public show_timer(){
	
	new data[ 54 ];
	get_time( "%m/%d/%Y", data, 53 );
	new ora[ 54 ];
	get_time( "%H:%M:%S", ora, 53 );
	
	set_hudmessage(0,250,0,0.75,0.05,0, 1.0, 1.0, 0.1, 0.2, 4)
	show_hudmessage(0,"Ceasul este: %s^nData: %s^nForum: www.infectati.ro",ora,data)
	
	return PLUGIN_CONTINUE
}