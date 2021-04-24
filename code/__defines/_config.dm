//Basic config settings for developers
#define ENABLE_INSTALOAD FALSE

#define FALLBACK_TURF locate(VIEW_RANGE+1,VIEW_RANGE+1,2)

#define FPS_CLIENT 60 //0 Means synced. Also this is default, players can change this for themselves.
#define FPS_SERVER 20

#define WORLD_SIZE 255
#define TILE_SIZE 32 //This shouldn't be touched unless you know what you're doing

#define MAX_MESSAGE_LEN 512
#define MAX_CHARACTERS 10 //Maximum amount of saved characters a player can have at once.

#define MAX_INVENTORY_X 8

#define ITEM_DELETION_TIME_DROPPED 3000 //5 minutes
#define ITEM_DELETION_TIME_NEW 600 //60 seconds.

//Enables/disables biome music.
#define ENABLE_TRACKS FALSE

//Enables/disables floating damage numbers.
#define ENABLE_DAMAGE_NUMBERS TRUE

//Enables/disables bullet casings.
#define ENABLE_BULLET_CASINGS FALSE

//Enables/disables lighting.
#define ENABLE_LIGHTING TRUE

//Enables/disables atmos.
#define ENABLE_ATMOS FALSE

//Enables/disables weather.
#define ENABLE_WEATHERGEN FALSE

//Enables/disables combat messages outside combat log
#define ENABLE_HIT_MESSAGES FALSE

//Enables/disables wikibot helper functions
#define ENABLE_WIKIBOT TRUE