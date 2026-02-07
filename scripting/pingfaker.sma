#include <amxmodx>
#include <amxmisc>
#include <fakemeta>

const TASK_ARGUMENTS = 100

new cvar_ping, cvar_flux, cvar_target, cvar_bots, cvar_multiplier
new g_maxplayers, g_connected[33], g_isbot[33], g_argping[33]
new g_loaded_counter, g_pingoverride[33] = { -1, ... }
new Array:g_loaded_authid, Array:g_loaded_ping

public plugin_init()
{

	cvar_ping = register_cvar("cloudpingfake_ping", "1337")
	cvar_flux = register_cvar("cloudpingfake_flux", "0")
	cvar_target = register_cvar("cloudpingfake_target", "1")
	cvar_bots = register_cvar("cloudpingfake_bots", "0")
	cvar_multiplier = register_cvar("cloudpingfake_multiplier", "0.5")
	
	g_maxplayers = get_maxplayers()
	
	// If mod is CS, register some additional events to fix a bug
	new mymod[16]
	get_modname(mymod, charsmax(mymod))
	if (equal(mymod, "cstrike") || equal(mymod, "czero"))
	{
		register_event("DeathMsg", "fix_fake_pings", "a")
		register_event("TeamInfo", "fix_fake_pings", "a")
	}
	
	register_forward(FM_UpdateClientData, "fw_UpdateClientData")
	
	g_loaded_authid = ArrayCreate(32, 1)
	g_loaded_ping = ArrayCreate(1, 1)
	
	// Calculate weird argument values regularly in case we are faking ping fluctuations or a multiple of the real ping
	set_task(2.0, "calculate_arguments", TASK_ARGUMENTS, _, _, "b")
}

// After some events in CS, the fake pings are overriden for some reason, so we have to send them again...
public fix_fake_pings()
{
	static player
	for (player = 1; player <= g_maxplayers; player++)
	{
		// Player not in game?
		if (!g_connected[player])
			 continue;
		
		// Resend fake pings
		fw_UpdateClientData(player)
	}
}

public client_authorized(id)
{
	check_for_loaded_pings(id)
}

public client_putinserver(id)
{
	g_connected[id] = true
	if (is_user_bot(id)) g_isbot[id] = true
	check_for_loaded_pings(id)
}

public client_disconnect(id)
{
	g_connected[id] = false
	g_isbot[id] = false
	g_pingoverride[id] = -1
}

public fw_UpdateClientData(id)
{
	
	// Scoreboard key being pressed?
	if (!(pev(id, pev_button) & IN_SCORE) && !(pev(id, pev_oldbuttons) & IN_SCORE))
		return;
	
	// Send fake player's pings
	static player, sending, bits, bits_added
	sending = false
	bits = 0
	bits_added = 0
	
	for (player = 1; player <= g_maxplayers; player++)
	{
		// Player not in game?
		if (!g_connected[player])
			 continue;
		
		// Fake latency for its target too?
		if (!get_pcvar_num(cvar_target) && id == player)
			continue;
		
		
		// Only do these checks if not overriding ping for player
		if (g_pingoverride[player] < 0)
		{
			// Is this a bot?
			if (g_isbot[player])
			{
				// Bots setting disabled?
				if (!get_pcvar_num(cvar_bots)) continue;
			}
			else
			{
				// Bots only setting?
				if (get_pcvar_num(cvar_bots) == 2) continue;
			}
		}
		
		// Start message
		if (!sending)
		{
			message_begin(MSG_ONE_UNRELIABLE, SVC_PINGS, _, id)
			sending = true
		}
		
		// Add bits for this player
		AddBits(bits, bits_added, 1, 1) // flag = 1
		AddBits(bits, bits_added, player-1, 5) // player-1 since HL uses ids 0-31
		AddBits(bits, bits_added, g_argping[player], 12) // ping
		AddBits(bits, bits_added, 0, 7) // loss
		
		// Write group of 8 bits (bytes)
		WriteBytes(bits, bits_added, false)
	}
	
	// End message
	if (sending)
	{
		// Add empty bit at the end
		AddBits(bits, bits_added, 0, 1) // flag = 0
		
		// Write remaining bits
		WriteBytes(bits, bits_added, true)
		
		message_end()
	}
}

public cmd_fakeping(id, level, cid)
{
	// Check for access flag
	if (!cmd_access(id, level, cid, 3))
		return PLUGIN_HANDLED;
	
	// Retrieve arguments
	static arg[32], player, ping
	read_argv(1, arg, sizeof arg - 1)
	player = cmd_target(id, arg, CMDTARGET_ALLOW_SELF)
	read_argv(2, arg, sizeof arg - 1)
	ping = str_to_num(arg)
	
	// Invalid target
	if (!player) return PLUGIN_HANDLED;
	
	// Update ping overrides for player
	g_pingoverride[player] = min(ping, 4095)
	
	return PLUGIN_HANDLED;
}

// Calculate argument values based on target ping
public calculate_arguments()
{
	static player, ping, loss
	for (player = 1; player <= g_maxplayers; player++)
	{
		// Calculate target ping (clamp if out of bounds)
		if (g_pingoverride[player] < 0)
		{
			if (get_pcvar_float(cvar_multiplier) > 0.0)
			{
				get_user_ping(player, ping, loss)
				g_argping[player] = clamp(floatround(ping * get_pcvar_float(cvar_multiplier)), 0, 4095)
			}
			else
				g_argping[player] = clamp(get_pcvar_num(cvar_ping) + random_num(-abs(get_pcvar_num(cvar_flux)), abs(get_pcvar_num(cvar_flux))), 0, 4095)
		}
		else
			g_argping[player] = g_pingoverride[player]
	}
}
check_for_loaded_pings(id)
{
	// Nothing to check for
	if (g_loaded_counter <= 0) return;
	
	// Get steamid and ip
	static authid[32], ip[16], i, buffer[32]
	get_user_authid(id, authid, sizeof authid - 1)
	get_user_ip(id, ip, sizeof ip - 1, 1)
	
	for (i = 0; i < g_loaded_counter; i++)
	{
		// Retrieve authid
		ArrayGetString(g_loaded_authid, i, buffer, sizeof buffer - 1)
		
		// Compare it with this player's steamid and ip
		if (equali(buffer, authid) || equal(buffer, ip))
		{
			// We've got a match!
			g_pingoverride[id] = ArrayGetCell(g_loaded_ping, i)
			break;
		}
	}
}

AddBits(&bits, &bits_added, value, bit_count)
{
	// No more room (max 32 bits / 1 cell)
	if (bit_count > (32 - bits_added) || bit_count < 1)
		return;
	
	// Clamp value if its too high
	if (value >= (1 << bit_count))
		value = ((1 << bit_count) - 1)
	
	// Add new bits
	bits = bits + (value << bits_added)
	// Increase bits added counter
	bits_added += bit_count
}

WriteBytes(&bits, &bits_added, write_remaining)
{
	// Keep looping if there are more bytes to write
	while (bits_added >= 8)
	{
		// Write group of 8 bits
		write_byte(bits & ((1 << 8) - 1))
		
		// Remove bits we just sent by moving all bits to the right 8 times
		bits = bits >> 8
		bits_added -= 8
	}
	
	// Write remaining bits too?
	if (write_remaining && bits_added > 0)
	{
		write_byte(bits)
		bits = 0
		bits_added = 0
	}
}
