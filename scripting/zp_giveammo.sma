#include <amxmodx>
#include <amxmisc>
#include <zombie_plague_advance>

public plugin_init()
{
	register_plugin("[ZP] give ammo", "1.2", "Serbu");
	register_concmd("amx_giveammo", "CmdGiveAP", ADMIN_KICK, "- amx_giveeuro <nume> <cantitate>");
	register_concmd("amx_removeammo", "CmdRemoveAP", ADMIN_KICK, "- amx_removeeuro <nume> <cantitate>");
}

public CmdGiveAP ( id, level, cid )
{
	if(get_user_flags(id) & ADMIN_BAN)
	{

		new target[32], ammo[4];
		read_argv(1, target, 31);
		read_argv(2, ammo, 3);
		new player = cmd_target(id, target, CMDTARGET_NO_BOTS | CMDTARGET_ALLOW_SELF);
		
		if (!player)
		{
			client_print ( id, print_console, "Jucatorul nu a fost gasit, viziteaza zm.infectati.ro" );
			return PLUGIN_HANDLED;
		}
		new name[32], name2[32];
		get_user_name(id, name, 31);
		get_user_name(player, name2, 31);
		new packs = str_to_num(ammo);
		
		if (packs > 999)
			zp_set_user_ammo_packs ( player, 10 * (zp_get_user_ammo_packs(player) + packs ) );
		else
			zp_set_user_ammo_packs ( player, zp_get_user_ammo_packs(player) + packs );
		console_print(id, "I-ai adaugat lui %s %s Euro, viziteaza zm.infectati.ro", name, ammo);
	}
	else
		console_print(id, "Nu ai acces, viziteaza zm.infectati.ro")
	return PLUGIN_HANDLED;
}

public CmdRemoveAP ( id, level, cid )
{
	if(get_user_flags(id) & ADMIN_BAN)
	{

		new target[32], ammo[4];
		read_argv(1, target, 31);
		read_argv(2, ammo, 3);
		new player = cmd_target(id, target, CMDTARGET_NO_BOTS | CMDTARGET_ALLOW_SELF);
		
		if (!player)
		{
			client_print ( id, print_console, "Jucatorul nu a fost gasit, viziteaza zm.infectati.ro" );
			return PLUGIN_HANDLED;
		}
		new name[32], name2[32];
		get_user_name(id, name, 31);
		get_user_name(player, name2, 31);
		new packs = str_to_num(ammo);
		
		if (zp_get_user_ammo_packs(player) < packs)
		{
			client_print ( id, print_console, "Jucatorul are 0(zero) Euro, viziteaza zm.infectati.ro" );
			zp_set_user_ammo_packs ( player, 0 );
		}
		else
		{
			zp_set_user_ammo_packs ( player, zp_get_user_ammo_packs(player) - packs );
			console_print(id, "I-ai inlaturat lui %s %s Euro, viziteaza zm.infectati.ro", name, ammo);

		}
	}
	else
		console_print(id, "Nu ai acces, viziteaza zm.infectati.ro")
	return PLUGIN_HANDLED;
}