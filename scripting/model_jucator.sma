#include <amxmodx>
#include <amxmisc>
#include <cstrike>

public plugin_init() {
	register_plugin("Model jucator", "1.0", "Serbu")
	register_event("ResetHUD", "resetModel", "b")

}

public plugin_precache() {

	precache_model("models/player/admin_bb_infect/admin_bb_infect.mdl")
	return PLUGIN_CONTINUE
}

public resetModel(id, level, cid) {
	
	new CsTeams:userTeam = cs_get_user_team(id)
	
	if (get_user_flags(id) & ADMIN_KICK) {
		if(userTeam == CS_TEAM_CT)
			cs_set_user_model(id, "admin_bb_infect")
	}
}
