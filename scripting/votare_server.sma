#include < amxmodx >

public plugin_init(){
   register_plugin("Votare", "0.1", "Serbu")
   
   register_clcmd("say /vot", "vot")
   register_clcmd("say_team /vot", "vot")
   register_clcmd("say /vote", "vot")
   register_clcmd("say_team /vote", "vot")
   register_clcmd("say /voteaza", "vot")
   register_clcmd("say_team /voteaza", "vot")
}

public vot(id)
   show_motd(id, "vot.html")