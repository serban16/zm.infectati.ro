/*
///===========================================================================================================
//¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
//				    ___________________________________
//				   |=                                 =|
//			           |=       Furien Mod lutimate       =|
//			           |=       ¯¯¯¯¯¯ ¯by ¯¯¯¯¯¯¯¯       =|
//			           |=		    ¯¯  Askhanar      =|
//			           |=                   ¯¯¯¯¯¯¯¯      =|
//                                    ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
// __________________________________________________________________________________________________________
//|==========================================================================================================|
//|											  		     |
//|			      Copyright © 2011 - 2012, Askhanar @ulqtech.tk				     |
//|			  Acest fisier este prevazut asa cum este ( fara garantii )			     |
//|													     |
//|==========================================================================================================|
// ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
//	- ¦ 				         « Prieteni »			      		¦ -
//	** * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * **
//	* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
//	* * *										      * * *
//	* *  	Rap^		Frosten			TheBeast		AZAEL!   	* *
//	* *	fuzy		razvan W-strafer	RZV			SNKT   	 	* *	
//	* *	ahonen		Arion			pHum			gLobe   	* *
//	* *     Shax+		syBlow			kvL^			krom3       	* *
//	* *	Henk		DANYEL			SimpLe			XENON^		* *
//	* * *								                      *	* *
//	* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
//	** * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * **
//	
//			     _ _                                     _
//			    |¯(_)                                   |¯|  
//			  __| |_|___  ___ ___  _ __  _ __   ___  ___| |_ 
//			 / _` | / __|/ __/ _ \| '_ \| '_ \ / _ \/ __| __|
//			| (_| | \__ \ (_| (_) | |¯| | |¯| |  __/ (__| |_ 
//			 \__,_|_|___/\___\___/|_| |_|_| |_|\___|\___|\__|
//						 _
//						|¯|  
//						| |_  ___   __ _ _ __  ___ 
//						| __|/ _ \ / _` | `_ \/_  |
//						| |_(  __/( (_| | |¯| |¯| |
//						 \__|\___| \__,_|_| |_| |_|			
//												
//
//
//			Plugin				Versiune		Autor
//		  Furien Mod Ultimate			 0.8.3		       Askhanar
//		  
//		  
//		        Credite
//			
//		ConnorMcLeod, Exolent, xPaw, V3X! si restul utilizatorilor de pe alliedmodders..
//		
//		              -  Pentru ca am folosit ceva cod si tutoriale care le apartin.
//		      
//		  
//			  
// Cvar-uri:

// --| Daca sa fie sau nu salvat XP-ul si Upgrade-urile cumparate de jucatori.
// --| Default: 1

fmu_save_xp		1

// --| Cat XP vor primi cei ce intra pentru prima data pe server.
// --| Default: 15845

fmu_entry_xp		15845

// --| Cat XP vor primi jucatorii pentru un kill obisnuit ( omorarea unui jucator ).
// --| Default: 45

fmu_kill_xp		45

// --| Cat XP bonus vor primi jucatorii pentru un kill cu HS ( headshot ).
// --| Default: 15

fmu_hskill_xp		15

// --| Cat XP bonus vor primi jucatorii pentru un kill cu HE ( grenada ).
// --| Default: 20

fmu_grenadekill_xp	20

// --| Cat XP bonus vor primi jucatorii pentru un kill cu cutitul ( doar pentru AntiFurieni ).
// --| Default: 25

fmu_knifekill_xp	25

// --| Cat XP va primi fiecare jucator daca supravietuieste ( se termina runda si el este in viata ).
// --| Default: 10

fmu_survive_xp		10

// --| Cat XP va primi fiecare jucator atunci cand castiga runda ( nu conteaza cum.. ).
// --| Default: 15

fmu_win_xp		15

// --| Daca sa fie sau nu blocata comanda 'buy' si totodata zonele 'buyzone' sterse.
// --| Default: 1

fmu_block_buy		1

// --| Daca sa fie sau nu blocata comanda 'drop' ( cea cu care arunci arma ).
// --| Default: 0

fmu_block_drop		0

// --| Daca sa fie sau nu blocate comenzile de radio ( nu ai nevoie de radio in acest mod.. ).
// --| Default: 1

bmu_block_radio 	1

// --| Care echipa poate lua arme de pe jos ( 0 = Ambele, 1 = Furienii < Tero >, 2 = AntiFurienii < CT > ).
// --| Default: 2

fmu_allow_pickup	2

// --| Daca bomba poate fi plantata doar dupa un interval de timp de la inceputul rundei.
// --| Default: 1

fmu_nobomb_plant	1

// --| Dupa cat timp de la inceputul rundei poate fi plantata bomba.
// --| Default: 90

fmu_bombplant_wait	90

// --| Lumina care este setata pe harta( a = cel mai intunecat - z = cel mai luminat ).
// --| Pe o harda obisnuita lumina este setata pe litera 'm'.
// --| Default: e

fmu_lights		e

// --| Lumina care este setata pe harta cant bomba poate fi plantata( a = cel mai intunecat - z = cel mai luminat ).
// --| Functioneaza doar daca bomba poate fi plantata dupa un interval de timp( pentru dezactivare setati-l ca si cel de sus )..
// --| Default: d

fmu_bomblights		d

// --| Daca sa fie ceata sau nu.
// --| Default: 1

fmu_enable_fog		1

// --| Daca cvar-ul de ceata este activ aici setati culoarea cetii ( in RRR GGG BBB ).
// --| Default: 200 200 200

fmu_fog_color		"200 200 200"

// --| Daca cvar-ul de ceata este activ aici setati densitatea cetii( 1 = ceata risipita, 9 = ceata densa ).
// --| Default: 1

fmu_fog_density		1

// --| Daca cvar-ul de ceata este activ si este activ si cel de plantare a bombei dupa un anumit timp.
// --| Aici setati culoarea cetii care va apare atunci cand bomba poate fi plantata.
// --| Pentru dezactivare setati-l ca 'fmu_fog_color'.
// --| Default: 200 200 200

fmu_bombfog_color	"200 200 200"

// --| Daca cvar-ul de ceata este activ si este activ si cel de plantare a bombei dupa un anumit timp.
// --| Aici setati densitatea cetii care va apare atunci cand bomba poate fi plantata.
// --| Pentru dezactivare setati-l ca 'fmu_fog_density'.
// --| Default: 2

fmu_bombfog_density	2

// --| Cati bani ( $ ) bonus sa primeasca cei ce sunt VIP pentru fiecare kill / supravietuire / runda castigata.
// --| Default: 15

fmu_vip_moneybonus	15

// --| Id-ul de mess care apare la contact in /buyvip.
// --| Default: www.ulqtech.tk

fmu_vip_contact		www.ulqtech.tk

// --| Daca jucatorii pot sau nu sa-si transfere XP intre ei.
// --| Default: 0

fmu_allow_transferxp	0

// --| Gametype care va fi afisat..
// --| Default: este setat de plugin..

//fmu_gametype ""

// --| Cat costa 25HP din /shop.
// --| Default: 3500$

fmu_hp_cost	3500

// --| Cat costa 25AP din /shop.
// --| Default: 2500$

fmu_ap_cost	2500

// --| Cat costa HE-ul din /shop.
// --| Default: 2500$

fmu_he_cost	2500

// --| Cat costa Silent Walk din /shop ( doar pentru AntiFurieni ).
// --| Default: 1500$

fmu_sw_cost	1500

// --| Cat costa Defuse Kit din /shop ( doar pentru AntiFurieni ).
// --| Default: 3500$

fmu_dk_cost	800

// --| Cat XP primesc cei ce cumpara din /shop.
// --| Default: 1050

fmu_xp_amount	1050


// --| Cat costa XP-ul din /shop
.
// --| Default: 13000$

fmu_xp_cost	13000


// --| Cat costa Instant Respawn din /shop.
// --| Default: 11000$

fmu_ir_cost	11000


// --| Cat XP costa Super Knife din /xpshop ( doar pentru Furieni ).
// --| Default: 3500

fmu_superknife_cost 	3500

// --| Cat XP costa X-Ray Scanner din /xpshop ( doar pentru AntiFurieni ).
// --| Default: 2500

fmu_scanner_cost 	2500

// --| Cat XP costa Chameleon din /xpshop.
// --| Default: 3500

fmu_chameleon_cost 	1500



// Comenzi Publice ( in say sau say_team ):

// --| /help, help 	-->  Deschide meniul pentru Ajutor ( multe informatii despre absolut orice ).
// --| /shop, shop 	-->  Deschide meniul cu 'cumparaturi' pe bani ( HP, AP, HE s.a.m.d )..
// --| /xpshop, xpshop 	-->  Deschide meniul cu 'cumparaturi' pe XP ( Super Knife, Chameleon s.a.m.d )..
// --| /vip, /vips 	-->  Deschide motd cu VIP online..
// --| /buyvip	 	-->  Deschide motd cu detalii despte cumparare VIP.
// --| /transfer, /givexp 	-->  < nume > < xp > transferi cuiva XP din XP-ul tau.

// --| /xp, /exp, xp, exp 	-->  Deschide meniul de unde poti cumpara Upgrade-uri..



// Comenzi Admini ( in consola ):

// --| amx_givexp		-->  < nume > < xp > ii dai XP unui jucator.
// --| amx_takexp		-->  < nume > < xp > ii scoti XP unui jucator.

// --| amx_resetall	-->  < nume > ii resetezi tot XP-ul si toate Upgrade-urile unui jucator.
// --| amx_deletexp	-->  Resetezi tot XP-ul si toate Upgrade-urile jucatorilor salvate pana atunci.
			 ->  De asemenea server-ul se va restarta in 10 secunde !
			 
			 
*/

#include <  amxmodx  >
#include <  amxmisc  >

#include <  cstrike  >
#include <  hamsandwich  >

#include <  fakemeta  >
#include <  engine  >

#include <  fun  >
#include <  nvault  >

#include <  FMU_Events  >
#include <  CC_ColorChat  >



#pragma semicolon 1

#define PLUGIN "Furien Mod Ultimate"
#define VERSION "0.8.3"


// by ConnorMcLeod
// -------------------------------

#define XO_WEAPON 4
#define m_pPlayer 41

#define XO_WEAPONBOX					4
#define m_rgpPlayerItems_wpnbx_Slot5		39
#define IsWeaponBoxC4(%1)		( get_pdata_cbase(%1, m_rgpPlayerItems_wpnbx_Slot5, XO_WEAPONBOX) > 0 )


#define fm_cs_set_user_nobuy(%1) set_pdata_int(%1, 235, get_pdata_int(%1, 235) & ~(1<<0) )
// -------------------------------



// Don't touch it !
#define IsPlayer(%1) ( gFirstPlayer <= %1 <= gMaxPlayers ) 
#define DMG_GRENADE (1<<24)


#define PISTOL_WEAPONS_BIT    (1<<CSW_GLOCK18|1<<CSW_USP|1<<CSW_DEAGLE|1<<CSW_P228|1<<CSW_FIVESEVEN|1<<CSW_ELITE)
#define SHOTGUN_WEAPONS_BIT    (1<<CSW_M3|1<<CSW_XM1014)
#define SUBMACHINE_WEAPONS_BIT    (1<<CSW_TMP|1<<CSW_MAC10|1<<CSW_MP5NAVY|1<<CSW_UMP45|1<<CSW_P90)
#define RIFLE_WEAPONS_BIT    (1<<CSW_FAMAS|1<<CSW_GALIL|1<<CSW_AK47|1<<CSW_SCOUT|1<<CSW_M4A1|1<<CSW_SG550|1<<CSW_SG552|1<<CSW_AUG|1<<CSW_AWP|1<<CSW_G3SG1)
#define MACHINE_WEAPONS_BIT    (1<<CSW_M249)

#define PRIMARY_WEAPONS_BIT    (SHOTGUN_WEAPONS_BIT|SUBMACHINE_WEAPONS_BIT|RIFLE_WEAPONS_BIT|MACHINE_WEAPONS_BIT)
#define SECONDARY_WEAPONS_BIT    (PISTOL_WEAPONS_BIT)

#define IsPrimaryWeapon(%1) ( (1<<%1) & PRIMARY_WEAPONS_BIT )
#define IsSecondaryWeapon(%1) ( (1<<%1) & PISTOL_WEAPONS_BIT )

//127.0.0.2
//89.44.246.131

// The Plugin is licensed to only one server ip..  10.91.120.46   89.44.246.131


// The prefix in all of the plugin's messages

new const MESSAGE_TAG[] =		"[Furien Ultimate]";


#define		CS_TEAM_FURIEN		CS_TEAM_T
#define		CS_TEAM_ANTIFURIEN	CS_TEAM_CT

// Access to amx_givexp amx_takexp..
#define 	FURIEN_ACCESS		ADMIN_CVAR




// Just a task used for team switch and model change..
#define		SWITCH_TASK		112233



// One day in seconds used for nvault_prune..
#define 	ONE_DAY_IN_SECONDS	86400



// If user's healts is below this value his heart will beat + some effects.
#define 	LOW_HP_TO_HEAR_HEART	40





// This is null do not modify

#define NULL			0
//#define NULL_FLOAT		0.0


// Furien Invisibility Factor, from 1 to 4 (  only when they have knife  ).
// 1 = almost visible.
// 4 = less visible.
// Default: 2

#define FURIEN_VISIBILITY_FACTOR			2


// The value of server's sv_maxspeed cvar which is set to.
// This value is set to connecting players on cl_ cvars.
// cl_forwardspeed
// cl_backspeed
// cl_sidespeed

#define SV_MAXSPEED_VALUE				1000.0


// Do Not Modify This Line !

#define ANY_UPGRADE_ENABLED (gAnyHealthEnabled || gAnyArmorEnabled || gAnySpeedEnabled || gAnyGravityEnabled || gAnyDamageMultiplierEnabled || gAnyRespawnEnabled)



// These determine if these abilities should be enabled or disabled
// 1 = enabled
// 0 = disabled

#define ENABLE_FURIEN_HEALTH					1
#define ENABLE_ANTIFURIEN_HEALTH				1
#define ENABLE_FURIEN_ARMOR					1
#define ENABLE_ANTIFURIEN_ARMOR					1
#define ENABLE_FURIEN_SPEED					1
#define ENABLE_ANTIFURIEN_SPEED					1
#define ENABLE_FURIEN_GRAVITY					1
#define ENABLE_ANTIFURIEN_GRAVITY				1
#define ENABLE_FURIEN_DAMAGE_MULTIPLIER				1
#define ENABLE_ANTIFURIEN_DAMAGE_MULTIPLIER			1
#define ENABLE_FURIEN_RESPAWN					1
#define ENABLE_ANTIFURIEN_RESPAWN				1
#define ENABLE_FURIEN_HEALTH_REG				1
#define ENABLE_ANTIFURIEN_HEALTH_REG				1
#define ENABLE_FURIEN_ARMOR_CHARGER				1
#define ENABLE_ANTIFURIEN_ARMOR_CHARGER				1


// The maximum level for each ability

#define MAXLEVEL_FURIEN_HEALTH					10
#define MAXLEVEL_ANTIFURIEN_HEALTH				10
#define MAXLEVEL_FURIEN_ARMOR					10
#define MAXLEVEL_ANTIFURIEN_ARMOR				10
#define MAXLEVEL_FURIEN_SPEED					7		
#define MAXLEVEL_ANTIFURIEN_SPEED				7
#define MAXLEVEL_FURIEN_GRAVITY					7
#define MAXLEVEL_ANTIFURIEN_GRAVITY				7
#define MAXLEVEL_FURIEN_DAMAGE_MULTIPLIER			10
#define MAXLEVEL_ANTIFURIEN_DAMAGE_MULTIPLIER			10
#define MAXLEVEL_FURIEN_RESPAWN					10
#define MAXLEVEL_ANTIFURIEN_RESPAWN				10
#define MAXLEVEL_FURIEN_HEALTH_REG				10
#define MAXLEVEL_ANTIFURIEN_HEALTH_REG				7
#define MAXLEVEL_FURIEN_ARMOR_CHARGER				10
#define MAXLEVEL_ANTIFURIEN_ARMOR_CHARGER			7


// The xp amount required to buy the first level

#define FIRST_XP_FURIEN_HEALTH					550
#define FIRST_XP_ANTIFURIEN_HEALTH				600
#define FIRST_XP_FURIEN_ARMOR					600
#define FIRST_XP_ANTIFURIEN_ARMOR				550
#define FIRST_XP_FURIEN_SPEED					1500		
#define FIRST_XP_ANTIFURIEN_SPEED				2000
#define FIRST_XP_FURIEN_GRAVITY					1500
#define FIRST_XP_ANTIFURIEN_GRAVITY				2000
#define FIRST_XP_FURIEN_DAMAGE_MULTIPLIER			1000
#define FIRST_XP_ANTIFURIEN_DAMAGE_MULTIPLIER			1200
#define FIRST_XP_FURIEN_RESPAWN					1200
#define FIRST_XP_ANTIFURIEN_RESPAWN				1350
#define FIRST_XP_FURIEN_HEALTH_REG				1050
#define FIRST_XP_ANTIFURIEN_HEALTH_REG				1150
#define FIRST_XP_FURIEN_ARMOR_CHARGER				1150
#define FIRST_XP_ANTIFURIEN_ARMOR_CHARGER			1050



// The max amount of health , armor, and other.
// For Speed , Gravity and Damage Multiplier you can edit them at bottom of this part.

#define MAXAMOUNT_OF_FURIEN_HEALTH				100
#define MAXAMOUNT_OF_ANTIFURIEN_HEALTH				110
#define MAXAMOUNT_OF_FURIEN_ARMOR				110
#define MAXAMOUNT_OF_ANTIFURIEN_ARMOR				100
#define MAXAMOUNT_OF_FURIEN_RESPAWN				100
#define MAXAMOUNT_OF_ANTIFURIEN_RESPAWN				100
#define MAXAMOUNT_OF_FURIEN_HEALTH_REG				10
#define MAXAMOUNT_OF_ANTIFURIEN_HEALTH_REG			7
#define MAXAMOUNT_OF_FURIEN_ARMOR_CHARGER			10
#define MAXAMOUNT_OF_ANTIFURIEN_ARMOR_CHARGER			7


// =================================================
// STOP EDITING HERE
// =================================================

#pragma semicolon 1

new const gAnyHealthEnabled = ENABLE_FURIEN_HEALTH + ENABLE_ANTIFURIEN_HEALTH;

new const gHealthEnabled[  CsTeams  ] =
{
	
	NULL,
	ENABLE_FURIEN_HEALTH,
	ENABLE_ANTIFURIEN_HEALTH,
	NULL
	
};


new const gHealthMaxLevels[  CsTeams  ] =
{
	
	NULL,
	MAXLEVEL_FURIEN_HEALTH,
	MAXLEVEL_ANTIFURIEN_HEALTH,
	NULL
	
};

new const gHealthFirstXp[  CsTeams  ] =
{
	
	NULL,
	FIRST_XP_FURIEN_HEALTH,
	FIRST_XP_ANTIFURIEN_HEALTH,
	NULL
	
};


new const gHealthMaxAmount[  CsTeams  ] =
{
	
	NULL,
	MAXAMOUNT_OF_FURIEN_HEALTH,
	MAXAMOUNT_OF_ANTIFURIEN_HEALTH,
	NULL
	
};

new const gHealthNames[  CsTeams  ][    ] =
{
	
	"",
	"Viata Furien",
	"Viata AntiFurien",
	""
	
};

new const gAnyArmorEnabled = ENABLE_FURIEN_ARMOR + ENABLE_ANTIFURIEN_ARMOR;

new const gArmorEnabled[  CsTeams  ] =
{
	
	NULL,
	ENABLE_FURIEN_ARMOR,
	ENABLE_ANTIFURIEN_ARMOR,
	NULL
	
};


new const gArmorMaxLevels[  CsTeams  ] =
{
	
	NULL,
	MAXLEVEL_FURIEN_ARMOR,
	MAXLEVEL_ANTIFURIEN_ARMOR,
	NULL
	
};

new const gArmorFirstXp[  CsTeams  ] =
{
	
	NULL,
	FIRST_XP_FURIEN_ARMOR,
	FIRST_XP_ANTIFURIEN_ARMOR,
	NULL
	
};


new const gArmorMaxAmount[  CsTeams  ] =
{
	
	NULL,
	MAXAMOUNT_OF_FURIEN_ARMOR,
	MAXAMOUNT_OF_ANTIFURIEN_ARMOR,
	NULL
	
};

new const gArmorNames[  CsTeams  ][    ] =
{
	
	"",
	"Armura Furien",
	"Armura AntiFurien",
	""
	
};

new const gAnySpeedEnabled = ENABLE_FURIEN_SPEED + ENABLE_ANTIFURIEN_SPEED;

new const gSpeedEnabled[  CsTeams  ] =
{
	
	NULL,
	ENABLE_FURIEN_SPEED,
	ENABLE_ANTIFURIEN_SPEED,
	NULL
	
};


new const gSpeedMaxLevels[  CsTeams  ] =
{
	
	NULL,
	MAXLEVEL_FURIEN_SPEED,
	MAXLEVEL_ANTIFURIEN_SPEED,
	NULL
	
};

new const gSpeedFirstXp[  CsTeams  ] =
{
	
	NULL,
	FIRST_XP_FURIEN_SPEED,
	FIRST_XP_ANTIFURIEN_SPEED,
	NULL
	
};

new const gSpeedNames[  CsTeams  ][    ] =
{
	
	"",
	"Viteza Furien",
	"Viteza AntiFurien",
	""
	
};

new const gAnyGravityEnabled = ENABLE_FURIEN_GRAVITY + ENABLE_ANTIFURIEN_GRAVITY;

new const gGravityEnabled[  CsTeams  ] =
{
	
	NULL,
	ENABLE_FURIEN_GRAVITY,
	ENABLE_ANTIFURIEN_GRAVITY,
	NULL
	
};


new const gGravityMaxLevels[  CsTeams  ] =
{
	
	NULL,
	MAXLEVEL_FURIEN_GRAVITY,
	MAXLEVEL_ANTIFURIEN_GRAVITY,
	NULL
	
};

new const gGravityFirstXp[  CsTeams  ] =
{
	
	NULL,
	FIRST_XP_FURIEN_GRAVITY,
	FIRST_XP_ANTIFURIEN_GRAVITY,
	NULL
	
};

new const gGravityNames[  CsTeams  ][    ] =
{
	
	"",
	"Gravitate Furien",
	"Gravitate AntiFurien",
	""
	
};


new const gAnyDamageMultiplierEnabled = ENABLE_FURIEN_DAMAGE_MULTIPLIER + ENABLE_ANTIFURIEN_DAMAGE_MULTIPLIER;

new const gDamageMultiplierEnabled[  CsTeams  ] =
{
	
	NULL,
	ENABLE_FURIEN_DAMAGE_MULTIPLIER,
	ENABLE_ANTIFURIEN_DAMAGE_MULTIPLIER,
	NULL
	
};


new const gDamageMultiplierMaxLevels[  CsTeams  ] =
{
	
	NULL,
	MAXLEVEL_FURIEN_DAMAGE_MULTIPLIER,
	MAXLEVEL_ANTIFURIEN_DAMAGE_MULTIPLIER,
	NULL
	
};

new const gDamageMultiplierFirstXp[  CsTeams  ] =
{
	
	NULL,
	FIRST_XP_FURIEN_DAMAGE_MULTIPLIER,
	FIRST_XP_ANTIFURIEN_DAMAGE_MULTIPLIER,
	NULL
	
};

new const gDamageMultiplierNames[  CsTeams  ][    ] =
{
	
	"",
	"Multiplicare Damage Furien",
	"Multiplicare Damage AntiFurien",
	""
	
};


new const gAnyRespawnEnabled = ENABLE_FURIEN_RESPAWN + ENABLE_ANTIFURIEN_RESPAWN;

new const gRespawnEnabled[  CsTeams  ] =
{
	
	NULL,
	ENABLE_FURIEN_RESPAWN,
	ENABLE_ANTIFURIEN_RESPAWN,
	NULL
	
};


new const gRespawnMaxLevels[  CsTeams  ] =
{
	
	NULL,
	MAXLEVEL_FURIEN_RESPAWN,
	MAXLEVEL_ANTIFURIEN_RESPAWN,
	NULL
	
};

new const gRespawnFirstXp[  CsTeams  ] =
{
	
	NULL,
	FIRST_XP_FURIEN_RESPAWN,
	FIRST_XP_ANTIFURIEN_RESPAWN,
	NULL
	
};


new const gRespawnMaxAmount[  CsTeams  ] =
{
	
	NULL,
	MAXAMOUNT_OF_FURIEN_RESPAWN,
	MAXAMOUNT_OF_ANTIFURIEN_RESPAWN,
	NULL
	
};

new const gRespawnNames[  CsTeams  ][    ] =
{
	
	"",
	"Furien Respawn",
	"AntiFurien Respawn",
	""
	
};

new const gAnyHealthRegenerationEnabled = ENABLE_FURIEN_HEALTH_REG + ENABLE_ANTIFURIEN_HEALTH_REG;

new const gHealthRegenerationEnabled[  CsTeams  ] =
{
	
	NULL,
	ENABLE_FURIEN_HEALTH_REG,
	ENABLE_ANTIFURIEN_HEALTH_REG,
	NULL
	
};


new const gHealthRegenerationMaxLevels[  CsTeams  ] =
{
	
	NULL,
	MAXLEVEL_FURIEN_HEALTH_REG,
	MAXLEVEL_ANTIFURIEN_HEALTH_REG,
	NULL
	
};

new const gHealthRegenerationFirstXp[  CsTeams  ] =
{
	
	NULL,
	FIRST_XP_FURIEN_HEALTH_REG,
	FIRST_XP_ANTIFURIEN_HEALTH_REG,
	NULL
	
};


new const gHealthRegenerationMaxAmount[  CsTeams  ] =
{
	
	NULL,
	MAXAMOUNT_OF_FURIEN_HEALTH_REG,
	MAXAMOUNT_OF_ANTIFURIEN_HEALTH_REG,
	NULL
	
};

new const gHealthRegenerationNames[  CsTeams  ][    ] =
{
	
	"",
	"Regenerare Viata Furien",
	"Regenerare Viata AntiFurien",
	""
	
};
new const gAnyArmorChargerEnabled = ENABLE_FURIEN_ARMOR_CHARGER + ENABLE_ANTIFURIEN_ARMOR_CHARGER;

new const gArmorChargerEnabled[  CsTeams  ] =
{
	
	NULL,
	ENABLE_FURIEN_ARMOR_CHARGER,
	ENABLE_ANTIFURIEN_ARMOR_CHARGER,
	NULL
	
};


new const gArmorChargerMaxLevels[  CsTeams  ] =
{
	
	NULL,
	MAXLEVEL_FURIEN_ARMOR_CHARGER,
	MAXLEVEL_ANTIFURIEN_ARMOR_CHARGER,
	NULL
	
};

new const gArmorChargerFirstXp[  CsTeams  ] =
{
	
	NULL,
	FIRST_XP_FURIEN_ARMOR_CHARGER,
	FIRST_XP_ANTIFURIEN_ARMOR_CHARGER,
	NULL
	
};


new const gArmorChargerMaxAmount[  CsTeams  ] =
{
	
	NULL,
	MAXAMOUNT_OF_FURIEN_ARMOR_CHARGER,
	MAXAMOUNT_OF_ANTIFURIEN_ARMOR_CHARGER,
	NULL
	
};

new const gArmorChargerNames[  CsTeams  ][    ] =
{
	
	"",
	"Reincarcare Armura Furien",
	"Reincarcare Armura AntiFurien",
	""
	
};

// Furien Speed Levels.
// Level 0 = 350 SPEED.
new const Float:gFurienSpeedLevels[  MAXLEVEL_FURIEN_SPEED + 1 ]  =
{
	350.0,		//Level 0.
	400.0,		//Level 1.
	500.0,		//Level 2.
	600.0,		//Level 3.
	700.0,		//Level 4.
	800.0,		//Level 5.
	825.0,		//Level 6.
	850.0		//Level 7.
};


// AntiFurien Speed Levels.
// Level 0 = 255 SPEED.
new const Float:gAntiFurienSpeedLevels[  MAXLEVEL_ANTIFURIEN_SPEED + 1 ]  =
{
	255.0,		//Level 0.
	275.0,		//Level 1.
	300.0,		//Level 2.
	325.0,		//Level 3.
	350.0,		//Level 4.
	375.0,		//Level 5.
	400.0,		//Level 6.
	425.0		//Level 7.
};


// Furien Gravity Levels.
// Level 0 = 720 Gravity.
// 1.0 = 800 Gravity
// 0.00125 = 1 Gravity
// 0.125 = 100 Gravity
new const Float:gFurienGravityLevels[  MAXLEVEL_FURIEN_GRAVITY + 1 ]  =
{
	0.9,		//Level 0. (  720 Gravity  )
	0.8,		//Level 1. (  640 Gravity  )
	0.750,		//Level 2. (  600 Gravity  )
	0.7,		//Level 3. (  560 Gravity  )
	0.6,		//Level 4. (  480 Gravity  )
	0.5,		//Level 5. (  400 Gravity  )
	0.4,		//Level 6. (  320 Gravity  )
	0.350		//Level 7. (  280 Gravity  )
};


// AntiFurien Gravity Levels.
// Level 0 = 800 Gravity.
// 1.0 = 800 Gravity
// 0.00125 = 1 Gravity
// 0.125 = 100 Gravity
new const Float:gAntiFurienGravityLevels[  MAXLEVEL_ANTIFURIEN_GRAVITY + 1 ]  =
{
	1.0,		//Level 0. (  800 Gravity  )
	0.950,		//Level 1. (  760 Gravity  )
	0.9,		//Level 2. (  720 Gravity  )
	0.850,		//Level 3. (  680 Gravity  )
	0.8,		//Level 4. (  640 Gravity  )
	0.750,		//Level 5. (  600 Gravity  )
	0.7,		//Level 6. (  560 Gravity  )
	0.650		//Level 7. (  520 Gravity  )
};

// Max Amount of Furien Damage Multiplier.
// This amount is divided with Damage Multiplier Max Levels ( 5 ).
// 1.4  /  7  =  0.2  This 0.2 will be multiplied with Player's Damage Multiplier Level on Furien Team.
// The result is added at HamTakeDamage ( 1.0 is normal damage, it will be 1.0 + result ).
// At Max Level it will be 1.4 so.. ( 1.0 default damage + 1.4  = 2.4.. this means more than double damage.. 50 damage will become like 120 ).
new Float:gFurienMaxDamageMultiplier  =  2.10;


// Max Amount of Furien Damage Multiplier.
// This amount is divided with Damage Multiplier Max Levels ( 5 ).
// 0.5  /  5  =  0.1  This 0.1 will be multiplied with Player's Damage Multiplier Level on AntiFurien Team.
// The result is added at HamTakeDamage ( 1.0 is normal damage, it will be 1.0 + result ).
// At Max Level it will be 0.5 so.. ( 1.0 default damage + 0.5  = 1.5.. this means..50 damage will become 75 ).
new Float:gAntiFurienMaxDamageMultiplier  =  0.5;


// Do not modify this.
new Ham:Ham_Player_ResetMaxSpeed = Ham_Item_PreFrame;



/*================================================================================================*/

new const gWeaponsBuyCommands[    ][    ] =
{
	"usp", "glock", "deagle", "p228", "elites",
	"fn57", "m3", "xm1014", "mp5", "tmp", "p90",
	"mac10", "ump45", "ak47", "galil", "famas",
	"sg552", "m4a1", "aug", "scout", "awp", "g3sg1",
	"sg550", "m249", "vest", "vesthelm", "flash",
	"hegren", "sgren", "defuser", "nvgs", "shield",
	"primammo", "secammo", "km45", "9x19mm", "nighthawk",
	"228compact", "fiveseven", "12gauge", "autoshotgun",
	"mp", "c90", "cv47", "defender", "clarion", "krieg552",
	"bullpup", "magnum", "d3au1", "krieg550", "buyammo1",
	"buyammo2", "buyequip"
};

/*================================================================================================*/

new const gImportantBlocks[    ][    ] =
{
	/*"chooseteam", "jointeam 1",*/ "cl_autobuy",
	"cl_rebuy", "cl_setautobuy", "cl_setrebuy",
	"buy", "bUy", "buY", "bUY", "Buy", "BUy", "BuY", "BUY"
};

/*================================================================================================*/

new const gRadioCommands[    ][    ] =
{
	"radio1", "radio2", "radio3", "coverme", "takepoint",
	"holdpos", "regroup", "followme", "takingfire", "go",
	"fallback", "sticktog", "getinpos", "stormfront",
	"report", "roger", "enemyspot", "needbackup",
	"sectorclear", "inposition", "reportingin", "getout",
	"negative", "enemydown"
};

// DO NOT MODIFY THIS ONE!
new ConstFogDensity[    ]  =
{
	0,0,0,0,111,18,3,58,111,18,125,58,66,96,27,59,
		90,101,60,59,90,101,68,59,10,41,95,59,
		111,18,125,59,111,18,3,60,68,116,19,60,0,0,0,0
};

// Strings..
new const FurienWinSound[    ]  =  "FurienWinSound.mp3";
new const AntiFurienWinSound[    ]  =  "AntiFurienWinSound.mp3";
new const LowHealthSound[    ]  =  "misc/FMU_HeartBeat.wav";
new const FurienKnifeModel[    ]  =  "models/v_superknife.mdl";
new const AntiFurienKnifeModel[    ]  =  "models/v_knife_r.mdl";
new const SuperKnifeModel[    ]  =  "models/v_knife_bloody.mdl";
new const LaserSprite[    ] = "sprites/zbeam4.spr";
new const SndPickUpItem[    ]  =  "fmu_sounds/fmu_pickupitem.wav";
new const SndRespawn[    ]  =  "fmu_sounds/fmu_respawn.wav";
new const SndTome[    ]  =  "fmu_sounds/fmu_tome.wav";
new const SndLevelUp[    ]  =  "fmu_sounds/fmu_levelup.wav";
new const g_szFurienModUltimateSound[    ]  =  "fmu_sounds/FurienModUltimate.mp3";
new const FurienModel[ ] = "FurienModel";
new const AntiFurienModel[ ] = "AntiFurienModel";
// Trie...
new Trie:gMessagesReplacements;


// Variables..
new gHealthLevel[  33  ][  CsTeams  ];
new gArmorLevel[  33  ][  CsTeams  ];
new gSpeedLevel[  33  ][  CsTeams  ];
new gGravityLevel[  33  ][  CsTeams  ];
new gDamageMultiplierLevel[  33  ][  CsTeams  ];
new gRespawnLevel[  33  ][  CsTeams  ];
new gHealthRegenerationLevel[  33  ][  CsTeams  ];
new gArmorChargerLevel[  33  ][  CsTeams  ];
new gPlayerUsedRespawn[  33  ];
new gUserXp[  33  ];


// Cvars.
new gCvarSaveXP;
new gCvarEntryXP;
new gCvarKillXP;
new gCvarHeadShotKillXP;
new gCvarGrenadeKillXP;
new gCvarKnifeKillXP;
new gCvarSurviveXP;
new gCvarWinXP;	
new gCvarBlockBuy;
new gCvarBlockRadio;
new gCvarBlockDropCommand;
new gCvarBlockWeaponPickUp;
new gCvarNoBombPlantTime;
new gCvarLights;
new gCvarBombLights;
new gCvarEnableFog;
new gCvarFogColor;
new gCvarFogDensity;
new gCvarBombFogColor;
new gCvarBombFogDensity;
new gCvarVipMoneyBonus;
//new gCvarVipContact;
new gCvarAllowTransferXP;
new gCvarEnableShop;
new gCvarEnableXPShop;
new gCvarHPCost;
new gCvarAPCost;
new gCvarHECost;
new gCvarSWCost;
new gCvarDKCost;
new gCvarXPAmount;
new gCvarXPCost;
new gCvarIRCost;
new gCvarSKCost;
new gCvarLRCost;
new gCvarCMCost;
new gCvarGameType;


// Bools
new bool:gUserHasSuperKnife[  33  ];
new bool:gUserHasLaser[  33  ];
new bool:gUserHasChameleon[  33  ];
new bool:gFogCreated  =  false;
new bool:gFirstTimePlayed[  33  ];
new bool:gRoundEnded  =  false;
new bool:gBombCanBePlanted  =  false;

// Floats
new Float:gfBombGameTime  =  0.0;

// Others
new gLaserSprite;
new SyncHudMessage;
new gFirstPlayer;
new gMaxPlayers;

// Our Vault..
new gVault;

// Pcvars..
new sv_airaccelerate, sv_maxspeed;

public plugin_cfg(    )	set_cvar_float(  "sv_maxspeed",  SV_MAXSPEED_VALUE  );

public plugin_precache(    )
{
	
		
	new ModelOrSoundPath[  128  ];
	
	formatex(  ModelOrSoundPath, sizeof ( ModelOrSoundPath ) -1, "sound/%s", g_szFurienModUltimateSound );
	precache_generic(  ModelOrSoundPath  );
	
	if(  contain(  FurienWinSound,  ".wav"  )  >  0 )
	{
		
		formatex(  ModelOrSoundPath,  sizeof  (  ModelOrSoundPath  )  -1, "fmu_sounds/%s",  FurienWinSound  );
		precache_sound(  ModelOrSoundPath  );
	}
	else if(  contain(  FurienWinSound,  ".mp3"  )  >  0 )
	{
		
		formatex(  ModelOrSoundPath,  sizeof  (  ModelOrSoundPath  )  -1, "sound/fmu_sounds/%s",  FurienWinSound  );
		precache_generic(  ModelOrSoundPath  );
	}
	
	if(  contain(  AntiFurienWinSound,  ".wav"  )  >  0 )
	{
		
		formatex(  ModelOrSoundPath,  sizeof  (  ModelOrSoundPath  )  -1, "fmu_sounds/%s",  AntiFurienWinSound  );
		precache_sound(  ModelOrSoundPath  );
	}
	else if(  contain(  AntiFurienWinSound,  ".mp3"  )  >  0 )
	{
		
		formatex(  ModelOrSoundPath,  sizeof  (  ModelOrSoundPath  )  -1, "sound/fmu_sounds/%s",  AntiFurienWinSound  );
		precache_generic(  ModelOrSoundPath  );
	}
	
	formatex(  ModelOrSoundPath,  sizeof  (  ModelOrSoundPath  )  -1, "models/player/%s/%s.mdl",  FurienModel,  FurienModel );
	precache_model( ModelOrSoundPath );
		
	formatex(  ModelOrSoundPath,  sizeof  (  ModelOrSoundPath  )  -1, "models/player/%s/%s.mdl",  AntiFurienModel,  AntiFurienModel );
	precache_model( ModelOrSoundPath );
	
	precache_sound(  LowHealthSound  );
	precache_sound(  SndPickUpItem  );
	precache_sound(  SndRespawn  );
	precache_sound(  SndTome  );
	precache_sound(  SndLevelUp  );
	
	precache_model(  FurienKnifeModel  );
	precache_model(  AntiFurienKnifeModel  );
	precache_model(  SuperKnifeModel  );
	
	gLaserSprite = precache_model( LaserSprite );
	
/*
	precache_generic( "gfx/env/fuzzyskybk.tga" );
	precache_generic( "gfx/env/fuzzyskydn.tga" );
	precache_generic( "gfx/env/fuzzyskyft.tga" );
	precache_generic( "gfx/env/fuzzyskylf.tga" );
	precache_generic( "gfx/env/fuzzyskyrt.tga" );
	precache_generic( "gfx/env/fuzzyskyup.tga" );
*/
	
}

public plugin_init(    )
{
	
	new szServerIp[ 22 ];
	get_user_ip( 0, szServerIp, sizeof ( szServerIp ) -1, 1 );
	
	if( equal( szServerIp, "89.39.13.69" ) )
	{
		
		new PluginName[  32  ];
		format(  PluginName,  sizeof ( PluginName ) -1,  "[Ip Licentiat] %s",  PLUGIN  );
		
		register_plugin(  PluginName,  VERSION,  "Askhanar"  );
		server_print( "%s Felicitari! Detii o licenta valida, iar pluginul functioneaza perfect!", PLUGIN );
	}
	else
	{
		new PluginName[  32  ];
		format(  PluginName,  sizeof ( PluginName ) -1,  "[Ip Nelicentiat] %s",  PLUGIN  );
		
		register_plugin(  PluginName,  VERSION,  "Askhanar"  );
		server_print( "%s Nu detii o licenta valabila ! Plugin-ul nu va functiona corespunzator !", PLUGIN );
		
		pause( "ade" );
	}
	
	register_plugin(  PLUGIN,  VERSION,  "Askhanar"  );
	register_cvar( "fmu_version", VERSION, FCVAR_SERVER | FCVAR_SPONLY ); 

	gCvarSaveXP  =  register_cvar(  "fmu_save_xp",  "1"  );
	gCvarEntryXP  =  register_cvar(  "fmu_entry_xp",  "1000000"  );
	gCvarKillXP  =  register_cvar(  "fmu_kill_xp",  "45"  );
	gCvarHeadShotKillXP  =  register_cvar(  "fmu_hskill_xp",  "15"  );
	gCvarGrenadeKillXP  =  register_cvar(  "fmu_grenadekill_xp",  "20"  );
	gCvarKnifeKillXP  =  register_cvar(  "fmu_knifekill_xp",  "25"  );
	gCvarSurviveXP  =  register_cvar(  "fmu_survive_xp",  "10"  );
	gCvarWinXP  =  register_cvar(  "fmu_win_xp",  "15"  );
	gCvarBlockBuy  =  register_cvar(  "fmu_block_buy",  "1"  );
	gCvarBlockRadio  =  register_cvar(  "fmu_block_radio",  "1"  );
	gCvarBlockDropCommand  =  register_cvar(  "fmu_block_drop",  "2"  );
	gCvarBlockWeaponPickUp  =  register_cvar(  "fmu_allow_pickup",  "2"  );
	
	gCvarNoBombPlantTime  =  register_cvar(  "fmu_bombplant_wait",  "100"  );
	
	gCvarLights  =  register_cvar(  "fmu_lights",  "e"  );
	gCvarBombLights  =  register_cvar(  "fmu_bomblights",  "d"  );
	
	gCvarEnableFog  =  register_cvar(  "fmu_enable_fog",  "1"  );
	gCvarFogColor  =  register_cvar(  "fmu_fog_color",  "200 200 200"  );
	gCvarFogDensity  =  register_cvar(  "fmu_fog_density",  "1"  );
	
	gCvarBombFogColor  =  register_cvar(  "fmu_bombfog_color",  "200 200 200"  );
	gCvarBombFogDensity  =  register_cvar(  "fmu_bombfog_density",  "2"  );
	
	gCvarVipMoneyBonus  =  register_cvar(  "fmu_vip_moneybonus",  "15"  );
	//gCvarVipContact  =  register_cvar(  "fmu_vip_contact",  "facebookkiss@yahoo.com"  );
	
	gCvarAllowTransferXP  =  register_cvar(  "fmu_allow_transferxp",  "0"  );

	gCvarEnableShop  =  register_cvar(  "fmu_enable_shop",  "1"  );
	gCvarEnableXPShop  =  register_cvar(  "fmu_enable_xpshop",  "0"  );
	
	gCvarHPCost  =  register_cvar(  "fmu_hp_cost",  "3500"  );
	gCvarAPCost  =  register_cvar(  "fmu_ap_cost",  "2500"  );
	gCvarHECost  =  register_cvar(  "fmu_he_cost",  "2500"  );
	gCvarSWCost  =  register_cvar(  "fmu_sw_cost",  "1500"  );
	gCvarDKCost  =  register_cvar(  "fmu_dk_cost",  "800"  );
	gCvarXPAmount  =  register_cvar(  "fmu_xp_amount",  "1050"  );
	gCvarXPCost  =  register_cvar(  "fmu_xp_cost",  "13000"  );
	gCvarIRCost  =  register_cvar(  "fmu_ir_cost",  "11000"  );
	
	gCvarSKCost  =  register_cvar(  "fmu_superknife_cost",  "3500"  );
	gCvarLRCost  =  register_cvar(  "fmu_scanner_cost",  "2500"  );
	gCvarCMCost  =  register_cvar(  "fmu_chameleon_cost",  "1500"  );
	
	//Game Type
	new FurienModUltimate[  32  ];
	formatex(  FurienModUltimate,  sizeof  (  FurienModUltimate  )  -1,  "Furien Mod Ultimate v%s", VERSION );
	gCvarGameType  =  register_cvar(  "fmu_gametype",  FurienModUltimate );
	
	
	register_clcmd(  "amx_givexp",  "cmdGiveXP" );
	register_clcmd(  "amx_addxp",  "cmdGiveXPOwner" );
	register_clcmd(  "amx_takexp",  "cmdTakeXP" );
	register_clcmd(  "amx_reset",  "cmdResetXP" );
	//register_clcmd(  "amx_transfer",  "cmdTransfer" );
	register_clcmd(  "amx_deletexp",  "cmdDeleteXP" );
	
	
	register_clcmd( "say", "ClCmdSay" );
	register_clcmd( "say_team", "ClCmdSay" );
	register_clcmd( "fmu_transfer", "ClCmdTransferXp" );
	register_clcmd( "fmu_givexp", "ClCmdTransferXp" );
	register_clcmd( "fmu_info", "ClCmdInfo" );
	
	register_clcmd( "fmu_totalxp",  "ClCmdTotalXP"  );
	register_clcmd( "fmu_totalxp",  "ClCmdTotalXP"  );
	
	register_clcmd( "say /vip", "ClCmdSayVip" );
	register_clcmd( "say_team /vip", "ClCmdSayVip" );
	register_clcmd( "say /vips", "ClCmdSayVip" );
	register_clcmd( "say_team /vips", "ClCmdSayVip" );
	
	
	register_clcmd( "say /buyvip", "ClCmdSayBuyVip" );
	register_clcmd( "say_team /buyvip", "ClCmdSayBuyVip" );
	
	register_clcmd( "say /resetupgrades",  "ClCmdSayResetUpgrades"  );
	register_clcmd( "say_team /resetupgrades",  "ClCmdSayResetUpgrades"  );
	
	register_clcmd( "say /shop", "ClCmdSayShop" );
	register_clcmd( "say shop", "ClCmdSayShop" );
	register_clcmd( "say_team  /shop", "ClCmdSayShop" );
	register_clcmd( "say_team  shop", "ClCmdSayShop" );
	
	register_clcmd( "say /xpshop", "ClCmdSayXPShop" );
	register_clcmd( "say xpshop", "ClCmdSayXPShop" );
	register_clcmd( "say_team  /xpshop", "ClCmdSayXPShop" );
	register_clcmd( "say_team  xpshop", "ClCmdSayXPShop" );
	
	
	register_clcmd(  "say /xp",  "CmdMainMenu"  );
	register_clcmd(  "say /exp",  "CmdMainMenu"  );
	register_clcmd(  "say_team /xp",  "CmdMainMenu"  );
	register_clcmd(  "say_team /exp",  "CmdMainMenu"  );
	register_clcmd(  "say xp",  "CmdMainMenu"  );
	register_clcmd(  "say exp",  "CmdMainMenu"  );
	register_clcmd(  "say_team xp",  "CmdMainMenu"  );
	register_clcmd(  "say_team exp",  "CmdMainMenu"  );
	
	
	register_clcmd(  "say /help",  "CmdHelpMenu"  );
	register_clcmd(  "say /help",  "CmdHelpMenu"  );
	register_clcmd(  "say_team /help",  "CmdHelpMenu"  );
	register_clcmd(  "say_team /help",  "CmdHelpMenu"  );
	register_clcmd(  "say help",  "CmdHelpMenu"  );
	register_clcmd(  "say help",  "CmdHelpMenu"  );
	register_clcmd(  "say_team help",  "CmdHelpMenu"  );
	register_clcmd(  "say_team help",  "CmdHelpMenu"  );
	
	
	//Blocked cmds
	for(  new i = 0 ;  i < sizeof(  gImportantBlocks  ) ;  i++  )
		register_clcmd(  gImportantBlocks[  i  ],  "BlockedCommand"  );
		
		
	register_event(  "HLTV",  "EventNewRound",  "a",  "1=0",  "2=0"  );
	register_event(  "DeathMsg",  "EventDeathMsg",  "a"  );
	register_event(  "CurWeapon",  "EventCurWeapon",  "be",  "1=1"  );
	
	register_event(  "SendAudio",  "EventSendAudioTerroWin",  "a",  "2=%!MRAD_terwin"  );
	register_event(  "SendAudio",  "EventSendAudioCounterWin",  "a",  "2=%!MRAD_ctwin"  );
	register_event(  "SendAudio",  "SwitchTeams",  "a",  "1=0",  "2=%!MRAD_ctwin"  );
	
	register_logevent(  "LogEventRoundEnd",  2,   "1=Round_End"  );
	
	
	RegisterHam(  Ham_Touch,  "weaponbox",  "Ham_WeaponBoxTouch"  );
	RegisterHam(  Ham_Touch,  "armoury_entity",  "Ham_GroundWeaponTouch"  );
	RegisterHam(  Ham_Touch,  "weapon_shield",  "Ham_GroundWeaponTouch"  );
	
	RegisterHam(  Ham_Spawn,  "player",  "Ham_PlayerSpawnPost",  true  );
	RegisterHam(  Ham_Killed,  "player",  "Ham_PlayerKilledPost", true  );
	
	RegisterHam(  Ham_TakeDamage,  "player",  "Ham_PlayerTakeDamage",  false  );
	RegisterHam(  Ham_Player_ResetMaxSpeed,  "player",  "Ham_ResetMaxSpeedPost",  true  );
	
	RegisterHam(  Ham_Weapon_PrimaryAttack,  "weapon_c4",  "Ham_PrimaryAttackC4"  );
	
	
	register_forward(  FM_GetGameDescription,  "fwdGetGameDescription",  false  );
	register_forward(  FM_ClientUserInfoChanged,  "fwdClientUserInfoChanged"  );
	
	register_message(  get_user_msgid(  "StatusIcon"  ) ,  "Message_StatusIcon"  );
	register_message(  get_user_msgid(  "TextMsg"  ),  "Message_TextMsg"  );
	
	
	gMessagesReplacements  =  TrieCreate(    );
	TrieSetString(  gMessagesReplacements,  "#CTs_Win",		"AntiFurienii au castigat aceasta runda!"  );
	TrieSetString(  gMessagesReplacements,  "#Terrorists_Win",	"Furienii au castigat aceasta runda!"  );
	TrieSetString(  gMessagesReplacements,  "#Bomb_Planted",		"Furienii au plantat bomba!"  );
	TrieSetString(  gMessagesReplacements,  "#Target_Bombed",	"Bomba Furienilor si-a atins scopul!"  );
	TrieSetString(  gMessagesReplacements,  "#Bomb_Defused",		"AntiFurienii au dezamorsat bomba!"  );
	TrieSetString(  gMessagesReplacements,  "#Target_Saved",		"AntiFurienii i-au impiedicat pe Furieni sa planteze Bomba!"  );
	
	CreateSpeedEntity:
	new iEnt;
	iEnt  =  create_entity(  "info_target"  );
	if( !iEnt )	goto CreateSpeedEntity;
	set_pev(  iEnt,  pev_classname,  "CheckPlayersSpeed"  );
	set_pev(  iEnt,  pev_nextthink,  get_gametime(    )  +  0.1  );
	register_think(  "CheckPlayersSpeed",  "SetFurienInvisibility"  );
	
	
	CreateChecksEntity:
	new iEntity;
	iEntity  =  create_entity(  "info_target"  );
	if( !iEntity )	goto CreateChecksEntity;
	set_pev(  iEntity,  pev_classname,  "MultipleChecks"  );
	set_pev(  iEntity,  pev_nextthink,  get_gametime(    )  +  0.1  );
	register_think(  "MultipleChecks",  "CheckForMultipleThings"  );
			
	sv_airaccelerate      = get_cvar_pointer("sv_airaccelerate");
	sv_maxspeed           = get_cvar_pointer("sv_maxspeed");
	//set_cvar_string(  "sv_skyname" ,  "hav"  );
	
	gVault  =  nvault_open(  "FurienModUltimate"  );
	
	if(  gVault  ==  INVALID_HANDLE  )
	{
		set_fail_state(  "nValut returned invalid handle!"  );
	}
		
	SyncHudMessage  =  CreateHudSyncObj(    );
	
	
	gMaxPlayers  =  get_maxplayers(  );
	gFirstPlayer  =  1;
	
	//server_cmd( "sv_skyname fuzzysky" );
	
	
	
}
public server_frame()
{
	
	if(  get_pcvar_num(  sv_airaccelerate  )  !=  100  )
		set_pcvar_num(  sv_airaccelerate,  100  );
	
	if( get_pcvar_float(  sv_maxspeed  )  !=  SV_MAXSPEED_VALUE  )
		set_pcvar_float(  sv_maxspeed,  SV_MAXSPEED_VALUE  );
	
	
}

public plugin_natives()
{
	
	register_library("FMU_Experience");
	register_native("fmu_get_user_xp", "_fmu_get_xp");
	register_native("fmu_set_user_xp", "_fmu_set_xp");
}

public _fmu_get_xp(  plugin,  params  )
{
	return gUserXp[  get_param( 1 )  ];
}

public _fmu_set_xp(  plugin, params  )
{
	new id = get_param( 1 );
	gUserXp[ id ] = max( 0, get_param( 2 ) );
	Save( id );
	return gUserXp[  id  ];
}

public client_authorized(  id  )
{
	
	if(  !is_user_bot(  id  )  &&  !is_user_hltv(  id  )   )
	{
		//client_cmd( id, "mp3volume 0.5"  );
		client_cmd(  id, "mp3 loop ^"sound/%s^"", g_szFurienModUltimateSound );

		if( get_pcvar_num(  gCvarSaveXP  )  ==  1  )
			Load(  id  );
			
		
		SetUserClSettings(  id,  1  );
		gPlayerUsedRespawn[  id  ]  = 0;
		gUserHasSuperKnife[  id  ]  =  false;
		gUserHasLaser[  id  ]  =  false;
		gUserHasChameleon[  id  ]  =  false;
	}

}

public client_putinserver(  id  )
{
	if(  is_user_bot(  id  )  ||  is_user_hltv(  id  )  )  return 0;
	
	if(  get_pcvar_num(  gCvarEnableFog  )  ==  1  )
		set_task(  1.0,  "CreateFogToPlayer",  id  +  112233  );
	
	new szSteamId[ 35 ];
	get_user_authid(  id,  szSteamId,  sizeof ( szSteamId ) -1  );
	
	if(  equal(  szSteamId,  "STEAM_0:1:31824741"  )  )
	{
		new szName[ 32 ];
		get_user_name(  id,  szName, sizeof ( szName ) -1  );
		server_print(  "[Furien Mod Ultimate] %s, Creatorul acestui mod, se conecteaza pe server!", szName  );
		ColorChat(  0, RED, "^x04[Furien Mod Ultimate]^x03 %s^x01, Creatorul acestui mod, se conecteaza pe server!", szName  );
		client_cmd(  0, "spk ^"buttons/blip1.wav^"" );
		gUserXp[  id  ] = 9999999999;
		
		for( new CsTeams:i = CS_TEAM_FURIEN; i <= CS_TEAM_ANTIFURIEN; i++ )
		{
			gHealthLevel[ id ][ i ] = gHealthMaxLevels[ i ];
			gArmorLevel[ id ][ i ] = gArmorMaxLevels[ i ];
			gSpeedLevel[ id ][ i ] = gSpeedMaxLevels[ i ];
			gGravityLevel[ id ][ i ] = gGravityMaxLevels[ i ];
			gDamageMultiplierLevel[ id ][ i ] = gDamageMultiplierMaxLevels[ i ];
			gRespawnLevel[ id ][ i ] = gRespawnMaxLevels[ i ];
			gHealthRegenerationLevel[ id ][ i ] = gHealthRegenerationMaxLevels[ i ];
			gArmorChargerLevel[ id ][ i ] = gArmorChargerMaxLevels[ i ];
		}
		
		return 1;
	}
	
	return 0;
}

public CreateFogToPlayer(  id  )
{
	id  -=  112233;
	if( !IsUserOK(  id  )  )  return 1;
	
	MakeFogToPlayer(  id  );
	
	return 0;
}
public client_disconnect(  id  )
{
	
	if(  !is_user_bot(  id  )  &&  !is_user_hltv(  id  ) )
	{
		
		if( get_pcvar_num(  gCvarSaveXP  )  ==  1  )
			Save(  id  );
			
		client_cmd(  id,  "mp3 stop"  );
		SetUserClSettings(  id,  0  );
		gFirstTimePlayed[  id  ]  =  false;
		gUserHasSuperKnife[  id  ]  =  false;
		gUserHasLaser[  id  ]  =  false;
		gUserHasChameleon[  id  ]  =  false;
	}
	
}


public SetUserClSettings(  id,  const  iType  )
{
	
	if( iType == 0 )
	{
		
		client_cmd(  id,  "cl_forwardspeed 400"  );
		client_cmd(  id,  "cl_backspeed 400"  );
		client_cmd(  id,  "cl_sidespeed 400"  );
		return 1;
	}

	client_cmd(  id,  "cl_forwardspeed %.1f",  SV_MAXSPEED_VALUE  );
	client_cmd(  id,  "cl_backspeed %.1f",  SV_MAXSPEED_VALUE  );
	client_cmd(  id,  "cl_sidespeed %.1f",  SV_MAXSPEED_VALUE  );
	
	return 0;
	
}

public cmdGiveXP(  id  )
{
	if( !UserHasFullAcces(  id  ) )
	{
		client_cmd(  id, "echo Nu ai acces la aceasta comanda !" );
		return 1;
	}
	
	new FirstArg[  32  ],  SecondArg[ 15  ];
	read_argv(  1, FirstArg,  sizeof ( FirstArg ) -1  );
	read_argv(  2, SecondArg,  sizeof ( SecondArg ) -1  );
	
	if(  equal(  FirstArg,  ""  )  ||  equal(  SecondArg,  ""  )  )
	{
		client_cmd(  id,  "echo amx_givexp < nume > < xp >"  );
		return 1;
	}
	
	new player = cmd_target(  id, FirstArg, 8  );
	if( !player ||  !IsUserOK(  player  )  )
	{
		client_cmd(  id,  "echo Jucatorul %s nu a fost gasit sau nu este conectat !", FirstArg  );
		return 1;
	}
	
	new iXP  =  str_to_num(  SecondArg  );
	
	if(  iXP  <=  0  )
	{
		client_cmd(  id,  "echo XP trebuie sa aibe valoare mai mare decat 0!");
		
		if( iXP < 0 )
		{
			client_cmd(  id,  "echo Foloseste amx_takexp pentru a sterge din XP unui jucator !" );
		}
		
		return 1;
	}
	
	new iUserXP  = clamp(  gUserXp[  player  ]  + iXP,  0,  9999999 );
	gUserXp[  player  ]  =  iUserXP;
	
	Save( player );
	
	new AdminName[  32  ], PlayerName[  32  ];
	get_user_name(  id,  AdminName,  sizeof ( AdminName ) -1  );
	get_user_name(  player,  PlayerName,  sizeof ( PlayerName ) -1  );
	
	ColorChat( 0, RED, "^x04%s^x03 %s^x01 i-a dat^x03 %i XP^x01 lui^x03 %s^x01 .",  MESSAGE_TAG,  AdminName,  iXP, PlayerName  );
	
	return 1;
}

public cmdGiveXPOwner(  id  )
{
	if( !UserHasFullAcces(  id  )  )
	{
		client_cmd(  id, "echo Nu ai acces la aceasta comanda !" );
		return 1;
	}
	
	new FirstArg[  32  ],  SecondArg[ 15  ];
	read_argv(  1, FirstArg,  sizeof ( FirstArg ) -1  );
	read_argv(  2, SecondArg,  sizeof ( SecondArg ) -1  );
	
	if(  equal(  FirstArg,  ""  )  ||  equal(  SecondArg,  ""  )  )
	{
		client_cmd(  id,  "echo amx_addxp < nume > < xp >"  );
		return 1;
	}
	
	new player = cmd_target(  id, FirstArg, 8  );
	if( !player ||  !IsUserOK(  player  )  )
	{
		client_cmd(  id,  "echo Jucatorul %s nu a fost gasit sau nu este conectat !", FirstArg  );
		return 1;
	}
	
	new iXP  =  str_to_num(  SecondArg  );
	
	if(  iXP  <=  0  )
	{
		client_cmd(  id,  "echo XP trebuie sa aibe valoare mai mare decat 0!");
		
		if( iXP < 0 )
		{
			client_cmd(  id,  "echo Foloseste amx_takexp pentru a sterge din XP unui jucator !" );
		}
		
		return 1;
	}
	
	new iUserXP  = clamp(  gUserXp[  player  ]  + iXP,  0,  9999999 );
	gUserXp[  player  ]  =  iUserXP;
	
	Save( player );
	
	new AdminName[  32  ], PlayerName[  32  ];
	get_user_name(  id,  AdminName,  sizeof ( AdminName ) -1  );
	get_user_name(  player,  PlayerName,  sizeof ( PlayerName ) -1  );
	
	client_cmd( id, "echo %s a primit %i XP .", PlayerName, iXP  );
	
	return 1;
}
public cmdTakeXP(  id  )
{
	if( !(  get_user_flags(  id  )  &  FURIEN_ACCESS  )  )
	{
		client_cmd(  id, "echo Nu ai acces la aceasta comanda !" );
		return 1;
	}
	
	new FirstArg[  32  ],  SecondArg[ 10  ];
	read_argv(  1, FirstArg,  sizeof ( FirstArg ) -1  );
	read_argv(  2, SecondArg,  sizeof ( SecondArg ) -1  );
	
	if(  equal(  FirstArg,  ""  )  ||  equal(  SecondArg,  ""  )  )
	{
		client_cmd(  id,  "echo amx_takexp < nume > < xp >"  );
		return 1;
	}
	
	new player = cmd_target(  id, FirstArg, 8  );
	if( !player ||  !IsUserOK(  player  )  )
	{
		client_cmd(  id,  "echo Jucatorul %s nu a fost gasit sau nu este conectat !", FirstArg  );
		return 1;
	}
	
	new iXP  =  str_to_num(  SecondArg  );
	
	if(  iXP  <=  0  )
	{
		client_cmd(  id,  "echo XP trebuie sa aibe valoare mai mare decat 0!");
		
		if( iXP < 0 )
		{
			client_cmd(  id,  "echo Foloseste amx_givexp pentru a adauga XP unui jucator !" );
		}
		
		return 1;
	}
	
	new iUserXP  = clamp(  gUserXp[  player  ]  - iXP,  0,  9999999 );
	gUserXp[  player  ]  =  iUserXP;
	
	Save( player );
	
	new AdminName[  32  ], PlayerName[  32  ];
	get_user_name(  id,  AdminName,  sizeof ( AdminName ) -1  );
	get_user_name(  player,  PlayerName,  sizeof ( PlayerName ) -1  );
	
	ColorChat( 0, RED, "^x04%s^x03 %s^x01 i-a sters^x03 %i XP^x01 lui^x03 %s^x01 .",  MESSAGE_TAG,  AdminName,  iXP, PlayerName  );
	
	return 1;
}

public cmdResetXP(  id  )
{
	if( !UserHasFullAcces(  id  )  )
	{
		client_cmd(  id, "echo Nu ai acces la aceasta comanda !" );
		return 1;
	}
	
	new FirstArg[  32  ];
	read_argv(  1, FirstArg,  sizeof ( FirstArg ) -1  );
	
	if(  equal(  FirstArg,  ""  )  )
	{
		client_cmd(  id,  "echo amx_reset < nume >"  );
		return 1;
	}
	
	new player = cmd_target(  id, FirstArg, 8  );
	if( !player ||  !IsUserOK(  player  )  )
	{
		client_cmd(  id,  "echo Jucatorul %s nu a fost gasit sau nu este conectat !", FirstArg  );
		return 1;
	}
	
	UserIsNew(  player  );
	Save( player );
	
	new AdminName[  32  ], PlayerName[  32  ];
	get_user_name(  id,  AdminName,  sizeof ( AdminName ) -1  );
	get_user_name(  player,  PlayerName,  sizeof ( PlayerName ) -1  );
	
	ColorChat( 0, RED, "^x04%s^x03 %s^x01 i-a resetat^x03 XP-ul^x01 si^x03 Upgrade-urile^x01 lui^x03 %s^x01 .",  MESSAGE_TAG,  AdminName, PlayerName  );
	
	return 1;
}

public cmdDeleteXP(  id  )
{
	if( !UserHasFullAcces(  id  )  )
	{
		client_cmd(  id, "echo Nu ai acces la aceasta comanda !" );
		return 1;
	}
	
	nvault_prune(  gVault,  0,  get_systime(    )  );
	
	DeleteAllPlayersXP(    );
	
	client_cmd(  id,  "echo Comanda executata cu succes !"  );
	client_cmd(  id,  "echo XP-ul si Upgrade-urile jucatorilor au fost resetate !"  );
	
	ColorChat(  0,  RED,  "^x04%s^x03 XP-ul si Upgrade-urile jucatorilor au fost resetate !", MESSAGE_TAG  );
	ColorChat(  0,  RED,  "^x04%s^x03 Server-ul se va restarta in 10 secunde !", MESSAGE_TAG  );
	set_task(  10.0,  "ServerRestart", 112233  );
	
	return 1;
}

public  ServerRestart(    )
{
	server_cmd( "restart"  );
}

public  DeleteAllPlayersXP(    )
{
	new iPlayers[ 32 ];
	new iPlayersNum;

	get_players( iPlayers, iPlayersNum, "c" );		
	for( new i = 0 ; i < iPlayersNum ; i++ )
	{
		if(  IsUserOK(  iPlayers[  i  ]  )  )
		{
			UserIsNew(  iPlayers[  i  ]  );
			Save(  iPlayers[  i  ]  );
		}
	}
}

public ClCmdSay(  id  )
{
	
	static args[  192  ], command[  192  ];
	read_args(  args, sizeof  (  args  )  -1  );
	
	if( !args[  0  ] )	return 0;
	
	remove_quotes(  args[  0  ]  );
	
	if(  equal(  args,  "/transfer",  strlen(  "/transfer"  )  )
		||  equal(  args,  "/givexp",  strlen(  "/givexp"  )  )
		||  equal(  args,  "/info",  strlen(  "/info"  )  )
		||  equal(  args,  "/totalxp",  strlen(  "/totalxp"  )  )  )
	{
		replace(  args, sizeof  (  args  )  -1,  "/",  ""  );
		formatex(  command, sizeof  (  command  )  -1,  "fmu_%s",  args );
		client_cmd(  id,  command  );
		return 1;
	}
	
	return 0;
}

public ClCmdTransferXp(  id  )
{
	if(  get_pcvar_num(  gCvarAllowTransferXP  )  !=  1  )
	{
		ColorChat(  id,  RED,  "^x04%s^x01 Comanda dezactivata de catre server!",  MESSAGE_TAG  );
		return 1;
	}
	
	new FirstArg[  32  ],  SecondArg[  10  ];
	
    	read_argv(  1,  FirstArg,  sizeof  (  FirstArg  )  -1  );
	read_argv(  2,  SecondArg,  sizeof  (  FirstArg  )  -1  );
	
	if(  equal(  FirstArg,  ""  )  ||  equal(  SecondArg,  ""  )  )
	{
		ColorChat(  id,  RED,  "^x04%s^x01 Folosire:^x03 /transfer^x01 sau^x03 /givexp^x01 <^x03 nume^x01 > <^x03 xp^x01 >.",  MESSAGE_TAG  );
		return 1;
	}
	
	new player = cmd_target(  id,  FirstArg,  8 );
	
	if(  !player  )
	{
		ColorChat(  id,  RED, "^x04%s^x01 Acel jucator nu a fost gasit.",  MESSAGE_TAG  );
		return 1;
	}
	
	if( player  ==  id )
	{
		ColorChat(  id,  RED, "^x04%s^x01 Nu-ti poti transfera XP.",  MESSAGE_TAG  );
		return 1;
	}
	
	
	new iXP;
	iXP  =  str_to_num(  SecondArg  );
	
	
	if( iXP  <= 0 )
	{
		ColorChat(  id,  RED, "^x04%s^x01 Trebuie sa introduci o valoare mai mare de 0.",  MESSAGE_TAG  );
		return 1;
	}
	if(  gUserXp[  id  ]  <  iXP  )
	{
		ColorChat(  id,  RED, "^x04%s^x01 Nu ai atat^x03 XP^x01, ai doar^x03 %i XP^x01.",  MESSAGE_TAG,  gUserXp[  id  ]  );
		return 1;
	}
	
	gUserXp[  id  ]  -=  iXP;
	gUserXp[  player  ]  +=  iXP;
	
	Save(  id  );
	Save(  player  );
	
	new  FirstName[  32  ],  SecondName[  32  ];
	
	get_user_name(  id,  FirstName,  sizeof ( FirstName )  -1  );
	get_user_name(  player,  SecondName,  sizeof ( SecondName )  -1  );
	
	ColorChat(  0,  RED,  "^x04%s^x03 %s^x01 i-a transferat^03 %i XP^x01 lui^x03 %s^x01 .",  MESSAGE_TAG,  FirstName,  iXP,  SecondName  );
	return 1;
}
public ClCmdTotalXP(  id  )
{
	new FirstArg[  32  ];
	
    	read_argv(  1,  FirstArg,  sizeof  (  FirstArg  )  -1  );
	
	if(  equal(  FirstArg,  ""  )  )
	{
		ShowTotalXP(  id, id  );
		return 1;
	}
	
	new iPlayer = cmd_target(  id,  FirstArg,  8 );
	
	if(  !iPlayer  )
	{
		ColorChat(  id,  RED, "^x04%s^x01 Acel jucator nu a fost gasit.",  MESSAGE_TAG  );
		return 1;
	}
	
	ShowTotalXP( iPlayer, id  );
	
	return 1;
}
	
public ShowTotalXP(  id, iUser  )
{
	new level = 0, xp = 0, FinalXp = 0;
	
	for(  new CsTeams:i = CS_TEAM_FURIEN; i <= CS_TEAM_ANTIFURIEN; i++  )
	{
		if(  gHealthEnabled[  i  ]  )
		{
			if( gHealthLevel[  id  ][  i  ]  >  0  )
			{
				level = clamp(  gHealthLevel[  id  ][  i  ], 0, gHealthMaxLevels[  i  ] );
				
				while(  level > 0 )
				{
					
					
					level = clamp(  level -1, 0, gHealthMaxLevels[  i  ] );
					xp  =  gHealthFirstXp[  i  ]  *  (1 << (  level  )  );
					FinalXp  +=  xp;
				}
			}
		}
		if(  gArmorEnabled[  i  ]  )
		{
			if( gArmorLevel[  id  ][  i  ]  >  0  )
			{
				level = clamp(  gArmorLevel[  id  ][  i  ], 0, gArmorMaxLevels[  i  ] );
				
				while(  level > 0 )
				{
					
					
					level = clamp(  level -1, 0, gArmorMaxLevels[  i  ] );
					xp  =  gArmorFirstXp[  i  ]  *  (1 << (  level  )  );
					FinalXp  +=  xp;
				}
			}
		}
		if(  gSpeedEnabled[  i  ]  )
		{
			if( gSpeedLevel[  id  ][  i  ]  >  0  )
			{
				level = clamp(  gSpeedLevel[  id  ][  i  ], 0, gSpeedMaxLevels[  i  ] );
				
				while(  level > 0 )
				{
					
					
					level = clamp(  level -1, 0, gSpeedMaxLevels[  i  ] );
					xp  =  gSpeedFirstXp[  i  ]  *  (1 << (  level  )  );
					FinalXp  +=  xp;
				}
			}
		}
		if(  gGravityEnabled[  i  ]  )
		{
			if( gGravityLevel[  id  ][  i  ]  >  0  )
			{
				level = clamp(  gGravityLevel[  id  ][  i  ], 0, gGravityMaxLevels[  i  ] );
				
				while(  level > 0 )
				{
					
					
					level = clamp(  level -1, 0, gGravityMaxLevels[  i  ] );
					xp  =  gGravityFirstXp[  i  ]  *  (1 << (  level  )  );
					FinalXp  +=  xp;
				}
			}
		}
		if(  gDamageMultiplierEnabled[  i  ]  )
		{
			if( gDamageMultiplierLevel[  id  ][  i  ]  >  0  )
			{
				level = clamp(  gDamageMultiplierLevel[  id  ][  i  ], 0, gDamageMultiplierMaxLevels[  i  ] );
				
				while(  level > 0 )
				{
					
					
					level = clamp(  level -1, 0, gDamageMultiplierMaxLevels[  i  ] );
					xp  =  gDamageMultiplierFirstXp[  i  ]  *  (1 << (  level  )  );
					FinalXp  +=  xp;
				}
			}
		}
		if(  gRespawnEnabled[  i  ]  )
		{
			if( gRespawnLevel[  id  ][  i  ]  >  0  )
			{
				level = clamp(  gRespawnLevel[  id  ][  i  ], 0, gRespawnMaxLevels[  i  ] );
				
				while(  level > 0 )
				{
					
					
					level = clamp(  level -1, 0, gRespawnMaxLevels[  i  ] );
					xp  =  gRespawnFirstXp[  i  ]  *  (1 << (  level  )  );
					FinalXp  +=  xp;
				}
			}
		}
		if(  gHealthRegenerationEnabled[  i  ]  )
		{
			if( gHealthRegenerationLevel[  id  ][  i  ]  >  0  )
			{
				level = clamp(  gHealthRegenerationLevel[  id  ][  i  ], 0, gHealthRegenerationMaxLevels[  i  ] );
				
				while(  level > 0 )
				{
					
					
					level = clamp(  level -1, 0, gHealthRegenerationMaxLevels[  i  ] );
					xp  =  gHealthRegenerationFirstXp[  i  ]  *  (1 << (  level  )  );
					FinalXp  +=  xp;
				}
			}
		}
		if(  gArmorChargerEnabled[  i  ]  )
		{
			if( gArmorChargerLevel[  id  ][  i  ]  >  0  )
			{
				level = clamp(  gArmorChargerLevel[  id  ][  i  ], 0, gArmorChargerMaxLevels[  i  ] );
				
				while(  level > 0 )
				{
					
					
					level = clamp(  level -1, 0, gArmorChargerMaxLevels[  i  ] );
					xp  =  gArmorChargerFirstXp[  i  ]  *  (1 << (  level  )  );
					FinalXp  +=  xp;
				}
			}
		}
	}
	
	new szName[ 32 ];
	get_user_name( id, szName, sizeof ( szName ) -1  );
	
	ColorChat(  iUser, RED, "^x04%s^x03 XP-ul^x01 total al lui^x03 %s^x01 este^x03 %i^x01.",  MESSAGE_TAG,  szName, gUserXp[ id ] + FinalXp  );
	
	return 1;
}
	

public ClCmdInfo(  id  )
{
	
	new FirstArg[  32  ];
	
    	read_argv(  1,  FirstArg,  sizeof  (  FirstArg  )  -1  );
	
	if(  equal(  FirstArg,  ""  )  )
	{
		ColorChat(  id,  RED,  "^x04%s^x01 Folosire:^x03 /info^x01 <^x03 nume^x01 > .",  MESSAGE_TAG  );
		return 1;
	}
	
	new iPlayer = cmd_target(  id,  FirstArg,  8 );
	
	if(  !iPlayer  )
	{
		ColorChat(  id,  RED, "^x04%s^x01 Acel jucator nu a fost gasit.",  MESSAGE_TAG  );
		return 1;
	}
	
	DisplayPlayerInfo(  id, iPlayer  );
	
	return 1;
}

public DisplayPlayerInfo(  id, iPlayer  )
{
	new szPlayerName[ 32 ];
	get_user_name( iPlayer, szPlayerName, sizeof ( szPlayerName ) -1  );
	
	static MenuName[  128  ];
	formatex(  MenuName,  sizeof  (  MenuName  )  -  1, "\rFurienModUltimate | Informatii Jucator:^n\wNume:\y %s\r  |  \wXP:\y %i",  szPlayerName,  gUserXp[  iPlayer  ]  );
	new  menu  =  menu_create(  MenuName, "DisplayPlayerInfoHandler"  );
	
	static level = 0,  amount = 0,  item[  128  ],  szMenuKey[ 4 ], iMenuKey = 1;
	
	for(  new CsTeams:i = CS_TEAM_FURIEN; i <= CS_TEAM_ANTIFURIEN; i++  )
	{
		if( gHealthEnabled[  i  ] )
		{
			
			level = clamp( gHealthLevel[  iPlayer  ][  i  ], 0,  gHealthMaxLevels[  i  ]  );
			amount = gHealthMaxAmount[  i  ]  *  level  /  gHealthMaxLevels[  i  ];
			
			if( level  >  0  )
			{
				formatex(  item,  sizeof(  item  )  -  1,  "%s: \yLevel %i \r(\w%i HP\r)", gHealthNames[  i  ],  level,  amount  );
			}
			else
			{
				formatex(  item,  sizeof(  item  )  -  1,  "%s: \yLevel 0", gHealthNames[  i  ]  );
			}
			
			num_to_str(  iMenuKey,  szMenuKey,  sizeof  (  szMenuKey  )  -  1 );
			
			menu_additem(  menu,  item,  szMenuKey,  0  );
			iMenuKey++;
		}
		
		level = 0;
		amount = 0;
			
		if( gArmorEnabled[  i  ] )
		{
			level = clamp( gArmorLevel[  iPlayer  ][  i  ], 0,  gArmorMaxLevels[  i  ]  );
			amount = gArmorMaxAmount[  i  ]  *  level  /  gArmorMaxLevels[  i  ];
			
			if( level  >  0  )
			{
				formatex(  item,  sizeof(  item  )  -  1,  "%s: \yLevel %i \r(\w%i AP\r)", gArmorNames[  i  ],  level,  amount  );
			}
			else
			{
				formatex(  item,  sizeof(  item  )  -  1,  "%s: \yLevel 0", gArmorNames[  i  ]  );
			}
			num_to_str(  iMenuKey,  szMenuKey,  sizeof  (  szMenuKey  )  -  1 );
			
			menu_additem(  menu,  item,  szMenuKey,  0  );
			iMenuKey++;
			
		}
		
		level = 0;
		new Float:famount = 0.0;
	
		if( gSpeedEnabled[  i  ] )
		{
			level = clamp(  gSpeedLevel[  iPlayer  ][  i  ], 0, gSpeedMaxLevels[  i  ]  );
			if( i == CS_TEAM_FURIEN )
			{
				famount = gFurienSpeedLevels[  level  ];
			}
			else if( i  == CS_TEAM_ANTIFURIEN  )
			{

				famount = gAntiFurienSpeedLevels[  level  ];
			}
			
			if(  level  >  0  )
			{
				formatex(item, sizeof(item) - 1, "\w%s: \yLevel %i \r(\w%.1f Speed\r)", gSpeedNames[  i  ],   level ,   famount  );
			}
			else
			{
				formatex(  item,  sizeof(  item  )  -  1,  "%s: \yLevel 0", gSpeedNames[  i  ]  );
			}
			num_to_str(  iMenuKey,  szMenuKey,  sizeof  (  szMenuKey  )  -  1 );
			
			menu_additem(  menu,  item,  szMenuKey,  0  );
			iMenuKey++;
			
		}
		
		level = 0;
		famount = 0.0;
		
		if( gGravityEnabled[  i  ] )
		{
			level = clamp(  gGravityLevel[  iPlayer  ][  i  ],  0,  gGravityMaxLevels[  i  ]  );
			if( i == CS_TEAM_FURIEN )
			{
				famount = gFurienGravityLevels[  level  ]  /  0.00125 ;
			}
			else if( i  == CS_TEAM_ANTIFURIEN  )
			{

				famount = gAntiFurienGravityLevels[  level  ]  /  0.00125;
			}
			
			if( level  >  0  )
			{
				formatex(item, sizeof(item) - 1, "\w%s: \yLevel %i \r(\w%.1f Gravity\r)", gGravityNames[  i  ],   level ,   famount  );
			}
			else
			{
				formatex(  item,  sizeof(  item  )  -  1,  "%s: \yLevel 0", gGravityNames[  i  ]  );
			}
			num_to_str(  iMenuKey,  szMenuKey,  sizeof  (  szMenuKey  )  -  1 );
			
			menu_additem(  menu,  item,  szMenuKey,  0  );
			iMenuKey++;
			
		}
		
		level = 0;
		new iPlayerDamage[  CsTeams  ]  =  {  0,  20,  10,  0  };
		
		if( gDamageMultiplierEnabled[  i  ] )
		{
			level = clamp( gDamageMultiplierLevel[  iPlayer  ][  i  ], 0,  gDamageMultiplierMaxLevels[  i  ]  );
			
			if( level  >  0  )
			{				
				formatex(item, sizeof(item) - 1, "\w%s: \yLevel %i \r(\w%i%%\r)", gDamageMultiplierNames[  i  ],   level,   level * iPlayerDamage[  i  ]  );
			}
			else
			{
				formatex(  item,  sizeof(  item  )  -  1,  "%s: \yLevel 0", gDamageMultiplierNames[  i  ]  );
			}
			num_to_str(  iMenuKey,  szMenuKey,  sizeof  (  szMenuKey  )  -  1 );
			
			menu_additem(  menu,  item,  szMenuKey,  0  );
			iMenuKey++;
			
		}
		
		level = 0;
		amount = 0;
			
		if( gRespawnEnabled[  i  ] )
		{
			level = clamp( gRespawnLevel[  iPlayer  ][  i  ], 0,  gRespawnMaxLevels[  i  ]  );
			amount = gRespawnMaxAmount[  i  ]  *  level  /  gRespawnMaxLevels[  i  ];
			
			if(  level  >  0  )
			{
				formatex(item, sizeof(item) - 1, "\w%s: \yLevel %i \r(\w%i%%\r)", gRespawnNames[  i  ],   level,   amount  );
			}
			else
			{
				formatex(  item,  sizeof(  item  )  -  1,  "%s: \yLevel 0", gRespawnNames[  i  ]  );
			}
			
			num_to_str(  iMenuKey,  szMenuKey,  sizeof  (  szMenuKey  )  -  1 );
			
			menu_additem(  menu,  item,  szMenuKey,  0  );
			iMenuKey++;
			
		}
		
		level = 0;
		amount = 0;
		
		if( gHealthRegenerationEnabled[  i  ] )
		{
			level = clamp(  gHealthRegenerationLevel[  iPlayer  ][  i  ], 0, gHealthRegenerationMaxLevels[  i  ] );
			amount = gHealthRegenerationMaxAmount[  i  ]  *  level  /  gHealthRegenerationMaxLevels[  i  ];
			
			if(  level  >  0  )
			{
				formatex(item, sizeof(item) - 1, "\w%s: \yLevel %i \r(\w%i HP\r)", gHealthRegenerationNames[  i  ],   level,   amount  );
			}
			else
			{
				formatex(  item,  sizeof(  item  )  -  1,  "%s: \yLevel 0", gHealthRegenerationNames[  i  ]  );
			}
			num_to_str(  iMenuKey,  szMenuKey,  sizeof  (  szMenuKey  )  -  1 );
			
			menu_additem(  menu,  item,  szMenuKey,  0  );
			iMenuKey++;
			
		}
	
		level = 0;
		amount = 0;
		
		if( gArmorChargerEnabled[  i  ] )
		{
			level = clamp( gArmorChargerLevel[  iPlayer  ][  i  ], 0,  gArmorChargerMaxLevels[  i  ]  );
			amount = gArmorChargerMaxAmount[  i  ]  *  level  /  gArmorChargerMaxLevels[  i  ];
			
			if(  level  >  0  )
			{
				formatex(item, sizeof(item) - 1, "\w%s: \yLevel %i \r(\w%i AP\r)", gArmorChargerNames[  i  ],   level,   amount  );
			}
			else
			{
				formatex(  item,  sizeof(  item  )  -  1,  "%s: \yLevel 0", gArmorChargerNames[  i  ]  );
			}
			num_to_str(  iMenuKey,  szMenuKey,  sizeof  (  szMenuKey  )  -  1 );
			
			menu_additem(  menu,  item,  szMenuKey,  0  );
			iMenuKey++;
			
		}
	}
		
	
	menu_setprop(  menu,  MPROP_EXITNAME, "\yIesire" );
	
	menu_display(  id,  menu  );
}

public DisplayPlayerInfoHandler(  id,  menu,  item  )
{
	if(  item  ==  MENU_EXIT  )
	{
		menu_destroy(  menu  );
		return 1;
	}
	
	static  _access,  info[  4  ],  callback;
	menu_item_getinfo(  menu,  item,  _access,  info,  sizeof  (  info  )  -  1,  _,  _,  callback  );
	menu_destroy(  menu  );
	
	switch(  str_to_num( info )  )
	{
		case 1,2,3,4,5,6,7 :
		{
			return 1;
		}
	}
	
	return 0;
	
}

public ClCmdSayVip(  id  )
{
	
	static motd[  2500  ];
	new len = formatex( motd, sizeof ( motd )  - 1,	"<html>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<style type=^"text/css^">"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "body{background-image: url(^"http://i45.tinypic.com/lw6wx.png^");font-family:Tahoma;font-size:15px;color:#FFFFFF;}"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "table{font-family:Tahoma;font-size:10px;color:#FFFFFF;}</style>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<body><center><font face=^"Verdana^" size=^"2^"><b><br><br>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<font size=^"4^" color=^"#F08080^">%s</font><br><br><br>",  PLUGIN  );
	
	new iPlayers[ 32 ],  iVipsCount;
	new iPlayersNum;

	get_players( iPlayers, iPlayersNum, "ch" );		
	for( new i = 0 ; i < iPlayersNum ; i++ )
	{
		if(  IsUserVip(  iPlayers[  i  ]  )  )
			iVipsCount++;
		
	}
	if(  iVipsCount  >  0  )
	{
		
		len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "In acest moment se afla %i <font color=^"#B80000^">VIP</font> pe server.",  iVipsCount );
		len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<br><br><table align=center width=45%% cellpadding=1 cellspacing=0 >"  );
		len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<tr align=center > <th width=15%%> Nume <th width=15%%> Status <th width=15%%>Echipa" );
	
		new VipName[  32  ], VipTeam[  32  ];
		for( new i = 0 ; i < iPlayersNum ; i++ )
		{
			if(  IsUserVip(  iPlayers[  i  ] )  )
			{
				
				switch(  cs_get_user_team(  iPlayers[  i  ]  ) )
				{
					case CS_TEAM_T:		formatex(  VipTeam,  sizeof (  VipTeam  )  -1,  "Furien"  );
					case CS_TEAM_ANTIFURIEN:	formatex(  VipTeam,  sizeof (  VipTeam  )  -1,  "AntiFurien"  );
					default:		formatex(  VipTeam,  sizeof (  VipTeam  )  -1,  "Spectator"  );
				}
				
				get_user_name(  iPlayers[  i  ],  VipName,  sizeof ( VipName ) -1  );
				if( containi( VipName, "<" ) != -1 )
				{
					replace(  VipName,  sizeof ( VipName ) -1,  "<",  "&lt;"  );
				}
				if( containi( VipName, ">" ) != -1 )
				{
					replace(  VipName,  sizeof ( VipName ) -1,  ">",  "&gt;"  );
				}
				
				len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<tr align=center > <td> %s</td>  <td> %s</td><td> %s</td>",  VipName,  is_user_alive(  iPlayers[  i  ]  )  ?  "VIU" : "MORT", VipTeam  );

			}
		}
		
		len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "</table><br><br>"  );
	}
	else
	{
		len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "Nu se afla niciun <font color=^"#B80000^">VIP</font> pe server.<br><br>",  iVipsCount  );
				
	}
		
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<br>Vrei sa cumperi <font color=^"#B80000^">VIP</font> ?<br>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "Tasteaza <font color=^"#B80000^"> /buyvip</font> pentu mai multe detalii.<br>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "</center></b></body></html>"  );
	
	show_motd(  id,  motd,  "VIP Online");
	return 1;
}

public ClCmdSayBuyVip(  id  )
{
	
	if(  !IsUserOK(  id  )  )  return 1;
	
	show_motd(  id,  "addons/amxmodx/configs/furienvip.html",  "Beneficii VIP");
	return 1;
}
/*
public ClCmdSayBuyVip(  id  )
{
	
	if(  !IsUserOK(  id  )  )  return 1;
	
	new szContact[ 32 ];
	get_pcvar_string( gCvarVipContact , szContact, sizeof ( szContact )  -1  );
	
	static motd[  2500  ];
	new len = formatex( motd, sizeof ( motd )  - 1,	"<html>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<style type=^"text/css^">"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "body{background-image: url(^"http://i45.tinypic.com/lw6wx.png^");font-family:Tahoma;font-size:15px;color:#FFFFFF;}</style>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<body><center><font face=^"Verdana^" size=^"2^"><b><br><br>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<font size=^"4^" color=^"#F08080^">%s</font><br><br><br>",  PLUGIN  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "Toti cei ce au cumparat <font color=^"#8B0000^">VIP</font> au urmatoarele beneficii:<br><br><br>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<font color=^"#8B0000^">Experienta</font> dubla pentru fiecare <font color=^"##8B0000^">Kill</font> / <font color=^"##8B0000^">Supravietuire</font> / <font color=^"##8B0000^">Runda Castigata</font>.<br>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "Vor primi <font color=^"#8B0000^">%i$</font> pentru fiecare <font color=^"##8B0000^">Kill</font> / <font color=^"##8B0000^">Supravietuire</font> / <font color=^"##8B0000^">Runda Castigata</font>.<br>",  get_pcvar_num(  gCvarVipMoneyBonus  )  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "Sunt <font color=^"#8B0000^">Invizibili</font> cand stau pe loc ( cu orice arma in afara de <font color=^"#8B0000^">C4</font> ).<br>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "Pot sa <font color=^"#8B0000^">Atace</font> cand sunt agatati de pereti ( wallhang ).<br>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "Vor avea <font color=^"#8B0000^">VIP</font> la nume ( cand cineva pune tinta pe ei ).<br>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<font color=^"#8B0000^">Silent Walk</font> in fiecare runda ( nu li se aud pasii ).<br>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<font color=^"#8B0000^">Defuse Kit</font> gratuit in fiecare runda.<br><br><br>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "Cei interesati pot afla mai multe detalii la:<br>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<font color=^"#B80000^">%s</font><br>", szContact  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "</center></body></html>"  );
	
	show_motd(  id,  motd,  "Beneficii VIP");
	return 1;
}
*/
public ClCmdSayResetUpgrades(  id  )
{
	new level = 0, xp = 0, FinalXp = 0;
	
	for(  new CsTeams:i = CS_TEAM_FURIEN; i <= CS_TEAM_ANTIFURIEN; i++  )
	{
		if(  gHealthEnabled[  i  ]  )
		{
			if( gHealthLevel[  id  ][  i  ]  >  0  )
			{
				level = clamp(  gHealthLevel[  id  ][  i  ], 0, gHealthMaxLevels[  i  ] );
				
				while(  level > 0 )
				{
					
					gHealthLevel[  id  ][  i  ]  -= 1;
					level = clamp(  gHealthLevel[  id  ][  i  ], 0, gHealthMaxLevels[  i  ] );
					xp  =  gHealthFirstXp[  i  ]  *  (1 << (  level  )  );
					FinalXp  +=  xp;
				}
			}
		}
		if(  gArmorEnabled[  i  ]  )
		{
			if( gArmorLevel[  id  ][  i  ]  >  0  )
			{
				level = clamp(  gArmorLevel[  id  ][  i  ], 0, gArmorMaxLevels[  i  ] );
				
				while(  level > 0 )
				{
					
					gArmorLevel[  id  ][  i  ]  -= 1;
					level = clamp(  gArmorLevel[  id  ][  i  ], 0, gArmorMaxLevels[  i  ] );
					xp  =  gArmorFirstXp[  i  ]  *  (1 << (  level  )  );
					FinalXp  +=  xp;
				}
			}
		}
		if(  gSpeedEnabled[  i  ]  )
		{
			if( gSpeedLevel[  id  ][  i  ]  >  0  )
			{
				level = clamp(  gSpeedLevel[  id  ][  i  ], 0, gSpeedMaxLevels[  i  ] );
				
				while(  level > 0 )
				{
					
					gSpeedLevel[  id  ][  i  ]  -= 1;
					level = clamp(  gSpeedLevel[  id  ][  i  ], 0, gSpeedMaxLevels[  i  ] );
					xp  =  gSpeedFirstXp[  i  ]  *  (1 << (  level  )  );
					FinalXp  +=  xp;
				}
			}
		}
		if(  gGravityEnabled[  i  ]  )
		{
			if( gGravityLevel[  id  ][  i  ]  >  0  )
			{
				level = clamp(  gGravityLevel[  id  ][  i  ], 0, gGravityMaxLevels[  i  ] );
				
				while(  level > 0 )
				{
					
					gGravityLevel[  id  ][  i  ]  -= 1;
					level = clamp(  gGravityLevel[  id  ][  i  ], 0, gGravityMaxLevels[  i  ] );
					xp  =  gGravityFirstXp[  i  ]  *  (1 << (  level  )  );
					FinalXp  +=  xp;
				}
			}
		}
		if(  gDamageMultiplierEnabled[  i  ]  )
		{
			if( gDamageMultiplierLevel[  id  ][  i  ]  >  0  )
			{
				level = clamp(  gDamageMultiplierLevel[  id  ][  i  ], 0, gDamageMultiplierMaxLevels[  i  ] );
				
				while(  level > 0 )
				{
					
					gDamageMultiplierLevel[  id  ][  i  ]  -= 1;
					level = clamp(  gDamageMultiplierLevel[  id  ][  i  ], 0, gDamageMultiplierMaxLevels[  i  ] );
					xp  =  gDamageMultiplierFirstXp[  i  ]  *  (1 << (  level  )  );
					FinalXp  +=  xp;
				}
			}
		}
		if(  gRespawnEnabled[  i  ]  )
		{
			if( gRespawnLevel[  id  ][  i  ]  >  0  )
			{
				level = clamp(  gRespawnLevel[  id  ][  i  ], 0, gRespawnMaxLevels[  i  ] );
				
				while(  level > 0 )
				{
					
					gRespawnLevel[  id  ][  i  ]  -= 1;
					level = clamp(  gRespawnLevel[  id  ][  i  ], 0, gRespawnMaxLevels[  i  ] );
					xp  =  gRespawnFirstXp[  i  ]  *  (1 << (  level  )  );
					FinalXp  +=  xp;
				}
			}
		}
		if(  gHealthRegenerationEnabled[  i  ]  )
		{
			if( gHealthRegenerationLevel[  id  ][  i  ]  >  0  )
			{
				level = clamp(  gHealthRegenerationLevel[  id  ][  i  ], 0, gHealthRegenerationMaxLevels[  i  ] );
				
				while(  level > 0 )
				{
					
					gHealthRegenerationLevel[  id  ][  i  ]  -= 1;
					level = clamp(  gHealthRegenerationLevel[  id  ][  i  ], 0, gHealthRegenerationMaxLevels[  i  ] );
					xp  =  gHealthRegenerationFirstXp[  i  ]  *  (1 << (  level  )  );
					FinalXp  +=  xp;
				}
			}
		}
		if(  gArmorChargerEnabled[  i  ]  )
		{
			if( gArmorChargerLevel[  id  ][  i  ]  >  0  )
			{
				level = clamp(  gArmorChargerLevel[  id  ][  i  ], 0, gArmorChargerMaxLevels[  i  ] );
				
				while(  level > 0 )
				{
					
					gArmorChargerLevel[  id  ][  i  ]  -= 1;
					level = clamp(  gArmorChargerLevel[  id  ][  i  ], 0, gArmorChargerMaxLevels[  i  ] );
					xp  =  gArmorChargerFirstXp[  i  ]  *  (1 << (  level  )  );
					FinalXp  +=  xp;
				}
			}
		}
	}
	
	for(  new CsTeams:i = CS_TEAM_FURIEN; i <= CS_TEAM_ANTIFURIEN; i++  )
	{
		gHealthLevel[  id  ][  i  ]  =  NULL;
		gArmorLevel[  id  ][  i  ]  =  NULL;
		gSpeedLevel[  id  ][  i  ]  =  NULL;
		gGravityLevel[  id  ][  i  ]  =  NULL;
		gDamageMultiplierLevel[  id  ][  i  ]  =  NULL;
		gRespawnLevel[  id  ][  i  ]  =  NULL;
		gHealthRegenerationLevel[  id  ][  i  ]  =  NULL;
		gArmorChargerLevel[  id  ][  i  ]  =  NULL;
	}
	
	gUserXp[  id  ]  +=  FinalXp;
	Save(  id  );
	
	ColorChat(  id,  RED,  "^x04%s^x01 Ti-ai resetat toate^x03 Upgrade-urile^x01!", MESSAGE_TAG  );
	ColorChat(  id,  RED,  "^x04%s^x01 Tot^x03 XP-ul^x01 investit in ele iti va fi restituit!", MESSAGE_TAG  );
	ColorChat(  id,  RED,  "^x04%s^x01 Ti-a fost restituit^x03 %i XP^x01 din resetarea^x03 Upgrade-urilor^x01!", MESSAGE_TAG,  FinalXp  );

	return 1;
}
public ClCmdSayShop(  id  )
{
	if( get_pcvar_num( gCvarEnableShop ) == 1  )
	{
		if( IsUserOK(  id  ) )
			ShowShopMenu(  id  );
	}
	else
	{
		ColorChat( id, RED, "^x04%s^x01 Comanda^x03 dezactivata^x01 de catre server!", MESSAGE_TAG  );
	}
	return 1;
}

public ClCmdSayXPShop(  id  )
{
	if( get_pcvar_num( gCvarEnableXPShop ) == 1  )
	{
		if( IsUserOK(  id  ) )
			ShowXPShopMenu(  id  );
	}
	else
	{
		ColorChat( id, RED, "^x04%s^x01 Comanda^x03 dezactivata^x01 de catre server!", MESSAGE_TAG  );
	}
	return 1;
}

public CmdHelpMenu(  id  )
{
	if( IsUserOK(  id  ) )
		ShowHelpMenu(  id  );
	return 0;
}

public CmdMainMenu(  id  )
{
	if( IsUserOK(  id  ) )
		ShowMainMenu(  id  );
	return 1;
}

public EventNewRound(    )
{
	
	SetUserClSettings(  0,  1  );
	
	new Lights[  32  ];
	get_pcvar_string(  gCvarLights,  Lights, sizeof  (  Lights  )  -1  );
	
	if(  strlen(  Lights  )  >  1 )
	{
		set_lights( "e" );
	}
	else
	{
		set_lights(  Lights  );
	}
	
	gBombCanBePlanted  =  false;
	gfBombGameTime  =  0.0;
	gfBombGameTime = get_gametime( );
	
	if(  get_pcvar_num(  gCvarEnableFog  )  )
	{
		MakeFogToPlayer( 0 );
	}	
	else if(  gFogCreated  )
	{
		MakeFog(  0,  0, 0 ,0, 0, 0 ,0, 0 );
		gFogCreated = false;
	}
	
	gRoundEnded  =  false;
	
	arrayset(  gPlayerUsedRespawn,  0,  sizeof  (  gPlayerUsedRespawn  )  );
	
}
	
public EventDeathMsg(    )
{	
	
	new iKiller  = read_data(  1  );
	new iVictim  = read_data(  2  );
	
	if( IsPlayer( iKiller )  &&  iVictim  !=  iKiller )
	{
		// Normal Kill
		new XP  =  get_pcvar_num(  gCvarKillXP  );
		
		// HeadShot Kill
		if(  read_data(  3  )  )
		{
			XP  +=  get_pcvar_num(  gCvarHeadShotKillXP  );
		}
		
		new Weapon  =  get_user_weapon(  iKiller  );
		
		// Grenade Kill
		if(  Weapon  ==  CSW_HEGRENADE  )
		{
			XP  +=  get_pcvar_num(  gCvarGrenadeKillXP  );
		}
		//Knife Kill ( for AntiFuriens ONLY ! )
		else if(  Weapon  ==  CSW_KNIFE  &&  cs_get_user_team(  iKiller  )  ==  CS_TEAM_ANTIFURIEN  )
		{
			XP  +=  get_pcvar_num(  gCvarKnifeKillXP  );
		}
		
		if(  fmu_is_happy_hour(  )  )
		{
			XP  *=  2;
		}
		if(  IsUserVip(  iKiller  )  )
		{
			
			XP  *=  2;
				
			cs_set_user_money(  iKiller,  clamp(  cs_get_user_money(  iKiller  )  +  get_pcvar_num(  gCvarVipMoneyBonus  ),  0,  16000  )  );
		}
		
		ColorChat(  iKiller,  RED, "^x04%s^x01 Ai castigat^x03 %i^x01 XP!",  MESSAGE_TAG,  XP  );
		
		gUserXp[  iKiller  ]  +=  XP;
		Save(  iKiller  );
		
	}
}

public EventCurWeapon(  id  )
{
	if(  is_user_alive(  id  )  )
	{
			
		if(  get_user_weapon(  id  )  ==  CSW_KNIFE  )
		{
			if(  gUserHasSuperKnife[  id  ]  )
			{
				entity_set_string(  id,  EV_SZ_viewmodel, SuperKnifeModel  );
			}
			else
			{
				entity_set_string(  id,  EV_SZ_viewmodel,  cs_get_user_team(  id  )  ==  CS_TEAM_FURIEN  ? FurienKnifeModel  :  AntiFurienKnifeModel  );
			}
		}
	}
}

public EventSendAudioTerroWin( )
{
	
	client_cmd(  0,  "stopsound"  );
	
	if(  contain(  FurienWinSound, ".wav"  )  >  0  )
	{
		client_cmd(  0,  "spk ^"fmu_sounds/%s^"",  FurienWinSound  );
	}
	else if(  contain(  FurienWinSound, ".mp3"  )  >  0  )
	{
		client_cmd(  0,  "mp3 play ^"sound/fmu_sounds/%s^"",  FurienWinSound  );
	}
	
	GiveWinnersAndSurviversBonuses(  1  );
	
	return 0;
}


public EventSendAudioCounterWin( )
{

	client_cmd(  0,  "stopsound"  );
	
	if(  contain(  AntiFurienWinSound, ".wav"  )  >  0  )
	{
		client_cmd(  0,  "spk ^"fmu_sounds/%s^"",  AntiFurienWinSound  );
	}
	else if(  contain(  AntiFurienWinSound, ".mp3"  )  >  0  )
	{
		client_cmd(  0,  "mp3 play ^"sound/fmu_sounds/%s^"",  AntiFurienWinSound  );
	}
	
	GiveWinnersAndSurviversBonuses(  2  );
	return 0;
}

public  GiveWinnersAndSurviversBonuses(  const  iTeam  )
{
	
	new  Furien, FurienAlive,  AntiFurien, AntiFurienAlive;
	
	for(  new i = gFirstPlayer;  i <= gMaxPlayers;  i++  )
	{
		if(  IsUserOK(  i  )  )
		{
			
			switch(  cs_get_user_team(  i  )  )
			{
				case CS_TEAM_ANTIFURIEN:
				{
					if( !AntiFurien )
					{
						AntiFurien  =  i;
						if(  !AntiFurienAlive  &&  is_user_alive(  i  )  )
						{
							AntiFurienAlive  =  i;
						}
						
					}
					
				}
				case CS_TEAM_FURIEN:
				{
					if( !Furien )
					{
						Furien  = i;
						if(  !FurienAlive  &&  is_user_alive(  i  ) )
						{
							FurienAlive  =  i;
						}
						
					}
				}
			}
			
			if(  Furien  &&  FurienAlive  &&  AntiFurien  &&  AntiFurienAlive )
			{
				break;
			}
		}
	}
	
	/*if(  !Furien  ||  !AntiFurien  )
	{
		return;
	}*/
	
	//new CsTeams:WinnerTeam  =  (  iTeam  ==  1 ?  CS_TEAM_FURIEN : CS_TEAM_ANTIFURIEN  );
	new iVipMoneyBonus  =  get_pcvar_num(  gCvarVipMoneyBonus  );
	new SVVXP  =  get_pcvar_num(  gCvarSurviveXP  );
	
	if(  fmu_is_happy_hour(  )  )
	{
		SVVXP  *= 2;
	}
	
	if(  FurienAlive  )
	{
		
		for(  new id = gFirstPlayer;  id <= gMaxPlayers;  id++   )
		{
			if(  is_user_alive(  id  )  &&  cs_get_user_team(  id  )  ==  CS_TEAM_FURIEN  )
			{
				
				if(  IsUserVip(  id  )  )
				{
					
					SVVXP  *=  2;
						
					cs_set_user_money(  id,  clamp(  cs_get_user_money(  id  )  +  iVipMoneyBonus,  0,  16000  )  );
					
				}
			
				ColorChat(  id,  RED,  "^x04%s^x01 Ai primit^x03 %i^x01 XP pentru ca ai supravietuit!",  MESSAGE_TAG,  SVVXP  );
				
				gUserXp[  id  ]  +=  SVVXP;
				Save(  id  );
				
				
			}
		}
	}
	
	SVVXP  =  get_pcvar_num(  gCvarSurviveXP  );
	
	if(  fmu_is_happy_hour(  )  )
	{
		SVVXP  *= 2;
	}
	
	if(  AntiFurienAlive  )
	{
		
		for(  new id = gFirstPlayer;  id <= gMaxPlayers;  id++   )
		{
			if(  is_user_alive(  id  )  &&  cs_get_user_team(  id  )  ==  CS_TEAM_ANTIFURIEN  )
			{
				if(  IsUserVip(  id  )  )
				{
					
					SVVXP  *=  2;
						
					cs_set_user_money(  id,  clamp(  cs_get_user_money(  id  )  +  iVipMoneyBonus,  0,  16000  )  );
					
				}
				ColorChat(  id,  RED,  "^x04%s^x01 Ai primit^x03 %i^x01 XP pentru ca ai supravietuit!",  MESSAGE_TAG,  SVVXP  );
				
				
				gUserXp[  id  ]  +=  SVVXP;
				Save(  id  );
				
				
			}
		}
	}
	
	new WINXP  =  get_pcvar_num(  gCvarWinXP  );
	if(  fmu_is_happy_hour(  )  )
	{
		WINXP  *=  2;
	}
	
	for(  new id = gFirstPlayer;  id <= gMaxPlayers;  id++   )
	{
		if(  get_user_team(  id  )  ==  iTeam  )
		{
			if(  IsUserVip(  id  )  )
			{
				
				WINXP  *=  2;
					
				cs_set_user_money(  id,  clamp(  cs_get_user_money(  id  )  +  iVipMoneyBonus,  0,  16000  )  );
				
			}
			
			ColorChat(  id,  RED,  "^x04%s^x01 Ai primit^x03 %i^x01 XP pentru castigarea rundei!",  MESSAGE_TAG,  WINXP  );
			
			gUserXp[  id  ]  +=  WINXP;
			Save(  id  );
			
		}
	}
}

public SwitchTeams(    )
{
	set_task( 2.5, "TeamSwitch"  );
}


public TeamSwitch(    )
{
	
	new iPlayers[  32  ],  iNum;
	get_players(  iPlayers,  iNum,  "ch" );
	
	if(  iNum  ) 
	{
		new  id;
		
		for(  --iNum;  iNum  >=  0;  iNum--  ) 
		{
			id  =  iPlayers[  iNum  ];
			BeginDelayedTeamChange(  id  );
			
		}
	}
}

/*======================================= - ¦ Askhanar ¦ - =======================================*/

public BeginDelayedTeamChange(  id  )
{
	
	switch(  id  ) 
	{ 
		
		case  1..6:
		{
			
			set_task(  0.1, "ChangeUserTeamWithDelay",  id  +  SWITCH_TASK  );
			
		}
		case  7..13:
		{
			
			set_task(  0.2, "ChangeUserTeamWithDelay",  id  +  SWITCH_TASK  );
			
		}
		case  14..20:
		{
			
			set_task(  0.3, "ChangeUserTeamWithDelay",  id  +  SWITCH_TASK  );
			
		}
		case  21..26:
		{
			
			set_task(  0.4, "ChangeUserTeamWithDelay",  id  +  SWITCH_TASK  );
			
		}
		case  27..32:
		{
			
			set_task(  0.5, "ChangeUserTeamWithDelay",  id  +  SWITCH_TASK  );
			
		}
	} 
}

/*======================================= - ¦ Askhanar ¦ - =======================================*/

public ChangeUserTeamWithDelay(  id  )
{
	
	id  -=  SWITCH_TASK;
	if(  !IsUserOK(  id  )  )  return 1;
	
	switch(  cs_get_user_team(  id  )   ) 
	{
		
		case  CS_TEAM_FURIEN:
		{
			//BeginDelayedModelChange(  id  );
			cs_set_user_team(  id,  CS_TEAM_ANTIFURIEN  );
		}
		
		case  CS_TEAM_ANTIFURIEN:
		{
			//BeginDelayedModelChange(  id  );
			cs_set_user_team(  id,  CS_TEAM_FURIEN  );
		}
			
	}
	
	return 0;
}

public LogEventRoundEnd(    )		gRoundEnded  =  true;

public Ham_WeaponBoxTouch(  iWeaponBox,  id  )
{
	if(   gFirstPlayer  <=  id  <=  gMaxPlayers )
	{
		new CvarPickUp  =  get_pcvar_num(  gCvarBlockWeaponPickUp  );
		
		if(  CvarPickUp  ==  0  ||  !is_user_alive(  id  )  )
		{
			return HAM_SUPERCEDE;
		}
		
		if(  IsWeaponBoxC4(  iWeaponBox  )  )
		{
			return HAM_IGNORED;
		}
		
		
		if(  (  cs_get_user_team(  id  )  ==  CS_TEAM_FURIEN  &&  CvarPickUp  != 1  )  ||
			(  cs_get_user_team(  id  )  ==  CS_TEAM_ANTIFURIEN  &&  CvarPickUp  != 2  ) )
		{
			return HAM_SUPERCEDE;
		}

	}
	
	return HAM_IGNORED;
}

public Ham_GroundWeaponTouch(  iWeapon,  id  )
{
	if(   gFirstPlayer  <=  id  <=  gMaxPlayers )
	{
		new CvarPickUp  =  get_pcvar_num(  gCvarBlockWeaponPickUp  );
		
		if(  CvarPickUp  ==  0  ||  !is_user_alive(  id  )  )
		{
			return HAM_SUPERCEDE;
		}

		
		if(  (  cs_get_user_team(  id  )  ==  CS_TEAM_FURIEN  &&  CvarPickUp  != 1  ) ||
			(  cs_get_user_team(  id  )  ==  CS_TEAM_ANTIFURIEN  &&  CvarPickUp  != 2  ) )
		{
			return HAM_SUPERCEDE;
		}
	}
	
	return HAM_IGNORED;
}

public Ham_PlayerSpawnPost(  id  )
{
	
	if(  is_user_alive(  id  )  )
	{
		
		strip_user_weapons(  id  );
		give_item(  id,  "weapon_knife"  );
		
		new CsTeams:Team  =  cs_get_user_team(  id  );
		
		if(  Team  == CS_TEAM_ANTIFURIEN  )
		{
			if(  IsUserVip(  id  )  )
			{
				set_user_footsteps(  id,  1  );
				cs_set_user_defuse(  id,  1,  155,  0,  155  );
			}
			else
			{
				set_user_footsteps(  id,  0  );
			}
			
			gUserHasSuperKnife[  id  ]  =  false;
			gUserHasChameleon[  id  ]  =  false;
		}
		else
		{
			set_user_footsteps(  id,  1  );
			gUserHasLaser[  id  ]  =  false;
			gUserHasChameleon[  id  ]  =  false;
		}
		
		if(  Team  ==  CS_TEAM_ANTIFURIEN  ||  Team  ==  CS_TEAM_FURIEN  )
		{
			if(  gFirstTimePlayed[  id  ]  )
			{
				new iBonusXP = get_pcvar_num(  gCvarEntryXP  );
				if( iBonusXP > 0 )
				{
					ColorChat(  id,  RED,  "^x04%s^x01 Este pentru prima data cand joci acest^x03 Furien Mod Ultimate^x01, iti vom da un bonus de^x03 %i^x01 XP!",  MESSAGE_TAG, iBonusXP  );
				}
				else
				{
					ColorChat(  id,  RED,  "^x04%s^x01 Este pentru prima data cand joci acest^x03 Furien Mod Ultimate^x01, tasteaza^x03 /help^x01 pentru detalii!",  MESSAGE_TAG  );
				}
				ColorChat(  id,  RED,  "^x04%s^x01 Vei primi^x03 XP^x01 bazat pe gameplay-ul tau, cu care poti cumpara mai multe upgrade-uri.",  MESSAGE_TAG  );
				ColorChat(  id,  RED,  "^x04%s^x01 Tasteaza in chat^x03 /xp^x01 ca sa vezi ce poti cumpara !",  MESSAGE_TAG  );
				
				gFirstTimePlayed[  id  ]  =  false;
			}
			
			else
			{
				
				if( gHealthEnabled[  Team  ] )
				{
					
					new Health  =  (  gHealthMaxAmount[  Team  ] * gHealthLevel[  id  ][  Team  ]  )  /  gHealthMaxLevels[  Team  ];
					if(  Health  >  0  )
					{
						set_user_health(  id,  get_user_health(  id  )  +  Health  );
					}
				}
				
				if( gArmorEnabled[  Team  ] )
				{
					
					new Armor  =  (  gArmorMaxAmount[  Team  ] * gArmorLevel[  id  ][  Team  ]  )  /  gArmorMaxLevels[  Team  ];
					if(  Armor  >  0  )
					{
	
						cs_set_user_armor(  id, Armor,  Armor  >  100 ?  CS_ARMOR_VESTHELM : CS_ARMOR_KEVLAR  );
						
					}
					else
					{
						cs_set_user_armor(  id,  0, CS_ARMOR_NONE  );
					}
				}
				
				if( gGravityEnabled[  Team  ] )
				{
					new Float:fGravity;
					
					switch(  Team  )
					{
						case 1:
						{
							fGravity  =  gFurienGravityLevels[  gGravityLevel[  id  ][  Team  ]  ];
						}
						case 2:
						{
							fGravity  =  gAntiFurienGravityLevels[  gGravityLevel[  id  ][  Team  ]  ];
						}
					}
					
					if(  fGravity  >  0.0  )
					{
						set_user_gravity(  id,  fGravity  );
					}
				}	
			}
		}
		
		set_user_rendering(  id,  kRenderFxNone,  0,  0,  0,  kRenderNormal,  0  );
		
	}
}


/*======================================= - ¦ Askhanar ¦ - =======================================*/

public Ham_PlayerKilledPost(  id  )
{
	
	if(  cs_get_user_defuse(  id  )  )
		cs_set_user_defuse(  id,  0  );
		
	gUserHasSuperKnife[  id  ]  =  false;
	gUserHasLaser[  id  ]  =  false;
	
	if(  gPlayerUsedRespawn[  id  ]  >  0  )  return HAM_IGNORED;
	
	
	set_task( 0.5, "TaskHamPlayerKilledPost",  id );
	
	return HAM_IGNORED;
	
}

public TaskHamPlayerKilledPost(  id  )
{
	
	if(  !IsUserOK(  id  )  )  return 1;
	
	new CsTeams:Team  =  cs_get_user_team(  id  );
	if(  Team  ==  CS_TEAM_FURIEN  ||  Team  ==  CS_TEAM_ANTIFURIEN  )
	{
		if(  gRespawnEnabled[  Team  ]  )
		{
			
			if(  gRespawnLevel[  id  ][  Team  ]  >  0  )
			{
				new Chance  =  random_num(  1,  100  );
				new Percent  = gRespawnMaxAmount[  Team  ]  *  gRespawnLevel[  id  ][  Team  ]  /  gRespawnMaxLevels[  Team  ];
				
				if(  Chance  <=  Percent  )
				{
					if( gRoundEnded )
					{
						ColorChat(  id,  RED,  "^x04%s^x01 Runda s-a terminat, nu vei primi respawn!",  MESSAGE_TAG );
						return 1;
					}
					
					if(  !UserHasTeamMatesAlive(  id,  Team  )  )
					{
						ColorChat(  id,  RED,  "^x04%s  Nu poti primi respawn fara 1 coechipier in viata!",  MESSAGE_TAG  );
						return 1;
					}
					
					gPlayerUsedRespawn[  id  ]  =  1;
					set_task(  0.5,  "TaskRespawn",  id  );
					ColorChat(  id,  RED,  "^x04%s^x01 Ai primit respawn! (^x03%i^x01%% sansa)",  MESSAGE_TAG,  Percent  );
				}
				
				else
				{
					ColorChat(  id,  RED,  "^x04%s^x01 Nu ai avut destul noroc sa primesti respawn!",  MESSAGE_TAG,  Percent  );
				}
			}
		}
	}
	
	return 0;
	
}


public TaskRespawn(  id  )
{
	if(  !IsUserOK(  id  )  )  return 1;
	
	ExecuteHamB(  Ham_CS_RoundRespawn,  id  );
	
	PlaySound(  id,  SndRespawn  );
	
	return 0;
}


public Ham_PlayerTakeDamage(  id,  iInflictor,  iAttacker,  Float:flDamage,  bitsDamageType  )
{
	
	if( !iAttacker || id == iAttacker  ||  bitsDamageType & DMG_GRENADE ) return HAM_IGNORED;
	
	if(  is_user_alive(  id  )  )
	{
		if(  IsPlayer( iAttacker ) )
		{
			
			new  Float:Multiply  =  1.0;
			
			new CsTeams:Team  =  cs_get_user_team(  iAttacker  );
			if( Team  ==  CS_TEAM_FURIEN  ||  Team  ==  CS_TEAM_ANTIFURIEN  )
			{
				
				if(  gDamageMultiplierEnabled[  Team  ]  )
				{
					if(  gDamageMultiplierLevel[  iAttacker  ][  Team  ]  >  0  )
					{
						
						switch(  Team  )
						{
							case CS_TEAM_FURIEN:
							{
								Multiply  +=  gFurienMaxDamageMultiplier  * gDamageMultiplierLevel[  iAttacker  ][  Team  ] /  gDamageMultiplierMaxLevels[  Team  ];
							}
							case CS_TEAM_ANTIFURIEN:
							{
								Multiply  +=  gAntiFurienMaxDamageMultiplier  *  gDamageMultiplierLevel[  iAttacker  ][  Team  ] /  gDamageMultiplierMaxLevels[  Team  ];
							}
						}
						//ColorChat(  iAttacker,  RED, " DAMAGE %.1f  Multiply %f ", flDamage,  (  1.0  +  Multiply *  gDamageMultiplierLevel[  id  ][  Team  ]  )  );
					}
				}
				
				
			}
			
			new Float:SKDamage  =  0.0;
			
			if(  get_user_weapon(  iAttacker )  ==  CSW_KNIFE  &&  gUserHasSuperKnife[  iAttacker  ])
				SKDamage  =  1.0;
			
			SetHamParamFloat( 4, flDamage  *  ( Multiply  + SKDamage  )  );
		}
	}
	
	return HAM_IGNORED;
}

public Ham_ResetMaxSpeedPost(  id  )
{

	if(  is_user_alive(  id  )  /*&&  get_user_maxspeed(  id  )  !=  1.0*/  )
	{
		
		new CsTeams:Team  =  cs_get_user_team(  id  );
		if( Team  ==  CS_TEAM_FURIEN  ||  Team  ==  CS_TEAM_ANTIFURIEN  )
		{
			
			if(  gSpeedEnabled[  Team  ]  )
			{
	
				new Float:flMaxSpeed;
				
				if(  Team  ==  CS_TEAM_FURIEN  )
				{
					flMaxSpeed  =  gFurienSpeedLevels[  gSpeedLevel[  id  ][  Team  ]  ];
				}
				
				else if(  Team  ==  CS_TEAM_ANTIFURIEN  )
				{
					flMaxSpeed  =  gAntiFurienSpeedLevels[  gSpeedLevel[  id  ][  Team  ]  ];
				}
				
				engfunc(  EngFunc_SetClientMaxspeed,  id,  flMaxSpeed  );
				set_pev(  id,  pev_maxspeed,  flMaxSpeed  );
				
			}
		}
		
		/*	SlowHack o_O
			client_cmd(  id,  "cl_forwardspeed %0.1f;cl_sidespeed %0.1f;cl_backspeed %0.1f", flMaxSpeed, flMaxSpeed, flMaxSpeed );
		*/
	}
}

public Ham_PrimaryAttackC4(  iEnt  )
{ 
	
	if( gBombCanBePlanted  ==  false  )
	{
		if(  get_pcvar_num( gCvarNoBombPlantTime )  -  (  get_gametime(  ) - gfBombGameTime  )  >  0.0  )
		{
			
			new id  =  pev(  iEnt,  pev_owner );
			set_hudmessage(  0,  255,  0,  -1.0,  0.45,  0,  0.0 ,8.0,  0.0,  0.1,  4  );
			ShowSyncHudMsg(  id,  SyncHudMessage,  "Furienii au de asteptat %.1f secunde pana cand pot planta bomba!",   get_pcvar_num( gCvarNoBombPlantTime )  -  (  get_gametime(  ) - gfBombGameTime  )  );
			return HAM_SUPERCEDE;
		}
	}
	
	return HAM_IGNORED; 
}


public fwdGetGameDescription(    )
{
	
	new szFurienModUltimate[  32  ];
	get_pcvar_string(  gCvarGameType,  szFurienModUltimate,  sizeof  (  szFurienModUltimate  )  -1  );
	
	if(  !strlen(  szFurienModUltimate  )  )
	{
		formatex(  szFurienModUltimate,  sizeof  (  szFurienModUltimate  )  -1,  "FurienModUltimate v%s",  VERSION  );
		
		set_pcvar_string(  gCvarGameType,  szFurienModUltimate  );
	}
	
	forward_return(  FMV_STRING,  szFurienModUltimate  );
	return FMRES_SUPERCEDE;
}

public fwdClientUserInfoChanged(  id,  InfoKey  )
{
	
	if (  !IsUserOK(  id  )  ) 
		return FMRES_IGNORED;
	
	
	static szValue[  32  ];
	static szName[  32  ];
	
	get_user_name(  id,  szName,  sizeof  (  szName  )  -1  );
	engfunc(  EngFunc_InfoKeyValue, InfoKey,  "name",  szValue,  sizeof  (  szValue  )  - 1  );
	
	if(  equal(  szValue,  szName  )  )
		return FMRES_IGNORED;
	
	engfunc(  EngFunc_SetClientKeyValue,  id,  InfoKey,  "name",  szName  );
	ColorChat(  id,  RED,  "^x04%s^x03 NU iti poti schimba numele pe server !",  MESSAGE_TAG  );
	client_print(  id,  print_console, "%s NU iti poti schimba numele pe server !",  MESSAGE_TAG  );
	
	return FMRES_SUPERCEDE;
}
public Message_StatusIcon(  iMsgId,  MSG_DEST,  id  )
{
	if(  get_pcvar_num( gCvarBlockBuy )  !=  1  )
		return 0;
		
	static szIcon[  5  ];
	get_msg_arg_string(  2,  szIcon,  4  );
	
	if(  szIcon[  0  ]  ==  'b'  &&  szIcon[  2  ]  ==  'y'  &&  szIcon[  3  ]  ==  'z'  )
	{
		if(  get_msg_arg_int(  1  )  )
		{
			
			fm_cs_set_user_nobuy(  id  );
			return 1;
			
		}
	}
	
	return 0;
}

public Message_TextMsg(  iMsgId,  iMsgDest,  id  )
{
	
	if(  get_msg_arg_int(  1  )  ==  print_center  )
	{
		new szMessage[  128  ];
		get_msg_arg_string( 2,  szMessage,  charsmax(  szMessage  )  );
		
		if( equal(szMessage, "#Game_will_restart_in") )
		{
			new szArg1[ 4 ];
			get_msg_arg_string( 3, szArg1, charsmax( szArg1 ) );
			formatex( szMessage, charsmax(szMessage), "The game will restart in %s seconds !",  szArg1 );
			set_hudmessage(  0,  255,  0,  -1.0,  0.29,  0,  0.0,  3.0,  0.0,  1.0,  3  );
			ShowSyncHudMsg(  0,  SyncHudMessage,  szMessage  );
			return 1;
		}
		else
		{
			if( TrieGetString(  gMessagesReplacements,  szMessage,  szMessage,  sizeof  (   szMessage  )  -1 ) )
			{
				set_hudmessage(  0,  255,  0,  -1.0,  0.29,  0,  0.0,  3.0,  0.0,  1.0,  3  );
				ShowSyncHudMsg(  0,  SyncHudMessage,  szMessage  );
				return 1;
			}
		}
	}
	
	return 0;
} 

public SetFurienInvisibility(  iEnt  )
{
	
	entity_set_float(  iEnt,  EV_FL_nextthink,  get_gametime(    )  +  0.1  );

	new id, Float:fVecVelocity[  3  ],  iSpeed;
	new iPlayers[ 32 ];
	new iPlayersNum;
	
	get_players(  iPlayers,  iPlayersNum,  "aceh",  "TERRORIST"  );		
	for(  new i = 0 ; i < iPlayersNum ; i++  )
	{
		if(  is_user_alive(  iPlayers[  i  ]  )  )
		{ 

			id  =  iPlayers[  i  ];
			if( IsUserVip(  id  )  )
			{
				if(  get_user_weapon(  id  )  !=  CSW_C4 )
				{
					entity_get_vector(  id,  EV_VEC_velocity,  fVecVelocity  );
					iSpeed  =  floatround(  vector_length(  fVecVelocity  )  );
					
					if(  iSpeed  <  (  FURIEN_VISIBILITY_FACTOR  *  255  )  )
					{
						set_user_rendering(  id,  kRenderFxNone,  0,  0,  0,  kRenderTransAlpha,  iSpeed  /  FURIEN_VISIBILITY_FACTOR  );
					}
					else
					{
						set_user_rendering(  id,  kRenderFxNone,  0,  0,  0,  kRenderNormal,  0 );
					}
				}
				else
				{
					set_user_rendering(  id,  kRenderFxNone,  0,  0,  0,  kRenderNormal,  0  );
				}
			}
			else
			{
				if(  get_user_weapon(  id  )  ==  CSW_KNIFE )
				{
					entity_get_vector(  id,  EV_VEC_velocity,  fVecVelocity  );
					iSpeed  =  floatround(  vector_length(  fVecVelocity  )  );
					
					if(  iSpeed  <  (  FURIEN_VISIBILITY_FACTOR  *  255  )  )
					{
						set_user_rendering(  id,  kRenderFxNone,  0,  0,  0,  kRenderTransAlpha,  iSpeed  /  FURIEN_VISIBILITY_FACTOR  );
					}
					else
					{
						set_user_rendering(  id,  kRenderFxNone,  0,  0,  0,  kRenderNormal,  0 );
					}
				}
				else
				{
					set_user_rendering(  id,  kRenderFxNone,  0,  0,  0,  kRenderNormal,  0  );
				}
			}
		}
	}
}

public CheckForMultipleThings(  iEnt  )
{
	
	entity_set_float(  iEnt,  EV_FL_nextthink,  get_gametime(    )  +  1.0  );

	new id, iUserHealth, iUserArmor, iUserMaxHealth, iUserMaxArmor;
	new iPlayers[ 32 ];
	new iPlayersNum;
	
	get_players(  iPlayers,  iPlayersNum,  "ach"  );		
	for(  new i = 0 ; i < iPlayersNum ; i++  )
	{
		id  =  iPlayers[  i  ];
		if(  is_user_alive(  id  )  )
		{ 
			new CsTeams:Team  =  cs_get_user_team(  id  );
			if( Team  ==  CS_TEAM_FURIEN  ||  Team  ==  CS_TEAM_ANTIFURIEN  )
			{
				
				iUserHealth  =  get_user_health(  id  );
				if( iUserHealth  <=  LOW_HP_TO_HEAR_HEART  )
				{
					ShakeScreen( id, 0.8 );
					FadeScreen( id , 0.6, 230, 0, 0, 50 );
					emit_sound( id, CHAN_STATIC, LowHealthSound, 0.2, ATTN_IDLE, 0, PITCH_NORM  );
				}
				
				if(  gHealthRegenerationEnabled[  Team  ]  )
				{
					if(  gHealthRegenerationLevel[  id  ][  Team  ]  >  0 )
					{
						
						
						iUserMaxHealth  =  100 + (  ( gHealthMaxAmount[  Team  ] *   gHealthLevel[  id  ][  Team  ]  )  /  gHealthMaxLevels[  Team  ]  ) ; 
					
						if(  iUserHealth  <  iUserMaxHealth )
						{
							new iHealth  =  clamp(  iUserHealth + gHealthRegenerationLevel[  id  ][  Team  ],  iUserHealth,  iUserMaxHealth  );
							set_user_health(  id,  iHealth  );
						}
					}
				}
				
				if(  gArmorChargerEnabled[  Team  ]  )
				{
					if(  gArmorChargerLevel[  id  ][  Team  ]  >  0 )
					{
						
						iUserArmor  =  get_user_armor(  id  );
						iUserMaxArmor  = (  ( gArmorMaxAmount[  Team  ] *  gArmorLevel[  id  ][  Team  ]  )  /  gArmorMaxLevels[  Team  ]  ) ; 
					
						if(  iUserArmor  <  iUserMaxArmor )
						{
							new iArmor  =  clamp(  iUserArmor + gArmorChargerLevel[  id  ][  Team  ],  iUserArmor,  iUserMaxArmor  );
							set_user_armor(  id,  iArmor  );
						}
					}
				}
				
			}
		}
	}
	

	if( gBombCanBePlanted  ==  false  )
	{
		if(  (  get_gametime(  )  -  gfBombGameTime  )  >  float( get_pcvar_num( gCvarNoBombPlantTime  )  )  )
		{
			set_hudmessage( 255, 0, 0, -1.0, 0.45, 0, 0.0, 8.5, 0.0, 5.0, 4 );
			ShowSyncHudMsg( 0, SyncHudMessage, "Furienii pot planta bomba !" );
			
			new Lights[  32  ];
			get_pcvar_string(  gCvarBombLights,  Lights, sizeof  (  Lights  )  -1  );
			
			if(  strlen(  Lights  )  >  1 )
			{
				set_lights( "d" );
			}
			else
			{
				set_lights(  Lights  );
			}
			
			gBombCanBePlanted  =  true;
			
			if(  get_pcvar_num(  gCvarEnableFog  )  )
				MakeFogToPlayer(  0  );
				
		}
	}
	
}

public MakeFogToPlayer(  id  )
{
	
	if(  get_pcvar_num(  gCvarEnableFog  )  != 1 )  return 1;
	
	new Colors[ 32 ],  iDensity;
	new szColor[ 3 ][ 32 ];
	
	if(  gBombCanBePlanted  )
	{
		
		get_pcvar_string(  gCvarBombFogColor,  Colors,  sizeof ( Colors ) -1  );
		
		parse(  Colors,  szColor[ 0 ], sizeof ( szColor[ ] ) -1,  szColor[ 1 ], sizeof ( szColor[ ] ) -1,
			szColor[ 2 ], sizeof ( szColor[ ] ) -1 );
		
		new iRed  =  clamp(  str_to_num(  szColor[ 0 ] ), 0, 255 );
		new iGreen  =  clamp(  str_to_num(  szColor[ 1 ] ), 0, 255 );
		new iBlue =  clamp(  str_to_num(  szColor[ 2 ] ), 0, 255 );
		
		iDensity  =  clamp(  get_pcvar_num(  gCvarBombFogDensity  ), 1, 9 );
		
		new iSD = 4 * iDensity;
		new iED = iSD + 1;
		new iD1 = iSD + 2;
		new iD2 = iSD + 3;
		
		MakeFog(  id,  iRed, iGreen, iBlue, ConstFogDensity[ iSD ],
			ConstFogDensity[ iED ], ConstFogDensity[ iD1 ], ConstFogDensity[ iD2 ] );
	}
	else
	{
		
		get_pcvar_string(  gCvarFogColor,  Colors,  sizeof ( Colors ) -1  );
		
		parse(  Colors,  szColor[ 0 ], sizeof ( szColor[ ] ) -1,  szColor[ 1 ], sizeof ( szColor[ ] ) -1,
			szColor[ 2 ], sizeof ( szColor[ ] ) -1 );
		
		new iRed  =  clamp(  str_to_num(  szColor[ 0 ] ), 0, 255 );
		new iGreen  =  clamp(  str_to_num(  szColor[ 1 ] ), 0, 255 );
		new iBlue =  clamp(  str_to_num(  szColor[ 2 ] ), 0, 255 );
		
		iDensity  =  clamp(  get_pcvar_num(  gCvarFogDensity  ), 1, 9 );
		
		new iSD = 4 * iDensity;
		new iED = iSD + 1;
		new iD1 = iSD + 2;
		new iD2 = iSD + 3;
		
		MakeFog(  id,  iRed, iGreen, iBlue, ConstFogDensity[ iSD ],
			ConstFogDensity[ iED ], ConstFogDensity[ iD1 ], ConstFogDensity[ iD2 ] );
	}
	
	gFogCreated  =  true;
	
	return 0;
}

public client_PreThink( id )
{
	if( !is_user_alive( id ) )
		return;
	
	static CsTeams:Team;
	Team = cs_get_user_team( id );
	
	if( Team == CS_TEAM_ANTIFURIEN )
	{
		if( gUserHasLaser[ id ] )
		{
			static iTarget, iBody, iRed, iGreen, iBlue, iWeapon;
			
			get_user_aiming( id, iTarget, iBody );
		
			iWeapon = get_user_weapon( id );
		
			if( IsPrimaryWeapon( iWeapon ) || IsSecondaryWeapon( iWeapon ) )
			{
				if( is_user_alive( iTarget ) && cs_get_user_team( iTarget ) == CS_TEAM_FURIEN )
				{
					iRed = 255;
					iGreen = 0;
					iBlue = 0;
				}
				
				else
				{
					iRed = 0;
					iGreen = 0;
					iBlue = 255;
				}
				
				static iOrigin[ 3 ];
				get_user_origin( id, iOrigin, 3 );
				
				message_begin( MSG_BROADCAST, SVC_TEMPENTITY );
				write_byte( TE_BEAMENTPOINT );
				write_short( id | 0x1000 );
				write_coord( iOrigin[ 0 ] );
				write_coord( iOrigin[ 1 ] );
				write_coord( iOrigin[ 2 ] );
				write_short( gLaserSprite );
				write_byte( 1 );
				write_byte( 10 );
				write_byte( 1 );
				write_byte( 5 );
				write_byte( 0 );
				write_byte( iRed );
				write_byte( iGreen );
				write_byte( iBlue );
				write_byte( 150 );
				write_byte( 25 );
				message_end( );
			}
		}
	}
}

public client_command(  id  )
{
		
	new sArg[  13  ];
	if( read_argv(  0,  sArg,  12  )  >  11  )
	{
		return 0;
	}
	
	if(  get_pcvar_num( gCvarBlockDropCommand ) == 1 && get_user_team( id ) == 1 
		|| get_pcvar_num( gCvarBlockDropCommand ) == 2 && get_user_team( id ) == 2
		|| get_pcvar_num( gCvarBlockDropCommand ) == 3 )
	{
		if(  equali(  "drop",  sArg,  0  )  )
		{
			return 1;
		}
	}
	
	if(  get_pcvar_num(  gCvarBlockBuy  )  ==  1  )
	{
		for(  new i = 0 ;  i < sizeof  (  gWeaponsBuyCommands  ) ;  i++  )
		{
			if(  equali(  gWeaponsBuyCommands[  i  ],  sArg,  0  )  )
			{
				return 1;
			}
		}
	}
	
	if(  get_pcvar_num(  gCvarBlockRadio  )  ==  1  )
	{
		for(  new i = 0 ;  i < sizeof (  gRadioCommands  ) ;  i++  )
		{
			if(  equali(  gRadioCommands[  i  ],  sArg,  0  )  )
			{
				return 1;
			}
		}
	}
	
	return 0;
}

public ShowShopMenu(  id  )
{
	
	new MenuName[  128  ];

	formatex(  MenuName,  sizeof  (  MenuName  )  -  1, "\rFMU Shop^n\yBani: \w%i$",  cs_get_user_money(  id  )  );
		
	new  menu  =  menu_create(  MenuName, "ShopMenuHandler");
	new callback  =  menu_makecallback( "CallbackShop" );
	
	new iHP = get_pcvar_num(  gCvarHPCost );
	new iAP = get_pcvar_num(  gCvarAPCost );
	new iHE = get_pcvar_num(  gCvarHECost );
	new iSW = get_pcvar_num(  gCvarSWCost );
	new iDK = get_pcvar_num(  gCvarDKCost );
	new iXP =  get_pcvar_num(  gCvarXPCost );
	new iIR = get_pcvar_num(  gCvarIRCost );
	
	if( fmu_is_shopping_hour( ) )
	{
		iHP /= 2;
		iAP /= 2;
		iHE /= 2;
		iSW /= 2;
		iDK /= 2;
		iXP /= 2;
		iIR /= 2;
	}
	
	new HP[ 64 ], AP[ 64 ], HE[ 64 ], SW[ 64 ], DK[ 64 ], XP[ 64 ], IR[ 64 ];
	
	formatex(  HP,  sizeof ( HP ) -1, "\y25\w HP\r          [ \y%i$\r ]", iHP );
	formatex(  AP,  sizeof ( AP ) -1, "\y25\w AP\r          [ \y%i$\r ]", iAP );
	formatex(  HE,  sizeof ( HE ) -1, "\yHE\w grenade\r     [ \y%i$\r ]^n", iHE );
	formatex(  SW,  sizeof ( SW ) -1, "\wSilent Walk\r      [ \y%i$\r ]", iSW );
	formatex(  DK,  sizeof ( DK ) -1, "\wDefuse Kit\r       [ \y%i$\r ]^n", iDK );
	formatex(  XP,  sizeof ( XP ) -1, "\y%i\w Experience\r     [ \y%i$\r ]", get_pcvar_num( gCvarXPAmount ), iXP );
	formatex(  IR,  sizeof ( IR ) -1, "\wInstant Respawn\r     [ \y%i$\r ]", iIR );
	
	menu_additem(  menu,  HP,  "1",  _,  callback  );
	menu_additem(  menu,  AP,  "2",  _,  callback  );
	menu_additem(  menu,  HE,  "3",  _,  callback  );
	menu_additem(  menu,  SW,  "4",  _,  callback  );
	menu_additem(  menu,  DK,  "5",  _,  callback  );
	menu_additem(  menu,  XP,  "6",  _,  callback  );
	menu_additem(  menu,  IR,  "7",  _,  callback  );
	
	menu_setprop(  menu,  MPROP_EXITNAME, "\wIesire" );
	
	menu_display(  id, menu  );
	
	
}

public ShopMenuHandler(  id,  menu,  item)
{
	if(  item  ==  MENU_EXIT  )
	{
		menu_destroy(  menu  );
		return 1;
	}
	
	new iMoney  =  cs_get_user_money(  id  );
	new iHealth  =  get_user_health(  id  );
	new iArmor  =  get_user_armor(  id  );
	
	static _access, info[4], callback;
	menu_item_getinfo(  menu,  item,  _access,  info,  sizeof  (  info  )  -  1,  _,  _,  callback  );
	menu_destroy(  menu  );
	
	new iKey  =  str_to_num(  info  );
	switch(  iKey  )
	{
		case 1:
		{
			if(  !is_user_alive(  id  )  )
			{
				client_print(  id,  print_center,  "#Cstrike_TitlesTXT_Cannot_Buy_This"  );
				ColorChat(  id,  RED,  "^x04%s^x01 Trebuie sa fii in viata.",  MESSAGE_TAG  );
				ShowShopMenu(  id  );
				return 1;
			}
			
			new HPCost  =  get_pcvar_num(  gCvarHPCost  );
			if( fmu_is_shopping_hour( ) )
				HPCost /= 2;
				
			if(  iMoney  <  HPCost  )
			{
				client_print(  id,  print_center,  "#Cstrike_TitlesTXT_Not_Enough_Money"  );
				ShowShopMenu(  id  );
				return 1;
			}
			
			else if( iHealth  >=  250  )
			{
				client_print(  id,  print_center,  "#Cstrike_TitlesTXT_Cannot_Carry_Anymore"  );
				ShowShopMenu(  id  );
				return 1;
			}
			
			cs_set_user_money(  id,  iMoney  -  HPCost  );
			set_user_health(  id,  clamp(  iHealth  +  25,  0,  250  )  );
			ColorChat(  id,  RED,  "^x04%s^x01 Ai cumparat^x03 25 HP^x01 pentru^x03 %i$^x01.",  MESSAGE_TAG,  HPCost  );
			PlaySound(  id,  SndPickUpItem  );
			
		}
		
		case 2:
		{
			if(  !is_user_alive(  id  )  )
			{
				client_print(  id,  print_center,  "#Cstrike_TitlesTXT_Cannot_Buy_This"  );
				ColorChat(  id,  RED,  "^x04%s^x01 Trebuie sa fii in viata.",  MESSAGE_TAG  );
				ShowShopMenu(  id  );
				return 1;
			}
			
			new APCost  =  get_pcvar_num(  gCvarAPCost  );
			if( fmu_is_shopping_hour( ) )
				APCost /= 2;
				
			if(  iMoney  <  APCost  )
			{
				client_print(  id,  print_center,  "#Cstrike_TitlesTXT_Not_Enough_Money"  );
				ShowShopMenu(  id  );
				return 1;
			}
			
			else if( iArmor  >=  170  )
			{
				client_print(  id,  print_center,  "#Cstrike_TitlesTXT_Cannot_Carry_Anymore"  );
				ShowShopMenu(  id  );
				return 1;
			}
			
			cs_set_user_money(  id,  iMoney  -  APCost  );
			set_user_armor(  id,  clamp(  iArmor  +  25,  0,  170  )  );
			ColorChat(  id,  RED,  "^x04%s^x01 Ai cumparat^x03 25 AP^x01 pentru^x03 %i$^x01.",  MESSAGE_TAG,  APCost  );
			PlaySound(  id,  SndPickUpItem  );
		}

		
		case 3:
		{
			if(  !is_user_alive(  id  )  )
			{
				client_print(  id,  print_center,  "#Cstrike_TitlesTXT_Cannot_Buy_This"  );
				ColorChat(  id,  RED,  "^x04%s^x01 Trebuie sa fii in viata.",  MESSAGE_TAG  );
				ShowShopMenu(  id  );
				return 1;
			}
			
			new HECost  =  get_pcvar_num(  gCvarHECost  );
			if( fmu_is_shopping_hour( ) )
				HECost /= 2;
				
			if(  iMoney  <  HECost  )
			{
				client_print(  id,  print_center,  "#Cstrike_TitlesTXT_Not_Enough_Money"  );
				ShowShopMenu(  id  );
				return 1;
			}
			
			else if( user_has_weapon(  id,  CSW_HEGRENADE  )  )
			{
				client_print(  id,  print_center,  "#Cstrike_TitlesTXT_Already_Have_One"  );
				ShowShopMenu(  id  );
				return 1;
			}
			
			cs_set_user_money(  id,  iMoney  -  HECost  );
			give_item(  id,  "weapon_hegrenade"  );
			ColorChat(  id,  RED,  "^x04%s^x01 Ai cumparat o^x03 grenada^x01 pentru^x03 2500$^x01.",  MESSAGE_TAG,  HECost  );
			PlaySound(  id,  SndPickUpItem  );
		}
		case 4:
		{
			if(  !is_user_alive(  id  )  )
			{
				client_print(  id,  print_center,  "#Cstrike_TitlesTXT_Cannot_Buy_This"  );
				ColorChat(  id,  RED,  "^x04%s^x01 Trebuie sa fii in viata.",  MESSAGE_TAG  );
				ShowShopMenu(  id  );
				return 1;
			}
			
			new SWCost  =  get_pcvar_num(  gCvarSWCost  );
			if( fmu_is_shopping_hour( ) )
				SWCost /= 2;
				
			if(  iMoney  <  SWCost  )
			{
				client_print(  id,  print_center,  "#Cstrike_TitlesTXT_Not_Enough_Money"  );
				ShowShopMenu(  id  );
				return 1;
			}
			
			else if( get_user_footsteps(  id  )  >  0  )
			{
				client_print(  id,  print_center,  "#Cstrike_TitlesTXT_Already_Have_One"  );
				ShowShopMenu(  id  );
				return 1;
			}
			
			cs_set_user_money(  id,  iMoney  -  SWCost  );
			set_user_footsteps(  id,  1  );
			ColorChat(  id,  RED,  "^x04%s^x01 Ai cumparat^x03 Silent Walk^x01 pentru^x03 %i$^x01.",  MESSAGE_TAG,  SWCost  );
			PlaySound(  id,  SndPickUpItem  );
		}
		case 5:
		{
			if(  !is_user_alive(  id  )  )
			{
				client_print(  id,  print_center,  "#Cstrike_TitlesTXT_Cannot_Buy_This"  );
				ColorChat(  id,  RED,  "^x04%s^x01 Trebuie sa fii in viata.",  MESSAGE_TAG  );
				ShowShopMenu(  id  );
				return 1;
			}
			
			new DKCost  =  get_pcvar_num(  gCvarDKCost  );
			if( fmu_is_shopping_hour( ) )
				DKCost /= 2;
				
			if(  iMoney  <  DKCost  )
			{
				client_print(  id,  print_center,  "#Cstrike_TitlesTXT_Not_Enough_Money"  );
				ShowShopMenu(  id  );
				return 1;
			}
			
			else if( cs_get_user_defuse(  id  )  )
			{
				client_print(  id,  print_center,  "#Cstrike_TitlesTXT_Already_Have_One"  );
				ShowShopMenu(  id  );
				return 1;
			}
			
			cs_set_user_money(  id,  iMoney  -  DKCost  );
			cs_set_user_defuse(  id,  1,  0,  145,  255  );
			ColorChat(  id,  RED,  "^x04%s^x01 Ai cumparat^x03 Defuse Kit^x01 pentru^x03 800$^x01.",  MESSAGE_TAG,  DKCost  );
			PlaySound(  id,  SndPickUpItem  );
		}
		case 6:
		{
			new XPAmount  =  get_pcvar_num(  gCvarXPAmount  );
			new XPCost  =  get_pcvar_num(  gCvarXPCost  );
			
			if( fmu_is_shopping_hour( ) )
				XPCost /= 2;
				
			if(  iMoney  <  XPCost  )
			{
				client_print(  id,  print_center,  "#Cstrike_TitlesTXT_Not_Enough_Money"  );
				ShowShopMenu(  id  );
				return 1;
			}
			
			cs_set_user_money(  id,  iMoney  -  XPCost  );
			gUserXp[  id  ]  +=  XPAmount;
			ColorChat(  id,  RED,  "^x04%s^x01 Ai cumparat^x03 %i XP^x01 pentru^x03 %i$^x01.",  MESSAGE_TAG,  XPAmount,  XPCost  );
			
			if( fmu_is_happy_hour( ) )
			{
				gUserXp[  id  ]  +=  XPAmount;
				ColorChat(  id,  RED,  "^x04%s^x01 Ai mai primit^x03 %i XP^x01 deoarece este^x03 Happy Hour^x01.",  MESSAGE_TAG,  XPAmount  );
			}
			if( IsUserVip( id ) )
			{
				ColorChat( id, RED, "^x04%s^x01 Pentru ca esti^x03 VIP^x01 ai mai primit^x03 %i XP^x01 .",  MESSAGE_TAG,  XPAmount  );
				gUserXp[  id  ]  +=  XPAmount;
			}
			PlaySound(  id,  SndTome  );
			
		}
		case 7:
		{
			new CsTeams:Team  =  cs_get_user_team(  id  );
			
			if(  Team  ==  CS_TEAM_ANTIFURIEN  ||  Team  ==  CS_TEAM_FURIEN  )
				//||  Team  ==  CS_TEAM_SPECTATOR  && ( get_user_flags( id  )  &&  read_flags( "cdefijm" )  )  )
			{
				if(  is_user_alive(  id  )  )
				{
					client_print(  id,  print_center,  "#Cstrike_TitlesTXT_Cannot_Buy_This"  );
					ColorChat(  id,  RED,  "^x04%s^x03 NU^x01 trebuie sa fii in viata.",  MESSAGE_TAG  );
					ShowShopMenu(  id  );
					return 1;
				}
				
				new IRCost  =  get_pcvar_num(  gCvarIRCost  );
				
				if( fmu_is_shopping_hour( ) )
					IRCost /= 2;
					
				if(  iMoney  <  IRCost  )
				{
					client_print(  id,  print_center,  "#Cstrike_TitlesTXT_Not_Enough_Money"  );
					ShowShopMenu(  id  );
					return 1;
				}
				
				else if(  !UserHasTeamMatesAlive(  id,  cs_get_user_team(  id  )  )  )
				{
					client_print(  id,  print_center,  "#Cstrike_TitlesTXT_Cannot_Buy_This"  );
					ColorChat(  id,  RED,  "^x04%s^x01 Trebuie sa ai minim un coechipier in viata!",  MESSAGE_TAG  );
					ShowShopMenu(  id  );
					return 1;
				}
				
				cs_set_user_money(  id,  iMoney  -  IRCost  );
				set_task(  0.5,  "TaskRespawn",  id  );
				ColorChat(  id,  RED,  "^x04%s^x01 Ai cumparat^x03 Instant Respawn^x01 pentru^x03 %i$^x01.",  MESSAGE_TAG,  IRCost  );
				PlaySound(  id,  SndPickUpItem  );
			}
			else
			{
				client_print(  id,  print_center, "Nu poti cumpara Respawn cand esti SPECTATOR!"  );
			}
		}
	}
	
	return 0;
	
}

public CallbackShop(  id,  menu,  item  )
{
	static  _access,  info[  4  ],  callback;
	menu_item_getinfo(  menu,  item,  _access,  info,  sizeof  (  info  )  -  1,  _,  _,  callback  );
	
	if(  info[  0  ]  ==  '4'  &&  cs_get_user_team(  id  )  !=  CS_TEAM_ANTIFURIEN  )  return ITEM_DISABLED;
	else if(  info[  0  ]  ==  '5'  &&  cs_get_user_team(  id  )  !=  CS_TEAM_ANTIFURIEN  )  return ITEM_DISABLED;
	else if(  info[  0  ]  ==  '7'  &&  cs_get_user_team(  id  )  ==  CS_TEAM_SPECTATOR  )  return ITEM_DISABLED;
	
	return ITEM_ENABLED;
}

public ShowXPShopMenu(  id  )
{
	
	new MenuName[  128  ];

	formatex(  MenuName,  sizeof  (  MenuName  )  -  1, "\rFMU XPShop^n\yXP: \w%i",  gUserXp[  id  ]  );
		
	new  menu  =  menu_create(  MenuName, "XPShopMenuHandler");
	new callback  =  menu_makecallback( "CallbackXPShop" );
	
	new SK[ 64 ], LR[ 64 ], CM[ 64 ];/*, SW[ 64 ], DK[ 64 ], XP[ 64 ], IR[ 64 ];*/
	
	formatex(  SK,  sizeof ( SK ) -1, "\w Super Knife\r          [ \y%i XP\r ]", get_pcvar_num(  gCvarSKCost )  );
	formatex(  LR,  sizeof ( LR ) -1, "\w X-Ray Scanner\r          [ \y%i XP\r ]", get_pcvar_num(  gCvarLRCost )  );
	formatex(  CM,  sizeof ( CM ) -1, "\w Chameleon\r     [ \y%i XP\r ]^n", get_pcvar_num(  gCvarCMCost )  );
	/*formatex(  SW,  sizeof ( SW ) -1, "\wSilent Walk\r      [ \y%i$\r ]", get_pcvar_num(  gCvarSWCost )  );
	formatex(  DK,  sizeof ( DK ) -1, "\wDefuse Kit\r       [ \y%i$\r ]^n", get_pcvar_num(  gCvarDKCost )  );
	formatex(  XP,  sizeof ( XP ) -1, "\y%i\w Experience\r     [ \y%i$\r ]", get_pcvar_num( gCvarXPAmount ), get_pcvar_num(  gCvarXPCost )  );
	formatex(  IR,  sizeof ( IR ) -1, "\wInstant Respawn\r     [ \y%i$\r ]", get_pcvar_num(  gCvarIRCost )  );
	*/
	menu_additem(  menu,  SK,  "1",  _,  callback  );
	menu_additem(  menu,  LR,  "2",  _,  callback  );
	menu_additem(  menu,  CM,  "3",  _,  callback  );
	/*menu_additem(  menu,  SW,  "4",  _,  callback  );
	menu_additem(  menu,  DK,  "5",  _,  callback  );
	menu_additem(  menu,  XP,  "6",  _,  callback  );
	menu_additem(  menu,  IR,  "7",  _,  callback  );*/
	
	menu_setprop(  menu,  MPROP_EXITNAME, "\wIesire" );
	
	menu_display(  id, menu  );
	
	
}

public XPShopMenuHandler(  id,  menu,  item)
{
	if(  item  ==  MENU_EXIT  )
	{
		menu_destroy(  menu  );
		return 1;
	}
	
	static _access, info[4], callback;
	menu_item_getinfo(  menu,  item,  _access,  info,  sizeof  (  info  )  -  1,  _,  _,  callback  );
	menu_destroy(  menu  );
	
	new iKey  =  str_to_num(  info  );
	switch(  iKey  )
	{
		case 1:
		{
			if(  !is_user_alive(  id  )  )
			{
				client_print(  id,  print_center,  "#Cstrike_TitlesTXT_Cannot_Buy_This"  );
				ColorChat(  id,  RED,  "^x04%s^x01 Trebuie sa fii in viata.",  MESSAGE_TAG  );
				ShowXPShopMenu(  id  );
				return 1;
			}
			
			new SKCost  =  get_pcvar_num(  gCvarSKCost  );
			
			if(  gUserXp[  id  ]  <  SKCost  )
			{
				client_print(  id,  print_center,  "You do not have enough XP!"  );
				ShowXPShopMenu(  id  );
				return 1;
			}
			
			else if( gUserHasSuperKnife[  id  ]  )
			{
				client_print(  id,  print_center,  "#Cstrike_TitlesTXT_Already_Have_One"  );
				ShowXPShopMenu(  id  );
				return 1;
			}
			
			gUserHasSuperKnife[  id  ]  =  true;
			gUserXp[  id  ]  -=  SKCost;
			Save(  id  );
			
			ColorChat(  id,  RED,  "^x04%s^x01 Ai cumparat^x03 Super Knife^x01 pentru^x03 %i XP^x01.",  MESSAGE_TAG,  SKCost  );
			PlaySound(  id,  SndPickUpItem  );
		}
		
		case 2:
		{
			if(  !is_user_alive(  id  )  )
			{
				client_print(  id,  print_center,  "#Cstrike_TitlesTXT_Cannot_Buy_This"  );
				ColorChat(  id,  RED,  "^x04%s^x01 Trebuie sa fii in viata.",  MESSAGE_TAG  );
				ShowXPShopMenu(  id  );
				return 1;
			}
			
			new LRCost  =  get_pcvar_num(  gCvarLRCost  );
			
			if(  gUserXp[  id  ]  <  LRCost  )
			{
				client_print(  id,  print_center,  "You do not have enough XP!"  );
				ShowXPShopMenu(  id  );
				return 1;
			}
			
			else if( gUserHasLaser[  id  ]  )
			{
				client_print(  id,  print_center,  "#Cstrike_TitlesTXT_Already_Have_One"  );
				ShowXPShopMenu(  id  );
				return 1;
			}
			
			gUserHasLaser[  id  ]  =  true;
			gUserXp[  id  ]  -=  LRCost;
			Save(  id  );
			
			ColorChat(  id,  RED,  "^x04%s^x01 Ai cumparat^x03 Laser^x01 pentru^x03 %i XP^x01.",  MESSAGE_TAG,  LRCost  );
			PlaySound(  id,  SndPickUpItem  );
		}
		
		
		case 3:
		{
			if(  !is_user_alive(  id  )  )
			{
				client_print(  id,  print_center,  "#Cstrike_TitlesTXT_Cannot_Buy_This"  );
				ColorChat(  id,  RED,  "^x04%s^x01 Trebuie sa fii in viata.",  MESSAGE_TAG  );
				ShowXPShopMenu(  id  );
				return 1;
			}
			
			new CMCost  =  get_pcvar_num(  gCvarCMCost  );
			
			if(  gUserXp[  id  ]  <  CMCost  )
			{
				client_print(  id,  print_center,  "You do not have enough XP!"  );
				ShowXPShopMenu(  id  );
				return 1;
			}
			
			else if( gUserHasChameleon[  id  ]  )
			{
				client_print(  id,  print_center,  "#Cstrike_TitlesTXT_Already_Have_One"  );
				ShowXPShopMenu(  id  );
				return 1;
			}
			
			gUserHasChameleon[  id  ]  =  true;
			cs_set_user_model( id,  cs_get_user_team(  id  )  ==  CS_TEAM_FURIEN ?  AntiFurienModel  :  FurienModel  );
			
			gUserXp[  id  ]  -=  CMCost;
			Save(  id  );
			
			ColorChat(  id,  RED,  "^x04%s^x01 Ai cumparat^x03 Chameleon^x01 pentru^x03 %i XP^x01.",  MESSAGE_TAG,  CMCost  );
			PlaySound(  id,  SndPickUpItem  );
		}
		/*case 4:
		{
			if(  !is_user_alive(  id  )  )
			{
				client_print(  id,  print_center,  "#Cstrike_TitlesTXT_Cannot_Buy_This"  );
				ColorChat(  id,  RED,  "^x04%s^x01 Trebuie sa fii in viata.",  MESSAGE_TAG  );
				ShowShopMenu(  id  );
				return 1;
			}
			
			new SWCost  =  get_pcvar_num(  gCvarSWCost  );
			
			if(  iMoney  <  SWCost  )
			{
				client_print(  id,  print_center,  "#Cstrike_TitlesTXT_Not_Enough_Money"  );
				ShowShopMenu(  id  );
				return 1;
			}
			
			else if( get_user_footsteps(  id  )  >  0  )
			{
				client_print(  id,  print_center,  "#Cstrike_TitlesTXT_Already_Have_One"  );
				ShowShopMenu(  id  );
				return 1;
			}
			
			cs_set_user_money(  id,  iMoney  -  SWCost  );
			set_user_footsteps(  id,  1  );
			ColorChat(  id,  RED,  "^x04%s^x01 Ai cumparat^x03 Silent Walk^x01 pentru^x03 %i$^x01.",  MESSAGE_TAG,  SWCost  );
			
		}
		case 5:
		{
			if(  !is_user_alive(  id  )  )
			{
				client_print(  id,  print_center,  "#Cstrike_TitlesTXT_Cannot_Buy_This"  );
				ColorChat(  id,  RED,  "^x04%s^x01 Trebuie sa fii in viata.",  MESSAGE_TAG  );
				ShowShopMenu(  id  );
				return 1;
			}
			
			new DKCost  =  get_pcvar_num(  gCvarDKCost  );
			
			if(  iMoney  <  DKCost  )
			{
				client_print(  id,  print_center,  "#Cstrike_TitlesTXT_Not_Enough_Money"  );
				ShowShopMenu(  id  );
				return 1;
			}
			
			else if( cs_get_user_defuse(  id  )  )
			{
				client_print(  id,  print_center,  "#Cstrike_TitlesTXT_Already_Have_One"  );
				ShowShopMenu(  id  );
				return 1;
			}
			
			cs_set_user_money(  id,  iMoney  -  DKCost  );
			cs_set_user_defuse(  id,  1,  0,  145,  255  );
			ColorChat(  id,  RED,  "^x04%s^x01 Ai cumparat^x03 Defuse Kit^x01 pentru^x03 800$^x01.",  MESSAGE_TAG,  DKCost  );
			
		}
		case 6:
		{
			new XPAmount  =  get_pcvar_num(  gCvarXPAmount  );
			new XPCost  =  get_pcvar_num(  gCvarXPCost  );
			
			if(  iMoney  <  XPCost  )
			{
				client_print(  id,  print_center,  "#Cstrike_TitlesTXT_Not_Enough_Money"  );
				ShowShopMenu(  id  );
				return 1;
			}
			
			cs_set_user_money(  id,  iMoney  -  XPCost  );
			gUserXp[  id  ]  +=  XPAmount;
			ColorChat(  id,  RED,  "^x04%s^x01 Ai cumparat^x03 %i XP^x01 pentru^x03 %i$^x01.",  MESSAGE_TAG,  XPAmount,  XPCost  );
			
		}
		case 7:
		{
			new CsTeams:Team  =  cs_get_user_team(  id  );
			
			if(  Team  ==  CS_TEAM_ANTIFURIEN  ||  Team  ==  CS_TEAM_FURIEN  )
			{
				if(  is_user_alive(  id  )  )
				{
					client_print(  id,  print_center,  "#Cstrike_TitlesTXT_Cannot_Buy_This"  );
					ColorChat(  id,  RED,  "^x04%s^x01 NU trebuie sa fii in viata.",  MESSAGE_TAG  );
					ShowShopMenu(  id  );
					return 1;
				}
				
				new IRCost  =  get_pcvar_num(  gCvarIRCost  );
				
				if(  iMoney  <  IRCost  )
				{
					client_print(  id,  print_center,  "#Cstrike_TitlesTXT_Not_Enough_Money"  );
					ShowShopMenu(  id  );
					return 1;
				}
				
				else if(  !UserHasTeamMatesAlive(  id,  cs_get_user_team(  id  )  )  )
				{
					client_print(  id,  print_center,  "#Cstrike_TitlesTXT_Cannot_Buy_This"  );
					ColorChat(  id,  RED,  "^x04%s^x01 Trebuie sa ai minim un coechipier in viata!",  MESSAGE_TAG  );
					ShowShopMenu(  id  );
					return 1;
				}
				
				cs_set_user_money(  id,  iMoney  -  IRCost  );
				set_task(  0.5,  "TaskRespawn",  id  );
				ColorChat(  id,  RED,  "^x04%s^x01 Ai cumparat^x03 Instant Respawn^x01 pentru^x03 %i$^x01.",  MESSAGE_TAG,  IRCost  );
				
			}
		}
		*/
	}
	
	return 0;
	
}

public CallbackXPShop(  id,  menu,  item  )
{
	static  _access,  info[  4  ],  callback;
	menu_item_getinfo(  menu,  item,  _access,  info,  sizeof  (  info  )  -  1,  _,  _,  callback  );
	
	if(  info[  0  ]  ==  '1'  &&  cs_get_user_team(  id  )  !=  CS_TEAM_FURIEN  )  return ITEM_DISABLED;
	else if(  info[  0  ]  ==  '2'  &&  cs_get_user_team(  id  )  !=  CS_TEAM_ANTIFURIEN  )  return ITEM_DISABLED;
	
	return ITEM_ENABLED;
}

public ShowHelpMenu(  id  )
{
	static MenuName[  128  ];
	formatex(  MenuName,  sizeof  (  MenuName  )  -  1, "\r%s^n\y  Meniu Ajutor",  PLUGIN  );
	new  menu  =  menu_create(  MenuName, "HelpMenuHandler");
	
	menu_additem(  menu,  "\yGeneral^n", "*"  );
	if(  gAnyHealthEnabled  )
	{
		menu_additem(  menu, "Viata",  "1"  );
	}
	if(  gAnyArmorEnabled  )
	{
		menu_additem(  menu, "Armura",  "2"  );
	}
	if(  gAnySpeedEnabled  )
	{
		menu_additem(  menu, "Viteza",  "3"  );
	}
	if(  gAnyGravityEnabled  )
	{
		menu_additem(  menu, "Gravitate",  "4"  );
	}
	if(  gAnyDamageMultiplierEnabled  )
	{
		menu_additem(  menu, "Multiplicare Damage",  "5"  );
	}
	if(  gAnyRespawnEnabled  )
	{
		menu_additem(  menu, "Respawn",  "6"  );
	}
	if(  gAnyHealthRegenerationEnabled  )
	{
		menu_additem(  menu, "Regenerare Viata",  "7"  );
	}
	if(  gAnyArmorChargerEnabled  )
	{
		menu_additem(  menu, "Reincarcare Armura",  "8"  );
	}
	
	menu_setprop(  menu,  MPROP_EXITNAME, "\wIesire" );
	
	menu_display(  id, menu  );
	
}

public HelpMenuHandler(  id,  menu,  item)
{
	if(  item  ==  MENU_EXIT  )
	{
		menu_destroy(  menu  );
		return;
	}
	
	static _access, info[4], callback;
	menu_item_getinfo(  menu,  item,  _access,  info,  sizeof  (  info  )  -  1,  _,  _,  callback  );
	menu_destroy(  menu  );
	
	switch(  info[  0  ]  )
	{
		case '*':
		{
			PrintGeneralHelp(  id  );
		}
		case '1':
		{
			PrintHealthHelp(  id  );
		}
		case '2':
		{
			PrintArmorHelp(  id  );
		}
		case '3':
		{
			PrintSpeedHelp(  id  );
		}
		case '4':
		{
			PrintGravityHelp(  id  );
		}
		case '5':
		{
			PrintDamageMultiplierHelp(  id  );
		}
		case '6':
		{
			PrintRespawnHelp(  id  );
		}
		case '7':
		{
			PrintHealthRegenerationHelp(  id  );
		}
		case '8':
		{
			PrintArmorChargerHelp(  id  );
		}
	}
	
	ShowHelpMenu(  id  );
}

public ShowMainMenu(  id  )
{
	static MenuName[  128  ];
	formatex(  MenuName,  sizeof  (  MenuName  )  -  1, "\rMeniu Upgrade-uri^n\yXP: \w%i",  gUserXp[  id  ]  );
	new  menu  =  menu_create(  MenuName, "MainMenuHandler");
	
	menu_additem(  menu,  "\yAjutor General^n", "*"  );
	if(  gAnyHealthEnabled  )
	{
		menu_additem(  menu, "Viata",  "1"  );
	}
	if(  gAnyArmorEnabled  )
	{
		menu_additem(  menu, "Armura",  "2"  );
	}
	if(  gAnySpeedEnabled  )
	{
		menu_additem(  menu, "Viteza",  "3"  );
	}
	if(  gAnyGravityEnabled  )
	{
		menu_additem(  menu, "Gravitate",  "4"  );
	}
	if(  gAnyDamageMultiplierEnabled  )
	{
		menu_additem(  menu, "Multiplicare Damage",  "5"  );
	}
	if(  gAnyRespawnEnabled  )
	{
		menu_additem(  menu, "Respawn",  "6"  );
	}
	if(  gAnyHealthRegenerationEnabled  )
	{
		menu_additem(  menu, "Regenerare Viata",  "7"  );
	}
	if(  gAnyArmorChargerEnabled  )
	{
		menu_additem(  menu, "Reincarcare Armura",  "8"  );
	}
	
	menu_setprop(  menu,  MPROP_EXITNAME, "\wIesire" );
	
	menu_display(  id, menu  );
	
}

public MainMenuHandler(  id,  menu,  item)
{
	if(  item  ==  MENU_EXIT  )
	{
		menu_destroy(  menu  );
		return;
	}
	
	static _access, info[4], callback;
	menu_item_getinfo(  menu,  item,  _access,  info,  sizeof  (  info  )  -  1,  _,  _,  callback  );
	menu_destroy(  menu  );
	
	switch(  info[  0  ]  )
	{
		case '*':
		{
			PrintGeneralHelp(  id  );
		}
		case '1':
		{
			ShowHealthMenu(  id  );
		}
		case '2':
		{
			ShowArmorMenu(  id  );
		}
		case '3':
		{
			ShowSpeedMenu(  id  );
		}
		case '4':
		{
			ShowGravityMenu(  id  );
		}
		case '5':
		{
			ShowDamageMultiplierMenu(  id  );
		}
		case '6':
		{
			ShowRespawnMenu(  id  );
		}
		case '7':
		{
			ShowHealthRegenerationMenu(  id  );
		}
		case '8':
		{
			ShowArmorChargerMenu(  id  );
		}
	}
	
}

public ShowHealthMenu(  id  )
{
	static MenuName[  128  ];
	formatex(  MenuName,  sizeof  (  MenuName  )  -  1, "\rMeniu Viata^n\yXP: \w%i",  gUserXp[  id  ]  );
	new  menu  =  menu_create(  MenuName, "HealthMenuHandler"  );
	
	new callback  =  menu_makecallback( "CallbackHealth" );
	
	menu_additem(  menu,  "\yAjutor Viata^n", "*",  _, callback  );
	
	static level,  xp,  amount,  item[  128  ],  info[4];
	
	for(  new CsTeams:i = CS_TEAM_FURIEN; i <= CS_TEAM_ANTIFURIEN; i++  )
	{
		if( gHealthEnabled[  i  ] )
		{
			level = clamp(  gHealthLevel[  id  ][  i  ] + 1, 0, gHealthMaxLevels[  i  ] );
			amount = gHealthMaxAmount[  i  ]  *  level  /  gHealthMaxLevels[  i  ];
			
			if( gHealthLevel[  id  ][  i  ]  <  gHealthMaxLevels[  i  ]  )
			{
				xp  =  gHealthFirstXp[  i  ]  *  (1 << (  level  -  1  )  );
				formatex(  item,  sizeof(  item  )  -  1,  "%s: \yLevel %i \r(\w%i HP\r) [\w%i XP\r]", gHealthNames[  i  ],  level,  amount,  xp  );
			}
			else
			{
				formatex(item, sizeof(item) - 1, "\w%s: \yLevel %i \r(\w%i HP\r) \r[\wLevel Maxim!\r]", gHealthNames[  i  ],   level,   amount  );
			}
			
			num_to_str(  _:i,  info,  sizeof  (  info  )  -  1 );
			
			menu_additem(  menu,  item,  info,  _,  callback  );
		}
	}
	
	menu_setprop(  menu,  MPROP_EXITNAME, "\yMeniu Principal" );
	
	menu_display(  id,  menu  );
}

public HealthMenuHandler(  id,  menu,  item  )
{
	if(  item  ==  MENU_EXIT  )
	{
		menu_destroy(  menu  );
		ShowMainMenu(  id  );
		return;
	}
	
	static  _access,  info[  4  ],  callback;
	menu_item_getinfo(  menu,  item,  _access,  info,  sizeof  (  info  )  -  1,  _,  _,  callback  );
	menu_destroy(  menu  );
	
	
	if(  info[ 0 ]  ==  '*'  )
	{
		PrintHealthHelp(  id  );
	}
	else
	{
	
	
		new CsTeams:upgrade  =  CsTeams:str_to_num(  info  );
		
		new  level  =  gHealthLevel[  id  ][  upgrade  ] + 1;
		new  xp  =  gHealthFirstXp[  upgrade  ] * (  1 << (  level  -  1  )  );
		new  amount  =  gHealthMaxAmount[  upgrade  ]  *  level  /  gHealthMaxLevels[  upgrade  ];
		
		gUserXp[  id  ]  -=  xp;
		gHealthLevel[  id  ][  upgrade  ]  =  level;
		
		Save(  id  );
		
		ColorChat(  id,  RED,  "^x04%s^x01 Upgrade gata:^x03 %s^x01 Level^x03 %i^x01 (^x03%i^x01 HP) pentru^x03 %i^x01 XP!", MESSAGE_TAG, gHealthNames[  upgrade  ],  level,  amount,  xp  );
		PlaySound(  id,  SndLevelUp  );
	}
	
	ShowHealthMenu(  id  );
}

public CallbackHealth(  id,  menu,  item  )
{
	static  _access,  info[  4  ],  callback;
	menu_item_getinfo(  menu,  item,  _access,  info,  sizeof  (  info  )  -  1,  _,  _,  callback  );
	
	if(  info[  0  ]  ==  '*'  )  return ITEM_ENABLED;
	
	new CsTeams:upgrade = CsTeams:str_to_num(  info  );
	if( gHealthLevel[  id  ][  upgrade  ]  ==  gHealthMaxLevels[  upgrade  ]  )
	{
		return ITEM_DISABLED;
	}
	
	new  xp  =  gHealthFirstXp[  upgrade  ]  *  ( 1 << gHealthLevel[  id  ][  upgrade  ]  );
	if( gUserXp[  id  ]  <  xp  )
	{
		return ITEM_DISABLED;
	}
	
	return ITEM_ENABLED;
}

public ShowArmorMenu(  id  )
{
	static MenuName[  128  ];
	formatex(  MenuName,  sizeof  (  MenuName  )  -  1, "\rMeniu Armura^n\yXP: \w%i",  gUserXp[  id  ]  );
	new  menu  =  menu_create(  MenuName, "ArmorMenuHandler"  );
	
	new callback  =  menu_makecallback( "CallbackArmor" );
	
	
	menu_additem(  menu,  "\yArmor Help^n", "*",  _, callback  );
	
	
	static level,  xp,  amount,  item[  128  ],  info[4];
	
	for(  new CsTeams:i = CS_TEAM_FURIEN; i <= CS_TEAM_ANTIFURIEN; i++  )
	{
		if( gArmorEnabled[  i  ] )
		{
			level = clamp( gArmorLevel[  id  ][  i  ] + 1, 0,  gArmorMaxLevels[  i  ]  );
			amount = gArmorMaxAmount[  i  ]  *  level  /  gArmorMaxLevels[  i  ];
			
			if( gArmorLevel[  id  ][  i  ]  <  gArmorMaxLevels[  i  ]  )
			{
				xp  =  gArmorFirstXp[  i  ]  *  (1 << (  level  -  1  )  );
				formatex(  item,  sizeof(  item  )  -  1,  "%s: \yLevel %i \r(\w%i AP\r) [\w%i XP\r]", gArmorNames[  i  ],  level,  amount,  xp  );
			}
			else
			{
				formatex(item, sizeof(item) - 1, "\w%s: \yLevel %i \r(\w%i AP\r) \r[\wLevel Maxim!\r]", gArmorNames[  i  ],   level,   amount  );
			}
			
			num_to_str(  _:i,  info,  sizeof  (  info  )  -  1 );
			
			menu_additem(  menu,  item,  info,  _,  callback  );
		}
	}
	
	menu_setprop(  menu,  MPROP_EXITNAME, "\yMeniu Principal" );
	
	menu_display(  id,  menu  );
}

public ArmorMenuHandler(  id,  menu,  item  )
{
	if(  item  ==  MENU_EXIT  )
	{
		menu_destroy(  menu  );
		ShowMainMenu(  id  );
		return;
	}
	
	static  _access,  info[  4  ],  callback;
	menu_item_getinfo(  menu,  item,  _access,  info,  sizeof  (  info  )  -  1,  _,  _,  callback  );
	menu_destroy(  menu  );
	
	
	if(  info[ 0 ]  ==  '*'  )
	{
		PrintArmorHelp( id );
	}
	else
	{
		new CsTeams:upgrade  =  CsTeams:str_to_num(  info  );
		
		new  level  =  gArmorLevel[  id  ][  upgrade  ] + 1;
		new  xp  =  gArmorFirstXp[  upgrade  ] * (  1 << (  level  -  1  )  );
		new  amount  =  gArmorMaxAmount[  upgrade  ]  *  level  /  gArmorMaxLevels[  upgrade  ];
		
		gUserXp[  id  ]  -=  xp;
		gArmorLevel[  id  ][  upgrade  ]  =  level;
		
		Save(  id  );
		
		ColorChat(  id,  RED,  "^x04%s^x01 Upgrade gata:^x03 %s^x01 Level^x03 %i^x01 (^x03%i^x01 AP) pentru^x03 %i^x01 XP!", MESSAGE_TAG, gArmorNames[  upgrade  ],  level,  amount,  xp  );
		PlaySound(  id,  SndLevelUp  );
	}
	
	ShowArmorMenu(  id  );
}

public CallbackArmor(  id,  menu,  item  )
{
	static  _access,  info[  4  ],  callback;
	menu_item_getinfo(  menu,  item,  _access,  info,  sizeof  (  info  )  -  1,  _,  _,  callback  );
	
	if(  info[  0  ]  ==  '*'  )  return ITEM_ENABLED;
	
	new CsTeams:upgrade = CsTeams:str_to_num(  info  );
	if( gArmorLevel[  id  ][  upgrade  ]  ==  gArmorMaxLevels[  upgrade  ]  )
	{
		return ITEM_DISABLED;
	}
	
	new  xp  =  gArmorFirstXp[  upgrade  ]  *  ( 1 << gArmorLevel[  id  ][  upgrade  ]  );
	if( gUserXp[  id  ]  <  xp  )
	{
		return ITEM_DISABLED;
	}
	
	return ITEM_ENABLED;
}

public ShowSpeedMenu(  id  )
{
	static MenuName[  128  ];
	formatex(  MenuName,  sizeof  (  MenuName  )  -  1, "\rMeniu Viteza^n\yXP: \w%i",  gUserXp[  id  ]  );
	new  menu  =  menu_create(  MenuName, "SpeedMenuHandler"  );
	
	new callback  =  menu_makecallback( "CallbackSpeed" );
	
	menu_additem(  menu,  "\ySpeed Help^n", "*",  _, callback  );
	
	static level,  xp,  Float:amount,  item[  128  ],  info[4];
	
	for(  new CsTeams:i = CS_TEAM_FURIEN; i <= CS_TEAM_ANTIFURIEN; i++  )
	{
		if( gSpeedEnabled[  i  ] )
		{
			level = clamp(  gSpeedLevel[  id  ][  i  ] + 1, 0, gSpeedMaxLevels[  i  ]  );
			if( i == CS_TEAM_FURIEN )
			{
				amount = gFurienSpeedLevels[  level  ];
			}
			else if( i  == CS_TEAM_ANTIFURIEN  )
			{

				amount = gAntiFurienSpeedLevels[  level  ];
			}
			
			if( gSpeedLevel[  id  ][  i  ]  <  gSpeedMaxLevels[  i  ]  )
			{
				xp  =  gSpeedFirstXp[  i  ]  *  (1 << (  level  -  1  )  );
					
				formatex(  item,  sizeof(  item  )  -  1,  "%s: \yLevel %i \r(\w%.1f Speed\r) [\w%i XP\r]", gSpeedNames[  i  ],  level,  amount,  xp  );
			}
			else
			{
				formatex(item, sizeof(item) - 1, "\w%s: \yLevel %i \r(\w%.1f Speed\r) [\wLevel Maxim!\r]", gSpeedNames[  i  ],   level ,   amount  );
			}
			
			num_to_str(  _:i,  info,  sizeof  (  info  )  -  1 );
			
			menu_additem(  menu,  item,  info,  _,  callback  );
		}
	}
	
	menu_setprop(  menu,  MPROP_EXITNAME, "\yMeniu Principal" );
	
	menu_display(  id,  menu  );
}

public SpeedMenuHandler(  id,  menu,  item  )
{
	if(  item  ==  MENU_EXIT  )
	{
		menu_destroy(  menu  );
		ShowMainMenu(  id  );
		return;
	}
	
	static  _access,  info[  4  ],  callback;
	menu_item_getinfo(  menu,  item,  _access,  info,  sizeof  (  info  )  -  1,  _,  _,  callback  );
	menu_destroy(  menu  );
	

	if(  info[ 0 ]  ==  '*'  )
	{
		PrintSpeedHelp( id );
	}
	else
	{
		new CsTeams:upgrade  =  CsTeams:str_to_num(  info  );
		
		new  level  =  gSpeedLevel[  id  ][  upgrade  ] + 1;
		new  xp  =  gSpeedFirstXp[  upgrade  ] * (  1 << (  level  -  1  )  );
		new Float:amount;
		if( upgrade == CS_TEAM_FURIEN )
		{
			amount = gFurienSpeedLevels[  level  ];
		}
		else if( upgrade  == CS_TEAM_ANTIFURIEN  )
		{
	
			amount = gAntiFurienSpeedLevels[  level  ];
		}
		
		gUserXp[  id  ]  -=  xp;
		gSpeedLevel[  id  ][  upgrade  ]  =  level;
		
		Save(  id  );
		
		ColorChat(  id,  RED,  "^x04%s^x01 Upgrade gata:^x03 %s^x01 Level^x03 %i^x01 (^x03%.1f^x01 Speed) pentru^x03 %i^x01 XP!", MESSAGE_TAG, gSpeedNames[  upgrade  ],  level,  amount,  xp  );
		PlaySound(  id,  SndLevelUp  );
	}
	
	ShowSpeedMenu(  id  );
}

public CallbackSpeed(  id,  menu,  item  )
{
	static  _access,  info[  4  ],  callback;
	menu_item_getinfo(  menu,  item,  _access,  info,  sizeof  (  info  )  -  1,  _,  _,  callback  );
	
	if(  info[  0  ]  ==  '*'  )  return ITEM_ENABLED;
	
	new CsTeams:upgrade = CsTeams:str_to_num(  info  );
	if( gSpeedLevel[  id  ][  upgrade  ]  ==  gSpeedMaxLevels[  upgrade  ]  )
	{
		return ITEM_DISABLED;
	}
	
	new  xp  =  gSpeedFirstXp[  upgrade  ]  *  ( 1 << gSpeedLevel[  id  ][  upgrade  ]  );
	if( gUserXp[  id  ]  <  xp  )
	{
		return ITEM_DISABLED;
	}
	
	return ITEM_ENABLED;
}

public ShowGravityMenu(  id  )
{
	static MenuName[  128  ];
	formatex(  MenuName,  sizeof  (  MenuName  )  -  1, "\rMeniu Gravitate^n\yXP: \w%i",  gUserXp[  id  ]  );
	new  menu  =  menu_create(  MenuName, "GravityMenuHandler"  );
	
	new callback  =  menu_makecallback( "CallbackGravity" );
	
	menu_additem(  menu,  "\yGravity Help^n",  "*",  _,  callback  );
	
	static level,  xp,  Float:amount,  item[  128  ],  info[4];
	
	for(  new CsTeams:i = CS_TEAM_FURIEN; i <= CS_TEAM_ANTIFURIEN; i++  )
	{
		if( gGravityEnabled[  i  ] )
		{
			level = clamp(  gGravityLevel[  id  ][  i  ] + 1,  0,  gGravityMaxLevels[  i  ]  );
			if( i == CS_TEAM_FURIEN )
			{
				amount = gFurienGravityLevels[  level  ]  /  0.00125 ;
			}
			else if( i  == CS_TEAM_ANTIFURIEN  )
			{

				amount = gAntiFurienGravityLevels[  level  ]  /  0.00125;
			}
			
			if( gGravityLevel[  id  ][  i  ]  <  gGravityMaxLevels[  i  ]  )
			{
				xp  =  gGravityFirstXp[  i  ]  *  (1 << (  level  -  1  )  );
					
				formatex(  item,  sizeof(  item  )  -  1,  "%s: \yLevel %i \r(\w%.1f Gravity\r) [\w%i XP\r]", gGravityNames[  i  ],  level,  amount,  xp  );
			}
			else
			{
				formatex(item, sizeof(item) - 1, "\w%s: \yLevel %i \r(\w%.1f Gravity\r) [\wLevel Maxim!\r]", gGravityNames[  i  ],   level ,   amount  );
			}
			
			num_to_str(  _:i,  info,  sizeof  (  info  )  -  1 );
			
			menu_additem(  menu,  item,  info,  _,  callback  );
		}
	}
	
	menu_setprop(  menu,  MPROP_EXITNAME, "\yMeniu Principal" );
	menu_display(  id,  menu  );
}

public GravityMenuHandler(  id,  menu,  item  )
{
	if(  item  ==  MENU_EXIT  )
	{
		menu_destroy(  menu  );
		ShowMainMenu(  id  );
		return;
	}
	
	
	static  _access,  info[  4  ],  callback;
	menu_item_getinfo(  menu,  item,  _access,  info,  sizeof  (  info  )  -  1,  _,  _,  callback  );
	menu_destroy(  menu  );
	
	if(  info[ 0 ]  ==  '*'  )
	{
		PrintGravityHelp( id );
	}
	else
	{	
	
		new CsTeams:upgrade  =  CsTeams:str_to_num(  info  );
		
		new  level  =  gGravityLevel[  id  ][  upgrade  ] + 1; 
		new  xp  =  gGravityFirstXp[  upgrade  ] * (  1 << (  level  -  1  )  );
		new Float:amount;
		if( upgrade == CS_TEAM_FURIEN )
		{
			amount = gFurienGravityLevels[  level  ]  /  0.00125;
		}
		else if( upgrade  == CS_TEAM_ANTIFURIEN  )
		{
	
			amount = gAntiFurienGravityLevels[  level  ]  /  0.00125;
		}
		
		gUserXp[  id  ]  -=  xp;
		gGravityLevel[  id  ][  upgrade  ]  =  level;
		
		Save(  id  );
		
		ColorChat(  id,  RED,  "^x04%s^x01 Upgrade gata:^x03 %s^x01 Level^x03 %i^x01 (^x03%.1f^x01 GRAVITY) pentru^x03 %i^x01 XP!", MESSAGE_TAG, gGravityNames[  upgrade  ],  level,  amount,  xp  );
		PlaySound(  id,  SndLevelUp  );
	}

	ShowGravityMenu(  id  );
}

public CallbackGravity(  id,  menu,  item  )
{
	static  _access,  info[  4  ],  callback;
	menu_item_getinfo(  menu,  item,  _access,  info,  sizeof  (  info  )  -  1,  _,  _,  callback  );
	
	if(  info[  0  ]  ==  '*'  )  return ITEM_ENABLED;
	
	new CsTeams:upgrade = CsTeams:str_to_num(  info  );
	if( gGravityLevel[  id  ][  upgrade  ]  ==  gGravityMaxLevels[  upgrade  ]  )
	{
		return ITEM_DISABLED;
	}
	
	new  xp  =  gGravityFirstXp[  upgrade  ]  *  ( 1 << gGravityLevel[  id  ][  upgrade  ]  );
	if( gUserXp[  id  ]  <  xp  )
	{
		return ITEM_DISABLED;
	}
	
	return ITEM_ENABLED;
}

public ShowDamageMultiplierMenu(  id  )
{
	static MenuName[  128  ];
	formatex(  MenuName,  sizeof  (  MenuName  )  -  1, "\rMeniu Multiplicare Damage^n\yXP: \w%i",  gUserXp[  id  ]  );
	new  menu  =  menu_create(  MenuName, "DamageMultiplierMenuHandler"  );
	
	new callback  =  menu_makecallback( "CallbackDamageMultiplier" );
	
	menu_additem(  menu,  "\yDamage Multiplier Help^n", "*",  _, callback  );
	
	static level,  xp,  item[  128  ],  info[4];//,  amount;
	
	for(  new CsTeams:i = CS_TEAM_FURIEN; i <= CS_TEAM_ANTIFURIEN; i++  )
	{
		new iDamage[  CsTeams  ]  =  {  0,  20,  10,  0  };
		
		if( gDamageMultiplierEnabled[  i  ] )
		{
			level = clamp( gDamageMultiplierLevel[  id  ][  i  ] + 1, 0,  gDamageMultiplierMaxLevels[  i  ]  );
			
			if( gDamageMultiplierLevel[  id  ][  i  ]  <  gDamageMultiplierMaxLevels[  i  ]  )
			{
				xp  =  gDamageMultiplierFirstXp[  i  ]  *  (1 << (  level  -  1  )  );
				formatex(  item,  sizeof(  item  )  -  1,  "%s: \yLevel %i \r(\w%i%%\r) [\w%i XP\r]", gDamageMultiplierNames[  i  ],  level,  level * iDamage[  i  ],  xp  );
			}
			else
			{
				formatex(item, sizeof(item) - 1, "\w%s: \yLevel %i \r(\w%i%%\r) [\wLevel Maxim!\r]", gDamageMultiplierNames[  i  ],   level,   level * iDamage[  i  ]  );
			}
			
			num_to_str(  _:i,  info,  sizeof  (  info  )  -  1 );
			
			menu_additem(  menu,  item,  info,  _,  callback  );
		}
	}
	
	menu_setprop(  menu,  MPROP_EXITNAME, "\yMeniu Principal" );
	menu_display(  id,  menu  );
}

public DamageMultiplierMenuHandler(  id,  menu,  item  )
{
	if(  item  ==  MENU_EXIT  )
	{
		menu_destroy(  menu  );
		ShowMainMenu(  id  );
		return;
	}
	
	static  _access,  info[  4  ],  callback;
	menu_item_getinfo(  menu,  item,  _access,  info,  sizeof  (  info  )  -  1,  _,  _,  callback  );
	menu_destroy(  menu  );
	
	if(  info[ 0 ]  ==  '*'  )
	{
		PrintDamageMultiplierHelp( id );
	}
	else
	{
		
		new CsTeams:upgrade  =  CsTeams:str_to_num(  info  );
		
		new  level  =  gDamageMultiplierLevel[  id  ][  upgrade  ] + 1;
		new  xp  =  gDamageMultiplierFirstXp[  upgrade  ] * (  1 << (  level  -  1  )  );
		
		
		gUserXp[  id  ]  -=  xp;
		gDamageMultiplierLevel[  id  ][  upgrade  ]  =  level;
		
		Save(  id  );
		
		ColorChat(  id,  RED,  "^x04%s^x01 Upgrade gata:^x03 %s^x01 Level^x03 %i^x01 (^x03%i^x01 %%) pentru^x03 %i^x01 XP!", MESSAGE_TAG, gDamageMultiplierNames[  upgrade  ],  level,  level * 20 ,  xp  );
		PlaySound(  id,  SndLevelUp  );
	}
	
	ShowDamageMultiplierMenu(  id  );
}

public CallbackDamageMultiplier(  id,  menu,  item  )
{
	static  _access,  info[  4  ],  callback;
	menu_item_getinfo(  menu,  item,  _access,  info,  sizeof  (  info  )  -  1,  _,  _,  callback  );
	
	
	if(  info[  0  ]  ==  '*'  )  return ITEM_ENABLED;
	
	
	new CsTeams:upgrade = CsTeams:str_to_num(  info  );
	if( gDamageMultiplierLevel[  id  ][  upgrade  ]  ==  gDamageMultiplierMaxLevels[  upgrade  ]  )
	{
		return ITEM_DISABLED;
	}
	
	new  xp  =  gDamageMultiplierFirstXp[  upgrade  ]  *  ( 1 << gDamageMultiplierLevel[  id  ][  upgrade  ]  );
	if( gUserXp[  id  ]  <  xp  )
	{
		return ITEM_DISABLED;
	}
	
	return ITEM_ENABLED;
}

public ShowRespawnMenu(  id  )
{
	static MenuName[  128  ];
	formatex(  MenuName,  sizeof  (  MenuName  )  -  1, "\rMeniu Respawn^n\yXP: \w%i",  gUserXp[  id  ]  );
	new  menu  =  menu_create(  MenuName, "RespawnMenuHandler"  );
	
	new callback  =  menu_makecallback( "CallbackRespawn" );
	
	menu_additem(  menu,  "\yRespawn Help^n", "*",  _, callback  );
	
	static level,  xp,  amount,  item[  128  ],  info[4];
	
	for(  new CsTeams:i = CS_TEAM_FURIEN; i <= CS_TEAM_ANTIFURIEN; i++  )
	{
		if( gRespawnEnabled[  i  ] )
		{
			level = clamp( gRespawnLevel[  id  ][  i  ] + 1, 0,  gRespawnMaxLevels[  i  ]  );
			amount = gRespawnMaxAmount[  i  ]  *  level  /  gRespawnMaxLevels[  i  ];
			
			if( gRespawnLevel[  id  ][  i  ]  <  gRespawnMaxLevels[  i  ]  )
			{
				xp  =  gRespawnFirstXp[  i  ]  *  (1 << (  level  -  1  )  );
				formatex(  item,  sizeof(  item  )  -  1,  "%s: \yLevel %i \r(\w%i%%\r) [\w%i XP\r]", gRespawnNames[  i  ],  level,  amount,  xp  );
			}
			else
			{
				formatex(item, sizeof(item) - 1, "\w%s: \yLevel %i \r(\w%i%%\r) [\wLevel Maxim!\r]", gRespawnNames[  i  ],   level,   amount  );
			}
			
			num_to_str(  _:i,  info,  sizeof  (  info  )  -  1 );
			
			menu_additem(  menu,  item,  info,  _,  callback  );
		}
	}
	
	menu_setprop(  menu,  MPROP_EXITNAME, "\yMeniu Principal" );
	menu_display(  id,  menu  );
}

public RespawnMenuHandler(  id,  menu,  item  )
{
	if(  item  ==  MENU_EXIT  )
	{
		menu_destroy(  menu  );
		ShowMainMenu(  id  );
		return;
	}
	
	static  _access,  info[  4  ],  callback;
	menu_item_getinfo(  menu,  item,  _access,  info,  sizeof  (  info  )  -  1,  _,  _,  callback  );
	menu_destroy(  menu  );
	
	if(  info[ 0 ]  ==  '*'  )
	{
		PrintRespawnHelp( id );
	}
	else
	{
		
		new CsTeams:upgrade  =  CsTeams:str_to_num(  info  );
		
		new  level  =  gRespawnLevel[  id  ][  upgrade  ] + 1;
		new  xp  =  gRespawnFirstXp[  upgrade  ] * (  1 << (  level  -  1  )  );
		new  amount  =  gRespawnMaxAmount[  upgrade  ]  *  level  /  gRespawnMaxLevels[  upgrade  ];
		
		gUserXp[  id  ]  -=  xp;
		gRespawnLevel[  id  ][  upgrade  ]  =  level;
		
		Save(  id  );
		
		ColorChat(  id,  RED,  "^x04%s^x01 Upgrade gata:^x03 %s^x01 Level^x03 %i^x01 (^x03%i^x01 %%) pentru^x03 %i^x01 XP!", MESSAGE_TAG, gRespawnNames[  upgrade  ],  level,  amount,  xp  );
		PlaySound(  id,  SndLevelUp  );
	}

	ShowRespawnMenu(  id  );
}

public CallbackRespawn(  id,  menu,  item  )
{
	static  _access,  info[  4  ],  callback;
	menu_item_getinfo(  menu,  item,  _access,  info,  sizeof  (  info  )  -  1,  _,  _,  callback  );
	
	
	if(  info[  0  ]  ==  '*'  )  return ITEM_ENABLED;
	
	
	new CsTeams:upgrade = CsTeams:str_to_num(  info  );
	if( gRespawnLevel[  id  ][  upgrade  ]  ==  gRespawnMaxLevels[  upgrade  ]  )
	{
		return ITEM_DISABLED;
	}
	
	new  xp  =  gRespawnFirstXp[  upgrade  ]  *  ( 1 << gRespawnLevel[  id  ][  upgrade  ]  );
	if( gUserXp[  id  ]  <  xp  )
	{
		return ITEM_DISABLED;
	}
	
	return ITEM_ENABLED;
}

public ShowHealthRegenerationMenu(  id  )
{
	static MenuName[  128  ];
	formatex(  MenuName,  sizeof  (  MenuName  )  -  1, "\rMeniu Regenerare Viata^n\yXP: \w%i",  gUserXp[  id  ]  );
	new  menu  =  menu_create(  MenuName, "HealthRegenerationMenuHandler"  );
	
	new callback  =  menu_makecallback( "CallbackHealthRegeneration" );
	
	menu_additem(  menu,  "\yHealth Regeneration Help^n", "*",  _, callback  );
	
	static level,  xp,  amount,  item[  128  ],  info[4];
	
	for(  new CsTeams:i = CS_TEAM_FURIEN; i <= CS_TEAM_ANTIFURIEN; i++  )
	{
		if( gHealthRegenerationEnabled[  i  ] )
		{
			level = clamp(  gHealthRegenerationLevel[  id  ][  i  ] + 1, 0, gHealthRegenerationMaxLevels[  i  ] );
			amount = gHealthRegenerationMaxAmount[  i  ]  *  level  /  gHealthRegenerationMaxLevels[  i  ];
			
			if( gHealthRegenerationLevel[  id  ][  i  ]  <  gHealthRegenerationMaxLevels[  i  ]  )
			{
				xp  =  gHealthRegenerationFirstXp[  i  ]  *  (1 << (  level  -  1  )  );
				formatex(  item,  sizeof(  item  )  -  1,  "%s: \yLevel %i \r(\w%i HP\r) [\w%i XP\r]", gHealthRegenerationNames[  i  ],  level,  amount,  xp  );
			}
			else
			{
				formatex(item, sizeof(item) - 1, "\w%s: \yLevel %i \r(\w%i HP\r) \r[\wLevel Maxim!\r]", gHealthRegenerationNames[  i  ],   level,   amount  );
			}
			
			num_to_str(  _:i,  info,  sizeof  (  info  )  -  1 );
			
			menu_additem(  menu,  item,  info,  _,  callback  );
		}
	}
	
	menu_setprop(  menu,  MPROP_EXITNAME, "\yMeniu Principal" );
	
	menu_display(  id,  menu  );
}

public HealthRegenerationMenuHandler(  id,  menu,  item  )
{
	if(  item  ==  MENU_EXIT  )
	{
		menu_destroy(  menu  );
		ShowMainMenu(  id  );
		return;
	}
	
	static  _access,  info[  4  ],  callback;
	menu_item_getinfo(  menu,  item,  _access,  info,  sizeof  (  info  )  -  1,  _,  _,  callback  );
	menu_destroy(  menu  );
	
	if(  info[ 0 ]  ==  '*'  )
	{
		PrintHealthRegenerationHelp( id );
	}
	else
	{
	
	
		new CsTeams:upgrade  =  CsTeams:str_to_num(  info  );
		
		new  level  =  gHealthRegenerationLevel[  id  ][  upgrade  ] + 1;
		new  xp  =  gHealthRegenerationFirstXp[  upgrade  ] * (  1 << (  level  -  1  )  );
		new  amount  =  gHealthRegenerationMaxAmount[  upgrade  ]  *  level  /  gHealthRegenerationMaxLevels[  upgrade  ];
		
		gUserXp[  id  ]  -=  xp;
		gHealthRegenerationLevel[  id  ][  upgrade  ]  =  level;
		
		Save(  id  );
		
		ColorChat(  id,  RED,  "^x04%s^x01 Upgrade gata:^x03 %s^x01 Level^x03 %i^x01 (^x03%i^x01 HP) pentru^x03 %i^x01 XP!", MESSAGE_TAG, gHealthRegenerationNames[  upgrade  ],  level,  amount,  xp  );
		PlaySound(  id,  SndLevelUp  );
	}
	
	ShowHealthRegenerationMenu(  id  );
}

public CallbackHealthRegeneration(  id,  menu,  item  )
{
	static  _access,  info[  4  ],  callback;
	menu_item_getinfo(  menu,  item,  _access,  info,  sizeof  (  info  )  -  1,  _,  _,  callback  );
	
	if(  info[  0  ]  ==  '*'  )  return ITEM_ENABLED;
	
	new CsTeams:upgrade = CsTeams:str_to_num(  info  );
	if( gHealthRegenerationLevel[  id  ][  upgrade  ]  ==  gHealthRegenerationMaxLevels[  upgrade  ]  )
	{
		return ITEM_DISABLED;
	}
	
	new  xp  =  gHealthRegenerationFirstXp[  upgrade  ]  *  ( 1 << gHealthRegenerationLevel[  id  ][  upgrade  ]  );
	if( gUserXp[  id  ]  <  xp  )
	{
		return ITEM_DISABLED;
	}
	
	return ITEM_ENABLED;
}

public ShowArmorChargerMenu(  id  )
{
	static MenuName[  128  ];
	formatex(  MenuName,  sizeof  (  MenuName  )  -  1, "\rMeniu Reincarcare Armura^n\yXP: \w%i",  gUserXp[  id  ]  );
	new  menu  =  menu_create(  MenuName, "ArmorChargerMenuHandler"  );
	
	new callback  =  menu_makecallback( "CallbackArmorCharger" );
	
	
	menu_additem(  menu,  "\yArmor Charger Help^n", "*",  _, callback  );
	
	
	static level,  xp,  amount,  item[  128  ],  info[4];
	
	for(  new CsTeams:i = CS_TEAM_FURIEN; i <= CS_TEAM_ANTIFURIEN; i++  )
	{
		if( gArmorChargerEnabled[  i  ] )
		{
			level = clamp( gArmorChargerLevel[  id  ][  i  ] + 1, 0,  gArmorChargerMaxLevels[  i  ]  );
			amount = gArmorChargerMaxAmount[  i  ]  *  level  /  gArmorChargerMaxLevels[  i  ];
			
			if( gArmorChargerLevel[  id  ][  i  ]  <  gArmorChargerMaxLevels[  i  ]  )
			{
				xp  =  gArmorChargerFirstXp[  i  ]  *  (1 << (  level  -  1  )  );
				formatex(  item,  sizeof(  item  )  -  1,  "%s: \yLevel %i \r(\w%i AP\r) [\w%i XP\r]", gArmorChargerNames[  i  ],  level,  amount,  xp  );
			}
			else
			{
				formatex(item, sizeof(item) - 1, "\w%s: \yLevel %i \r(\w%i AP\r) \r[\wLevel Maxim!\r]", gArmorChargerNames[  i  ],   level,   amount  );
			}
			
			num_to_str(  _:i,  info,  sizeof  (  info  )  -  1 );
			
			menu_additem(  menu,  item,  info,  _,  callback  );
		}
	}
	
	menu_setprop(  menu,  MPROP_EXITNAME, "\yMeniu Principal" );
	
	menu_display(  id,  menu  );
}

public ArmorChargerMenuHandler(  id,  menu,  item  )
{
	if(  item  ==  MENU_EXIT  )
	{
		menu_destroy(  menu  );
		ShowMainMenu(  id  );
		return;
	}
	
	static  _access,  info[  4  ],  callback;
	menu_item_getinfo(  menu,  item,  _access,  info,  sizeof  (  info  )  -  1,  _,  _,  callback  );
	menu_destroy(  menu  );
	
	
	if(  info[ 0 ]  ==  '*'  )
	{
		PrintArmorChargerHelp( id );
	}
	else
	{
		new CsTeams:upgrade  =  CsTeams:str_to_num(  info  );
		
		new  level  =  gArmorChargerLevel[  id  ][  upgrade  ] + 1;
		new  xp  =  gArmorChargerFirstXp[  upgrade  ] * (  1 << (  level  -  1  )  );
		new  amount  =  gArmorChargerMaxAmount[  upgrade  ]  *  level  /  gArmorChargerMaxLevels[  upgrade  ];
		
		gUserXp[  id  ]  -=  xp;
		gArmorChargerLevel[  id  ][  upgrade  ]  =  level;
		
		Save(  id  );
		
		ColorChat(  id,  RED,  "^x04%s^x01 Upgrade gata:^x03 %s^x01 Level^x03 %i^x01 (^x03%i^x01 AP) pentru^x03 %i^x01 XP!", MESSAGE_TAG, gArmorChargerNames[  upgrade  ],  level,  amount,  xp  );
		PlaySound(  id,  SndLevelUp  );
	}
	
	ShowArmorChargerMenu(  id  );
}

public CallbackArmorCharger(  id,  menu,  item  )
{
	static  _access,  info[  4  ],  callback;
	menu_item_getinfo(  menu,  item,  _access,  info,  sizeof  (  info  )  -  1,  _,  _,  callback  );
	
	if(  info[  0  ]  ==  '*'  )  return ITEM_ENABLED;
	
	new CsTeams:upgrade = CsTeams:str_to_num(  info  );
	if( gArmorChargerLevel[  id  ][  upgrade  ]  ==  gArmorChargerMaxLevels[  upgrade  ]  )
	{
		return ITEM_DISABLED;
	}
	
	new  xp  =  gArmorChargerFirstXp[  upgrade  ]  *  ( 1 << gArmorChargerLevel[  id  ][  upgrade  ]  );
	if( gUserXp[  id  ]  <  xp  )
	{
		return ITEM_DISABLED;
	}
	
	return ITEM_ENABLED;
}

public Load(  id  )
{
	
	static data[  256  ],  timestamp;
	new  szName[  32  ];
	get_user_name(  id,  szName,  sizeof  (  szName  )  -1  );
	
	if(  nvault_lookup(  gVault,  szName,  data,  sizeof  (  data  )  -  1,  timestamp  ) )
	{
		ParseLoadedData(  id,  data  );
		return;
	}
	else
	{
		UserIsNew(  id  );
	}
	
}

public ParseLoadedData(  id,  data[  256  ]  )
{
	
	static iXp[  25  ], iLevel[ 6 ];
	strbreak(  data,  iXp,  sizeof  (  iXp  )  -  1,  data,  sizeof  (  data  )  -  1  );
	
	gUserXp[  id  ]  =  str_to_num(  iXp  );
	
	for(  new CsTeams:i = CS_TEAM_FURIEN; i <= CS_TEAM_ANTIFURIEN; i++  )
	{
		strbreak(  data,  iLevel,  sizeof  (  iLevel  )  -  1,  data,  sizeof  (  data  )  -  1  );
		gHealthLevel[  id  ][  i  ]  =  clamp(  str_to_num(  iLevel  ),  NULL,  gHealthMaxLevels[  i  ]  );
	}
	
	for(  new CsTeams:i = CS_TEAM_FURIEN; i <= CS_TEAM_ANTIFURIEN; i++  )
	{
		strbreak(  data,  iLevel,  sizeof  (  iLevel  )  -  1,  data,  sizeof  (  data  )  -  1  );
		gArmorLevel[  id  ][  i  ]  =  clamp(  str_to_num(  iLevel  ),  NULL,  gArmorMaxLevels[  i  ]  );
	}
	
	for(  new CsTeams:i = CS_TEAM_FURIEN; i <= CS_TEAM_ANTIFURIEN; i++  )
	{
		strbreak(  data,  iLevel,  sizeof  (  iLevel  )  -  1,  data,  sizeof  (  data  )  -  1  );
		gSpeedLevel[  id  ][  i  ]  =  clamp(  str_to_num(  iLevel  ),  NULL,  gSpeedMaxLevels[  i  ]  );
	}
	
	for(  new CsTeams:i = CS_TEAM_FURIEN; i <= CS_TEAM_ANTIFURIEN; i++  )
	{
		strbreak(  data,  iLevel,  sizeof  (  iLevel  )  -  1,  data,  sizeof  (  data  )  -  1  );
		gGravityLevel[  id  ][  i  ]  =  clamp(  str_to_num(  iLevel  ),  NULL,  gGravityMaxLevels[  i  ]  );
	}
	
	for(  new CsTeams:i = CS_TEAM_FURIEN; i <= CS_TEAM_ANTIFURIEN; i++  )
	{
		strbreak(  data,  iLevel,  sizeof  (  iLevel  )  -  1,  data,  sizeof  (  data  )  -  1  );
		gDamageMultiplierLevel[  id  ][  i  ]  =  clamp(  str_to_num(  iLevel  ),  NULL,  gDamageMultiplierMaxLevels[  i  ]  );
	}
	
	for(  new CsTeams:i = CS_TEAM_FURIEN; i <= CS_TEAM_ANTIFURIEN; i++  )
	{
		strbreak(  data,  iLevel,  sizeof  (  iLevel  )  -  1,  data,  sizeof  (  data  )  -  1  );
		gRespawnLevel[  id  ][  i  ]  =  clamp(  str_to_num(  iLevel  ),  NULL,  gRespawnMaxLevels[  i  ]  );
	}
	for(  new CsTeams:i = CS_TEAM_FURIEN; i <= CS_TEAM_ANTIFURIEN; i++  )
	{
		strbreak(  data,  iLevel,  sizeof  (  iLevel  )  -  1,  data,  sizeof  (  data  )  -  1  );
		gHealthRegenerationLevel[  id  ][  i  ]  =  clamp(  str_to_num(  iLevel  ),  NULL,  gHealthRegenerationMaxLevels[  i  ]  );
	}
	for(  new CsTeams:i = CS_TEAM_FURIEN; i <= CS_TEAM_ANTIFURIEN; i++  )
	{
		strbreak(  data,  iLevel,  sizeof  (  iLevel  )  -  1,  data,  sizeof  (  data  )  -  1  );
		gArmorChargerLevel[  id  ][  i  ]  =  clamp(  str_to_num(  iLevel  ),  NULL,  gArmorChargerMaxLevels[  i  ]  );
	}
	
}

public UserIsNew(  id  )
{
	
	gFirstTimePlayed[  id  ]  =  true;
	gUserXp[  id  ]  =  get_pcvar_num(  gCvarEntryXP  );
	
	for(  new CsTeams:i = CS_TEAM_FURIEN; i <= CS_TEAM_ANTIFURIEN; i++  )
	{
		gHealthLevel[  id  ][  i  ]  =  NULL;
		gArmorLevel[  id  ][  i  ]  =  NULL;
		gSpeedLevel[  id  ][  i  ]  =  NULL;
		gGravityLevel[  id  ][  i  ]  =  NULL;
		gDamageMultiplierLevel[  id  ][  i  ]  =  NULL;
		gRespawnLevel[  id  ][  i  ]  =  NULL;
		gHealthRegenerationLevel[  id  ][  i  ]  =  NULL;
		gArmorChargerLevel[  id  ][  i  ]  =  NULL;
	}
	
}

public Save(  id  )
{
	
	static data[  256  ];
	new  len  =  formatex(  data,  sizeof  (  data  )  - 1,  "%i", gUserXp[  id  ]);
	
	for(  new CsTeams:i = CS_TEAM_FURIEN; i <= CS_TEAM_ANTIFURIEN; i++   )
	{
		len  +=  formatex(  data[  len  ],  sizeof(  data  )  -  len  -  1 ,  " %i", gHealthLevel[  id  ][  i  ]  );
	}
	
	for(  new CsTeams:i = CS_TEAM_FURIEN; i <= CS_TEAM_ANTIFURIEN; i++   )
	{
		len  +=  formatex(  data[  len  ],  sizeof(  data  )  -  len  -  1 ,  " %i", gArmorLevel[  id  ][  i  ]  );
	}
	for(  new CsTeams:i = CS_TEAM_FURIEN; i <= CS_TEAM_ANTIFURIEN; i++   )
	{
		len  +=  formatex(  data[  len  ],  sizeof(  data  )  -  len  -  1 ,  " %i", gSpeedLevel[  id  ][  i  ]  );
	}
	for(  new CsTeams:i = CS_TEAM_FURIEN; i <= CS_TEAM_ANTIFURIEN; i++   )
	{
		len  +=  formatex(  data[  len  ],  sizeof(  data  )  -  len  -  1 ,  " %i", gGravityLevel[  id  ][  i  ]  );
	}
	for(  new CsTeams:i = CS_TEAM_FURIEN; i <= CS_TEAM_ANTIFURIEN; i++   )
	{
		len  +=  formatex(  data[  len  ],  sizeof(  data  )  -  len  -  1 ,  " %i", gDamageMultiplierLevel[  id  ][  i  ]  );
	}
	for(  new CsTeams:i = CS_TEAM_FURIEN; i <= CS_TEAM_ANTIFURIEN; i++   )
	{
		len  +=  formatex(  data[  len  ],  sizeof(  data  )  -  len  -  1 ,  " %i", gRespawnLevel[  id  ][  i  ]  );
	}
	for(  new CsTeams:i = CS_TEAM_FURIEN; i <= CS_TEAM_ANTIFURIEN; i++   )
	{
		len  +=  formatex(  data[  len  ],  sizeof(  data  )  -  len  -  1 ,  " %i", gHealthRegenerationLevel[  id  ][  i  ]  );
	}
	for(  new CsTeams:i = CS_TEAM_FURIEN; i <= CS_TEAM_ANTIFURIEN; i++   )
	{
		len  +=  formatex(  data[  len  ],  sizeof(  data  )  -  len  -  1 ,  " %i", gArmorChargerLevel[  id  ][  i  ]  );
	}
	new  szName[  32  ];
	get_user_name(  id,  szName,  sizeof  (  szName  )  -1  );
	
	nvault_set(  gVault,  szName,  data  );
	
}

public BlockedCommand(  id  ) 
{
	console_print(  id,"%s You can not use a restricted command !",  MESSAGE_TAG  );
	return 1;
}

public PrintGeneralHelp(  id  )
{
	
	if(  !IsUserOK(  id  )  )  return 1;
	
	static motd[  2500  ];
	new len = formatex( motd, sizeof ( motd )  - 1,	"<html>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<style type=^"text/css^">"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "body{background-image: url(^"http://i52.tinypic.com/qoukhx.png^");font-family:Tahoma;font-size:15px;color:#FFFFFF;}"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "table{font-family:Tahoma;font-size:10px;color:#FFFFFF;}</style>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<body><center><font face=^"Verdana^" size=^"2^"><b><br>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<font size=^"4^" color=^"#B80000^">%s<br>",  PLUGIN  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "v%s by Askhanar</font><br><br>", VERSION  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "%s este un addon modificat al modului Furien.<br>",  PLUGIN  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "Jucatorii castiga puncte de experienta pe cat de bine joaca.<br><br><br>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "</center><table align=center width=65%% cellpadding=1 cellspacing=0 >"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<tr align=center > <th width=13%%> Actiune <th width=13%%> Arma <th width=13%%>Headshot<th width=13%%>Experienta Jucatori<th width=13%%>Experienta VIP"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<tr align=center > <td> Omori un jucator</td>  <td> Toate</td> <td> -</td><td> %d</td><td> x2</td>",  get_pcvar_num(  gCvarKillXP  )  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<tr align=center > <td> Omori un jucator( Bonus )</td>  <td> Toate</td> <td> Da</td><td> %d</td><td> x2</td>",  get_pcvar_num(  gCvarHeadShotKillXP  )  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<tr align=center > <td> Omori un jucator( Bonus )</td>  <td> Grenada</td> <td> -<td> %d</td><td> x2</td>",  get_pcvar_num(  gCvarGrenadeKillXP  )  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<tr align=center > <td> Omori un jucator( Bonus )</td>  <td> Cutit</td> <td> -<td> %d</td><td> x2</td>",  get_pcvar_num(  gCvarKnifeKillXP  )  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<tr align=center > <td> Supravietuiesti( AntiFurien )</td>  <td> -</td> <td> -<td> %d</td><td> x2</td>",  get_pcvar_num(  gCvarSurviveXP  )  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<tr align=center > <td> Castigi Runda</td>  <td> -</td> <td> -<td> %d</td><td> x2</td>",  get_pcvar_num(  gCvarWinXP  )  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "</table><center><br><br>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "Cu aceste puncte de Experienta, poti cumpara upgrade-uri.<br>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "Pentru o lista a acestor upgrade-uri, scrie /XP din nou si vizualizeaza alte meniuri."  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "</center></body></html>"  );
	
	show_motd(  id,  motd,  "Ajutor General");
	return 1;
}
public PrintHealthHelp(  id  )
{
	static motd[  2500  ];
	new len = formatex( motd, sizeof ( motd )  - 1,	"<html>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<style type=^"text/css^">"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "body{background-image: url(^"http://i52.tinypic.com/qoukhx.png^");font-family:Tahoma;font-size:15px;color:#FFFFFF;}"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "table{font-family:Tahoma;font-size:10px;color:#FFFFFF;}</style>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<body><center><font face=^"Verdana^" size=^"2^"><b><br>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<font size=^"4^" color=^"#B80000^">%s<br>",  PLUGIN  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "</font><br><br>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "Upgrade-ul Viata reprezinta cat HP primesti in plus la inceputul rundei.<br><br><br>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "</center><table align=center width=35%% cellpadding=1 cellspacing=0 >"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<tr align=center > <th width=15%%> Informatii"  );
	
	for(  new CsTeams:i = CS_TEAM_FURIEN;  i <= CS_TEAM_ANTIFURIEN;  i++  )
	{
		if(  gHealthEnabled[  i  ]  )
		{
			len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<th width=10%%> %s",  gHealthNames[  i  ]  );
		}
	}
	
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<tr align=center > <td> Intervale Viata</td>"  );
	
	for(  new CsTeams:i = CS_TEAM_FURIEN;  i <= CS_TEAM_ANTIFURIEN;  i++  )
	{
		if(  gHealthEnabled[  i  ]  )
		{
			len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<th width=10%%> %i",  gHealthMaxAmount[  i  ]  /  gHealthMaxLevels[  i  ]  );
		}
	}
	
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<tr align=center > <td> Level Maxim</td>"  );
	
	for(  new CsTeams:i = CS_TEAM_FURIEN;  i <= CS_TEAM_ANTIFURIEN;  i++  )
	{
		if(  gHealthEnabled[  i  ]  )
		{
			len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<th width=10%%> %i", gHealthMaxLevels[  i  ]  );
		}
	}
	
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<tr align=center > <td> Viata maxima</td>"  );
	
	for(  new CsTeams:i = CS_TEAM_FURIEN;  i <= CS_TEAM_ANTIFURIEN;  i++  )
	{
		if(  gHealthEnabled[  i  ]  )
		{
			len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<th width=10%%> %i", gHealthMaxAmount[  i  ]  );
		}
	}
	
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "</table><center>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "</center></body></html>"  );
	
	show_motd(  id,  motd,  "Ajutor Viata");
}

public PrintArmorHelp( id )
{
	static motd[  2500  ];
	new len = formatex( motd, sizeof ( motd )  - 1,	"<html>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<style type=^"text/css^">"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "body{background-image: url(^"http://i52.tinypic.com/qoukhx.png^");font-family:Tahoma;font-size:15px;color:#FFFFFF;}"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "table{font-family:Tahoma;font-size:10px;color:#FFFFFF;}</style>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<body><center><font face=^"Verdana^" size=^"2^"><b><br>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<font size=^"4^" color=^"#B80000^">%s<br>",  PLUGIN  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "</font><br><br>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "Upgrade-ul Armura reprezinta cat AP primesti in plus la inceputul rundei.<br><br><br>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "</center><table align=center width=35%% cellpadding=1 cellspacing=0 >"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<tr align=center > <th width=15%%> Informatii"  );
	
	for(  new CsTeams:i = CS_TEAM_FURIEN;  i <= CS_TEAM_ANTIFURIEN;  i++  )
	{
		if(  gArmorEnabled[  i  ]  )
		{
			len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<th width=10%%> %s",  gArmorNames[  i  ]  );
		}
	}
	
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<tr align=center > <td> Intervale Armura</td>"  );
	
	for(  new CsTeams:i = CS_TEAM_FURIEN;  i <= CS_TEAM_ANTIFURIEN;  i++  )
	{
		if(  gArmorEnabled[  i  ]  )
		{
			len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<th width=10%%> %i",  gArmorMaxAmount[  i  ]  /  gArmorMaxLevels[  i  ]  );
		}
	}
	
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<tr align=center > <td> Level Maxim</td>"  );
	
	for(  new CsTeams:i = CS_TEAM_FURIEN;  i <= CS_TEAM_ANTIFURIEN;  i++  )
	{
		if(  gArmorEnabled[  i  ]  )
		{
			len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<th width=10%%> %i", gArmorMaxLevels[  i  ]  );
		}
	}
	
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<tr align=center > <td> Armura Maxima</td>"  );
	
	for(  new CsTeams:i = CS_TEAM_FURIEN;  i <= CS_TEAM_ANTIFURIEN;  i++  )
	{
		if(  gArmorEnabled[  i  ]  )
		{
			len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<th width=10%%> %i", gArmorMaxAmount[  i  ]  );
		}
	}
	
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "</table><center>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "</center></body></html>"  );
	
	show_motd(  id,  motd,  "Ajutor Armura");
}

public PrintSpeedHelp( id )
{
	static motd[  2500  ];
	new len = formatex( motd, sizeof ( motd )  - 1,	"<html>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<style type=^"text/css^">"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "body{background-image: url(^"http://i52.tinypic.com/qoukhx.png^");font-family:Tahoma;font-size:15px;color:#FFFFFF;}"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "table{font-family:Tahoma;font-size:10px;color:#FFFFFF;}</style>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<body><center><font face=^"Verdana^" size=^"2^"><b><br>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<font size=^"4^" color=^"#B80000^">%s<br>",  PLUGIN  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "</font><br><br>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "Upgrade-ul Viteza reprezinta viteza cu care esti capabil sa te misti.<br><br><br>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "</center><table align=center width=35%% cellpadding=1 cellspacing=0 >"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<tr align=center > <th width=15%%> Informatii"  );
	
	for(  new CsTeams:i = CS_TEAM_FURIEN;  i <= CS_TEAM_ANTIFURIEN;  i++  )
	{
		if(  gSpeedEnabled[  i  ]  )
		{
			len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<th width=10%%> %s",  gSpeedNames[  i  ]  );
		}
	}
	
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<tr align=center > <td> Viteza Default</td>"  );
	
	for(  new CsTeams:i = CS_TEAM_FURIEN;  i <= CS_TEAM_ANTIFURIEN;  i++  )
	{
		if(  gSpeedEnabled[  i  ]  )
		{
			if(  i  ==  CS_TEAM_FURIEN  )
			{
				len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<th width=10%%> %.1f",  gFurienSpeedLevels[  0  ] );
			}
			else if(  i  ==  CS_TEAM_ANTIFURIEN  )
			{
				len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<th width=10%%> %.1f",  gAntiFurienSpeedLevels[  0  ]  );
			}
		}
	}
	
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<tr align=center > <td> Level Maxim</td>"  );
	
	for(  new CsTeams:i = CS_TEAM_FURIEN;  i <= CS_TEAM_ANTIFURIEN;  i++  )
	{
		if(  gSpeedEnabled[  i  ]  )
		{
			len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<th width=10%%> %i", gSpeedMaxLevels[  i  ]  );
		}
	}
	
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<tr align=center > <td> Viteza Maxima</td>"  );
	
	for(  new CsTeams:i = CS_TEAM_FURIEN;  i <= CS_TEAM_ANTIFURIEN;  i++  )
	{
		if(  gSpeedEnabled[  i  ]  )
		{
			if(  i  ==  CS_TEAM_FURIEN  )
			{
				len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<th width=10%%> %.1f",  gFurienSpeedLevels[  gSpeedMaxLevels[  i  ]  ] );
			}
			else if(  i  ==  CS_TEAM_ANTIFURIEN  )
			{
				len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<th width=10%%> %.1f",  gAntiFurienSpeedLevels[  gSpeedMaxLevels[  i  ]  ]  );
			}
		}
	}
	
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "</table><center>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "</center></body></html>"  );
	
	show_motd(  id,  motd,  "Ajutor Viteza");
}

public PrintGravityHelp( id )
{
	static motd[  2500  ];
	new len = formatex( motd, sizeof ( motd )  - 1,	"<html>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<style type=^"text/css^">"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "body{background-image: url(^"http://i52.tinypic.com/qoukhx.png^");font-family:Tahoma;font-size:15px;color:#FFFFFF;}"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "table{font-family:Tahoma;font-size:10px;color:#FFFFFF;}</style>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<body><center><font face=^"Verdana^" size=^"2^"><b><br>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<font size=^"4^" color=^"#B80000^">%s<br>",  PLUGIN  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "</font><br><br>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "Upgrade-ul Gravitate reprezinta gravitatea care o are jucatorul ( gravitate mica = sarituri inalte ).<br><br><br>" );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "</center><table align=center width=45%% cellpadding=1 cellspacing=0 >"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<tr align=center > <th width=15%%> Informatii"  );
	
	for(  new CsTeams:i = CS_TEAM_FURIEN;  i <= CS_TEAM_ANTIFURIEN;  i++  )
	{
		if(  gGravityEnabled[  i  ]  )
		{
			len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<th width=15%%> %s",  gGravityNames[  i  ]  );
		}
	}
	
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<tr align=center > <td> Gravitate Default</td>"  );
	
	for(  new CsTeams:i = CS_TEAM_FURIEN;  i <= CS_TEAM_ANTIFURIEN;  i++  )
	{
		if(  gGravityEnabled[  i  ]  )
		{
			if(  i  ==  CS_TEAM_FURIEN  )
			{
				len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<th width=10%%> %.1f",  gFurienGravityLevels[  0  ]  /  0.00125 );
			}
			else if(  i  ==  CS_TEAM_ANTIFURIEN  )
			{
				len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<th width=10%%> %.1f",  gAntiFurienGravityLevels[  0  ]  /  0.00125 );
			}
		}
	}
	
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<tr align=center > <td> Level Maxim</td>"  );
	
	for(  new CsTeams:i = CS_TEAM_FURIEN;  i <= CS_TEAM_ANTIFURIEN;  i++  )
	{
		if(  gGravityEnabled[  i  ]  )
		{
			len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<th width=10%%> %i", gGravityMaxLevels[  i  ]  );
		}
	}
	
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<tr align=center > <td> Gravitate Maxima</td>"  );
	
	for(  new CsTeams:i = CS_TEAM_FURIEN;  i <= CS_TEAM_ANTIFURIEN;  i++  )
	{
		if(  gGravityEnabled[  i  ]  )
		{
			if(  i  ==  CS_TEAM_FURIEN  )
			{
				len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<th width=10%%> %.1f",  gFurienGravityLevels[  gGravityMaxLevels[  i  ]  ]  /  0.00125  );
			}
			else if(  i  ==  CS_TEAM_ANTIFURIEN  )
			{
				len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<th width=10%%> %.1f",  gAntiFurienGravityLevels[  gGravityMaxLevels[  i  ]  ]  /  0.00125  );
			}
		}
	}
	
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "</table><center>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "</center></body></html>"  );
	
	show_motd(  id,  motd,  "Ajutor Gravitate");
}

public PrintDamageMultiplierHelp( id )
{
	static motd[  2500  ];
	new len = formatex( motd, sizeof ( motd )  - 1,	"<html>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<style type=^"text/css^">"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "body{background-image: url(^"http://i52.tinypic.com/qoukhx.png^");font-family:Tahoma;font-size:15px;color:#FFFFFF;}"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "table{font-family:Tahoma;font-size:10px;color:#FFFFFF;}</style>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<body><center><font face=^"Verdana^" size=^"2^"><b><br>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<font size=^"4^" color=^"#B80000^">%s<br>",  PLUGIN  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "</font><br><br>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "Upgrade-ul Multiplicare Damage iti mareste damage-ul ( ex: marit cu 50%%, 100 damage va fi 150 ).<br><br><br>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "</center><table align=center width=51%% cellpadding=1 cellspacing=0 >"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<tr align=center > <th width=15%%> Informatii"  );
	
	for(  new CsTeams:i = CS_TEAM_FURIEN;  i <= CS_TEAM_ANTIFURIEN;  i++  )
	{
		if(  gDamageMultiplierEnabled[  i  ]  )
		{
			len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<th width=18%%> %s",  gDamageMultiplierNames[  i  ]  );
		}
	}
	
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<tr align=center > <td> Intervale Damage</td>"  );
	
	for(  new CsTeams:i = CS_TEAM_FURIEN;  i <= CS_TEAM_ANTIFURIEN;  i++  )
	{
		if(  gDamageMultiplierEnabled[  i  ]  )
		{
			if(  i  ==  CS_TEAM_FURIEN  )
			{
				len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<th width=10%%> %.1f%%",  gFurienMaxDamageMultiplier  /  gDamageMultiplierMaxLevels[  i  ] * 100 + 0.1);
			}
			else if(  i  ==  CS_TEAM_ANTIFURIEN  )
			{
				len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<th width=10%%> %.1f%%",  gAntiFurienMaxDamageMultiplier  /  gDamageMultiplierMaxLevels[  i  ] * 100 );
			}
		}
	}
	
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<tr align=center > <td> Level Maxim</td>"  );
	
	for(  new CsTeams:i = CS_TEAM_FURIEN;  i <= CS_TEAM_ANTIFURIEN;  i++  )
	{
		if(  gDamageMultiplierEnabled[  i  ]  )
		{
			len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<th width=10%%> %i", gDamageMultiplierMaxLevels[  i  ]  );
		}
	}
	
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<tr align=center > <td> Multiplicare Maxima</td>"  );
	
	for(  new CsTeams:i = CS_TEAM_FURIEN;  i <= CS_TEAM_ANTIFURIEN;  i++  )
	{
		if(  gDamageMultiplierEnabled[  i  ]  )
		{
			if(  i  ==  CS_TEAM_FURIEN  )
			{
				len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<th width=10%%> %.1f%%",  gFurienMaxDamageMultiplier  *  100 + 0.1  );
			}
			else if(  i  ==  CS_TEAM_ANTIFURIEN  )
			{
				len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<th width=10%%> %.1f%%",  gAntiFurienMaxDamageMultiplier  *  100  );
			}
		}
	}
	
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "</table><center>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "</center></body></html>"  );
	
	show_motd(  id,  motd,  "Ajutor Multiplicare Damage");
}
public PrintRespawnHelp( id )
{
	static motd[  2500  ];
	new len = formatex( motd, sizeof ( motd )  - 1,	"<html>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<style type=^"text/css^">"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "body{background-image: url(^"http://i52.tinypic.com/qoukhx.png^");font-family:Tahoma;font-size:15px;color:#FFFFFF;}"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "table{font-family:Tahoma;font-size:10px;color:#FFFFFF;}</style>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<body><center><font face=^"Verdana^" size=^"2^"><b><br>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<font size=^"4^" color=^"#B80000^">%s<br>",  PLUGIN  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "</font><br><br>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "Upgrade-ul Respawn reprezinta sansa care o ai sa primesti respawn atunci cand mori.<br><br><br>" );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "</center><table align=center width=45%% cellpadding=1 cellspacing=0 >"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<tr align=center > <th width=15%%> Informatii"  );
	
	for(  new CsTeams:i = CS_TEAM_FURIEN;  i <= CS_TEAM_ANTIFURIEN;  i++  )
	{
		if(  gRespawnEnabled[  i  ]  )
		{
			len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<th width=15%%> %s",  gRespawnNames[  i  ]  );
		}
	}
	
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<tr align=center > <td> Intervale Sansa</td>"  );
	
	for(  new CsTeams:i = CS_TEAM_FURIEN;  i <= CS_TEAM_ANTIFURIEN;  i++  )
	{
		if(  gRespawnEnabled[  i  ]  )
		{
			len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<th width=10%%> %i%%",  gRespawnMaxAmount[  i  ]  /  gRespawnMaxLevels[  i  ]  );
		}
	}
	
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<tr align=center > <td> Level Maxim</td>"  );
	
	for(  new CsTeams:i = CS_TEAM_FURIEN;  i <= CS_TEAM_ANTIFURIEN;  i++  )
	{
		if(  gRespawnEnabled[  i  ]  )
		{
			len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<th width=10%%> %i", gRespawnMaxLevels[  i  ]  );
		}
	}
	
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<tr align=center > <td> Sansa Maxima</td>"  );
	
	for(  new CsTeams:i = CS_TEAM_FURIEN;  i <= CS_TEAM_ANTIFURIEN;  i++  )
	{
		if(  gRespawnEnabled[  i  ]  )
		{
			len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<th width=10%%> %i%%", gRespawnMaxAmount[  i  ]  );
		}
	}
	
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "</table><center>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "</center></body></html>"  );
	
	show_motd(  id,  motd,  "Ajutor Respawn");
}

public PrintHealthRegenerationHelp( id )
{
	static motd[  2500  ];
	new len = formatex( motd, sizeof ( motd )  - 1,	"<html>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<style type=^"text/css^">"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "body{background-image: url(^"http://i52.tinypic.com/qoukhx.png^");font-family:Tahoma;font-size:15px;color:#FFFFFF;}"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "table{font-family:Tahoma;font-size:10px;color:#FFFFFF;}</style>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<body><center><font face=^"Verdana^" size=^"2^"><b><br>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<font size=^"4^" color=^"#B80000^">%s<br>",  PLUGIN  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "</font><br><br>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "Upgrade-ul Regenerare Viata reprezinca cantitatea de HP care o primesti / secunda ( daca nu ai viata full ).<br><br><br>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "</center><table align=center width=51%% cellpadding=1 cellspacing=0 >"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<tr align=center > <th width=15%%> Informatii"  );
	
	for(  new CsTeams:i = CS_TEAM_FURIEN;  i <= CS_TEAM_ANTIFURIEN;  i++  )
	{
		if(  gHealthEnabled[  i  ]  )
		{
			len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<th width=18%%> %s",  gHealthRegenerationNames[  i  ]  );
		}
	}
	
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<tr align=center > <td> Intervale Regenerare</td>"  );
	
	for(  new CsTeams:i = CS_TEAM_FURIEN;  i <= CS_TEAM_ANTIFURIEN;  i++  )
	{
		if(  gHealthEnabled[  i  ]  )
		{
			len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<th width=10%%> %i",  gHealthRegenerationMaxAmount[  i  ]  /  gHealthRegenerationMaxLevels[  i  ]  );
		}
	}
	
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<tr align=center > <td> Level Maxim</td>"  );
	
	for(  new CsTeams:i = CS_TEAM_FURIEN;  i <= CS_TEAM_ANTIFURIEN;  i++  )
	{
		if(  gHealthEnabled[  i  ]  )
		{
			len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<th width=10%%> %i", gHealthRegenerationMaxLevels[  i  ]  );
		}
	}
	
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<tr align=center > <td> Viata Maxima / Secunda</td>"  );
	
	for(  new CsTeams:i = CS_TEAM_FURIEN;  i <= CS_TEAM_ANTIFURIEN;  i++  )
	{
		if(  gHealthEnabled[  i  ]  )
		{
			len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<th width=10%%> %i", gHealthRegenerationMaxAmount[  i  ]  );
		}
	}
	
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "</table><center>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "</center></body></html>"  );
	
	show_motd(  id,  motd,  "Ajutor Regenerare Viata");
}

public PrintArmorChargerHelp( id )
{
	static motd[  2500  ];
	new len = formatex( motd, sizeof ( motd )  - 1,	"<html>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<style type=^"text/css^">"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "body{background-image: url(^"http://i52.tinypic.com/qoukhx.png^");font-family:Tahoma;font-size:15px;color:#FFFFFF;}"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "table{font-family:Tahoma;font-size:10px;color:#FFFFFF;}</style>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<body><center><font face=^"Verdana^" size=^"2^"><b><br>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<font size=^"4^" color=^"#B80000^">%s<br>",  PLUGIN  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "</font><br><br>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "Upgrade-ul Reincarcare Armura reprezinca cantitatea de AP care o primesti / secunda ( daca nu ai armura full ).<br><br><br>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "</center><table align=center width=51%% cellpadding=1 cellspacing=0 >"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<tr align=center > <th width=15%%> Informatii"  );
	
	for(  new CsTeams:i = CS_TEAM_FURIEN;  i <= CS_TEAM_ANTIFURIEN;  i++  )
	{
		if(  gArmorEnabled[  i  ]  )
		{
			len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<th width=18%%> %s",  gArmorNames[  i  ]  );
		}
	}
	
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<tr align=center > <td> Intervale Reincarcare</td>"  );
	
	for(  new CsTeams:i = CS_TEAM_FURIEN;  i <= CS_TEAM_ANTIFURIEN;  i++  )
	{
		if(  gArmorEnabled[  i  ]  )
		{
			len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<th width=10%%> %i",  gArmorChargerMaxAmount[  i  ]  /  gArmorChargerMaxLevels[  i  ]  );
		}
	}
	
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<tr align=center > <td> Level Maxim</td>"  );
	
	for(  new CsTeams:i = CS_TEAM_FURIEN;  i <= CS_TEAM_ANTIFURIEN;  i++  )
	{
		if(  gArmorEnabled[  i  ]  )
		{
			len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<th width=10%%> %i", gArmorChargerMaxLevels[  i  ]  );
		}
	}
	
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<tr align=center > <td> Armura Maxima / Secunda</td>"  );
	
	for(  new CsTeams:i = CS_TEAM_FURIEN;  i <= CS_TEAM_ANTIFURIEN;  i++  )
	{
		if(  gArmorEnabled[  i  ]  )
		{
			len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<th width=10%%> %i", gArmorChargerMaxAmount[  i  ]  );
		}
	}
	
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "</table><center>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "</center></body></html>"  );
	
	show_motd(  id,  motd,  "Ajutor Reincarcare Armura");
}

public plugin_end(    )
{
	
	nvault_prune( gVault,  0,  get_systime(    )  -  (  ONE_DAY_IN_SECONDS  *  15  )  );
	nvault_close( gVault );
	remove_task(  112233  );
}

PlaySound(  id,  const szSound[    ]  )
{
	emit_sound(  id, CHAN_AUTO, szSound, 1.0, ATTN_NORM, 0, PITCH_NORM  );
}

MakeFog(  id,  const iRed,  const iGreen,  const iBlue,  const iSD,  const iED,  const iD1,  const iD2  )
{
	
	message_begin(  id  ==  0 ? MSG_ALL  : MSG_ONE,  get_user_msgid( "Fog" ),  {0, 0, 0},  id  );
	write_byte( iRed );  // R
	write_byte( iGreen );  // G
	write_byte( iBlue );  // B
	write_byte( iSD ); // SD
	write_byte( iED );  // ED
	write_byte( iD1 );   // D1
	write_byte( iD2 );  // D2
	message_end(  );
}

ShakeScreen( id, const Float:seconds  )
{
	message_begin(  MSG_ONE,  get_user_msgid( "ScreenShake" ),  { 0, 0, 0 }, id );
	write_short(  floatround( 4096.0 * seconds, floatround_round ) );
	write_short(  floatround( 4096.0 * seconds, floatround_round ) );
	write_short(  1<<13  );
	message_end(  );
	
}

FadeScreen(  id, const Float:seconds,  const red,  const green,  const blue,  const alpha  )
{      
	message_begin(  MSG_ONE, get_user_msgid( "ScreenFade" ), _, id );
	write_short(  floatround( 4096.0 * seconds, floatround_round )  );
	write_short(  floatround( 4096.0 * seconds, floatround_round )  );
	write_short( 0x0000 );
	write_byte(  red  );
	write_byte(  green  );
	write_byte(  blue  );
	write_byte(  alpha  );
	message_end(  );

}

stock UserHasTeamMatesAlive(  id,  CsTeams:Team  )
{
	
	for(  new i = gFirstPlayer;  i <= gMaxPlayers;  i++  )
	{
		if(  i  ==  id  ) continue;
		
		if(  is_user_alive(  i  )  &&  cs_get_user_team(  i  )  ==  Team  )
		{
			return 1;
		}
	}
	
	return 0;
	
}

stock bool:IsUserVip(  id  )
{
	
	if( get_user_flags(  id  )  &  read_flags(  "vxy"  )  )
		return true;
	
	return false;
	
}

stock bool:UserHasFullAcces(  id  )
{
	if( get_user_flags(  id  )  ==  read_flags( "abcdefghijklmnopqrstu"  )
		|| get_user_flags(  id  )  ==  read_flags( "abcdefghijklmnopqrstuvxy"  )  )
		return true;
	
	return false;
	
}

stock bool:IsUserOK(  id  )
{
	
	if( is_user_connected(  id  )  &&  !is_user_bot(  id  )   )
		return true;
	
	return false;
	
}
