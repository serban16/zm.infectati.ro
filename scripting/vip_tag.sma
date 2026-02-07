#include <amxmodx>
#include <hamsandwich>

#define PLUGIN "VIP"
#define VERSION "1.0"
#define AUTHOR "Cloud-center.ro"


public plugin_init() {
        register_plugin(PLUGIN, VERSION, AUTHOR);        
        RegisterHam(Ham_Spawn, "player", "Spawn", 1);  
} 

public Spawn(id) {

        if(is_user_alive(id)) {
                if (get_user_flags(id) & ADMIN_LEVEL_F)  {
                        set_task(0.5, "iScoreBoard", id + 6969)
                }
        }
}

public iScoreBoard(tID) {
        new id = tID - 6969;
        
        message_begin(MSG_ALL, get_user_msgid("ScoreAttrib"));
        write_byte(id);
        write_byte(4);
        message_end();
}