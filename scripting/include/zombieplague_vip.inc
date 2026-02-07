#if defined _zombieplague_vip_included
  #endinput
#endif
#define _zombieplague_vip_included

/**
 * Returns whether a player is a VIP.
 *
 * @param id		Player index.
 * @return		True if it is, false otherwise.
 */
native zp_is_user_vip(id)

/**
 * Called when VIP round started.
 *
 */
forward zp_round_is_vip()