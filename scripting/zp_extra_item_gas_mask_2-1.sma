#include <amxmodx>
#include <hamsandwich>
#include <engine>
#include <zombieplague>

#define _MarkPlayerInMask(%0)   _bitPlayerInMask |= (1 << (%0 & 31))
#define _ClearPlayerInMask(%0)  _bitPlayerInMask &= ~(1 << (%0 & 31))
#define _IsPlayerInMask(%0)     _bitPlayerInMask & (1 << (%0 & 31))

#define _MarkPlayerConnected(%0)  _bitPlayerConnected |= (1 << (%0 & 31))
#define _ClearPlayerConnected(%0) _bitPlayerConnected &= ~(1 << (%0 & 31))
#define _IsPlayerConnected(%0)    _bitPlayerConnected & (1 << (%0 & 31))

#define _MarkPlayerAlive(%0)  _bitPlayerAlive |= (1 << (%0 & 31))
#define _ClearPlayerAlive(%0) _bitPlayerAlive &= ~(1 << (%0 & 31))
#define _IsPlayerAlive(%0)    _bitPlayerAlive & (1 << (%0 & 31))

#define EV_INT_nadetype     EV_INT_flTimeStepSound
#define NADETYPE_INFECTION  1111 

#define COST 10

new g_itemid_buyremoverh
new g_icon 

new _pcvar_range
	,_pcvar_after_remove
	,_pcvar_prefix
	
new _bitPlayerInMask
	,_bitPlayerAlive
	,_bitPlayerConnected

new g_MsgSayText
	,g_MaxPlayers	
	
	
public plugin_init() {
	register_plugin( "[ZP] Extra item: Gas Mask", "2.1", "H.RED.ZONE" )
	
	RegisterHam(Ham_Killed, "player", "fw_PlayerKilled")
	RegisterHam(Ham_Spawn, "player", "fw_PlayerSpawn", 1 )
	RegisterHam(Ham_Think, "grenade", "fw_ThinkGrenade", 1)
	
	g_itemid_buyremoverh = zp_register_extra_item("Masca de Gaz(o runda)" , COST , ZP_TEAM_HUMAN )
    
	register_event( "HLTV", "NewRound", "a", "1=0", "2=0" )
  
	_pcvar_range = register_cvar( "zp_gas_remover_range", "200" )
	_pcvar_after_remove = register_cvar( "zp_gas_remover_after", "3" )
	_pcvar_prefix = register_cvar("zp_gas_mask_prefix", "Masca", 0, 0.0)
	
	g_MsgSayText = get_user_msgid("SayText");
	g_MaxPlayers = get_maxplayers()
	g_icon = get_user_msgid("StatusIcon") 
}

public zp_extra_item_selected( plr, itemid ) {
	if ( itemid == g_itemid_buyremoverh ) {
		if( ~_IsPlayerInMask( plr ) ) {
			_MarkPlayerInMask( plr )
			ProtoChat(plr, "Masca de Gaz te protejeaza de grenazile de infectare.")
			
			Icon_On(plr)
		}	
	}
}

public buy_mask(id) {
	new ammopacks = zp_get_user_ammo_packs(id)
	static id;
	if( _IsPlayerInMask( id ) ) {
		ProtoChat(id, "Masca de Gaz te protejeaza de grenazile de infectare.")
	}
	else if( ammopacks > COST) {
		_MarkPlayerInMask(id)
		zp_set_user_ammo_packs(id, zp_get_user_ammo_packs(id) - COST);
	}
	else {
		ProtoChat(id, "Nu poti cumpara o Masca de Gaz.")
	}	
}

public fw_ThinkGrenade( entity ) {
	if( is_valid_ent( entity ) && entity_get_int( entity, EV_INT_nadetype ) == NADETYPE_INFECTION  ) { 
		new _cvar_range = get_pcvar_num( _pcvar_range ) 
		new _cvar_after_remove = get_pcvar_num( _pcvar_after_remove )
        
		for( new id = 1 ; id <= g_MaxPlayers ; id++ ) {
			if( is_user_connected( id ) && _IsPlayerAlive( id ) && _IsPlayerInMask( id ) ) {
                			if( get_entity_distance( entity, id ) <= _cvar_range ) {
                    			remove_entity( entity )
                    	
                    			if( _cvar_after_remove ) {
                        				_ClearPlayerInMask( id )
							
                        				Icon_Off(id)	
                        				ProtoChat(id, "Masca de Gaz nu mai are efect.")
                    			}
                			}
            		}
        		}
    	}
	return HAM_IGNORED;
}  

public NewRound() {
	_bitPlayerInMask = 0
}

public client_connect( plr ) {
	_MarkPlayerConnected( plr )	
}

public client_disconnect( plr ) {
	_ClearPlayerConnected( plr )
	Icon_Off( plr )	
}

public zp_user_infected_post( id ) {
	_ClearPlayerInMask( id )
	Icon_Off( id )	
}

public zp_user_infected_pre( id ) {
	_ClearPlayerInMask( id )
	Icon_Off( id )	
} 

public Icon_On(plr) {
	message_begin( MSG_ONE_UNRELIABLE, g_icon, { 0, 0, 0 }, plr );
	write_byte( 1 );
	write_string( "dmg_gas" );
	write_byte( 0 );
	write_byte( 255 );
	write_byte( 0 );
	message_end( );
}
	
public Icon_Off(plr) {
	message_begin( MSG_ONE_UNRELIABLE, g_icon, { 0, 0, 0 }, plr );
	write_byte( 0 );
	write_string( "dmg_gas" );
	write_byte( 0 );
	write_byte( 255 );
	write_byte( 0 );
	message_end( );
}
	
public fw_PlayerKilled(plr, attacker, shouldgib) {
	if(_IsPlayerConnected(plr)) {
		_ClearPlayerAlive(plr)
	}
}

public fw_PlayerSpawn(plr) {
	if(_IsPlayerConnected(plr)) {
		_MarkPlayerAlive(plr)
	}
}

ProtoChat (plr, const sFormat[], any:...) {
	static i; i = plr ? plr : get_player();
	if ( !i ) {
		return PLUGIN_HANDLED;
	}
	
	new sPrefix[16];
	get_pcvar_string(_pcvar_prefix, sPrefix, 15);
	
	new sMessage[256];
	new len = formatex(sMessage, 255, "^x01[^x04%s^x01] ", sPrefix);
	vformat(sMessage[len], 255-len, sFormat, 3)
	sMessage[192] = '^0' 
	
	Make_SayText(plr, i, sMessage)
	
	return PLUGIN_CONTINUE;
}

get_player() {
	for ( new plr; plr <= g_MaxPlayers; plr++) {
		if (_IsPlayerConnected(plr)) {
			return plr;
		}
	}
	return PLUGIN_HANDLED
}

Make_SayText(Receiver, Sender, sMessage[]) {
	if (!Sender) {
		return PLUGIN_HANDLED;
	}
	message_begin(Receiver ? MSG_ONE_UNRELIABLE : MSG_ALL, g_MsgSayText, {0,0,0}, Receiver)
	write_byte(Sender)
	write_string(sMessage)
	message_end()
	
	return PLUGIN_CONTINUE;
}