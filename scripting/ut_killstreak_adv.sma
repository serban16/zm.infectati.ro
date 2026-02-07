#include <amxmodx>
#include <amxmisc>

#define PLUGIN_NAME "Sunete"
#define PLUGIN_VERSION "1.0"
#define PLUGIN_AUTHOR "Serbu" 


new kills[33] = {0,...};
new deaths[33] = {0,...};
new firstblood
new kill[33][24];

#define LEVELS 10
#define hsounds 2
#define fbsounds 2
#define maxdbsounds 2
#define TASK_CLEAR_KILL    100

new hsenable
new firstbloodenable
new nadecvar
new cvardouble
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

new doublelist[maxdbsounds][]=
{
"ultimate_sounds/doublekill1_ultimate",
"ultimate_sounds/doublekill2_ultimate"
}


public plugin_init() {
    register_plugin(PLUGIN_NAME, PLUGIN_VERSION, PLUGIN_AUTHOR);
    killstreaktype = register_cvar("ut_killstreak_advanced", "2");
    hsenable = register_cvar("ut_killstreak_hs","1");
    firstbloodenable = register_cvar("ut_firstblood","1");
    nadecvar = register_cvar("ut_nade_events","0");
    cvardouble = register_cvar("ut_doublekill_events","1");

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
		new i
		i = random_num(0,hsounds-1)
		client_cmd(0,"spk %s",hslist[i])
    }

	if(firstblood && killer!=victim && killer>0 && get_pcvar_num(firstbloodenable) ==1) 
    {
		new t
		t = random_num(0,fbsounds-1)
		client_cmd(0,"spk %s",fblist[t])
		firstblood = 0
    }

	if(weapon[1] == 'r' && get_pcvar_num(nadecvar) ==1)
	{
		client_cmd(0,"spk ultimate_sounds/nade_ultimate")
	}

	if(kill[killer][0] && equal(kill[killer],weapon) && get_pcvar_num(cvardouble) == 1)
	{
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
    

    if(get_pcvar_num(killstreaktype) == 2)
    {
	client_cmd(0, "spk %s", sounds[level]);
    }

    if(get_pcvar_num(killstreaktype) == 3)
    {
	client_cmd(0, "spk %s", sounds[level]);
    }
	
    return PLUGIN_CONTINUE;
	
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
precache_sound("ultimate_sounds/firstblood1_ultimate.wav")
precache_sound("ultimate_sounds/firstblood2_ultimate.wav")
precache_sound("ultimate_sounds/nade_ultimate.wav")
precache_sound("ultimate_sounds/doublekill1_ultimate.wav")
precache_sound("ultimate_sounds/doublekill2_ultimate.wav")
}