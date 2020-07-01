#define LOOT(L) (SSloot.all_loot[L] ? SSloot.all_loot[L] : null)

#define CREATE_LOOT(L,desired_loc) SSloot.all_loot[L] ? SSloot.all_loot[L].spawn_loot_table(desired_loc) : null