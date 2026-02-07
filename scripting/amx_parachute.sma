#include <amxmodx>
#include <amxmisc>
#include <engine>
#include <cstrike>
#include <fun>

new bool:has_parachute[33]
new para_ent[33]
new pDetach, pFallSpeed, pEnabled

#define PARACHUTE_LEVEL ADMIN_LEVEL_A

public plugin_init()
{
    register_plugin("Parachute", "1.3", "KRoT@L/JTP10181")
    pEnabled = register_cvar("sv_parachute", "1" )
    pFallSpeed = register_cvar("parachute_fallspeed", "100")
    pDetach = register_cvar("parachute_detach", "1")
    
    register_clcmd("say", "HandleSay")
    register_clcmd("say_team", "HandleSay")
    
    register_event("ResetHUD", "newSpawn", "be")
    
    //Setup jtp10181 CVAR
    new cvarString[256], shortName[16]
    copy(shortName,15,"chute")
    
    register_cvar("jtp10181","",FCVAR_SERVER|FCVAR_SPONLY)
    get_cvar_string("jtp10181",cvarString,255)
    
    if (strlen(cvarString) == 0) {
        formatex(cvarString,255,shortName)
        set_cvar_string("jtp10181",cvarString)
    }
    else if (contain(cvarString,shortName) == -1) {
        format(cvarString,255,"%s,%s",cvarString, shortName)
        set_cvar_string("jtp10181",cvarString)
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

public plugin_precache()
{
    precache_model("models/parachute.mdl")
}

public newSpawn(id)
{
    if(para_ent[id] > 0) {
        remove_entity(para_ent[id])
        set_user_gravity(id, 1.0)
        para_ent[id] = 0
    }
    
    has_parachute[id] = true
}

public HandleSay(id)
{
    if(!is_user_connected(id)) return PLUGIN_CONTINUE
    
    new args[128]
    read_args(args, 127)
    remove_quotes(args)
    
    return PLUGIN_CONTINUE
}

public client_PreThink(id)
{
    //parachute.mdl animation information
    //0 - deploy - 84 frames
    //1 - idle - 39 frames
    //2 - detach - 29 frames
	new szMapName[ 11 ];
	get_mapname( szMapName, 10 );
    if (!get_pcvar_num(pEnabled)) return
    if (!is_user_alive(id) || !has_parachute[id] || equal( szMapName, "1hp" ) ) return
    
    new Float:fallspeed = get_pcvar_float(pFallSpeed) * -1.0
    new Float:frame
    
    new button = get_user_button(id)
    new oldbutton = get_user_oldbutton(id)
    new flags = get_entity_flags(id)
    
    if (para_ent[id] > 0 && (flags & FL_ONGROUND)) {
        
        if (get_pcvar_num(pDetach)) {
            
            if (get_user_gravity(id) == 0.1) set_user_gravity(id, 1.0)
            
            if (entity_get_int(para_ent[id],EV_INT_sequence) != 2) {
                entity_set_int(para_ent[id], EV_INT_sequence, 2)
                entity_set_int(para_ent[id], EV_INT_gaitsequence, 1)
                entity_set_float(para_ent[id], EV_FL_frame, 0.0)
                entity_set_float(para_ent[id], EV_FL_fuser1, 0.0)
                entity_set_float(para_ent[id], EV_FL_animtime, 0.0)
                entity_set_float(para_ent[id], EV_FL_framerate, 0.0)
                return
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
        
        return
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