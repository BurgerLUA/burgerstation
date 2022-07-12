#define LOOT(L) (SSloot.all_loot[L] ? SSloot.all_loot[L] : null)

//The "..." should be the loc and the optional rarity
#define SPAWN_LOOT(L,data...) SSloot.all_loot[L] ? SSloot.all_loot[L].do_spawn(data) : null