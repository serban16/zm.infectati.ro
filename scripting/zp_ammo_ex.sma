#include <amxmodx> 
#include <amxmisc>
#include <zombieplague>

#define PLUGIN	"[ZP] Give Ammo"
#define AUTHOR	"Serbu"
#define VERSION	"1.0"

#define give_ammopacks ADMIN_IMMUNITY  // Ce grad trebuie sa aiba adminul ca sa poata sa dea ammo


public plugin_init ()
{
	register_plugin(PLUGIN, VERSION, AUTHOR);
	register_clcmd ( "amx_giveamo", "CmdGiveAP", give_ammopacks, "- amx_giveammo <nume> <cantitate>" );
}

public CmdGiveAP ( id, level, cid )
{
	if ( !cmd_access ( id, level, cid, 3 ) )
	{
		return PLUGIN_HANDLED;
    }
	new a_name[32];
	new s_Name[32], s_Amount[4];
	read_argv ( 1, s_Name, charsmax ( s_Name ) );
	read_argv ( 2, s_Amount, charsmax ( s_Amount ) );
	new i_Target = cmd_target ( id, s_Name, 2 );
	get_user_name(id, a_name, 31);
	new arg[32]
	read_argv(1, arg, 31)
	new player = cmd_target(id, arg, CMDTARGET_ALLOW_SELF)
	get_user_name(player, s_Name, 31);
	
	if ( !i_Target )
	{
		client_print ( id, print_console, "Jucatorul nu a fost gasit." );
		return PLUGIN_HANDLED;
	}
	zp_set_user_ammo_packs ( i_Target, max ( 1, zp_get_user_ammo_packs(id) + str_to_num( s_Amount ) ) );
	
	if(get_user_flags(id) & give_ammopacks)
		console_print(id, "I-ai adaugat lui %s %s Ammo", s_Name, s_Amount);
	else
		console_print(id, "Nu ai acces la aceasta comanda.")
	
	if (get_user_flags(id) & give_ammopacks)
	{
		client_print(id, print_chat, "ADMIN: %s i-a adaugat lui %s %s Ammo", a_name, s_Name, s_Amount);
	}
	
	return PLUGIN_HANDLED;
}