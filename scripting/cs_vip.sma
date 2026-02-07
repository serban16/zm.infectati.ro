#include <amxmodx>
#include <amxmisc>
#include <cstrike>
#include <fun>
#include <engine>

#define DAMAGE_RECIEVED

#define PLUGIN "CS_Vip"
#define VERSION "1.0"
#define AUTHOR "Serbu"

#define FLAG_A (1<<0)
#define FLAG_B (1<<1)
#define FLAG_C (1<<2)
#define FLAG_D (1<<3)
#define FLAG_E (1<<4)
#define FLAG_K (1<<10)

new amx_password_field_string[30]
new g_user_privileges[33]
enum _:database_items
{
	auth[50],
	password[50],
	accessflags,
	flags
}
new vips_database[database_items]
new Array:database_holder

new const
	MODELS_PAS[]	= "Parola invalida! Contactea-za Administratorul.";
	
new jumpnum[33] = 0
new bool:dojump[33] = false

static const COLOR[] = "^x04" //green
new maxplayers
new gmsgSayText
new mpd, mkb, mhb
new g_MsgSync
new health_add
new health_hs_add
new health_max
new nKiller
new nKiller_hp
new nHp_add
new nHp_max
new g_awp_active
new g_menu_active
new multijump
new bool:has_parachute[33]
new para_ent[33]
new pDetach, pFallSpeed, pEnabled
new CurrentRound
new bool:HasC4[33]
#define Keysrod (1<<0)|(1<<1)|(1<<9) // Keys: 1234567890
#if defined DAMAGE_RECIEVED
	new g_MsgSync2
#endif

public plugin_init()
{
	register_plugin(PLUGIN, VERSION, AUTHOR)
	get_cvar_string("amx_password_field", amx_password_field_string, charsmax(amx_password_field_string))
	register_concmd("amx_vips", "reload_vips", ADMIN_CFG)
	reload_vips()
	register_event("ResetHUD", "resetModel", "be")
	pEnabled = register_cvar("sv_parachute", "1" )
	pFallSpeed = register_cvar("parachute_fallspeed", "100")
	pDetach = register_cvar("parachute_detach", "1")
	mpd = register_cvar("vip_bani_pe_damage","5")
	mkb = register_cvar("vip_bani_omorare","200")
	mhb = register_cvar("vip_bani_hs","500")
	multijump = register_cvar("vip_multijump","2")
	health_add = register_cvar("vip_hp", "15")
	health_hs_add = register_cvar("vip_hp_hs", "30")
	health_max = register_cvar("vip_max_hp", "150")
	g_awp_active = register_cvar("vip_awp_activ", "1")
	g_menu_active = register_cvar("vip_meniu_activ", "1")
	register_event("Damage","Damage","b")
	register_event("DeathMsg","death_msg","a")
	register_menucmd(register_menuid("rod"), Keysrod, "Pressedrod")
	register_clcmd("awp","HandleCmd")
    	register_clcmd("sg550","HandleCmd")
    	register_clcmd("g3sg1","HandleCmd")
	register_clcmd("say /wantvip","ShowMotd")
	maxplayers = get_maxplayers()
	gmsgSayText = get_user_msgid("SayText")
	register_clcmd("say", "handle_say")
	register_clcmd("say_team", "handle_say")
	register_logevent("LogEvent_RoundStart", 2, "1=Round_Start" );
	register_event("TextMsg","Event_RoundRestart","a","2&#Game_w")
	register_event("TextMsg","Event_RoundRestart","a","2&#Game_C");
	register_event("DeathMsg", "hook_death", "a", "1>0")
	register_event("Damage", "on_damage", "b", "2!0", "3=0", "4!0")
	g_MsgSync = CreateHudSyncObj()
#if defined DAMAGE_RECIEVED
	g_MsgSync2 = CreateHudSyncObj()
#endif

	//Setup jtp10181 CVAR
	new cvarString[256], shortName[16]
	copy(shortName,15,"chute")

	register_cvar("jtp10181","",FCVAR_SERVER|FCVAR_SPONLY)
	get_cvar_string("jtp10181",cvarString,255)
	
	if (strlen(cvarString) == 0)
	{
		formatex(cvarString,255,shortName)
		set_cvar_string("jtp10181",cvarString)
	}
	else if (contain(cvarString,shortName) == -1)
	{
		format(cvarString,255,"%s,%s",cvarString, shortName)
		set_cvar_string("jtp10181",cvarString)
	}
}

public plugin_cfg()
{	
	new cfgdir[32]
	get_configsdir(cfgdir, charsmax(cfgdir))
	
	server_cmd("exec %s/cs_vips.cfg", cfgdir)
}

public plugin_precache() 
{
	precache_model("models/player/vip_ct/vip_ct.mdl")
	precache_model("models/player/vip_te/vip_te.mdl")
	precache_model("models/parachute.mdl")
}

public resetModel(id, level, cid) {
	setVip()
	if(g_user_privileges[id] & FLAG_A)
	{
		new CsTeams:userTeam = cs_get_user_team(id)
		if (userTeam == CS_TEAM_T)
			cs_set_user_model(id, "vip_te")
		else if(userTeam == CS_TEAM_CT)
			cs_set_user_model(id, "vip_ct")
		else
			cs_reset_user_model(id)
	}
	if(g_user_privileges[id] & FLAG_D)
	{
		if(para_ent[id] > 0)
		{
			remove_entity(para_ent[id])
			set_user_gravity(id, 1.0)
			para_ent[id] = 0
		}
		has_parachute[id] = true
	}
}

public client_connect(id)
{
	set_flags(id)
}

public client_putinserver(id)
{
	jumpnum[id] = 0
	dojump[id] = false
}

public client_disconnect(id)
{
	jumpnum[id] = 0
	dojump[id] = false
}

public reload_vips() {
	
	if(database_holder) ArrayDestroy(database_holder)
	database_holder = ArrayCreate(database_items)
	new configsDir[64]
	get_configsdir(configsDir, 63)
	format(configsDir, 63, "%s/vips.ini", configsDir)
	
	new File=fopen(configsDir,"r");
	
	if (File)
	{
		static Text[512], Flags[32], AuthData[50], Privileges_Flags[32], Password[50]
		while (!feof(File))
		{
			fgets(File,Text,sizeof(Text)-1);
			
			trim(Text);
			
			// comment
			if (Text[0]==';') 
			{
				continue;
			}
			
			Flags[0]=0;
			AuthData[0]=0;
			Privileges_Flags[0]=0;
			Password[0]=0;
			
			// not enough parameters
			if (parse(Text,AuthData,sizeof(AuthData)-1,Password,sizeof(Password)-1,Privileges_Flags,sizeof(Privileges_Flags)-1,Flags,sizeof(Flags)-1) < 2)
			{
				continue;
			}

			vips_database[auth] = AuthData
			vips_database[password] = Password
			vips_database[accessflags] = read_flags(Privileges_Flags)
			vips_database[flags] = read_flags(Flags)
			ArrayPushArray(database_holder, vips_database)
		}
		
		fclose(File);
	}
	else log_amx("Error: vips.ini file doesn't exist")
}

public set_flags(id) {
	
	static ip[31], name[51], index, client_password[30], size, log_flags[11]
	get_user_ip(id, ip, 30, 1)
	get_user_name(id, name, 50)
	get_user_info(id, amx_password_field_string, client_password, charsmax(client_password))
	
	g_user_privileges[id] = 0
	size = ArraySize(database_holder)
	
	for(index=0; index < size ; index++) {
		ArrayGetArray(database_holder, index, vips_database)
		if(vips_database[flags] & FLAG_D) {
			if(equal(ip, vips_database[auth])) {
				if(!(vips_database[flags] & FLAG_E)) {
					if(equal(client_password, vips_database[password]))
						g_user_privileges[id] = vips_database[accessflags]
					else if(vips_database[flags] & FLAG_A) {
						server_cmd("kick #%d ^"%L^"", get_user_userid(id), id, MODELS_PAS)
						break
					}
				}
				else g_user_privileges[id] = vips_database[accessflags]
				get_flags(vips_database[accessflags], log_flags, 10)
				break
			}
		}
		else {
			if(vips_database[flags] & FLAG_K) {
				if((vips_database[flags] & FLAG_B && contain(name, vips_database[auth]) != -1) || equal(name, vips_database[auth])) {
					if(!(vips_database[flags] & FLAG_E)) {
						if(equal(client_password, vips_database[password]))
							g_user_privileges[id] = vips_database[accessflags]
						else if(vips_database[flags] & FLAG_A) {
							server_cmd("kick #%d ^"%L^"", get_user_userid(id), id, MODELS_PAS)
							break
						}
					}
					else g_user_privileges[id] = vips_database[accessflags]
					get_flags(vips_database[accessflags], log_flags, 10)
					break
				}
			}
			else {
				if((vips_database[flags] & FLAG_B && containi(name, vips_database[auth]) != -1) || equali(name, vips_database[auth])) {
					if(!(vips_database[flags] & FLAG_E)) {
						if(equal(client_password, vips_database[password]))
							g_user_privileges[id] = vips_database[accessflags]
						else if(vips_database[flags] & FLAG_A) {
							server_cmd("kick #%d ^"%L^"", get_user_userid(id), id, MODELS_PAS)
							break
						}
					}
					else g_user_privileges[id] = vips_database[accessflags]
					get_flags(vips_database[accessflags], log_flags, 10)
					break
				}
			}
		}
	}
}

//PLUGIN -->

public on_damage(id)
{
	new attacker = get_user_attacker(id)

#if defined DAMAGE_RECIEVED
	// id should be connected if this message is sent, but lets check anyway
	if ( is_user_connected(id) && is_user_connected(attacker) )
	if (g_user_privileges[attacker] & FLAG_A)
	{
		new damage = read_data(2)

		set_hudmessage(255, 0, 0, 0.45, 0.50, 2, 0.1, 4.0, 0.1, 0.1, -1)
		ShowSyncHudMsg(id, g_MsgSync2, "%i^n", damage)
#else
	if ( is_user_connected(attacker) && (g_user_privileges[attacker] & FLAG_B) )
	{
		new damage = read_data(2)
#endif
		set_hudmessage(0, 100, 200, -1.0, 0.55, 2, 0.1, 4.0, 0.02, 0.02, -1)
		ShowSyncHudMsg(attacker, g_MsgSync, "%i^n", damage)
	}
}

public Damage(id)
{
	new weapon, hitpoint, attacker = get_user_attacker(id,weapon,hitpoint)
	if(attacker<=maxplayers && is_user_alive(attacker) && attacker!=id)
	if (g_user_privileges[attacker] & FLAG_A) 
	{
		new money = read_data(2) * get_pcvar_num(mpd)
		if(hitpoint==1) money += get_pcvar_num(mhb)
		cs_set_user_money(attacker,cs_get_user_money(attacker) + money)
	}
}

public death_msg()
{
	if(read_data(1)<=maxplayers && read_data(1) && read_data(1)!=read_data(2)) cs_set_user_money(read_data(1),cs_get_user_money(read_data(1)) + get_pcvar_num(mkb) - 300)
}

public LogEvent_RoundStart()
{
	CurrentRound++;
	new players[32], player, pnum;
	get_players(players, pnum, "a");
	for(new i = 0; i < pnum; i++)
	{
		player = players[i];
		if(is_user_alive(player) && (g_user_privileges[player] & FLAG_B))
		{
			give_item(player, "weapon_hegrenade")
			give_item(player, "weapon_flashbang")
			give_item(player, "weapon_flashbang")
			give_item(player, "weapon_smokegrenade")
			give_item(player, "item_assaultsuit")
			give_item(player, "item_thighpack")
			
			if (!get_pcvar_num(g_menu_active))
				return PLUGIN_CONTINUE
			
			if(CurrentRound >= 3)
			{
				Showrod(player);
			}
		}
	}
	return PLUGIN_HANDLED
}

public Event_RoundRestart()
{
	CurrentRound=0;
}

public hook_death()
{
   // Killer id
   nKiller = read_data(1)
   
   if ( (read_data(3) == 1) && (read_data(5) == 0) )
   {
      nHp_add = get_pcvar_num (health_hs_add)
   }
   else
      nHp_add = get_pcvar_num (health_add)
   nHp_max = get_pcvar_num (health_max)
   // Updating Killer HP

   if(!(g_user_privileges[nKiller] & FLAG_B))
   return;

   nKiller_hp = get_user_health(nKiller)
   nKiller_hp += nHp_add
   // Maximum HP check
   if (nKiller_hp > nHp_max) nKiller_hp = nHp_max
   set_user_health(nKiller, nKiller_hp)
   // Hud message "Healed +15/+30 hp"
   set_hudmessage(0, 255, 0, -1.0, 0.15, 0, 1.0, 1.0, 0.1, 0.1, -1)
   show_hudmessage(nKiller, "Healed +%d hp", nHp_add)
   // Screen fading
   message_begin(MSG_ONE, get_user_msgid("ScreenFade"), {0,0,0}, nKiller)
   write_short(1<<10)
   write_short(1<<10)
   write_short(0x0000)
   write_byte(0)
   write_byte(0)
   write_byte(200)
   write_byte(75)
   message_end()
 
}

public Showrod(id) {
	show_menu(id, Keysrod, "Arme gratuite de VIP^n\w1. M4A1+Deagle ^n\w2. AK47+Deagle^n0. Iesire^n", -1, "rod") // Display menu
}
public Pressedrod(id, key) {
	/* Menu:
	* VIP Menu
	* 1. Get M4A1+Deagle
	* 2. Get AK47+Deagle
	* 0. Exit
	*/
	switch (key) {
		case 0: { 
			if (user_has_weapon(id, CSW_C4) && get_user_team(id) == 1)
				HasC4[id] = true;
			else
				HasC4[id] = false;
            
			strip_user_weapons (id)
			give_item(id,"weapon_m4a1")
			give_item(id,"ammo_556nato")
			give_item(id,"ammo_556nato")
			give_item(id,"ammo_556nato")
			give_item(id,"weapon_deagle")
			give_item(id,"ammo_50ae")
			give_item(id,"ammo_50ae")
			give_item(id,"ammo_50ae")
			give_item(id,"ammo_50ae")
			give_item(id,"ammo_50ae")
			give_item(id,"ammo_50ae")
			give_item(id,"ammo_50ae")
			give_item(id,"weapon_knife")
			give_item(id,"weapon_hegrenade")
			give_item(id, "weapon_flashbang");
			give_item(id, "weapon_flashbang");
			give_item(id, "weapon_smokegrenade");
			give_item(id, "item_assaultsuit");
			give_item(id, "item_thighpack");
			client_print(id, print_center, "Ai primit gratuit M4A1 si Deagle")
			
			if (HasC4[id])
			{
				give_item(id, "weapon_c4");
				cs_set_user_plant( id );
			}
			}
		case 1: { 
			if (user_has_weapon(id, CSW_C4) && get_user_team(id) == 1)
				HasC4[id] = true;
			else
				HasC4[id] = false;
            
			strip_user_weapons (id)
			give_item(id,"weapon_ak47")
			give_item(id,"ammo_762nato")
			give_item(id,"ammo_762nato")
			give_item(id,"ammo_762nato")
			give_item(id,"weapon_deagle")
			give_item(id,"ammo_50ae")
			give_item(id,"ammo_50ae")
			give_item(id,"ammo_50ae")
			give_item(id,"ammo_50ae")
			give_item(id,"ammo_50ae")
			give_item(id,"ammo_50ae")
			give_item(id,"ammo_50ae")
			give_item(id,"weapon_knife")
			give_item(id,"weapon_hegrenade")
			give_item(id, "weapon_flashbang");
			give_item(id, "weapon_flashbang");
			give_item(id, "weapon_smokegrenade");
			give_item(id, "item_assaultsuit");
			give_item(id, "item_thighpack");
			client_print(id, print_center, "Ai primit gratuit AK47 si Deagle")
			
			if (HasC4[id])
			{
				give_item(id, "weapon_c4");
				cs_set_user_plant( id );
			}
			}
		case 9: { 			
		}
	}
	return PLUGIN_CONTINUE
}

public HandleCmd(id){
	if (!get_pcvar_num(g_awp_active))
      return PLUGIN_CONTINUE
	if(g_user_privileges[id] & FLAG_C)	
		return PLUGIN_CONTINUE
	client_print(id, print_center, "Sniper doar pentru VIP")
	return PLUGIN_HANDLED
}

public ShowMotd(id)
{
 show_motd(id, "vip.txt")
}
public setVip()
{
	new players[32], pNum
	get_players(players, pNum, "a")

	for (new i = 0; i < pNum; i++)
	{
		new id = players[i]
		if (g_user_privileges[id] & FLAG_A)
		{
			message_begin(MSG_ALL, get_user_msgid("ScoreAttrib"))
			write_byte(id)
			write_byte(4)
			message_end()
		}
	}
	return PLUGIN_HANDLED
}

public client_PreThink(id)
{
    // Multi-Jump
    if(is_user_alive(id) && (g_user_privileges[id] & FLAG_E))
    {
        new nbut = get_user_button(id)
        new obut = get_user_oldbutton(id)
        if((nbut & IN_JUMP) && !(get_entity_flags(id) & FL_ONGROUND) && !(obut & IN_JUMP))
        {
            if(jumpnum[id] < get_pcvar_num(multijump))
            {
                dojump[id] = true
                jumpnum[id]++
            }
        }
        if((nbut & IN_JUMP) && (get_entity_flags(id) & FL_ONGROUND))
            jumpnum[id] = 0
    }


    // Parachute
    if (get_pcvar_num(pEnabled) && (g_user_privileges[id] & FLAG_D))
    {
    if (!is_user_alive(id) || !has_parachute[id])
        return PLUGIN_CONTINUE
    
    new Float:fallspeed = get_pcvar_float(pFallSpeed) * -1.0
    new Float:frame
    
    new button = get_user_button(id)
    new oldbutton = get_user_oldbutton(id)
    new flags = get_entity_flags(id)
    
    if (para_ent[id] > 0 && (flags & FL_ONGROUND)) {
        
        if (get_pcvar_num(pDetach)) {
            if (get_user_gravity(id) == 0.1)
                set_user_gravity(id, 1.0)
            
            if (entity_get_int(para_ent[id],EV_INT_sequence) != 2) {
                entity_set_int(para_ent[id], EV_INT_sequence, 2)
                entity_set_int(para_ent[id], EV_INT_gaitsequence, 1)
                entity_set_float(para_ent[id], EV_FL_frame, 0.0)
                entity_set_float(para_ent[id], EV_FL_fuser1, 0.0)
                entity_set_float(para_ent[id], EV_FL_animtime, 0.0)
                entity_set_float(para_ent[id], EV_FL_framerate, 0.0)
            }
            
            frame = entity_get_float(para_ent[id],EV_FL_fuser1) + 2.0
            entity_set_float(para_ent[id],EV_FL_fuser1,frame)
            entity_set_float(para_ent[id],EV_FL_frame,frame)
            
            if (frame > 254.0) {
                remove_entity(para_ent[id])
                para_ent[id] = 0
            }
        }
        else {
            remove_entity(para_ent[id])
            set_user_gravity(id, 1.0)
            para_ent[id] = 0
        }
    }
    
    if (button & IN_USE) {
        
        new Float:velocity[3]
        entity_get_vector(id, EV_VEC_velocity, velocity)
        
        if (velocity[2] < 0.0) {
            
            if(para_ent[id] <= 0) {
                para_ent[id] = create_entity("info_target")
                if(para_ent[id] > 0) {
                    entity_set_string(para_ent[id],EV_SZ_classname,"parachute")
                    entity_set_edict(para_ent[id], EV_ENT_aiment, id)
                    entity_set_edict(para_ent[id], EV_ENT_owner, id)
                    entity_set_int(para_ent[id], EV_INT_movetype, MOVETYPE_FOLLOW)
                    entity_set_model(para_ent[id], "models/parachute.mdl")
                    entity_set_int(para_ent[id], EV_INT_sequence, 0)
                    entity_set_int(para_ent[id], EV_INT_gaitsequence, 1)
                    entity_set_float(para_ent[id], EV_FL_frame, 0.0)
                    entity_set_float(para_ent[id], EV_FL_fuser1, 0.0)
                }
            }
            
            if (para_ent[id] > 0) {
                
                entity_set_int(id, EV_INT_sequence, 3)
                entity_set_int(id, EV_INT_gaitsequence, 1)
                entity_set_float(id, EV_FL_frame, 1.0)
                entity_set_float(id, EV_FL_framerate, 1.0)
                set_user_gravity(id, 0.1)
                
                velocity[2] = (velocity[2] + 40.0 < fallspeed) ? velocity[2] + 40.0 : fallspeed
                entity_set_vector(id, EV_VEC_velocity, velocity)
                
                if (entity_get_int(para_ent[id],EV_INT_sequence) == 0) {
                    
                    frame = entity_get_float(para_ent[id],EV_FL_fuser1) + 1.0
                    entity_set_float(para_ent[id],EV_FL_fuser1,frame)
                    entity_set_float(para_ent[id],EV_FL_frame,frame)
                    
                    if (frame > 100.0) {
                        entity_set_float(para_ent[id], EV_FL_animtime, 0.0)
                        entity_set_float(para_ent[id], EV_FL_framerate, 0.4)
                        entity_set_int(para_ent[id], EV_INT_sequence, 1)
                        entity_set_int(para_ent[id], EV_INT_gaitsequence, 1)
                        entity_set_float(para_ent[id], EV_FL_frame, 0.0)
                        entity_set_float(para_ent[id], EV_FL_fuser1, 0.0)
                    }
                }
            }
        }
        else if (para_ent[id] > 0) {
            remove_entity(para_ent[id])
            set_user_gravity(id, 1.0)
            para_ent[id] = 0
        }
    }
    else if ((oldbutton & IN_USE) && para_ent[id] > 0 ) {
        remove_entity(para_ent[id])
        set_user_gravity(id, 1.0)
        para_ent[id] = 0
    }
    }
}

public client_PostThink(id)
{
	if(is_user_alive(id) && (g_user_privileges[id] & FLAG_E))
	{
		if(dojump[id] == true)
		{
			new Float:velocity[3]	
			entity_get_vector(id,EV_VEC_velocity,velocity)
			velocity[2] = random_float(265.0,285.0)
			entity_set_vector(id,EV_VEC_velocity,velocity)
			dojump[id] = false
		}
	}
}

public plugin_natives()
{
    set_module_filter("module_filter")
    set_native_filter("native_filter")
}

public module_filter(const module[])
{
    if (!cstrike_running() && equali(module, "cstrike")) {
        return PLUGIN_HANDLED
    }
    
    return PLUGIN_CONTINUE
}

public native_filter(const name[], index, trap)
{
    if (!trap) return PLUGIN_HANDLED
    
    return PLUGIN_CONTINUE
}

public handle_say(id) {
	if(is_user_connected(id))
	{
		new said[192]
		read_args(said,192)
		if((contain(said, "/vips") != -1) || (contain(said, "/vip") != -1))
			set_task(0.1,"print_adminlist",id)
	
		new args[128]
		read_args(args, 127)
		remove_quotes(args)
	}
}

public print_adminlist(user) 
{
	new adminnames[33][32]
	new message[256]
	new id, count, x, len
	
	for(id = 1 ; id <= maxplayers ; id++)
		if(is_user_connected(id))
			if(g_user_privileges[id] & FLAG_A)
				get_user_name(id, adminnames[count++], 31)

	len = format(message, 255, "%s VIP ONLINE: ",COLOR)
	if(count > 0) {
		for(x = 0 ; x < count ; x++) {
			len += format(message[len], 255-len, "%s%s ", adminnames[x], x < (count-1) ? ", ":"")
			if(len > 96 ) {
				print_message(user, message)
				len = format(message, 255, "%s ",COLOR)
			}
		}
		print_message(user, message)
	}
	else {
		len += format(message[len], 255-len, "Nici un VIP Online.")
		print_message(user, message)
	}
}

print_message(id, msg[]) {
	message_begin(MSG_ONE, gmsgSayText, {0,0,0}, id)
	write_byte(id)
	write_string(msg)
	message_end()
}