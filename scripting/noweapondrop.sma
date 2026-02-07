/* AMX Mod X
*   No Weapon Drop
*
* (c) Copyright 2007 by VEN
*
* This file is provided as is (no warranties)
*
*     DESCRIPTION
*       Plugin disables weapon drop. Differs from "No Weapon Drop on Death" plugin:
*       better/"natural"/safe weapon deleting method, alive/death/disconnect/team modes,
*       custom weapons support, defuser support. By default this plugin disables any
*       weapon drop except C4. Via CVars you can configure alive/death/disconnect/team
*       modes, enable drop for specific weapon(s), disable defuser drop.
*
*     CVARs
*       nwd_state (flags: 1&2&4, default: 7)
*         1 - affect on alive players
*         2 - affect on player's death
*         4 - affect on player's disconnect (bomb only)
*       nwd_teams (flags: 1&2, default: 3)
*         1 - affect on Terrorist players
*         2 - affect on Counter-Terrorist players
*       nwd_allow (flags: 1&2&4..., default: 65)
*                  1 - defuser [not a weapon but item; allowed by default]
*                  2 - p228
*                  4 - shield
*                  8 - scout
*                 16 - hegrenade [will not be dropped in any case]
*                 32 - xm1014
*                 64 - c4 [allowed by default]
*                128 - mac10
*                256 - aug
*                512 - smokegrenade [will not be dropped in any case]
*               1024 - elite
*               2048 - fiveseven
*               4096 - ump45
*               8192 - sg550
*              16384 - galil
*              32768 - famas
*              65536 - usp
*             131072 - glock18
*             262144 - awp
*             524288 - mp5navy
*            1048576 - m249
*            2097152 - m3
*            4194304 - m4a1
*            8388608 - tmp
*           16777216 - g3sg1
*           33554432 - flashbang [will not be dropped in any case]
*           67108864 - deagle
*          134217728 - sg552
*          268435456 - ak47
*          536870912 - knife [will not be dropped in any case]
*         1073741824 - p90
*/

#include <amxmodx>
#include <fakemeta>
#include <cstrike>

// plugin's main information
#define PLUGIN_NAME "No Weapon Drop"
#define PLUGIN_VERSION "0.1"
#define PLUGIN_AUTHOR "VEN"

// state CVar name and default value
#define CVAR_STATE_NAME "nwd_state"
#define CVAR_STATE_DEF "7"

// teams CVar name and default value
#define CVAR_TEAMS_NAME "nwd_teams"
#define CVAR_TEAMS_DEF "3"

// allow CVar name and default value
#define CVAR_ALLOW_NAME "nwd_allow"
#define CVAR_ALLOW_DEF "65"

// state flags
#define FLAG_ALIVE (1<<0)
#define FLAG_DEAD (1<<1)
#define FLAG_DISCONNECT (1<<2)

// team flags
#define FLAG_T (1<<0)
#define FLAG_CT (1<<1)

// custom indexes
#define DEFUSER 0
#define SHIELD 2

#define CONTAIN_FLAG_OF_INDEX(%1,%2) ((%1) & (1<<(%2)))

new const g_wbox_class[] = "weaponbox"
new const g_shield_class[] = "weapon_shield"
new const g_wbox_model[] = "models/w_weaponbox.mdl"
new const g_model_prefix[] = "models/w_"

#define CLIENT_START_INDEX 1

new g_max_clients
new g_max_entities

new g_pcvar_state
new g_pcvar_teams
new g_pcvar_allow

public plugin_init() {
	register_plugin(PLUGIN_NAME, PLUGIN_VERSION, PLUGIN_AUTHOR)

	g_pcvar_state = register_cvar(CVAR_STATE_NAME, CVAR_STATE_DEF)
	g_pcvar_teams = register_cvar(CVAR_TEAMS_NAME, CVAR_TEAMS_DEF)
	g_pcvar_allow = register_cvar(CVAR_ALLOW_NAME, CVAR_ALLOW_DEF)

	register_forward(FM_SetModel, "forward_set_model")
	register_event("DeathMsg", "event_death", "a")

	g_max_clients = global_get(glb_maxClients)
	g_max_entities = global_get(glb_maxEntities)
}

public forward_set_model(ent, const model[]) {
	if (!pev_valid(ent) || !equali(model, g_model_prefix, sizeof g_model_prefix - 1) || equali(model, g_wbox_model))
		return FMRES_IGNORED

	new id = pev(ent, pev_owner)
	if (!(CLIENT_START_INDEX <= id <= g_max_clients))
		return FMRES_IGNORED

	new weapon
	static class[32]
	pev(ent, pev_classname, class, sizeof class - 1)
	if (equal(class, g_shield_class))
		weapon = SHIELD
	else if (!equal(class, g_wbox_class))
		return FMRES_IGNORED

	new cvar_state = get_pcvar_num(g_pcvar_state)
	new cvar_teams = get_pcvar_num(g_pcvar_teams)
	new cvar_allow = get_pcvar_num(g_pcvar_allow)
	if (cvar_state <= 0 || cvar_teams <= 0)
		return FMRES_IGNORED

	new state_, team
	if (!is_user_connected(id)) {
		state_ = FLAG_DISCONNECT
		team = FLAG_T // on disconnect only T can drop weapon (the bomb only)
	}
	else if (!is_user_alive(id))
		state_ = FLAG_DEAD
	else
		state_ = FLAG_ALIVE

	if (!(cvar_state & state_))
		return FMRES_IGNORED

	if (state_ != FLAG_DISCONNECT) {
		switch (cs_get_user_team(id)) {
			case CS_TEAM_T : team = FLAG_T
			case CS_TEAM_CT: team = FLAG_CT
		}
	}

	if (!(cvar_teams & team))
		return FMRES_IGNORED

	if (weapon == SHIELD) {
		if (!CONTAIN_FLAG_OF_INDEX(cvar_allow, SHIELD)) {
			set_pev(ent, pev_effects, EF_NODRAW)
			set_task(0.1, "task_remove_shield", ent) // we even can't use nextthink, that will not work
		}

		return FMRES_IGNORED
	}

	for (new i = g_max_clients + 1; i < g_max_entities; ++i) {
		if (!pev_valid(i) || ent != pev(i, pev_owner))
			continue

		if (!CONTAIN_FLAG_OF_INDEX(cvar_allow, cs_get_weapon_id(i)))
			dllfunc(DLLFunc_Think, ent)
	
		return FMRES_IGNORED
	}

	return FMRES_IGNORED
}

public event_death() {
	new id = read_data(2)
	if (!(get_pcvar_num(g_pcvar_state) & FLAG_DEAD) || !(get_pcvar_num(g_pcvar_teams) & FLAG_CT) || !cs_get_user_defuse(id))
		return

	if (CONTAIN_FLAG_OF_INDEX(get_pcvar_num(g_pcvar_allow), DEFUSER))
		return

	cs_set_user_defuse(id, 0)
	set_pev(id, pev_body, 0) // backward compatibility
}

public task_remove_shield(ent) {
	dllfunc(DLLFunc_Think, ent)
}
