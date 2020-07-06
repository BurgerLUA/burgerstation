//Loads your character instantly at a marker point.
#define ENABLE_INSTALOAD FALSE
#define ENABLE_STOPLAG TRUE
#define MOVEMENT_DELAY_MOD 0.75 //Lower values means faster.

//Game Options
#define FPS_CLIENT 60 //0 Means synced. Also this is default, players can change this for themselves.
#define FPS_SERVER 30

#define SHUTDOWN_SUBSYSTEM_ON_ERROR FALSE

#define TILE_SIZE 32 //This shouldn't be touched unless you know what you're doing

#define MOB_HEIGHT_OFFSET 2

#define GARBAGE_LOGS_PATH "data/server/garbage_logs.txt"

#define BADNAMES "text/badnames.txt"

#define MAX_ZOOM 4 //This is for z-zoom.
#define MIN_ZOOM 1

#define ZOOM_RANGE 8
#define VIEW_RANGE 10
#define AI_DETECTION_RANGE VIEW_RANGE * 0.6
#define AI_DETECTION_RANGE_NOISE VIEW_RANGE
#define AI_DETECTION_RANGE_CAUTION VIEW_RANGE + ZOOM_RANGE*0.5
#define AI_DETECTION_RANGE_COMBAT VIEW_RANGE + ZOOM_RANGE

#define SOUND_RANGE VIEW_RANGE + ZOOM_RANGE

#define STUN_ANGLE -90

#define WHISPER_RANGE 2
#define TALK_RANGE VIEW_RANGE
#define YELL_RANGE VIEW_RANGE*1.5

#define RADIO_RANGE 3 //Can only receive radio messages in this distance
#define RADIO_WHISPER_RANGE 1
#define RADIO_TALK_RANGE 4
#define RADIO_YELL_RANGE 8

#define BOSS_RANGE VIEW_RANGE*2 //If you're out of this range, you're out of the boss fight.

#define MAX_MESSAGE_LEN 512
#define MAX_CHARACTERS 10 //Maximum amount of saved characters a player can have at once.

#define ATTACK_ANIMATION_LENGTH 1
#define DODGE_ANIMATION_LENGTH 4

#define SHOP_RESTOCK_COUNTDOWN 120

#define NPC_MANA_COST_MULTIPLIER 0.1 //NPCS cast spells for less. We skyrim now.

#define WEATHER_ADD_CHANCE 40
#define WEATHER_REMOVE_CHANCE 10

#define BYPASS_AREA_NO_DAMAGE TRUE

//Makes compiling faster. FALSE means disabled

#define ENABLE_BULLET_CASINGS FALSE
#define ENABLE_AI TRUE
#define ENABLE_MAPLOAD TRUE
#define ENABLE_LIGHTING TRUE
#define ENABLE_TURFGEN TRUE

#define ENABLE_HIJACK FALSE

#define ENABLE_ATMOS FALSE

#define ENABLE_MOB TRUE
#define ENABLE_WEATHERGEN TRUE
#define ENABLE_HAZARDS FALSE
#define ENABLE_WOUNDS FALSE

#define ENABLE_HIT_MESSAGES FALSE

#define ENABLE_LORE FALSE
#define ENABLE_KARMA FALSE
#define ENABLE_WIKIBOT TRUE
#define ENABLE_SCREEN_MESSAGES FALSE

#define BEEF_TIME_SECONDS 600

//#define ENABLE_SLOTS

#define ENABLE_VAREDIT FALSE

#define ENABLE_XP TRUE
#define ENABLE_XP_SAVING TRUE
#define LEVEL_CAP 100 //This is the highest possible OVERALL level someone can get.

#define ITEM_DELETION_TIME_DROPPED 3000 //5 minutes
#define ITEM_DELETION_TIME_NEW 600 //60 seconds.

#define WARN_ON_DUPLICATE_QDEL FALSE
#define CRASH_ON_DUPLICATE_QDEL FALSE

#define CHAT_FONT_SIZE 0.25

#define GENERATE_PROTECTION_TIME 10 //Time in seconds that you have spawn protection for when you leave a safezone.

#define FOOTSTEP_VOLUME 25
#define FOOTPRINT_FADE_TIME SECONDS_TO_DECISECONDS(60)

#define DEFAULT_BRIGHTNESS_LIGHTSOURCE 1

#define DEFAULT_BRIGHTNESS_AMBIENT_STRONG 0.4
#define DEFAULT_BRIGHTNESS_AMBIENT 0.2
#define DEFAULT_RANGE_AMBIENT 2

#define DEFAULT_SKILL_ALLOCATION 190
#define DEFAULT_ATTRIBUTE_ALLOCATION 130

#define SPRINT_STAMINA_LOSS 1

#define MAX_INVENTORY_X 8

#define DAMAGE_REDUCTION_CAP 0.8 //How much damage maximum (percentage) is someone allowed to reduce when attacked. For example, 0.8 means you can absorb up to 80% of the damage dealt.

#define STEALTH_MAX_ALPHA 10
#define STEALTH_MIN_ALPHA 1

#define CONSUME_AMOUNT_MAX 30

#define HEALTH_REGEN_BUFFER_MAX 10
#define HEALTH_REGEN_BUFFER_MIN -10

#define STAMINA_REGEN_BUFFER_MAX 10
#define STAMINA_REGEN_BUFFER_MIN -10

#define MANA_REGEN_BUFFER_MAX 10
#define MANA_REGEN_BUFFER_MIN -10

#define TARGETABLE_LIMBS list(BODY_HEAD, BODY_TORSO, BODY_GROIN, BODY_ARM_LEFT, BODY_ARM_RIGHT , BODY_HAND_LEFT, BODY_HAND_RIGHT, BODY_LEG_LEFT, BODY_LEG_RIGHT, BODY_FOOT_LEFT, BODY_FOOT_RIGHT	)
#define TARGETABLE_LIMBS_KV list(BODY_HEAD = 0, BODY_TORSO = 0, BODY_GROIN = 0, BODY_ARM_LEFT = 0, BODY_ARM_RIGHT = 0, BODY_HAND_LEFT = 0, BODY_HAND_RIGHT = 0, BODY_LEG_LEFT = 0, BODY_LEG_RIGHT = 0, BODY_FOOT_LEFT = 0, BODY_FOOT_RIGHT = 0	)

#define AIR_TEMPERATURE_MOD 3 //How much the air has an impact on reagent temperature.

#define DEFAULT_COLORS list("#3D5E80","#48728B","#5D96A0","#FFFFFF","#335871","#FE0000")

#define FRIENDLY_FIRE FALSE
#define PLAYER_COLLISIONS FALSE

#define QWERTY_MACROS list( \
	"W" = "move_up", \
	"D" = "move_right", \
	"S" = "move_down", \
	"A" = "move_left",\
	"1" = "set-intent-help",\
	"2" = "set-intent-disarm", \
	"3" = "set-intent-grab", \
	"4" = "set-intent-harm", \
	"North" = "move_up", \
	"East" = "move_right", \
	"South" = "move_down", \
	"West" = "move_left", \
	"Shift" = "sprint", \
	"Alt" = "walk", \
	"Ctrl" = "grab", \
	"R" = "throw", \
	"Q" = "drop", \
	"C" = "sneak", \
	"E" = "examine_mode", \
	"Z" = "quick_self", \
	"Space" = "kick", \
	"G" = "cycle-intent-clockwise", \
	"F" = "cycle-intent-counter-clockwise", \
	"T" = "say", \
	"O" = "ooc", \
	"L" = "looc", \
	"V" = "zoom"\
)

#define AZERTY_MACROS list( \
	"Z" = "move_up",\
	"D" = "move_right",\
	"S" = "move_down",\
	"Q" = "move_left",\
	"1" = "set-intent-help",\
	"2" = "set-intent-disarm",\
	"3" = "set-intent-grab",\
	"4" = "set-intent-harm",\
	"North" = "move_up",\
	"East" = "move_right",\
	"South" = "move_down",\
	"West" = "move_left",\
	"Shift" = "sprint",\
	"Alt" = "walk",\
	"Ctrl" = "grab",\
	"R" = "throw",\
	"X" = "drop",\
	"C" = "sneak",\
	"E" = "examine_mode",\
	"F" = "quick_self",\
	"Space" = "kick",\
	"G" = "cycle-intent-clockwise",\
	"H" = "cycle-intent-counter-clockwise",\
	"T" = "say",\
	"O" = "ooc",\
	"L" = "looc",\
	"V" = "zoom",\
)