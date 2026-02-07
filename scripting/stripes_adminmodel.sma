#include <amxmodx>
#include <amxmisc>
#include <cstrike>

public plugin_init() {
        register_plugin("Stripes Admin Model", "1.0", "AgentStrike")
        register_event("ResetHUD", "resetModel", "b")
        return PLUGIN_CONTINUE
}

public plugin_precache() {
        precache_model("models/player/adm_stripes_ct/adm_stripes_ct.mdl")
        precache_model("models/player/adm_stripes_te/adm_stripes_te.mdl")

        return PLUGIN_CONTINUE
}

public resetModel(id, level, cid) {
        if (get_user_flags(id) & ADMIN_KICK) {
                new CsTeams:userTeam = cs_get_user_team(id)
                if (userTeam == CS_TEAM_T) {
                        cs_set_user_model(id, "adm_stripes_te")
                }
                else if(userTeam == CS_TEAM_CT) {
                        cs_set_user_model(id, "adm_stripes_ct")
                }
        }

        return PLUGIN_CONTINUE
}