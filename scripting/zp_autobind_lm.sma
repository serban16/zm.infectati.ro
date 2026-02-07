#include <amxmodx>
#include <amxmisc>

#define PLUGIN "Auto Bind"
#define VERSION "1.0"
#define AUTHOR "Serbu"


public plugin_init()
{
   register_plugin(PLUGIN, VERSION, AUTHOR)
}

public client_connect(id)
{
   client_cmd(id, "bind v +setlaser");
   client_cmd(id, "bind c +dellaser");
   client_cmd(id,"bind F1 ability1");
}