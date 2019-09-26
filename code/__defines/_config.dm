//Game Options

#define FPS_CLIENT 60 //0 Means synced. Also this is default, players can change this for themselves.
#define FPS_SERVER 30

#define MAP_DIRECTORY "maps/main/" //This shouldn't be touched unless you know what you're doing
#define TILE_SIZE 32 //This shouldn't be touched unless you know what you're doing
#define WORLD_SIZE 512 //This shouldn't be touched unless you know what you're doing
#define WORLD_SIZE_SEGMENT 128 //This shouldn't be touched unless you know what you're doing

#define BADWORDS "text/badwords.txt"

#define ZOOM_RANGE 7
#define VIEW_RANGE 11

#define SOUND_RANGE 18

#define TALK_RANGE 14
#define YELL_RANGE 21
#define WHISPER_RANGE 2

#define BOSS_RANGE 18 //If you're out of this range, you're out of the boss fight.

#define MAX_MESSAGE_LEN 512
#define MAX_CHARACTERS 10 //Maximum amount of saved characters a player can have at once.

#define ATTACK_ANIMATION_LENGTH 2

#define SHOP_RESTOCK_COUNTDOWN 300

#define NPC_MANA_COST_MULTIPLIER 0.1 //NPCS cast spells for less. We skyrim now.


//Basically debug mode
#define ENABLE_INSTALOAD FALSE

//Makes compiling faster FALSE disabled
#define ENABLE_MAPLOAD FALSE
#define ENABLE_LIGHTING TRUE
#define ENABLE_WEATHERGEN TRUE
#define ENABLE_TURFGEN TRUE
#define ENABLE_CHARGEN TRUE

#define ENABLE_XP TRUE
#define LEVEL_CAP 100

#define SPAWN_PROTECTION_TIME 10 //Time in seconds that you have spawn protection for when you leave a safezone.

#define FOOTSTEP_VOLUME 25
#define FOOTPRINT_FADE_TIME SECONDS_TO_DECISECONDS(60)

#define DEFAULT_BRIGHTNESS_LIGHTSOURCE 1

#define DEFAULT_BRIGHTNESS_AMBIENT_STRONG 0.4
#define DEFAULT_BRIGHTNESS_AMBIENT 0.2
#define DEFAULT_RANGE_AMBIENT 2

#define DEFAULT_BRIGHTNESS_MUL_INTERIOR 0.6
#define DEFAULT_BRIGHTNESS_MUL_EXTERIOR 0.8

#define DEFAULT_SKILL_ALLOCATION 190
#define DEFAULT_ATTRIBUTE_ALLOCATION 130

#define LIFE_TICK 1 //Deciseconds per life tick interval.
#define LIFE_TICK_SLOW 10

#define ARMOR_CAP 1000 //How much armor you're allowed to have in total.


#define DAMAGE_REDUCTION_CAP 0.8 //How much damage maximum (percentage) is someone allowed to reduce when attacked. For example, 0.8 means you can absorb up to 80% of the damage dealt.

#define STEALTH_MAX_ALPHA 10
#define STEALTH_MIN_ALPHA 1


#define CONSUME_AMOUNT_MAX 30

#define HEALTH_REGEN_BUFFER_MAX 1
#define HEALTH_REGEN_BUFFER_MIN -1

#define STAMINA_REGEN_BUFFER_MAX 1
#define STAMINA_REGEN_BUFFER_MIN -1

#define MANA_REGEN_BUFFER_MAX 1
#define MANA_REGEN_BUFFER_MIN -1

#define MAX_ZOOM 4
#define MIN_ZOOM 2