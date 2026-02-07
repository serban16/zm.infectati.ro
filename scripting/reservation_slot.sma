#include <amxmodx>
#include <amxmisc>

static const PLUGIN[] = "Advanced Admin Slots"
static const VERSION[] = "0.1.0"
static const AUTHOR[] = "SAMURAI"

new g_cmdLoopback[16]
new g_maxplayers

public plugin_init() 
{
	register_plugin(PLUGIN, VERSION, AUTHOR)
	register_cvar("amx_reservation","1")

	format(g_cmdLoopback, 15, "amxres%c%c%c%c" ,
	random_num('A','Z'), random_num('A','Z'), random_num('A','Z'), random_num('A','Z'))
	register_clcmd(g_cmdLoopback, "ackSignal")
	
	g_maxplayers = get_maxplayers()
}

public ackSignal(id) {
  server_cmd("kick #%d %s", get_user_userid(id),("Ai primit kick pentru rezervare slot"))
}
public client_authorized(id) {
  new players = get_playersnum(1)
  new limit = g_maxplayers - 1
  new resType = get_cvar_num("amx_reservation")
  if(!resType) return PLUGIN_CONTINUE
  new who
  if(players > limit) {
        if(get_user_flags(id) & ADMIN_RESERVATION) {
          switch(resType) {
                case 1:
					who = kickLag()
          }
          if(who) {
                new name[32]
                get_user_name(who, name, 31)
                client_cmd(id, ("echo ^"* %s a fost dat afara pentru a elibera un slot^""), name)
          }
          return PLUGIN_CONTINUE
        }
        client_cmd(id, g_cmdLoopback)
        return PLUGIN_HANDLED
  }
  return PLUGIN_CONTINUE
}

kickLag() {
  new who = 0, ping, loss, worst = -1
  for(new i = 1; i <= g_maxplayers; ++i) {
        if(!is_user_connected(i) && !is_user_connecting(i))
          continue
        if(get_user_flags(i) & ADMIN_RESERVATION)
          continue
        get_user_ping(i, ping, loss)
        if(ping > worst) {
          worst = ping
          who = i
        }
  }
  if(who) {
        client_cmd(who,("echo ^"Ai primit kick deoarece a intrat un admin cu slot^";%s"), g_cmdLoopback)
  }
  return who
}