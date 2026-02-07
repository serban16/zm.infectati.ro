#include <amxmodx>
#include <amxmisc>
#define MAX_GROUPS 9

new g_groupNames[MAX_GROUPS][] = {
"Fondator",
"Owners ",
"Manager",
"Administrator",
"Super-Moderator",
"Moderator ",
"HelpeR ",
"Premium ",
"SloT "
}
new g_groupFlags[MAX_GROUPS][] = {
"abcdefghijklmnopqrstxu",
"abcdefghijkmnopqrs",
"abcdefghijmnopqr",
"abcdefghijmnop",
"abcdefhijmno",
"abcdefijmn",
"bcefijm",
"abci",
"b"
}
new g_groupFlagsValue[MAX_GROUPS]
public plugin_init() {
register_plugin("Amx Who by eXtream", "1.0", "eXtreamCS.com")
register_concmd("amx_who", "cmdWho", 0)
for(new i = 0; i < MAX_GROUPS; i++) {
g_groupFlagsValue[i] = read_flags(g_groupFlags[i])
}
}
public cmdWho(id) {
new players[32], inum, player, name[32], i, a
get_players(players, inum)
console_print(id, "Galati.LeagueCs.Ro")
for(i = 0; i < MAX_GROUPS; i++) {
console_print(id, "-----[%d]%s-----", i+1, g_groupNames[i])
for(a = 0; a < inum; ++a) {
player = players[a]
get_user_name(player, name, 31)
if(get_user_flags(player) & read_flags(g_groupFlagsValue))
{
console_print(id, "%s", name)
}
}
}
console_print(id, "Galati.LeagueCs.Ro")
return PLUGIN_HANDLED
}