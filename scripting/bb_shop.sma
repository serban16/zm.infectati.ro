#include <amxmodx>
#include <amxmisc>
#include <fun>
#include <cstrike>
#include <Hamsandwich>
#include <fakemeta>
#include <ColorChat>

#define PLUGIN "Shop"
#define VERSION "1.3"
#define AUTHOR "Free~Man"

#define gMaxItem 8

enum _:gItems
{
    ITEM_ONE,
    ITEM_TWO,
    ITEM_THREE,
    ITEM_FOUR,
    ITEM_FIVE,
    ITEM_SIX,
    ITEM_SEVEN,
    ITEM_EIGHT,
    ITEM_NINE
}

new const gItemsText[][] = {
    "Gravity",
    "Super Knife Cut",
    "Respawn",
    "HP ++",
    "Super Deagle",
    "Invisiblty For 15 sec",
    "Glows",
    "Health Gun",
    "GodMode For 5 sec"
}

new const gItemsCvarText[][] = {
    "Shop_Item_One",
    "Shop_Item_Two",
    "Shop_Item_Three",
    "Shop_Item_Four",
    "Shop_Item_Five",
    "Shop_Item_Six",
    "Shop_Item_Seven",
    "Shop_Item_Eight",
    "Shop_Item_Nine"
}

new const gItemsCost[][] = {
    "8000",
    "10000",
    "5000",
    "500",
    "14000",
    "16000",
    "200",
    "16000",
    "16000"
}


new iItems[ gItems ]

new bool:get_user_supercutknife[33]
new bool:get_user_superdeagle[33]
new bool:get_user_healthgun[33]
new bool:is_user_godmode[33]
new bool:is_user_invisible[33]
new user_timing[33]

new explode_script

new szMapName[32]

new const Knife_Model[][] = {
    "models/shop/v_cutter.mdl",
    "models/shop/p_cutter.mdl"
}

new const Deagle_Model[][] = {
    "models/shop/v_super_deagle.mdl",
    "models/shop/p_super_deagle.mdl"
}


public plugin_init() {
    register_plugin(PLUGIN, VERSION, AUTHOR)
    
    for( new i = 0; i < sizeof gItemsCvarText; i++ )
        register_cvar(gItemsCvarText[i], gItemsCost[i])
    
    get_mapname(szMapName, charsmax(szMapName))
    
    if(contain(szMapName, "surf_") != -1 || contain(szMapName, "bb_") != -1)
    {
        register_event("CurWeapon", "Current_Weapon", "be", "1=1")
        RegisterHam(Ham_TakeDamage, "player", "Player_Took_Dmg")
        RegisterHam(Ham_Spawn, "player", "Player_Spawn", 1)
        RegisterHam(Ham_Respawn, "player", "Player_Spawn", 1)
        register_concmd("amx_give_money", "give_player_money", ADMIN_LEVEL_H, "<Target> <Amount>")
        register_concmd("amx_take_money", "take_player_money", ADMIN_LEVEL_H, "<Target> <Amount>")
        register_clcmd("say /Shop", "Shop_Menu")
        register_clcmd("say Shop", "Shop_Menu")
        
        set_task(35.0, "Message")
    }
}
public plugin_precache()
{
    get_mapname(szMapName, charsmax(szMapName))
    
    if(contain(szMapName, "surf_") != -1 || contain(szMapName, "bb_") != -1)
    {
        static i
        
        for( i = 0; i < sizeof Knife_Model; i++ )
            precache_model(Knife_Model[i])
        for( i = 0; i < sizeof Deagle_Model; i++ )
            precache_model(Deagle_Model[i])
        
        explode_script = precache_model("sprites/zerogxplode-big1.spr")
        precache_sound("events/enemy_died.wav")
    }
}
//-------------------//
/* Give Player Money */
//-------------------//
public give_player_money(id, level, cid)
{
    if(!cmd_access(id, level, cid, 3))
        return PLUGIN_HANDLED
    
    new target[32], amount[21]
    
    read_argv(1, target, charsmax(target))
    read_argv(2, amount, charsmax(amount))
    
    new player = cmd_target(id, target, 8)
    
    if(!player)
        return PLUGIN_HANDLED
    
    new szAdminName[32], szPlayerName[32]
    get_user_name(id, szAdminName, charsmax(szAdminName))
    get_user_name(player, szPlayerName, charsmax(szPlayerName))
    
    new player_money = str_to_num(amount)
    
    if(player_money > 16000 || player_money < 0)
    {
        ColorChat(id, NORMAL, "^3[ Shop ] ^1This is ^3maximally ^4( 0 - 16000 ) ^3$")
        return PLUGIN_HANDLED
    }
    
    cs_set_user_money(player, player_money)
    ColorChat(0, NORMAL, "^3[ Shop ] ^4Admin ^1%s Gave To ^3%s ^1%i ^3$", szAdminName, szPlayerName, player_money)
    return PLUGIN_HANDLED
}
//-------------------//
/* Take Player Money */
//-------------------//
public take_player_money(id, level, cid)
{
    if(!cmd_access(id, level, cid, 3))
        return PLUGIN_HANDLED
    
    new target[32], amount[21]
    
    read_argv(1, target, charsmax(target))
    read_argv(2, amount, charsmax(amount))
    
    new player = cmd_target(id, target, 8)
    
    if(!player)
        return PLUGIN_HANDLED
    
    new szAdminName[32], szPlayerName[32]
    get_user_name(id, szAdminName, charsmax(szAdminName))
    get_user_name(player, szPlayerName, charsmax(szPlayerName))
    
    new player_money = str_to_num(amount)
    
    if(cs_get_user_money(id) <= 0)
    {
        cs_set_user_money(player, 0)
        ColorChat(id, NORMAL, "^3[ Shop ] ^1Player Has No ^4Money ^3To Take")
        return PLUGIN_HANDLED
    }
    
    cs_set_user_money(player, cs_get_user_money(player) - player_money)
    ColorChat(0, NORMAL, "^3[ Shop ] ^4Admin ^1%s Took From ^3%s ^1%i ^3$", szAdminName, szPlayerName, player_money)
    return PLUGIN_HANDLED
}
//-----------//
/* Shop Menu */
//-----------//
public Shop_Menu(id)
{
    new szText[64], szTempNumz[8]
    
    formatex(szText, charsmax(szText), "\yShop")
    new MShop = menu_create(szText, "Shop_Handle")
    
    for( new i = 0; i < sizeof gItemsText; i++ )
    {
        num_to_str(i, szTempNumz, charsmax(szTempNumz))
        formatex(szText, charsmax(szText), "\r%s   \y%d $", gItemsText[ i ], get_cvar_num(gItemsCvarText[i]))
        menu_additem(MShop, szText, szTempNumz, 0)
    }
    menu_display(id, MShop)
    return PLUGIN_CONTINUE
}
//-------------//
/* Shop Handle */
//-------------//
public Shop_Handle(id, menu, item)
{
    if(item == MENU_EXIT)
    {
        menu_destroy(menu)
        return PLUGIN_HANDLED
    }
    
    new data[8], name[64]
    new access, callback
    menu_item_getinfo(menu, item, access, data, charsmax(data), name, charsmax(name), callback)
    
    new tempid = str_to_num(data)
    
    new szName[32]
    get_user_name(id, szName, charsmax(szName))
    
    if(cs_get_user_money(id) < get_cvar_num(gItemsCvarText[tempid]))
    {
        ColorChat(id, NORMAL, "^3[ Shop ] ^1You Dont Have Enough ^4Money")
        return PLUGIN_HANDLED
    }
    
    iItems[ gMaxItem ] = tempid
    
    if(contain(szMapName, "bb_") != -1 && cs_get_user_team(id) != CS_TEAM_CT)
    {
        if(iItems[ gMaxItem ] == ITEM_TWO || iItems[ gMaxItem ] == ITEM_FIVE || iItems[ gMaxItem ] == ITEM_EIGHT)
        {
            ColorChat(id, NORMAL, "^3[ Shop ] ^4Only ^3Human Can Use This Item")
            return PLUGIN_CONTINUE
        }
    }
    
    if(is_user_invisible[id] && iItems[ gMaxItem ] == ITEM_NINE || is_user_godmode[id] && iItems[ gMaxItem ] == ITEM_SIX)
    {
        ColorChat(id, NORMAL, "^3[ Shop ] ^4You ^3Cant Use Two Items in the Same Time")
        return PLUGIN_HANDLED
    }
    
    if(!is_user_alive(id) && iItems[ gMaxItem ] != ITEM_THREE)
    {
        ColorChat(id, NORMAL, "^3[ Shop ] ^1You Need ^3To Be Alive to Buy This ^4Item")
        return PLUGIN_HANDLED
    }
    
    switch( iItems[ gMaxItem ] )
    {
        case ITEM_ONE:
        {
            set_user_gravity(id, 0.25)
        }
        case ITEM_TWO:
        {
            get_user_supercutknife[id] = true
            give_item(id, "weapon_knife")
        }
        case ITEM_THREE:
        {
            set_task(1.0, "Respawn", id)
        }
        case ITEM_FOUR:
        {
            set_user_health(id, get_user_health(id) + 500)
            set_task(1.0, "Show_Health", id, _, _, "b")
        }
        case ITEM_FIVE:
        {
            get_user_superdeagle[id] = true
            give_item(id, "weapon_deagle")
            cs_set_user_bpammo(id, CSW_DEAGLE, 35)
        }
        case ITEM_SIX:
        {
            remove_task(id)
            set_user_rendering(id, kRenderFxGlowShell, 0, 0, 0, kRenderGlow, 0)
            is_user_invisible[id] = true
            user_timing[id] = 15
            set_task(1.0, "Timing", id)
        }
        case ITEM_SEVEN:
        {
            remove_task(id)
            set_task(1.0, "User_Glow", id)
        }
        case ITEM_EIGHT:
        {
            get_user_healthgun[id] = true
            give_item(id, "weapon_p228")
            cs_set_user_bpammo(id, CSW_P228, 90)
        }
        case ITEM_NINE:
        {
            remove_task(id)
            set_user_godmode(id, 1)
            is_user_godmode[id] = true
            user_timing[id] = 5
            set_task(1.0, "Timing", id)
            set_task(1.0, "User_Glow", id)
        }
    }
    cs_set_user_money(id, cs_get_user_money(id) - get_cvar_num(gItemsCvarText[tempid]))
    ColorChat(0, NORMAL, "^3[ Shop ] ^4%s ^1Has Bougth ^4%s ^3Cost: ^4%d $", szName, gItemsText[ tempid ], get_cvar_num(gItemsCvarText[tempid]))
    return PLUGIN_HANDLED
}
public Current_Weapon(id)
{
    new weapon = read_data(2)
    
    if(weapon == CSW_KNIFE)
    {
        if(get_user_supercutknife[id])
        {
            set_pev(id, pev_viewmodel2, Knife_Model[0])
            set_pev(id, pev_weaponmodel2, Knife_Model[1])
        }
    }
    if(weapon == CSW_DEAGLE)
    {
        if(get_user_superdeagle[id])
        {
            set_pev(id, pev_viewmodel2, Deagle_Model[0])
            set_pev(id, pev_weaponmodel2, Deagle_Model[1])
        }
    }

}    
public Player_Took_Dmg(victim, inflictor, attacker, Float:damage, bits)
{
    if(!is_user_connected(victim) || !is_user_connected(attacker) || attacker == victim)
        return HAM_IGNORED
    
    new Clip, Ammo
    new weapon = get_user_weapon(attacker, Clip, Ammo)
    
    if(get_user_supercutknife[attacker] && weapon == CSW_KNIFE && cs_get_user_team(attacker) != cs_get_user_team(victim))
    {
        SetHamParamFloat(4, damage + 5000)
        set_user_maxspeed(attacker, get_user_maxspeed(attacker) + 1.0)
    }
    if(get_user_superdeagle[attacker] && weapon == CSW_DEAGLE && cs_get_user_team(attacker) != cs_get_user_team(victim))
    {
        SetHamParamFloat(4, damage + 255)
        User_Kill_Effects(victim)
    }
    if(get_user_healthgun[attacker] && weapon == CSW_P228 && cs_get_user_team(attacker) != cs_get_user_team(victim))
    {
        SetHamParamFloat(4, (damage - damage) + 15)
        set_user_health(attacker, get_user_health(attacker) + 15)
        emit_sound(attacker, CHAN_AUTO, "events/enemy_died.wav", 1.0, 0.5, 0, PITCH_NORM)
        
        if(get_user_health(attacker) >= 255)
        {
            set_user_health(attacker, 254)
            return HAM_IGNORED
        }
    }
    return HAM_IGNORED
}
public Respawn(id)
{
    if(!is_user_alive(id))
    {
        spawn(id)
        set_task(0.15, "Respawn", id)
    }
    else
    {
        spawn(id)
        give_item(id, "weapon_knife")
    }
}
public Timing(id)
{
    if(!is_user_alive(id))
        return PLUGIN_HANDLED
    
    if(is_user_invisible[id])
    {
        user_timing[id] --
        set_task(1.0, "Timing", id)
        set_hudmessage(170, 255, 255, 0.0, 0.52, 0, 0.5, 0.5, 0.5, 0.5, 2)
        show_hudmessage(id, "Your Invisible For %i Sec", user_timing[id])
        
        if(user_timing[id] == 0)
        {
            is_user_invisible[id] = false
            set_user_rendering(id, kRenderFxNone, 0, 0, 0, kRenderNormal, 16)
            return PLUGIN_HANDLED
        }
    }
    if(is_user_godmode[id])
    {
        user_timing[id] --
        set_task(1.0, "Timing", id)
        set_hudmessage(170, 255, 255, 0.0, 0.42, 0, 0.5, 0.5, 0.5, 0.5, 3)
        show_hudmessage(id, "Your GodMode For %i Sec", user_timing[id])
        
        if(user_timing[id] == 0)
        {
            is_user_godmode[id] = false
            set_user_godmode(id, 0)
            set_user_rendering(id, kRenderFxNone, 0, 0, 0, kRenderNormal, 16)
            remove_task(id)
            return PLUGIN_HANDLED
        }
    }
    return PLUGIN_HANDLED
}
        
public User_Kill_Effects(id)
{
    new Origin[3]
    get_user_origin(id, Origin)
    
    emit_sound(0, CHAN_VOICE, "weapons/c4_explode1.wav", 1.0, 0.5, 0, PITCH_NORM)
    
    message_begin(MSG_BROADCAST, SVC_TEMPENTITY, _, id)
    write_byte(TE_SPRITE)
    write_coord(Origin[0])
    write_coord(Origin[1])
    write_coord(Origin[2])
    write_short(explode_script) 
    write_byte(15)
    write_byte(255)
    message_end()
}
public User_Glow(id)
{
    if(!is_user_alive(id))
    {
        remove_task(id)
    }
    else
    {
        new R, G, B
        new Random_Color = random_num(0, 5)
        
        switch( Random_Color )
        {
            case 0:
            {
                R = 255
                G = 0
                B = 0
            }
            case 1:
            {
                R = 0
                G = 255
                B = 0
            }
            case 2:
            {
                R = 0
                G = 0
                B = 255
            }
            case 3:
            {
                R = 255
                G = 255
                B = 255
            }
            case 4:
            {
                R = 255
                G = 0
                B = 255
            }
            case 5:
            {
                R = random_num(0, 255)
                G = random_num(0, 255)
                B = random_num(0, 255)
            }
        }
        set_user_rendering(id, kRenderFxGlowShell, R, G, B, kRenderNormal, 20)
        set_task(1.0, "User_Glow", id)
    }
}
public Player_Spawn(id)
{
    if(is_user_alive(id))
    {
        get_user_supercutknife[id] = false
        get_user_superdeagle[id] = false
        is_user_invisible[id] = false
        is_user_godmode[id] = false
        remove_task(id)
        set_user_rendering(id, kRenderFxNone, 0, 0, 0, kRenderNormal, 16)
    }
}
//-------------//
/* Show Health */
//-------------//
public Show_Health(id)
{
    if(contain(szMapName, "surf_") != -1 && is_user_alive(id))
    {
        set_hudmessage(255, 255, 255, -1.0, 0.85, 0, 1.0, 1.0, 1.0, 1.0, 7)
        show_hudmessage(id, "Health: %i", get_user_health(id))
    }
}
//---------//
/* Message */
//---------//
public Message()
{
    ColorChat(0, NORMAL, "^3[ Shop ] ^1Say ^4/Shop ^3to Open The Shop Menu")
    set_task(90.0, "Message")
} 