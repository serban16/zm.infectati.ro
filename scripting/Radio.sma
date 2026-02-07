#include <amxmodx>
#include <amxmisc>

public plugin_init()
{
   register_plugin("Radio", "2.0", "Jamez")

   register_clcmd("say \ajutor","radiol")
   register_clcmd("say_team \ajutor","radiol")
   register_clcmd("say \laser","stopradio")
   register_clcmd("say_team \laser","stopradio")
}

public radiol(id)
{
   show_motd(id,"addons\amxmodx\configs\radiolive.html","Radio")
   return PLUGIN_HANDLED
}

public stopradio(id)
{
   show_motd(id,"addons\amxmodx\configs\stopradio.html","Stop Radio")
   return PLUGIN_HANDLED
}

