// This script plez "ammunition depleted" sound from HL 
// Idea, Coding & Testing by MistaGee
// I got most of this script from xeroblood @ http://www.amxmodx.org/forums/viewtopic.php?p=142756#142756

#include <amxmodx>
#include <amxmisc>
#include <cstrike>

#define SND_AMMODEPL "/fvox/ammo_depleted.wav"
//#define DEBUG

new g_iCurrWeapon[33][2];

public plugin_init(){
	register_plugin("Ammo depleted", "1.0", "MistaGee");
    register_event("CurWeapon", "event_ShotFired", "b");
	}
/*	only had this stuff to make users dl the sound file
public plugin_precache(){
	precache_sound(SND_AMMODEPL);
	}
*/	
public event_ShotFired( id ){
    // Players current weapon data..
    new wID = read_data( 2 ), wAmmo = read_data( 3 );

    if( g_iCurrWeapon[id][0] != wID ) // User Changed Weapons..
    {
        g_iCurrWeapon[id][0] = wID;
        g_iCurrWeapon[id][1] = wAmmo;
        return PLUGIN_CONTINUE;
    }
    if( g_iCurrWeapon[id][1] < wAmmo ) // User Reloaded..
    {
        g_iCurrWeapon[id][1] = wAmmo;
        return PLUGIN_CONTINUE;
    }
    if( g_iCurrWeapon[id][1] == wAmmo ) // User did something else, but didn't shoot..
        return PLUGIN_CONTINUE;

    // This far means user shot his/her gun..
    // Save new weapon data..
    g_iCurrWeapon[id][1] = wAmmo;
    g_iCurrWeapon[id][0] = wID;
    
    new wName[32]; get_weaponname(wID, wName, 31);
    new wBpAmmo = cs_get_user_bpammo(id, wID);
    
#if defined DEBUG
    new pName[32]; get_user_name(id, pName, 31);
    server_print("[AMXX][AMMO] %s (%d) shot %s (%d) and has left %d in clip and %d in BP !", pName, id, wName, wID, wAmmo, wBpAmmo);
#endif
    
    // wenn ammo == 0 und pbammo == 0 sound abspielen weil Ammo leer
    if(!wAmmo && !wBpAmmo) client_cmd(id, "spk %s", SND_AMMODEPL);
    
    return PLUGIN_CONTINUE;
	}	
