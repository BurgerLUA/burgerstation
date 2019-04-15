#define TILE_SIZE 32 //This should generally always be 32.

#define FPS_CLIENT 60
#define FPS_SERVER 30

#define MAP_DIRECTORY "maps/main/" //This shouldn't be touched unless you know what you're doing
#define WORLD_SIZE 512 //This shouldn't be touched unless you know what you're doing
#define WORLD_SIZE_SEGMENT 128 //This shouldn't be touched unless you know what you're doing


#define VIEW_RANGE 11
#define SOUND_RANGE 18

#define MAX_MESSAGE_LEN 256
#define MAX_CHARACTERS 10 //Maximum amount of characters a player can have at once.


#define ATTACK_ANIMATION_LENGTH 2

#define SHOP_RESTOCK_COUNTDOWN 60


#define NPC_MANA_COST_MULTIPLIER 0.1 //NPCS cost spells for less. We skyrim now.

//Makes compiling faster
#define ENABLE_MAPLOAD FALSE
#define ENABLE_LIGHTING TRUE
#define ENABLE_CHARGEN FALSE
#define ENABLE_TURFGEN TRUE
#define ENABLE_INSTALOAD TRUE


#define ENABLE_XP TRUE
#define LEVEL_CAP 100


#define FOOTSTEP_VOLUME 25
#define FOOTPRINT_FADE_TIME SECONDS_TO_DECISECONDS(60)

#define DEFAULT_BRIGHTNESS_INTERIOR 0.1
#define DEFAULT_BRIGHTNESS_EXTERIOR 0.2
#define DEFAULT_BRIGHTNESS_TURF_LIGHT 0.4


#define DEFAULT_SKILL_ALLOCATION 190
#define DEFAULT_ATTRIBUTE_ALLOCATION 130