#include <amxmodx>
#include <amxmisc>

#define PLUGIN "Preturi"
#define VERSION "1.0"
#define AUTHOR "Serbu"

public plugin_init()
{
   register_plugin(PLUGIN, VERSION, AUTHOR)

   register_clcmd("say /preturi","preturi")
   register_clcmd("say_team /preturi","preturi")
   register_clcmd("say /pret","preturi")
   register_clcmd("say_team /pret","preturi")

}

public preturi(id)
{
	show_motd(id,"/addons/amxmodx/configs/preturi.html","preturi")
}