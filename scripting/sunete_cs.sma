#include <amxmodx>
#include <amxmisc>

#define PLUGIN_NAME "Ultimate KillStreak Advanced"
#define PLUGIN_VERSION "0.7"
#define PLUGIN_AUTHOR "SAMURAI" 


new kills[33] = {0,...};
new deaths[33] = {0,...};
new firstblood
new kill[33][24];

#define LEVELS 10
#define hsounds 2
#define knsounds 2
#define fbsounds 2
#define prpsounds 3
#define suicidesounds 4
#define maxdbsounds 2
#define TASK_CLEAR_KILL    100

new hsenable
new knifeenable
new firstbloodenable
new nadecvar
new suicidecvar
new cvardouble
new rnstartcvar
new killstreaktype


new levels[10] = {3, 4, 6, 8, 10, 12,14,15,16,18};

new sounds[10][] = 
{
"ultimate_sounds/triplekill_ultimate", 
"ultimate_sounds/multikill_ultimate", 
"ultimate_sounds/ultrakill_ultimate",
"ultimate_sounds/killingspree_ultimate", 
"ultimate_sounds/megakill_ultimate", 
"ultimate_sounds/holyshit_ultimate",
"ultimate_sounds/ludicrouskill_ultimate",
"ultimate_sounds/rampage_ultimate",
"ultimate_sounds/unstoppable_ultimate",
"ultimate_sounds/monsterkill_ultimate"
};

new messages[10][] = 
{
"%s: Triple Kill !", 
"%s: Multi Kill !",
"%s: Ultra Kill !", 
"%s: Killing Spree !",
"%s: Mega Kill !",
"%s: Holy Shit !",
"%s: Ludicrous Kill !", 
"%s: Rampage !",
"%s: Unstoppable !", 
"%s: M o n s t e R  K i L L ! ! !"
};

new hslist[hsounds][] = 
{
"ultimate_sounds/headshot1_ultimate",
"ultimate_sounds/headshot2_ultimate"
}

new fblist[fbsounds][]=
{
"ultimate_sounds/firstblood1_ultimate",
"ultimate_sounds/firstblood2_ultimate"
}

new preplist[prpsounds][]=
{
"ultimate_sounds/prepare1_ultimate",
"ultimate_sounds/prepare2_ultimate",
"ultimate_sounds/prepare3_ultimate"
}


new fbmessages[1][]=
{
"%s : First Blood !"
}

new hsmessages[3][]=
{
"%s i-a taiat capul lui %s !!",
"%s a realizat un superb headshot cu %s !",
"%s ia dat un headshout lui %s!"
}

new knlist[knsounds][]=
{
"ultimate_sounds/knife1_ultimate",
"ultimate_sounds/knife2_ultimate"
}

new knmessages[3][]=
{
"%s l-a taiat felii pe %s",
"%s a scos cutitul si l-a taiat pe %s",	
"%s l-a taiat %s"
}

new nademessages[3][]=
{
"%s got a big explosion for %s",
"%s made a precision throw to %s",
"%s is good grenadier ! i think he back from the war ..."
}

new suicidemess[2][]=
{
"%s s-a auto-distrus!",
"%s a stiut ca nu mai are nici o sansa asa ca s-a omorat!"
}

new suicidelist[suicidesounds][]=
{
"ultimate_sounds/suicide1_ultimate",
"ultimate_sounds/suicide2_ultimate",
"ultimate_sounds/suicide3_ultimate",
"ultimate_sounds/suicide4_ultimate"
}

new doublelist[maxdbsounds][]=
{
"ultimate_sounds/doublekill1_ultimate",
"ultimate_sounds/doublekill2_ultimate"
}

is_mode_set(bits) {
    new mode[9];
    get_cvar_string("ut_killstreak_advanced", mode, 8);
    return read_flags(mode) & bits;
}

public plugin_init() {
    register_plugin(PLUGIN_NAME, PLUGIN_VERSION, PLUGIN_AUTHOR);
    killstreaktype = register_cvar("ut_killstreak_advanced", "3");
    register_event("ResetHUD", "reset_hud", "b");
    register_event("HLTV","rnstart","a", "1=0", "2=0");
    register_event("DeathMsg", "event_death", "a");
    hsenable = register_cvar("ut_killstreak_hs","1");
    knifeenable = register_cvar("ut_killstreak_knife","1");
    firstbloodenable = register_cvar("ut_firstblood","1");
    nadecvar = register_cvar("ut_nade_events","1");
    suicidecvar = register_cvar("ut_suicide_events","1");
    cvardouble = register_cvar("ut_doublekill_events","1");
    rnstartcvar = register_cvar("ut_roundcout_sounds","1");

    return PLUGIN_CONTINUE;
}


public event_death(id) {
    new killer = read_data(1);
    new victim = read_data(2);
    new headshot = read_data(3);
    new weapon[24], vicname[32], killname[32]
    read_data(4,weapon,23)
    get_user_name(victim,vicname,31)
    get_user_name(killer,killname,31)
    
   
 
    if(headshot == 1 && get_pcvar_num(hsenable) ==1) 
    { 
	set_hudmessage(0, 0, 255, -1.0, 0.30, 0, 6.0, 6.0)
	show_hudmessage(0, (hsmessages[random_num(0,3)]), killname, vicname)
	new i
	i = random_num(0,hsounds-1)
	client_cmd(0,"spk %s",hslist[i])
    } 

    
    if(weapon[0] == 'k'  && get_pcvar_num(knifeenable) ==1)
    { 
    	set_hudmessage(255, 0, 255, -1.0, 0.30, 0, 6.0, 6.0)
    	show_hudmessage(0, (knmessages[random_num(0,2)]), killname, vicname)
        new r
	r = random_num(0,knsounds-1)
	client_cmd(0,"spk %s",knlist[r])   
    } 
    
    
    if(firstblood && killer!=victim && killer>0 && get_pcvar_num(firstbloodenable) ==1) 
    {	   	
        set_hudmessage(255, 0, 255, -1.0, 0.30, 0, 6.0, 6.0)
	show_hudmessage(0, (fbmessages[random_num(0,2)]), killname)
	new t
	t = random_num(0,fbsounds-1)
	client_cmd(0,"spk %s",fblist[t])
	firstblood = 0
     }
     
     
    if(weapon[1] == 'r' && get_pcvar_num(nadecvar) ==1)
     {
     	set_hudmessage(255, 0, 255, -1.0, 0.30, 0, 6.0, 6.0)
	show_hudmessage(0,(nademessages[random_num(0,2)]),killname,vicname)
	client_cmd(0,"spk ultimate_sounds/nade_ultimate")
     }

     
    if(killer == victim && get_pcvar_num(suicidecvar) ==1) 
    { 
     	set_hudmessage(255, 0, 255, -1.0, 0.30, 0, 6.0, 6.0)
	show_hudmessage(0,(suicidemess[random_num(0,1)]), vicname)
	new z
	z = random_num(0,suicidesounds-1)
	client_cmd(0,"spk %s",suicidelist[z])
      
    } 
    
    
    if(kill[killer][0] && equal(kill[killer],weapon) && get_pcvar_num(cvardouble) == 1)
    {
        set_hudmessage(255, 0, 255, -1.0, 0.30, 0, 6.0, 6.0)
	show_hudmessage(0,"Wow %s made a double kill", killname)
        kill[killer][0] = 0;
        new q
        q= random_num(0,maxdbsounds-1)
        client_cmd(0,"spk %s",doublelist[q])
    }
    
    else
    {
        kill[killer] = weapon;
        set_task(0.1,"clear_kill",TASK_CLEAR_KILL+killer);
    }
       
	
    
    kills[killer] += 1;
    kills[victim] = 0;
    deaths[killer] = 0;
    deaths[victim] += 1;

    for (new i = 0; i < LEVELS; i++) 
    {
        if (kills[killer] == levels[i]) 
	{
            announce(killer, i);
            return PLUGIN_CONTINUE;
        }
    }

    return PLUGIN_CONTINUE;
}

announce(killer, level) 
{
	
    new name[33]
    new r = random(256)
    new g = random(256)
    new b = random(256)

    get_user_name(killer, name, 32);
    set_hudmessage(r,g,b, 0.05, 0.65, 2, 0.02, 6.0, 0.01, 0.1, 2);

    if( (get_pcvar_num(killstreaktype) <= 0 ) || get_pcvar_num(killstreaktype) > 3)
    return PLUGIN_HANDLED;
    
    
    
    if(get_pcvar_num(killstreaktype) == 1)
    {
    	show_hudmessage(0, messages[level], name);
    }
    	
    if(get_pcvar_num(killstreaktype) == 2)
    {
	client_cmd(0, "spk %s", sounds[level]);
    }

    if(get_pcvar_num(killstreaktype) == 3)
    {
	show_hudmessage(0, messages[level], name);
	client_cmd(0, "spk %s", sounds[level]);
    }
	
    return PLUGIN_CONTINUE;
	
}


public reset_hud(id) 
{
    firstblood = 1 
    if (is_mode_set(16)) {
      if (kills[id] > levels[0]) {
        client_print(id, print_chat, 
                     "Felicitari! Ai omorat %d inamici la rand.", kills[id]);
      } else if (deaths[id] > 1) {
        client_print(id, print_chat, 
                     "Ai murit de %d ori la rand, ai grija...", deaths[id]);

        }
    }
}

public rnstart(id)
{
    if(get_pcvar_num(rnstartcvar) == 1)
    {
    firstblood = 1   
    set_hudmessage(255, 0, 255, -1.0, 0.30, 0, 6.0, 6.0)
    show_hudmessage(0, "Pregateste-te de lupta!")
    new q
    q = random_num(0,prpsounds-1)
    client_cmd(0,"spk %s",preplist[q])
    }
}

public client_connect(id) {
    kills[id] = 0;
    deaths[id] = 0;
}

public clear_kill(taskid)
 {
    new id = taskid-TASK_CLEAR_KILL;
    kill[id][0] = 0;
 }

public plugin_precache()
{
	precache_sound("ultimate_sounds/triplekill_ultimate.wav")
	precache_sound("ultimate_sounds/multikill_ultimate.wav")
	precache_sound("ultimate_sounds/ultrakill_ultimate.wav")
	precache_sound("ultimate_sounds/killingspree_ultimate.wav")
	precache_sound("ultimate_sounds/megakill_ultimate.wav")
	precache_sound("ultimate_sounds/holyshit_ultimate.wav")
	precache_sound("ultimate_sounds/ludicrouskill_ultimate.wav")
	precache_sound("ultimate_sounds/rampage_ultimate.wav")
	precache_sound("ultimate_sounds/unstoppable_ultimate.wav")
	precache_sound("ultimate_sounds/monsterkill_ultimate.wav")
	precache_sound("ultimate_sounds/headshot1_ultimate.wav")
	precache_sound("ultimate_sounds/headshot2_ultimate.wav")
	precache_sound("ultimate_sounds/knife1_ultimate.wav")
	precache_sound("ultimate_sounds/knife2_ultimate.wav")
	precache_sound("ultimate_sounds/firstblood1_ultimate.wav")
	precache_sound("ultimate_sounds/firstblood2_ultimate.wav")
	precache_sound("ultimate_sounds/prepare1_ultimate.wav")
	precache_sound("ultimate_sounds/prepare2_ultimate.wav")
	precache_sound("ultimate_sounds/prepare3_ultimate.wav")
	precache_sound("ultimate_sounds/nade_ultimate.wav")
	precache_sound("ultimate_sounds/suicide1_ultimate.wav")
	precache_sound("ultimate_sounds/suicide2_ultimate.wav")
	precache_sound("ultimate_sounds/suicide3_ultimate.wav")
	precache_sound("ultimate_sounds/suicide4_ultimate.wav")
	precache_sound("ultimate_sounds/doublekill1_ultimate.wav")
	precache_sound("ultimate_sounds/doublekill2_ultimate.wav")
}