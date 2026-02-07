/* Furien Mod Ultimate
*
* (c) Copyright 2012, Askhanar
*
* This file is provided as is (no warranties).
*/

#if defined _FMU_Experience_included
	#endinput
#endif

#define _FMU_Experience_included


/*
 * Returns a players XP points
 * 
 * @param		client - The player index to get points of
 * 
 * @return		The XP points of client
 * 
 */

native fmu_get_user_xp(client);

/*
 * Sets <xp> points to client
 * 
 * @param		client - The player index to set points to
 * @param		xp - The amount of XP points to set to client
 * 
 * @return		The XP points of client
 * 
 */

native fmu_set_user_xp(client, xp);

/*
 * Adds <xp> points to client
 * 
 * @param		client - The player index to add points to
 * @param		xp - The amount of XP points to add to client
 * 
 * @return		The XP points of client
 * 
 */

stock fmu_add_user_xp(client, xp)
{
	return fmu_set_user_xp(client, fmu_get_user_xp(client) + xp);
}

/*
 * Subtracts <xp> points from client
 * 
 * @param		client - The player index to subtract points from
 * @param		xp - The amount of XP points to subtract from client
 * 
 * @return		The XP points of client
 * 
 */

stock fmu_sub_user_xp(client, xp)
{
	return fmu_set_user_xp(client, fmu_get_user_xp(client) - xp);
}