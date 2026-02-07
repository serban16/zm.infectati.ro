#include <amxmodx>
#include <amxmisc>
#include <fakemeta>
#include <orpheu>

#define PLUGIN "Infect_Functions"
#define VERSION "2.1"
#define AUTHOR "INFECTATI.RO"

new ct[33], Float:start_time[33], nft;
new Float:gRadio[33]
new pTime, pBlock

new Array:aRule
new Array:aFile
new Array:aRuleType

new szRadioCommands[][] =
{
	"radio1", "coverme", "takepoint", "holdpos", "regroup", "followme", "takingfire",
	"radio2", "go", "fallback", "sticktog", "getinpos", "stormfront", "report",
	"radio3", "roger", "enemyspot", "needbackup", "sectorclear", "inposition", "reportingin", "getout", "negative", "enemydown"
}

new g_identificare[][] = 
{ 
	"fullupdate", 
	"echo_off", 
	"gX4takingfire", 
	"echo_on", 
	"gX4sticktog", 
	"gX4regroup", 
	"gX4holdpos", 
	"gX4getout" 
};
new toggle_mode;
new autobuy_mode;
new custom_mode;
new anti_hack;

public plugin_init() 
{ 
	register_plugin(PLUGIN, VERSION, AUTHOR);
	register_cvar("Infect_functions", VERSION, FCVAR_SERVER); 

	register_clcmd("cl_autobuy","cmd_check")
	register_clcmd("cl_rebuy","cmd_check")
	register_clcmd("cl_setautobuy","cmd_check")
	register_clcmd("cl_setrebuy","cmd_check")
	
	for (new i=0; i<sizeof g_identificare; i++) 
	{
		register_clcmd(g_identificare[i], "cfg_afc"); 
	}
	toggle_mode = register_cvar("infect_cfgfloodfix", "1");
	autobuy_mode = register_cvar("infect_autobuyfix", "1");
	pTime = register_cvar("infect_radioflood","5");
	nft = register_cvar("infect_name_flood", "20");
	custom_mode = register_cvar("infect_delete_custom","1");
	anti_hack = register_cvar("infect_anti_raiz","1");
	
	for (new i=0; i<sizeof szRadioCommands; i++)
	{
		register_clcmd(szRadioCommands[i], "cmdRadio")
	}
	pBlock = register_cvar("nrf_block_fith","0");
	register_message(get_user_msgid("SendAudio"),"FireInTheHole");
	register_cvar("srf_version",VERSION,FCVAR_SERVER|FCVAR_SPONLY); //Srf = Stop Radio Flooding :D, Last Plugin name
	
	register_concmd("amx_infectinfo", "show_uptime", ADMIN_KICK, "- amx_uptime vezi uptime-ul la server" );
	
	register_srvcmd("fw_add_file","file_add",_,"fw_add_file <ACCEPT | BLOCK> <filename>")
	register_srvcmd("fw_rules","show_rules")
	aRule=ArrayCreate(1,32)
	aRuleType=ArrayCreate(1,32)
	aFile=ArrayCreate(128,32)
	server_cmd("exec anti-hack.cfg")
	OrpheuRegisterHook(OrpheuGetFunction("FS_Open"),"FS_Open", OrpheuHookPre)
}

public plugin_cfg()
{
	new file[64]; get_localinfo("amxx_configsdir",file,63);

	format(file, 63, "%s/Infect_functions.cfg", file);

	if(file_exists(file))
		server_cmd("exec %s", file), server_exec();
}

public cmd_check(id)
{
	if(get_pcvar_num(autobuy_mode) == 1)
	{
		static arg[512], args, i
		args = read_argc()

		for(i = 1; i < args; ++i)
		{
			read_argv(i, arg, charsmax(arg))
			if(is_cmd_long(arg, charsmax(arg)))
			{
				server_cmd("kick #%d ^"Ai folosit Autobuy Bug !!!^"",get_user_userid(id));
				return PLUGIN_HANDLED
			}
		}
	}

	return PLUGIN_CONTINUE
} 

stock bool:is_cmd_long( string[], const len ) 
{ 
    static cmd[512] 

    while( strlen( string ) ) 
    { 
        strtok( string, cmd, charsmax( cmd ), string, len , ' ', 1 ) 

        if( strlen( cmd ) > 31 ) return true 
    } 

    return false 
}

public client_putinserver(id)
{
	ct[id]=0;
	start_time[id]=0.0;
}

public cfg_afc(id) 
{ 
	if (!is_user_connected(id)) 
	{ 
		return PLUGIN_HANDLED; 
	} 
	new name[32], userip[32]; 
	get_user_name(id, name, 31); 
	get_user_ip(id, userip, 31, 1); 
	new userid2 = get_user_userid(id); 
 
	switch(get_pcvar_num(toggle_mode)) 
	{ 
		case 1: 
		{ 
			server_cmd("kick #%d ^"Restrictionat pt FLOOD PERMANENT^"", userid2); 
		} 
		case 2:
		{ 
			server_cmd("kick #%d ^"Restrictionat pt FLOOD PERMANENT^";wait;addip 0.0 ^"%s^";wait;writeip", userid2, userip); 
		} 
	}
	return PLUGIN_CONTINUE; 
}

public cmdRadio(id)
{
	
	new iTime = get_pcvar_num(pTime)
	
	if(!is_user_alive(id))
	{
		return PLUGIN_HANDLED_MAIN
	}
	
	if(iTime > 0)
	{  		
		new Float:fTime = get_gametime()
		
		if(fTime - gRadio[id] < iTime)
		{
			
			client_print(id,print_center,"Scuze, dar nu poti folosi aceasta comanda!")
			
			return PLUGIN_HANDLED_MAIN
		}
		
		gRadio[id] = fTime
	}
	
	return PLUGIN_CONTINUE
}

public FireInTheHole(msgid,msg_dest,msg_entity)
{
	
	if(get_msg_args() < 3 || get_msg_argtype(2) != ARG_STRING)
	{
		return PLUGIN_HANDLED
	}
	
	new szArg[32]
	
	get_msg_arg_string(2,szArg,31)
	
	if(equal(szArg ,"%!MRAD_FIREINHOLE") && get_pcvar_num(pBlock))
	{
		return PLUGIN_HANDLED;
	}
	
	return PLUGIN_CONTINUE;
}

public plugin_end()
{
	if(get_pcvar_num(custom_mode) == 1)
	{
		new szDir[] = "/", DirPointer, szFile[32];
		DirPointer = open_dir(szDir, "", 0);
		
		while(next_file(DirPointer, szFile, sizeof szFile - 1))
		{
			if(szFile[0] == '.')
				continue;

			if(containi(szFile, "custom.hpk") != -1)
			{
				delete_file(szFile);
				break;
			}
		}
		close_dir(DirPointer);
	}
	return 1;
}

public client_infochanged(id)
{
	new newname[32], oldname[32];
	get_user_info(id, "name", newname,31);
	get_user_name(id, oldname, 31);
		
	if(equal(newname, oldname))
		return PLUGIN_HANDLED;
	else
	{	
		reset:
		if(ct[id]==0)
		{
			start_time[id] = get_gametime();
			ct[id]++;
		}
		else
		{
			if(get_gametime() - start_time[id] < get_pcvar_num(nft))
				ct[id]++;
			else
			{	
				ct[id]=0;
				goto reset;
			}
		}
		
		if(ct[id]==3)
		{
			client_print(id, print_chat, "*** Nick change flood! Opreste-te sau vei primi kick! ***");
			client_print(id, print_chat, "*** Nick change flood! Opreste-te sau vei primi kick! ***");
		}
		
		if(ct[id]==4)
		{
			if( (get_gametime() - start_time[id]) < get_pcvar_num(nft))
			{
				ct[id]=0;
				server_cmd("kick #%d ^"%s^"", get_user_userid(id), "Kick pentru flood cu numele.");
				return PLUGIN_HANDLED;
			}
			else
			{
				ct[id]=0;
				goto reset;
			}
		}
	}
	return PLUGIN_HANDLED;
}

public OrpheuHookReturn:FS_Open(test[],b[])
{
    if((containi(b,"w")!=-1) && (get_pcvar_num(anti_hack) == 1))
    {
        new rule
        strtolower(test)
        replace_all(test,strlen(test),"/","\")
        new len=strlen(test)
        new count=ArraySize(aFile)
        for(new i;(i<count && !rule);i++)
        {
            new file[128]
            ArrayGetString(aFile,i,file,127)
            switch(ArrayGetCell(aRuleType,i))
            {
                case 0:if(equal(test,file)) rule=i+1
                case 1:if(containi(test,file)==len-strlen(file)) rule=i+1
                case 2:if(containi(test,file)==0) rule=i+1
                case 3:if(containi(test,file)!=-1) rule=i+1
            }
        }
        if(rule)
        {
            if(ArrayGetCell(aRule,--rule))
            {
                return OrpheuIgnored;
            }
            else
            {
                return OrpheuSupercede;
            }
        }
        else
        {
            return OrpheuSupercede;
        }
    }
    return OrpheuIgnored;
}


public file_add()
{
    if(get_pcvar_num(anti_hack) == 1)
    {
    new rule[10]
    new file[128]
    read_argv(1,rule,9)
    read_argv(2,file,127)
    if(!equal(rule,"ACCEPT") && !equal(rule,"BLOCK"))
    {
        console_print(0,"RULE ADD ERROR use <ACCEPT | BLOCK>")
        return PLUGIN_HANDLED;
    }
    if(strlen(file)<1)
    {
        console_print(0,"RULE ADD ERROR ^" ^" to specify filename")
        return PLUGIN_HANDLED;
    }
    ArrayPushCell(aRule,equal(rule,"ACCEPT"))
    ArrayPushCell(aRuleType,((file[0]==42) + 2*(file[strlen(file)-1]==42)))
    replace_all(file,127,"*","")
    replace_all(file,127,"/","\")
    ArrayPushString(aFile,file)
    return PLUGIN_HANDLED;
    }
    return PLUGIN_HANDLED;
}

public show_rules()
{
    if(get_pcvar_num(anti_hack) == 1)
	{
    if(!ArraySize(aFile))
        console_print(0,"NO RULES FOUND!")
    else
    {
        new count=ArraySize(aFile)
        for(new i;i<count;i++)
        {
            new file[128]
            ArrayGetString(aFile,i,file,127)
            console_print(0,"[%d] %s %s%s%s",i,(ArrayGetCell(aRule,i))?"ACCEPT":"BLOCK",(ArrayGetCell(aRuleType,i) & 1)?"*":"",file,(ArrayGetCell(aRuleType,i) & 2)?"*":"")
        }
    
    }
    }

}

public show_uptime(id)
{
	new Float:UpTime_F = Float:engfunc(EngFunc_Time);

	new UpTime_str[32];
	float_to_str(UpTime_F, UpTime_str, 31);

	new UpTime = str_to_num(UpTime_str);

	new Seconds = UpTime % 60;
	new Minutes = (UpTime / 60) % 60;
	new Hours = (UpTime / 3600) % 24;
	new Days = UpTime / 86400;

	console_print(id, "----------------------------------------------------");
	console_print(id, "--- Obtiuni Infect_functions ---");
	console_print(id, "----------------------------------------------------");
	
	if(get_pcvar_num(anti_hack))
		console_print(id, "--- Protectie Raiz0 : ACTIVAT ---");
	else
		console_print(id, "--- Protectie Raiz0 : DEZACTIVAT ---");
	if(get_pcvar_num(toggle_mode))
		console_print(id, "--- Protectie FloodCFG : ACTIVAT ---");
	else
		console_print(id, "--- Protectie FloodCFG : DEZACTIVAT ---");
	
	if(get_pcvar_num(autobuy_mode) == 1)
		console_print(id, "--- Protectie AutoBUY Exploit : ACTIVAT ---");
	else
		console_print(id, "--- Protectie AutoBUY Exploit : DEZACTIVAT ---");
		
	if(get_pcvar_num(pTime) > 0)
		console_print(id, "--- Protectie RadioFlood : ACTIVAT ---");
	else
		console_print(id, "--- Protectie RadioFlood : DEZACTIVAT ---");
	
	if(get_pcvar_num(nft) > 0)
		console_print(id, "--- Protectie Anti-Flood Name : ACTIVAT ---");
	else
		console_print(id, "--- Protectie Anti-Flood Name : DEZACTIVAT ---");
	
	if(get_pcvar_num(custom_mode) == 1)
		console_print(id, "--- Auto-Delete custom.hpk : ACTIVAT ---");
	else
		console_print(id, "--- Auto-Delete custom.hpk : DEZACTIVAT ---");
	console_print(id, "----------------------------------------------------");
	console_print(id, "--- Server Uptime---");
	console_print(id, "----------------------------------------------------");
	console_print(id, "--- %iD:%iH:%iMin:%iSec ---", Days, Hours, Minutes, Seconds);
	console_print(id, "----------------------------------------------------");

	return 1;
}