#include <amxmodx>
#include <fakemeta>
#include <zombieplague>

#define PLUGIN "[ZP] Class : [A]dvanced [I]nvisible Zombie"
#define VERSION "1.0.8"
#define AUTHOR "Fry!"

new const zclass_name[] = "Predator Avansat"
new const zclass_info[] = "- Invisibility Predator -"
new const zclass_model[] = "predator_pr"
new const zclass_clawmodel[] = "claws"
const zclass_health = 1000
const zclass_speed = 200
const Float:zclass_gravity = 1.0
const Float:zclass_knockback = 1.35
new const zombie_idle_sound1[] = "zombie_plague/zombie_moan.wav"
new const zombie_idle_sound2[] = "zombie_plague/zombie_breathing.wav" 
new zisA, zisB
new g_zclass_ai_zombie, g_ai_zombie_invisible
public plugin_init() 
{
 register_plugin(PLUGIN, VERSION, AUTHOR)
 
 register_cvar("zp_zclass_advanced_invisble_zombie",VERSION,FCVAR_SERVER|FCVAR_EXTDLL|FCVAR_UNLOGGED|FCVAR_SPONLY)
 
 g_ai_zombie_invisible = register_cvar("zp_ai_zombie_invisibility", "0")
 
 register_forward(FM_PlayerPreThink, "fm_PlayerPreThink")
}
public plugin_precache()
{
 g_zclass_ai_zombie = zp_register_zombie_class(zclass_name, zclass_info, zclass_model, zclass_clawmodel, zclass_health, zclass_speed, zclass_gravity, zclass_knockback)
 zisA = engfunc(EngFunc_PrecacheSound, zombie_idle_sound1)
 zisB = engfunc(EngFunc_PrecacheSound, zombie_idle_sound2)
}
public zp_user_infected_post(player, infector)
{
 if (zp_get_user_zombie_class(player) == g_zclass_ai_zombie && !zp_get_user_nemesis(player))
 {
  if ((pev(player, pev_flags) & FL_DUCKING))
  {
   set_pev(player, pev_renderfx, kRenderFxGlowShell)
   set_pev(player, pev_rendermode, kRenderTransAlpha)
   set_pev(player, pev_renderamt, get_pcvar_float(g_ai_zombie_invisible))
  }
 }
 return PLUGIN_CONTINUE
}
public fm_PlayerPreThink(id)
{
 if (!is_user_alive(id) || !zp_get_user_zombie(id))
  return FMRES_IGNORED
  
 if (zp_get_user_zombie_class(id) != g_zclass_ai_zombie)
  return FMRES_IGNORED
 
 if (!(pev(id, pev_flags) & FL_DUCKING))
 {
  set_pev(id, pev_renderfx, kRenderFxNone)
  set_pev(id, pev_rendermode, kRenderNormal)
  set_pev(id, pev_renderamt, 255.0)
  
  new iRandomNum = random_num(zisA, zisB)
  
  if (iRandomNum == zisA)
  {
   emit_sound(id, CHAN_VOICE, zombie_idle_sound1, VOL_NORM, ATTN_NORM, 0, PITCH_NORM)
  }
  
  else if (iRandomNum == zisB)
  {
   emit_sound(id, CHAN_VOICE, zombie_idle_sound2, VOL_NORM, ATTN_NORM, 0, PITCH_NORM)
  }
 }
  
 else
 {
  set_pev(id, pev_renderfx, kRenderFxGlowShell)
  set_pev(id, pev_rendermode, kRenderTransAlpha)
  set_pev(id, pev_renderamt, get_pcvar_float(g_ai_zombie_invisible))
 }
 return FMRES_IGNORED
}  