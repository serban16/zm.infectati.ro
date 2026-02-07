/*================================================================================
 * Please don't change plugin register information.
================================================================================*/
#include <amxmodx>
#include <fakemeta>
#include <zombie_plague_advance>

//#define DAMAGE_TYPE_IS_INFECT
#if defined DAMAGE_TYPE_IS_INFECT
#define GET_DAMAGE_JUST_INFECT
#endif

#define PLUGIN_NAME "[ZP] Zombie Class: Boomer"
#define PLUGIN_VERSION "1.2"
#define PLUGIN_AUTHOR "Jim"

#define Explo_MaxDamage 1570
#define Explo_MinDamage 1250
#define Sub_Damage_Value (Explo_MaxDamage - Explo_MinDamage)
#define LastZombie_Lower_Health 100

// Self Explosion Zombie Attributes
new const zclass_name[] = {"Chinezesc"}
new const zclass_info[] = {"Explodeaza cand moare"}
new const zclass_model[] = {"chinezesc"}
new const zclass_clawmodel[] = {"chinezesc1.mdl"}
const zclass_health = 4500
const zclass_speed = 300
const Float:zclass_gravity = 0.70
const Float:zclass_knockback = 1.95

new g_exploSpr_1, g_exploSpr_2
new g_msgScoreAttrib, g_msgScoreInfo
new g_zclass_explo
new g_explo_range
new bool:g_can_explo[33], bool:explo_started[33]
public plugin_init()
{
	register_plugin(PLUGIN_NAME, PLUGIN_VERSION, PLUGIN_AUTHOR)
	g_explo_range = register_cvar("zp_boomer_explo_range", "150.0")
	register_event("ResetHUD","NewRound","be")
	register_event("DeathMsg", "Death", "a")
	g_msgScoreAttrib = get_user_msgid("ScoreAttrib")
	g_msgScoreInfo = get_user_msgid("ScoreInfo")
}
public plugin_precache()
{
 g_exploSpr_1 = engfunc(EngFunc_PrecacheModel, "sprites/fexplo1.spr")
 g_exploSpr_2 = engfunc(EngFunc_PrecacheModel, "sprites/explode1.spr")
 
 g_zclass_explo = zp_register_zombie_class(zclass_name, zclass_info, zclass_model, zclass_clawmodel, zclass_health, zclass_speed, zclass_gravity, zclass_knockback)
}
public zp_user_infected_post(id, infector)
{
 if (zp_get_user_zombie_class(id) == g_zclass_explo && !zp_get_user_nemesis(id))
 {
  g_can_explo[id] = true
 }
}
public zp_user_humanized_post(id)
{
 g_can_explo[id] = false
}
public client_PreThink(id)
{
 if (!g_can_explo[id])
  return PLUGIN_CONTINUE
 
 if (zp_get_user_last_zombie(id) && (0 < get_user_health(id) < LastZombie_Lower_Health))
 {
  g_can_explo[id] = false
  explo_process(id)
 }
 
 if (is_user_alive(id))
  return PLUGIN_CONTINUE
 
 if (explo_started[id])
 {
  g_can_explo[id] = false
  explo_started[id] = false
  explo_process(id)
 }
 
 return PLUGIN_CONTINUE
}
public explo_process(id)
{
 new Float:origin[3]
 pev(id, pev_origin, origin)
 create_sprite(origin, g_exploSpr_1)
 create_sprite(origin, g_exploSpr_2)
 create_explo2(origin)
 
 new target[32], Float:t_range[32], num, Float:range
 range = get_pcvar_float(g_explo_range)
 zp_get_in_range_target(id, target, t_range, num, range, 2)
 
 new Float:velocity[3]
 new damage, health, armor, kills, frags, deaths
 
 #if defined DAMAGE_TYPE_IS_INFECT
 new bool:infect_round
 if (zp_is_nemesis_round() || zp_is_survivor_round() || zp_is_swarm_round())
  infect_round = false
 else
  infect_round = true
 #endif
 
 kills = 0
 
 for (new i = 0; i < num; i++)
 {
  if (is_user_alive(target[i]))
  {
   get_speed_vector_to(id, target[i], 800.0, velocity)
   velocity[2] += 50.0
   set_pev(target[i], pev_velocity, velocity)
   
   damage = Explo_MaxDamage - floatround(float(Sub_Damage_Value) *  t_range[i] / get_pcvar_float(g_explo_range))
   health = get_user_health(target[i])
   armor = get_user_armor(target[i])
   
   if (armor > 0)
   {
    if (armor > damage)
    {
     fm_set_user_armor(target[i], armor - damage)
     damage -= floatround(float(damage) / 3.0)
    }
    else
    {
     fm_set_user_armor(target[i], 0)
     damage -= floatround(float(armor) / 3.0)
    }
   }
   
   if (health > damage)
   {
    #if defined GET_DAMAGE_JUST_INFECT
    if (!infect_round || zp_get_user_last_human(target[i]))
    {
     fm_set_user_health(target[i], health - damage)
    }
    else
    {
     kills++
     zp_infect_user(target[i])
     frags = get_user_frags(target[i])
     deaths = get_user_deaths(target[i]) + 1
     fm_set_user_deaths(target[i], deaths)
     FixDeadAttrib(target[i])
     Update_ScoreInfo(target[i], frags, deaths)
    }
    #else
    fm_set_user_health(target[i], health - damage)
    #endif
   }
   else
   {
    kills++
    
    #if defined DAMAGE_TYPE_IS_INFECT
    if (!infect_round || zp_get_user_last_human(target[i]))
    {
     fm_set_user_health(target[i], 0)
     frags = get_user_frags(target[i]) + 1
     deaths = get_user_deaths(target[i])
     fm_set_user_frags(target[i], frags)
    }
    else
    {
     zp_infect_user(target[i])
     frags = get_user_frags(target[i])
     deaths = get_user_deaths(target[i]) + 1
     fm_set_user_deaths(target[i], deaths)
    }
    #else
    fm_set_user_health(target[i], 0)
    frags = get_user_frags(target[i]) + 1
    deaths = get_user_deaths(target[i])
    fm_set_user_frags(target[i], frags)
    #endif
    
    FixDeadAttrib(target[i])
    Update_ScoreInfo(target[i], frags, deaths)
   }
  }
 }
 
 zp_set_user_ammo_packs(id, zp_get_user_ammo_packs(id) + kills)
 frags = get_user_frags(id) + kills
 
 if (is_user_alive(id))
 {
  fm_set_user_health(id, 0)
 }
 
 deaths = get_user_deaths(id)
 fm_set_user_frags(id, frags)
 FixDeadAttrib(id)
 Update_ScoreInfo(id, frags, deaths)
}
public client_connect(id)
{
 g_can_explo[id] = false
 explo_started[id] = false
 
 return PLUGIN_CONTINUE
}
public client_disconnect(id)
{
 g_can_explo[id] = false
 explo_started[id] = false
 
 return PLUGIN_CONTINUE
}
public NewRound(id)
{
 g_can_explo[id] = false
 explo_started[id] = false
}
public Death()
{
 new player = read_data(2)
 if (g_can_explo[player])
  explo_started[player] = true
}
stock zp_get_in_range_target(id, target[32], Float:target_range[32], &target_num, Float:range, flag = 0) // flag: 0=Different, 1=Zombie, 2=Human
{
 new Float:origin1[3], Float:origin2[3]
 pev(id, pev_origin, origin1);
 
 target_num = 0
 
 static i, Float:i_range
 for (i = 1; i <= 32; i++)
 {
  if ((i != id) && is_user_alive(i))
  {
   pev(i, pev_origin, origin2);
   i_range = get_distance_f(origin1, origin2);
   
   if (i_range <= range)
   {
    if ((flag == 0) && (zp_get_user_zombie(id) != zp_get_user_zombie(i)))
    {
     target[target_num] = i
     target_range[target_num] = i_range
     target_num++
    }
    else if ((flag == 1) && zp_get_user_zombie(i))
    {
     target[target_num] = i
     target_range[target_num] = i_range
     target_num++
    }
    else if ((flag == 2) && !zp_get_user_zombie(i))
    {
     target[target_num] = i
     target_range[target_num] = i_range
     target_num++
    }
   }
  }
 }
}
stock get_speed_vector_to(ent1, ent2, Float:speed, Float:new_velocity[3])
{
 if(!pev_valid(ent1) || !pev_valid(ent2))
  return 0;
 
 static Float:origin1[3]
 pev(ent1,pev_origin,origin1)
 static Float:origin2[3]
 pev(ent2,pev_origin,origin2)
 
 new_velocity[0] = origin2[0] - origin1[0];
 new_velocity[1] = origin2[1] - origin1[1];
 new_velocity[2] = origin2[2] - origin1[2];
 
 static Float:num
 num = speed / vector_length(new_velocity);
    
 new_velocity[0] *= num;
 new_velocity[1] *= num;
 new_velocity[2] *= num;
 
 return 1;
}
stock fm_set_user_health(index, health)
{
 health > 0 ? set_pev(index, pev_health, float(health)) : dllfunc(DLLFunc_ClientKill, index);
 
 return 1;
}
stock fm_set_user_armor(index, armor)
{
 set_pev(index, pev_armorvalue, float(armor));
 return 1;
}
stock fm_set_user_frags(index, frags)
{
 set_pev(index, pev_frags, float(frags));
 
 return 1;
}
#if defined DAMAGE_TYPE_IS_INFECT
stock fm_set_user_deaths(index, deaths) // Set User Deaths
{
 set_pdata_int(index, 444, deaths, 5)
}
#endif
create_sprite(const Float:originF[3], sprite_index)
{
 // Sprite
 message_begin(MSG_BROADCAST, SVC_TEMPENTITY)
 write_byte(TE_SPRITE) // TE id (Additive sprite, plays 1 cycle)
 engfunc(EngFunc_WriteCoord, originF[0]) // x
 engfunc(EngFunc_WriteCoord, originF[1]) // y
 engfunc(EngFunc_WriteCoord, originF[2]) // z
 write_short(sprite_index) // sprite index
 write_byte(10) // scale in 0.1's
 write_byte(200) // brightness
 message_end()
}
create_explo2(const Float:originF[3])
{
 // WTF
 message_begin(MSG_BROADCAST, SVC_TEMPENTITY)
 write_byte(TE_EXPLOSION2) // TE id: 12
 engfunc(EngFunc_WriteCoord, originF[0]) // x
 engfunc(EngFunc_WriteCoord, originF[1]) // y
 engfunc(EngFunc_WriteCoord, originF[2]) // z
 write_byte(1) // starting color
 write_byte(10) // num colors
 message_end()
}
FixDeadAttrib(id) // Fix Dead Attrib on scoreboard
{
 message_begin(MSG_BROADCAST, g_msgScoreAttrib)
 write_byte(id) // id
 write_byte(0) // attrib
 message_end()
}
Update_ScoreInfo(id, frags, deaths) // Update Player's Frags and Deaths
{
 // Update scoreboard with attacker's info
 message_begin(MSG_BROADCAST, g_msgScoreInfo)
 write_byte(id) // id
 write_short(frags) // frags
 write_short(deaths) // deaths
 write_short(0) // class
 write_short(get_user_team(id)) // team
 message_end()
}