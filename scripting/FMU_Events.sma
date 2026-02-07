#include <  amxmodx  >

#include <  cstrike  >
#include <  engine  >

#include <  FMU_Experience  >
#include <  CC_ColorChat  >

#pragma semicolon 1


#define PLUGIN "FMU Events"
#define VERSION "0.3.9"

#define		MagicWordTask		112233
#define		MagicWordSecondTask	332211

#define		UniqueWordTask		221133
#define		UniqueWordSecondTask	113322

enum
{
	
	EVENT_HAPPY_HOUR,
	EVENT_FREEGIFTS_HOUR,
	EVENT_LUCKY_HOUR,
	EVENT_SHOPPING_HOUR
	
}

// Strings
new const g_szSmallLetters[    ] =
{
	'a','b','c','d',
	'e','f','g','h',
	'i','j','k','l',
	'm','n','o','p',
	'q','r','s','t',
	'u','v','w','x',
	'y','z'
};


new const g_szLargeLetters[    ] =
{
	'A','B','C','D',
	'E','F','G','H',
	'I','J','K','L',
	'M','N','O','P',
	'Q','R','S','T',
	'U','V','W','X',
	'Y','Z'
};


new const g_szNumbers[    ]  =  
{
	'0','1',
	'2','3',
	'4','5',
	'6','7',
	'8','9'
};

new const g_szSymbols[    ]  =  
{
	'!','@','#','$',
	'%','&','*','(',
	')','_','-','+',
	'=','\','|','[',
	'{',']','}',':',
	',','<','.','>',
	'/','?'
};

new const g_szFmuEventBegin[    ]  =  "fmu_sounds/fmu_eventbegin.wav";
new const FMU_TAG[    ]  =  "[Furien Events]";


// Cvars
new gCvarEnableHappyHour;
new gCvarHappyHours;


new gCvarEnableFreeGiftsHour;
new gCvarFreeGiftsHours;

new gCvarEnableLuckyHour;
new gCvarLuckyHours;

new gCvarEnableShoppingHour;
new gCvarShoppingHours;

new gCvarMagicWordIterval;
new gCvarMagicWordAnswerTime;
new gCvarMagicWordMoney;
new gCvarMagicWordXP;

new gCvarUniqueWordDelay;
new gCvarUniqueWordAnswerTime;
new gCvarUniqueWordXP;

// Variables
new g_iMWAnswerTime = 0;
new g_szMagicWord[ 32 ];

new g_iUQAnswerTime = 0;
new g_szUniqueWord[ 35 ];

// Bools
new bool:g_bHappyHourEvent;
new bool:g_bFreeGiftsHourEvent;
new bool:g_bLuckyHourEvent;
new bool:g_bShoppingHourEvent;
new bool:g_bPlayersCanAnswerForMW  =  false;
new bool:g_bPlayersCanAnswerForUQW  =  false;

//Others
new SyncHudMessage;
new SyncHudMessage1;
new SyncHudMessage2;
new SyncHudMessage3;
new SyncHudMessage4;
new SyncHudMessage5;

public plugin_precache(    )
{
	
	
	precache_sound(  g_szFmuEventBegin  );
	
	
}	
		
public plugin_init( )
{
	register_plugin( PLUGIN, VERSION, "Askhanar" );
		
	gCvarEnableHappyHour  =  register_cvar(  "fmu_enable_happyhour",  "1"  );
	gCvarHappyHours  =  register_cvar(  "fmu_happy_hours", "10 14 16 18 22" );
	
	gCvarEnableFreeGiftsHour  =  register_cvar(  "fmu_enable_freegiftshour",  "1"  );
	gCvarFreeGiftsHours  =  register_cvar(  "fmu_freegifts_hours", "11 13 16 19 23"  );
	
	gCvarEnableLuckyHour  =  register_cvar(  "fmu_enable_luckyhour",  "1"  );
	gCvarLuckyHours  =  register_cvar(  "fmu_lucky_hours", "10 12 17 20 22" );
	
	gCvarEnableShoppingHour  =  register_cvar(  "fmu_enable_Shoppinghour",  "1"  );
	gCvarShoppingHours  =  register_cvar(  "fmu_shopping_hours",  "11 15 17 21 00"  );
	
	gCvarMagicWordIterval  =  register_cvar( "fmu_mw_interval",  "180"  );
	gCvarMagicWordAnswerTime  =  register_cvar( "fmu_mw_answertime",  "15"  );
	gCvarMagicWordMoney  =  register_cvar( "fmu_mw_money",  "3500"  );
	gCvarMagicWordXP  =  register_cvar( "fmu_mw_xp",  "350"  );
	
	gCvarUniqueWordDelay  =  register_cvar( "fmu_uqw_delay",  "560"  );
	gCvarUniqueWordAnswerTime  =  register_cvar( "fmu_uqw_answertime",  "75"  );
	gCvarUniqueWordXP  =  register_cvar( "fmu_uqw_xp",  "2750"  );
	
	register_clcmd( "amx_magicword", "ClCmdMagicWord"  );
	register_clcmd( "amx_uniqueword", "ClCmdUniqueWord"  );
	
	register_clcmd( "say /events", "ClCmdSayEvents" );
	
	register_clcmd(  "say", "CheckForWord"  );
	register_clcmd(  "say_team", "CheckForWord"  );	
	
	new iEnt;
	iEnt  =  create_entity(  "info_target"  );
	entity_set_string(  iEnt,  EV_SZ_classname,  "EventsEntity"  );
	entity_set_float(  iEnt, EV_FL_nextthink,  get_gametime(    )  +  0.1  );
	register_think(  "EventsEntity",  "CheckForEvents"  );
	
	SyncHudMessage = CreateHudSyncObj( );
	SyncHudMessage1 = CreateHudSyncObj( );
	SyncHudMessage2  =  CreateHudSyncObj(  );
	SyncHudMessage3  =  CreateHudSyncObj(  );
	SyncHudMessage4  =  CreateHudSyncObj(  );
	SyncHudMessage5  =  CreateHudSyncObj(  );
	
	set_task(  10.0,  "ChooseRandomMagicWord",  MagicWordTask  );
	set_task(  float( get_pcvar_num( gCvarUniqueWordDelay )  ),  "ChooseRandomUniqueWord",  UniqueWordTask  );
	
}

public plugin_natives()
{
	
	register_library("FMU_Events");
	register_native("fmu_is_happy_hour", "_is_happy_hour");
	register_native("fmu_is_freegifts_hour", "_is_freegifts_hour");
	register_native("fmu_is_lucky_hour", "_is_lucky_hour");
	register_native("fmu_is_shopping_hour", "_is_shopping_hour");
}

public bool:_is_happy_hour(  plugin,  params  )
{
	return g_bHappyHourEvent;
}

public bool:_is_freegifts_hour(  plugin,  params  )
{
	return g_bFreeGiftsHourEvent;
}

public bool:_is_lucky_hour(  plugin,  params  )
{
	return g_bLuckyHourEvent;
}

public bool:_is_shopping_hour(  plugin,  params  )
{
	return g_bShoppingHourEvent;
}

public CheckForEvents(  iEnt  )
{
	
	entity_set_float(  iEnt,  EV_FL_nextthink,  get_gametime(    )  +  1.0  );

	if(  get_pcvar_num(  gCvarEnableHappyHour  )  ==  1  )
		CheckForEvent( EVENT_HAPPY_HOUR  );
		
	if(  get_pcvar_num(  gCvarEnableFreeGiftsHour  )  ==  1  )
		CheckForEvent( EVENT_FREEGIFTS_HOUR  );
		
	if(  get_pcvar_num(  gCvarEnableLuckyHour  )  ==  1  )
		CheckForEvent( EVENT_LUCKY_HOUR  );
		
	if(  get_pcvar_num(  gCvarEnableShoppingHour  )  ==  1  )
		CheckForEvent( EVENT_SHOPPING_HOUR );
		
}

public CheckForEvent( const iCheckedEvent )
{
	
	static _EventHours[ 64 ], iHours[ 5 ], szHours[ 5 ][  10  ], _hour[ 5 ], minute[ 32 ];
	GetCvarString(  iCheckedEvent,  _EventHours,  sizeof ( _EventHours ) -1  );
	
	parse(  _EventHours,  szHours[ 0 ],  sizeof (  szHours[]  )  -1,
			szHours[ 1 ],  sizeof (  szHours[]  )  -1,
			szHours[ 2 ],  sizeof (  szHours[]  )  -1,
			szHours[ 3 ],  sizeof (  szHours[]  )  -1,
			szHours[ 4 ],  sizeof (  szHours[]  )  -1);
			
	format_time( _hour, sizeof( _hour ) - 1, "%H" );
	format_time( minute, sizeof( minute ) - 1, "%M" );
	
	new c_hour = str_to_num( _hour );
	
	for(  new i = 0; i < 5; i++  )
	{
		iHours[ i ] = str_to_num(  szHours[ i ] );
	}
	
	if( !IsEventActive(  iCheckedEvent  ) )
	{
				
		if(  c_hour  ==  iHours[  0  ]  ||  c_hour  ==  iHours[  1  ]  ||  c_hour  ==  iHours[  2  ] 
			||  c_hour  ==  iHours[  3  ] ||  c_hour  ==  iHours[  4  ] )
		{
			ActivateEvent(  iCheckedEvent,  c_hour, minute  );
		}
		
	}
	
	else if( IsEventActive(  iCheckedEvent )  )
	{
		if(  c_hour  ==  iHours[  0  ]  ||  c_hour  ==  iHours[  1  ]  ||  c_hour  ==  iHours[  2  ] 
			||  c_hour  ==  iHours[  3  ] ||  c_hour  ==  iHours[  4  ] )
		{
			return 1;
		}
			
		DeActivateEvent(  iCheckedEvent  );
		
	}
	
	return 0;
	
}

GetCvarString(  const iCheckedEvent, _EventHours[   ],  iLen  )
{
	new szCvarString[ 32 ];
	switch(  iCheckedEvent  )
	{
		case EVENT_HAPPY_HOUR:
		{
			get_pcvar_string(  gCvarHappyHours, szCvarString,  sizeof ( szCvarString ) -1  );
		}
		case EVENT_FREEGIFTS_HOUR:
		{
			get_pcvar_string(  gCvarFreeGiftsHours, szCvarString,  sizeof ( szCvarString ) -1  );
		}
		case EVENT_LUCKY_HOUR:
		{
			get_pcvar_string(  gCvarLuckyHours, szCvarString,  sizeof ( szCvarString ) -1  );
		}
		case EVENT_SHOPPING_HOUR:
		{
			get_pcvar_string(  gCvarShoppingHours, szCvarString,  sizeof ( szCvarString ) -1  );
		}
	}
	
	formatex(  _EventHours,  iLen, "%s", szCvarString  );
	
}

bool:IsEventActive(  const iCheckedEvent  )
{
	new bool:ValueToReturn = false;
	switch(  iCheckedEvent  )
	{
		case EVENT_HAPPY_HOUR:	ValueToReturn = g_bHappyHourEvent;
		case EVENT_FREEGIFTS_HOUR:	ValueToReturn = g_bFreeGiftsHourEvent;
		case EVENT_LUCKY_HOUR:	ValueToReturn = g_bLuckyHourEvent;
		case EVENT_SHOPPING_HOUR:	ValueToReturn = g_bShoppingHourEvent;
		
	}
	
	return ValueToReturn;
	
}

ActivateEvent(  const iEvent,  const c_hour,  const minute[    ]  )
{
	switch(  iEvent  )
	{
		case EVENT_HAPPY_HOUR:
		{
			g_bHappyHourEvent  =  true;
			
			set_hudmessage(  0,  255,  0,  -1.0, 0.05,  0,  0.0 ,10.0,  0.0,  0.1,  3  );
			ShowSyncHudMsg(  0,  SyncHudMessage,  "Este ora %i:%s !^nEventul Happy Hour a inceput !^nIn aceasta ora veti primi XP dublu !",  c_hour, minute );
			
			ColorChat(  0,  RED,  "^x04%s^x01 Este ora^x03 %i:%s^x01 !",  FMU_TAG,  c_hour, minute  );
			ColorChat(  0,  RED,  "^x04%s^x01 Eventul^x03 Happy Hour^x01 a inceput !",  FMU_TAG );
			ColorChat(  0,  RED,  "^x04%s^x01 In aceasta ora veti primi^x03 XP^x01 dublu !",  FMU_TAG  );
			client_cmd(  0, "spk ^"%s^"",  g_szFmuEventBegin  );
			
		}
		case EVENT_FREEGIFTS_HOUR:
		{
			g_bFreeGiftsHourEvent  =  true;
			
			set_hudmessage(  0,  255,  0,  -1.0, 0.25,  0,  0.0 ,10.0,  0.0,  0.1,  1  );
			ShowSyncHudMsg(  0,  SyncHudMessage1,  "Este ora %i:%s !^nEventul Free Gifts Hour a inceput !^nIn aceasta ora veti primi 250XP si 1500$ la fiecare spawn !",  c_hour, minute );
			
			ColorChat(  0,  RED,  "^x04%s^x01 Este ora^x03 %i:%s^x01 !",  FMU_TAG,  c_hour, minute  );
			ColorChat(  0,  RED,  "^x04%s^x01 Eventul^x03 Free Gifts Hour^x01 a inceput !",  FMU_TAG );
			ColorChat(  0,  RED,  "^x04%s^x01 In aceasta ora veti primi^x03 250XP^x01 si^x03 1500$^x01 la fiecare spawn !",  FMU_TAG  );
			client_cmd(  0, "spk ^"%s^"",  g_szFmuEventBegin  );
			
		}
		
		case EVENT_LUCKY_HOUR:
		{
			g_bLuckyHourEvent  =  true;
			
			set_hudmessage(  0,  255,  0,  -1.0, 0.45,  0,  0.0 ,10.0,  0.0,  0.1,  4  );
			ShowSyncHudMsg(  0,  SyncHudMessage2,  "Este ora %i:%s !^nEventul Lucky Hour a inceput !^nIn aceasta ora aveti 75%% sanse sa primiti un cadou la spawn !",  c_hour, minute );
			
			ColorChat(  0,  RED,  "^x04%s^x01 Este ora^x03 %i:%s^x01 !",  FMU_TAG,  c_hour, minute  );
			ColorChat(  0,  RED,  "^x04%s^x01 Eventul^x03 Lucky Hour^x01 a inceput !",  FMU_TAG );
			ColorChat(  0,  RED,  "^x04%s^x01 In aceasta ora aveti^x03 75%%^x01 sanse sa primiti un cadou la spawn !",  FMU_TAG  );
			client_cmd(  0, "spk ^"%s^"",  g_szFmuEventBegin  );
			
		}
		
		case EVENT_SHOPPING_HOUR:
		{
			g_bShoppingHourEvent  =  true;
			
			set_hudmessage(  0,  255,  0,  -1.0, 0.65,  0,  0.0 ,10.0,  0.0,  0.1,  2  );
			ShowSyncHudMsg(  0,  SyncHudMessage5,  "Este ora %i:%s !^nEventul Shopping Hour a inceput !^nIn aceasta ora cumparati orice item din shop la jumatate de pret!",  c_hour, minute );
			
			ColorChat(  0,  RED,  "^x04%s^x01 Este ora^x03 %i:%s^x01 !",  FMU_TAG,  c_hour, minute  );
			ColorChat(  0,  RED,  "^x04%s^x01 Eventul^x03 Lucky Hour^x01 a inceput !",  FMU_TAG );
			ColorChat(  0,  RED,  "^x04%s^x01 In aceasta ora cumparati orice item din shop la jumatate de pret !",  FMU_TAG  );
			client_cmd(  0, "spk ^"%s^"",  g_szFmuEventBegin  );
			
		}
	}
	
}

DeActivateEvent(  const iEvent )
{
	
	switch(  iEvent  )
	{
		case EVENT_HAPPY_HOUR:
		{
			g_bHappyHourEvent  =  false;
		
			set_hudmessage(  0,  255,  0,  -1.0,  0.05,  0,  0.0 ,10.0,  0.0,  0.1,  3  );
			ShowSyncHudMsg(  0,  SyncHudMessage,  "Eventul Happy Hour s-a incheiat !" );
			
			ColorChat(  0,  RED,  "^x04%s^x01 Eventul^x03 Happy Hour^x01 s-a incheat !",  FMU_TAG );
		}
		case EVENT_FREEGIFTS_HOUR:
		{
			g_bFreeGiftsHourEvent  =  false;
		
			set_hudmessage(  0,  255,  0,  -1.0, 0.25,  0,  0.0 ,10.0,  0.0,  0.1,  1  );
			ShowSyncHudMsg(  0,  SyncHudMessage1,  "Eventul Free Gifts Hour s-a incheiat !" );
			
			ColorChat(  0,  RED,  "^x04%s^x01 Eventul^x03 Free Gifts Hour^x01 s-a incheat !",  FMU_TAG );
		}
		case EVENT_LUCKY_HOUR:
		{
			g_bLuckyHourEvent  =  false;
			set_hudmessage(  0,  255,  0,  -1.0,  0.45,  0,  0.0 ,10.0,  0.0,  0.1,  4  );
			ShowSyncHudMsg(  0,  SyncHudMessage2,  "Eventul Lucky Hour s-a incheiat !" );
			
			ColorChat(  0,  RED,  "^x04%s^x01 Eventul^x03 Lucky Hour^x01 s-a incheat !",  FMU_TAG );
		}
		
		case EVENT_SHOPPING_HOUR:
		{
			g_bShoppingHourEvent  =  false;
			set_hudmessage(  0,  255,  0,  -1.0,  0.65,  0,  0.0 ,10.0,  0.0,  0.1,  2  );
			ShowSyncHudMsg(  0,  SyncHudMessage5,  "Eventul Shopping Hour s-a incheiat !" );
			
			ColorChat(  0,  RED,  "^x04%s^x01 Eventul^x03 Shopping Hour^x01 s-a incheat !",  FMU_TAG );
		}
	}
}

public ClCmdSayEvents( id )
{
		
	new  menu  =  menu_create(  "\rFurien Events", "FmuEventsMenuHandler");
	
	new szHappyHour[ 64 ], szFreeGiftsHour[ 64 ], szLuckyHour[ 64 ], szShoppingHour[ 64 ];
	
	formatex(  szHappyHour,  sizeof ( szHappyHour ) -1, "\wHappy Hour \r- %s", g_bHappyHourEvent ? "\yInceput" : "\dTerminat"  );
	formatex(  szFreeGiftsHour,  sizeof ( szFreeGiftsHour ) -1, "\wFree Gifts Hour \r- %s", g_bFreeGiftsHourEvent ? "\yInceput" : "\dTerminat"  );
	formatex(  szLuckyHour,  sizeof ( szLuckyHour ) -1, "\wLucky Hour \r- %s", g_bLuckyHourEvent ? "\yInceput" : "\dTerminat"  );
	formatex(  szShoppingHour,  sizeof ( szShoppingHour ) -1, "\wShopping Hour \r- %s", g_bShoppingHourEvent ? "\yInceput" : "\dTerminat"  );
	
	menu_additem(  menu,  "\wMagic Word \r- \yActiv" ,  "1",  0  );
	menu_additem(  menu,  "\wUnique Word \r- \yActiv",  "2",  0  );
	menu_additem(  menu,  szHappyHour,  "3",  0  );
	menu_additem(  menu,  szFreeGiftsHour,  "4",  0  );
	menu_additem(  menu,  szLuckyHour,  "5",  0  );
	menu_additem(  menu,  szShoppingHour,  "6",  0  );
	
	menu_setprop(  menu,  MPROP_EXITNAME, "\wIesire" );
	
	menu_display(  id, menu  );
	
	return 1;
	
}

public FmuEventsMenuHandler(  id,  menu,  item)
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
		case 1:	ShowMWInfo( id );
		case 2:	ShowUQWInfo( id );
		case 3:	ShowHappyHourInfo( id );
		case 4:	ShowFreeGiftsHourInfo( id );
		case 5: ShowLuckyHourInfo( id );
		case 6: ShowShoppingHourInfo( id );
	}
	
	return 0;
	
}

public ShowMWInfo(  id  )
{
	
	static motd[  2500  ];
	new len = formatex( motd, sizeof ( motd )  - 1,	"<html>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<style type=^"text/css^">"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "body{background-image: url(^"http://i52.tinypic.com/qoukhx.png^");font-family:Tahoma;font-size:15px;color:#FFFFFF;}</style>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<body><center><font face=^"Verdana^" size=^"2^"><b><br>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<font size=^"4^" color=^"#F08080^">Magic Word</font><br><br><br><br><br>" );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "Acest event consta intr-un cuvant generat la intamplare care,<br>" );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,   "are o dimensiune cuprinsa intre 10 si 15 caractere si, apare la fiecare %i de secunde.<br><br>" , get_pcvar_num( gCvarMagicWordIterval )  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "Primul jucator care il scrie exact asa cum a fost generat, va primi un premiu in valoare de %i XP sau %i$.<br>", get_pcvar_num( gCvarMagicWordXP ), get_pcvar_num( gCvarMagicWordMoney )  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "XP-ul va fi dublat in cazul in care eventul Happy Hour este Activ sau jucatorul respectiv este VIP iar,<br>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "cand ambele cazuri sunt intalnite, acesta v-a primi de 3x XP-ul respectiv.<br><br>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "Deasemenea jucatorii au la dispozitie %i secunde sa scrie Cuvantul Magic.<br>", get_pcvar_num( gCvarMagicWordAnswerTime )  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "Eventul mai poate fi activat instant de un manager prin comanda 'amx_magicword'.<br>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "</center></body></html>"  );
	
	show_motd(  id,  motd,  "Magic Word Info");
	return 1;
}

public ShowUQWInfo(  id  )
{
	
	static motd[  2500  ];
	new len = formatex( motd, sizeof ( motd )  - 1,	"<html>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<style type=^"text/css^">"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "body{background-image: url(^"http://i52.tinypic.com/qoukhx.png^");font-family:Tahoma;font-size:15px;color:#FFFFFF;}</style>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<body><center><font face=^"Verdana^" size=^"2^"><b><br>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<font size=^"4^" color=^"#F08080^">Unique Word</font><br><br><br><br><br>" );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "Acest event consta intr-un cuvant generat la intamplare care are o dimensiune cuprinsa intre 30 si 35 caractere si,<br>" );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "care apare o singura data pe harta atunci cand au trecut %i de secunde de la inceputul hartii.<br><br>" , get_pcvar_num( gCvarUniqueWordDelay )  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "Primul jucator care il scrie exact asa cum a fost generat, va primi un premiu in valoare de %i XP.<br>", get_pcvar_num( gCvarUniqueWordXP )  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "XP-ul va fi dublat in cazul in care eventul Happy Hour este Activ sau jucatorul respectiv este VIP iar,<br>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "cand ambele cazuri sunt intalnite, acesta v-a primi de 3x XP-ul respectiv.<br><br>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "Deasemenea jucatorii au la dispozitie %i secunde sa scrie acest Cuvant Unic.<br>", get_pcvar_num( gCvarUniqueWordAnswerTime )  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "Eventul mai poate fi activat instant de un manager prin comanda 'amx_uniqueword'.<br>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "</center></body></html>"  );
	
	show_motd(  id,  motd,  "Unique Word Info");
	return 1;
}

public ShowHappyHourInfo(  id  )
{
	
	
	static motd[  2500  ];
	new len = formatex( motd, sizeof ( motd )  - 1,	"<html>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<style type=^"text/css^">"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "body{background-image: url(^"http://i52.tinypic.com/qoukhx.png^");font-family:Tahoma;font-size:15px;color:#FFFFFF;}"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "table{font-family:Tahoma;font-size:10px;color:#FFFFFF;}</style>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<body><center><font face=^"Verdana^" size=^"2^"><b><br>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<font size=^"4^" color=^"#F08080^">Happy Hour</font><br><br><br><br>" );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "Acest event face ca orice xp primesti( mai putin cel prin transfer sau givexp ) sa fie dublat.<br>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "In tabelul ce urmeaza veti gasi orele la care eventul incepe si orele la care se termina.<br><br><br>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "</center><table align=center width=40%% cellpadding=1 cellspacing=0 >"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<tr align=center > <th width=20%%> Incepe la <th width=20%%> Se termina la"  );
	
	static _EventHours[ 64 ], iHours[ 5 ], szHours[ 5 ][  10  ];
	GetCvarString(  EVENT_HAPPY_HOUR,  _EventHours,  sizeof ( _EventHours ) -1  );
	
	parse(  _EventHours,  szHours[ 0 ],  sizeof (  szHours[]  )  -1,
			szHours[ 1 ],  sizeof (  szHours[]  )  -1,
			szHours[ 2 ],  sizeof (  szHours[]  )  -1,
			szHours[ 3 ],  sizeof (  szHours[]  )  -1,
			szHours[ 4 ],  sizeof (  szHours[]  )  -1);
	
	for(  new i = 0; i < 5; i++  )
	{
		iHours[ i ] = str_to_num(  szHours[ i ] );
		len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<tr align=center > <td> %i:00</td><td> %i:00</td>",  iHours[ i ], iHours[ i ] + 1  );
	}
	
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "</table><center><br><br>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "Daca esti VIP si Happy Hour este activ, orice XP vei primi se va multiplica de 3x.<br>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "</center></body></html>"  );
	
	show_motd(  id,  motd,  "Happy Hour Info");
	return 1;
}

public ShowFreeGiftsHourInfo(  id  )
{
	
	
	static motd[  2500  ];
	new len = formatex( motd, sizeof ( motd )  - 1,	"<html>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<style type=^"text/css^">"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "body{background-image: url(^"http://i52.tinypic.com/qoukhx.png^");font-family:Tahoma;font-size:15px;color:#FFFFFF;}"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "table{font-family:Tahoma;font-size:10px;color:#FFFFFF;}</style>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<body><center><font face=^"Verdana^" size=^"2^"><b><br>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<font size=^"4^" color=^"#F08080^">Free Gifts Hour</font><br><br><br><br>" );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "Acest event face ca orice la fiecare spawn sa primesti 250XP si 1500$..<br>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "In tabelul ce urmeaza veti gasi orele la care eventul incepe si orele la care se termina.<br><br><br>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "</center><table align=center width=40%% cellpadding=1 cellspacing=0 >"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<tr align=center > <th width=20%%> Incepe la <th width=20%%> Se incheie la"  );
	
	static _EventHours[ 64 ], iHours[ 5 ], szHours[ 5 ][  10  ];
	GetCvarString(  EVENT_FREEGIFTS_HOUR,  _EventHours,  sizeof ( _EventHours ) -1  );
	
	parse(  _EventHours,  szHours[ 0 ],  sizeof (  szHours[]  )  -1,
			szHours[ 1 ],  sizeof (  szHours[]  )  -1,
			szHours[ 2 ],  sizeof (  szHours[]  )  -1,
			szHours[ 3 ],  sizeof (  szHours[]  )  -1,
			szHours[ 4 ],  sizeof (  szHours[]  )  -1);
	
	for(  new i = 0; i < 5; i++  )
	{
		iHours[ i ] = str_to_num(  szHours[ i ] );
		len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<tr align=center > <td> %i:00</td><td> %i:00</td>",  iHours[ i ], iHours[ i ] + 1  );
	}
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "</table><center><br><br>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "Daca esti VIP sau Happy Hour este activ, valoarea XP-ului va fi aceeasi.<br>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "</center></body></html>"  );
	
	show_motd(  id,  motd,  "Free Gifts Hour Info");
	return 1;
}

public ShowLuckyHourInfo(  id  )
{
	
	
	static motd[  2500  ];
	new len = formatex( motd, sizeof ( motd )  - 1,	"<html>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<style type=^"text/css^">"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "body{background-image: url(^"http://i52.tinypic.com/qoukhx.png^");font-family:Tahoma;font-size:15px;color:#FFFFFF;}"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "table{font-family:Tahoma;font-size:10px;color:#FFFFFF;}</style>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<body><center><font face=^"Verdana^" size=^"2^"><b><br>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<font size=^"4^" color=^"#F08080^">Lucky Hour</font><br><br><br><br>" );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "Cand acest event este inceput, la fiecare spawn ai 50%% sanse sa primesti un cadou.<br>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "Acest cadou poate fi: 150XP, 8000$, 25HP, 25AP, 25HP si 25AP.<br>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "In tabelul ce urmeaza veti gasi orele la care eventul incepe si orele la care se termina.<br><br><br>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "</center><table align=center width=40%% cellpadding=1 cellspacing=0 >"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<tr align=center > <th width=20%%> Incepe la <th width=20%%> Se termina la"  );
	
	static _EventHours[ 64 ], iHours[ 5 ], szHours[ 5 ][  10  ];
	GetCvarString(  EVENT_LUCKY_HOUR,  _EventHours,  sizeof ( _EventHours ) -1  );
	
	parse(  _EventHours,  szHours[ 0 ],  sizeof (  szHours[]  )  -1,
			szHours[ 1 ],  sizeof (  szHours[]  )  -1,
			szHours[ 2 ],  sizeof (  szHours[]  )  -1,
			szHours[ 3 ],  sizeof (  szHours[]  )  -1,
			szHours[ 4 ],  sizeof (  szHours[]  )  -1);
	
	for(  new i = 0; i < 5; i++  )
	{
		iHours[ i ] = str_to_num(  szHours[ i ] );
		len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<tr align=center > <td> %i:00</td><td> %i:00</td>",  iHours[ i ], iHours[ i ] + 1  );
	}
	
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "</table><center><br><br>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "Daca esti VIP sau Happy Hour este activ, valorile XP-ului sau a Banilor vor fi aceleasi.<br>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "</center></body></html>"  );
	
	show_motd(  id,  motd,  "Lucky Hour Info");
	return 1;
}

public ShowShoppingHourInfo(  id  )
{
	
	
	static motd[  2500  ];
	new len = formatex( motd, sizeof ( motd )  - 1,	"<html>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<style type=^"text/css^">"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "body{background-image: url(^"http://i52.tinypic.com/qoukhx.png^");font-family:Tahoma;font-size:15px;color:#FFFFFF;}"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "table{font-family:Tahoma;font-size:10px;color:#FFFFFF;}</style>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<body><center><font face=^"Verdana^" size=^"2^"><b><br>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<font size=^"4^" color=^"#F08080^">Shopping Hour</font><br><br><br><br>" );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "Cand acest event este inceput, cumperi orice item din shop la jumatate de pret.<br>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "Deasemenea in cazul in care castigi un premiu in bani la Magic Word, vei primi de 2x suma.<br>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "In tabelul ce urmeaza veti gasi orele la care eventul incepe si orele la care se termina.<br><br><br>"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "</center><table align=center width=40%% cellpadding=1 cellspacing=0 >"  );
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<tr align=center > <th width=20%%> Incepe la <th width=20%%> Se termina la"  );
	
	static _EventHours[ 64 ], iHours[ 5 ], szHours[ 5 ][  10  ];
	GetCvarString(  EVENT_SHOPPING_HOUR,  _EventHours,  sizeof ( _EventHours ) -1  );
	
	parse(  _EventHours,  szHours[ 0 ],  sizeof (  szHours[]  )  -1,
			szHours[ 1 ],  sizeof (  szHours[]  )  -1,
			szHours[ 2 ],  sizeof (  szHours[]  )  -1,
			szHours[ 3 ],  sizeof (  szHours[]  )  -1,
			szHours[ 4 ],  sizeof (  szHours[]  )  -1);
	
	for(  new i = 0; i < 5; i++  )
	{
		iHours[ i ] = str_to_num(  szHours[ i ] );
		len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "<tr align=center > <td> %i:00</td><td> %i:00</td>",  iHours[ i ], iHours[ i ] + 1  );
	}
	
	len += format(  motd[ len ],  sizeof ( motd ) - len - 1,	 "</table></body></html>"  );	
	show_motd(  id,  motd,  "Shopping Hour Info");
	return 1;
}
public ClCmdMagicWord(  id  )
{
	if( !UserHasFullAcces(  id  )  )
	{
		client_cmd(  id, "echo Nu ai acces la aceasta comanda !" );
		return 1;
	}
	
	read_argv(  1, g_szMagicWord, 14  );
	if( equal(  g_szMagicWord,  ""  )  )
	{
	
		remove_task( MagicWordTask );
		remove_task( MagicWordSecondTask );
		g_bPlayersCanAnswerForMW = false;
	
		ChooseRandomMagicWord(    );
	}
	else
	{
		remove_task( MagicWordTask );
		remove_task( MagicWordSecondTask );
		g_bPlayersCanAnswerForMW = false;
	
		DisplayMagicWord(    );
	}
	
	
	return 1;
}
public ClCmdUniqueWord(  id  )
{
	if( !UserHasFullAcces(  id  )  )
	{
		client_cmd(  id, "echo Nu ai acces la aceasta comanda !" );
		return 1;
	}
	
	remove_task( UniqueWordTask );
	remove_task( UniqueWordSecondTask );
	g_bPlayersCanAnswerForUQW = false;
	
	ChooseRandomUniqueWord(    );
	
	
	
	return 1;
}
	
public CheckForWord(  id  )
{
	
	static szSaid[ 192 ];
	read_args(  szSaid, sizeof ( szSaid ) -1  );
	
	remove_quotes(  szSaid  );
	if(  equali(  szSaid, ""  )  )	return 0;
	
	if(  g_bPlayersCanAnswerForMW || g_bPlayersCanAnswerForUQW  )
	{
	
		
		if(  equal(  szSaid,  g_szMagicWord  )  )
		{
			g_bPlayersCanAnswerForMW  =  false;
			client_cmd(  0,  "spk woop"  );
			GiveUserGift(  id , 1 );
		}
		else if(  equal(  szSaid,  g_szUniqueWord  )  )
		{
			g_bPlayersCanAnswerForUQW  =  false;
			client_cmd(  0,  "spk doop"  );
			GiveUserGift(  id, 2  );
		}
	}
	
	return 0;
}


public ChooseRandomMagicWord(    )
{
	if( !get_playersnum( ) ) return;
	
	new iLen  =  random_num(  10,  15  );
	format(  g_szMagicWord, sizeof ( g_szMagicWord ) -1, ""  );
	
	for(  new i = 0; i < iLen; i++ )
		g_szMagicWord[ i ] = GetRandomCharacter(  );
	
	StartMagicWord(    );
	client_cmd(  0,  "spk doop"  );
	
	set_task ( float(  get_pcvar_num(  gCvarMagicWordIterval  )  ), "ChooseRandomMagicWord", MagicWordTask  );
}

public DisplayMagicWord(    )
{
	if( !get_playersnum( ) ) return;
	
	StartMagicWord(    );
	client_cmd(  0,  "spk doop"  );
	
	set_task ( float(  get_pcvar_num(  gCvarMagicWordIterval  )  ), "ChooseRandomMagicWord", MagicWordTask  );
}

public ChooseRandomUniqueWord(    )
{
	if( !get_playersnum( ) ) return;
	
	remove_task( UniqueWordTask );
	remove_task( UniqueWordSecondTask );
	
	new iLen  =  random_num(  30,  35  );
	format(  g_szUniqueWord, sizeof ( g_szUniqueWord ) -1, ""  );
	
	for(  new i = 0; i < iLen; i++ )
		g_szUniqueWord[ i ] = GetRandomCharacter(  );
	
	StartUniqueWord(    );
	client_cmd(  0, "spk ^"%s^"",  g_szFmuEventBegin  );
	
	
}

GetRandomCharacter(    )
{
	new Float:fRandom  =  random_float(  1.0,  100.0  );
	
	if(  fRandom  <=  25.0  )
	{
		return g_szSmallLetters[  random(  sizeof ( g_szSmallLetters )  )  ];
	}
	
	else if(  fRandom  >  25.0  &&  fRandom  <=  50.0  )
	{
		return g_szLargeLetters[  random(  sizeof ( g_szLargeLetters )  )  ];
	}
	
	else if(  fRandom  >  50.0  && fRandom  <  75.0  )
	{
		return g_szNumbers[  random(  sizeof ( g_szNumbers )  )  ];
	}
	else if(  fRandom  >  75.0  )
	{
		return g_szSymbols[  random(  sizeof ( g_szSymbols )  )  ];
	}
	
	return 1;
}
public StartUniqueWord(    )
{
	g_bPlayersCanAnswerForUQW  =  true;
	
	g_iUQAnswerTime  =  get_pcvar_num(  gCvarUniqueWordAnswerTime );
	CountUniqueAnswerTime(  );
	
}
public StartMagicWord(    )
{
	g_bPlayersCanAnswerForMW  =  true;
	
	g_iMWAnswerTime  =  get_pcvar_num(  gCvarMagicWordAnswerTime );
	CountMagicAnswerTime(  );
	
}

public CountUniqueAnswerTime(  )
{
	
	if(  g_bPlayersCanAnswerForUQW  )
	{
		
		if(  g_iUQAnswerTime  <=  0  )
		{
			g_bPlayersCanAnswerForUQW  =  false;
			ColorChat(  0,  RED,  "^x04[Unique Word]^x01 Nu a scris nimeni^x03 Cuvantul Unic^x01, poate harta viitoare.."  );
			return 1;
		}
		
		set_hudmessage(  0,  255,  255,  -1.0, 0.20,  0,  0.0 ,1.0,  0.0,  0.1,  2  );
		ShowSyncHudMsg(  0,  SyncHudMessage4,  "Castiga %i XP primul care scrie^n-|   %s   |-^n^n%i secund%s ramas%s !!", get_pcvar_num(  gCvarUniqueWordXP ),
			g_szUniqueWord,  g_iUQAnswerTime, g_iUQAnswerTime  ==  1 ? "a" : "e", g_iUQAnswerTime  ==  1 ? "a" : "e"  );
		
		g_iUQAnswerTime--;
		
		set_task(  1.0,  "CountUniqueAnswerTime", UniqueWordSecondTask  );
	}
	
	return 0;
}
public CountMagicAnswerTime(  )
{
	
	if(  g_bPlayersCanAnswerForMW  )
	{
		
		if(  g_iMWAnswerTime  <=  0  )
		{
			g_bPlayersCanAnswerForMW  =  false;
			ColorChat(  0,  RED,  "^x04[Magic Word]^x01 Nu a scris nimeni cuvantul magic, poate data viitoare.."  );
			return 1;
		}
		
		set_hudmessage(  0,  255,  255,  0.01, 0.20,  0,  0.0 ,1.0,  0.0,  0.1,  2  );
		ShowSyncHudMsg(  0,  SyncHudMessage3,  "Castiga un premiu primul care scrie  -|   %s   |-^n               %i secund%s ramas%s !!",
			g_szMagicWord,  g_iMWAnswerTime, g_iMWAnswerTime  ==  1 ? "a" : "e", g_iMWAnswerTime  ==  1 ? "a" : "e"  );
		
		g_iMWAnswerTime--;
		
		set_task(  1.0,  "CountMagicAnswerTime", MagicWordSecondTask  );
	}
	
	return 0;
}

public GiveUserGift(  id , iType )
{
	
	new szName[ 32 ];
	get_user_name(  id, szName, sizeof ( szName ) -1  );
	
	if( iType  ==  2  )
	{
		
		fmu_add_user_xp(  id, get_pcvar_num(  gCvarUniqueWordXP  )  );
		ColorChat(  0,  RED,  "^x04[Unique Word]^x03 %s^x01 a scris primul^x03 Cuvantul Unic^x01 si a primit^x03 %i XP^x01 !",  szName,  get_pcvar_num(  gCvarUniqueWordXP  )  );
		if( g_bHappyHourEvent )
		{
			ColorChat(  0,  RED,  "^x04[Unique Word]^x01 Deoarece este^x03 Happy Hour^x01 a mai primit un bonus de^x03 %i XP^x01 !",  get_pcvar_num(  gCvarUniqueWordXP  )  );
			fmu_add_user_xp(  id, get_pcvar_num(  gCvarUniqueWordXP  )  );
		}
		if( IsUserVip( id ) )
		{
			ColorChat(  0,  RED,  "^x04[Unique Word]^x01 Pentru ca^x03 %s^x01 este^x03 VIP^x01 a mai primit^x03 %i XP^x01 !",  szName,  get_pcvar_num(  gCvarUniqueWordXP  )  );
			fmu_add_user_xp(  id, get_pcvar_num(  gCvarUniqueWordXP  )  );
		}
		format(  g_szUniqueWord, sizeof ( g_szUniqueWord ) -1, ""  );
		return 1;
	}
	new iRandom  =  random_num(  1, 100  );
	
	if(  iRandom  <=  35  )
	{
		cs_set_user_money(  id,  clamp(  cs_get_user_money(  id  )  +  get_pcvar_num(  gCvarMagicWordMoney  ),  0,  16000  )  );
		ColorChat(  0,  RED,  "^x04[Magic Word]^x03 %s^x01 a scris primul^x03 %s^x01 si a primit^x03 %i $^x01 !",  szName,  g_szMagicWord, get_pcvar_num(  gCvarMagicWordMoney  )  );
		
		if( g_bShoppingHourEvent )
		{
			ColorChat(  0,  RED,  "^x04[Magic Word]^x01 Deoarece este^x03 Shopping Hour^x01 a mai primit^x03 %i $^x01 !", get_pcvar_num(  gCvarMagicWordMoney  )  );
			cs_set_user_money(  id,  clamp(  cs_get_user_money(  id  )  +  get_pcvar_num(  gCvarMagicWordMoney  ),  0,  16000  )  );
		}
		
		if( IsUserVip( id ) )
		{
			ColorChat(  0,  RED,  "^x04[Magic Word]^x01 Pentru ca^x03 %s^x01 este^x03 VIP^x01 a mai primit^x03 %i $^x01 !",  szName,  get_pcvar_num(  gCvarMagicWordMoney  )  );
			cs_set_user_money(  id,  clamp(  cs_get_user_money(  id  )  +  get_pcvar_num(  gCvarMagicWordMoney  ),  0,  16000  )  );
		}
		return 1;
	}
	
	fmu_add_user_xp(  id, get_pcvar_num(  gCvarMagicWordXP  )  );
	ColorChat(  0,  RED,  "^x04[Magic Word]^x03 %s^x01 a scris primul^x03 %s^x01 si a primit^x03 %i XP^x01 !",  szName,  g_szMagicWord, get_pcvar_num(  gCvarMagicWordXP  )  );
	if( g_bHappyHourEvent )
	{
		ColorChat(  0,  RED,  "^x04[Magic Word]^x01 Deoarece este^x03 Happy Hour^x01 a mai primit un bonus de^x03 %i XP^x01 !",  get_pcvar_num(  gCvarMagicWordXP  )  );
		fmu_add_user_xp(  id, get_pcvar_num(  gCvarMagicWordXP  )  );
	}
	if( IsUserVip( id ) )
	{
		ColorChat(  0,  RED,  "^x04[Magic Word]^x01 Pentru ca^x03 %s^x01 este^x03 VIP^x01 a mai primit^x03 %i XP^x01 !",  szName,  get_pcvar_num(  gCvarMagicWordXP  )  );
		fmu_add_user_xp(  id, get_pcvar_num(  gCvarMagicWordXP  )  );
	}
	formatex(  g_szMagicWord, sizeof ( g_szMagicWord ) -1, ""  );
	return 0;
}

stock bool:UserHasFullAcces(  id  )
{
	
	if( get_user_flags(  id  )  ==  read_flags( "abcdefghijklmnopqrstuvxy"  ) )
		return true;
	
	return false;
	
}
stock bool:IsUserVip(  id  )
{
	
	if( get_user_flags(  id  )  &  read_flags(  "vxy"  )  )
		return true;
	
	return false;
	
}
