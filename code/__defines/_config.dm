//Basic config settings for developers

#define FALLBACK_TURF locate(VIEW_RANGE+1,VIEW_RANGE+1,1) //This shouldn't be touched unless you know what you're doing.

#define WORLD_SIZE 500 //This shouldn't be touched unless you know what you're doing.
#define TILE_SIZE 32 //This shouldn't be touched unless you know what you're doing

#define MAX_INVENTORY_X 8

#define FPS_CLIENT 60 //0 Means synced. Also this is default, players can change this for themselves.
#define FPS_SERVER 30

//Soft limit to prevent more than any of this amount of being on a single turf at once. THIS INCLUDES EVERYTHING THAT USES move(). forcemove() is intentionally ignored.
#define TURF_CONTENT_LIMIT 100

#define ARMOR_VALUE_TO_CONSIDER 100 //The armor value of which to consider the value of weapons, bullets, and armor for.