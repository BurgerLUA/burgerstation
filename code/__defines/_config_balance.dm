#define BITE_SIZE 5 //TODO: Make species based

#define MOVEMENT_DELAY_MOD 1 //Lower values means faster.
#define SPRINT_STAMINA_LOSS 1 //Multiplier

//Inventory sizes.
#define SIZE_0 0.5
#define SIZE_1 1
#define SIZE_2 2
#define SIZE_3 3
#define SIZE_4 4
#define SIZE_5 5
#define SIZE_6 6
#define SIZE_7 7
#define SIZE_8 8
#define SIZE_9 10
#define SIZE_X 100

//Inventory weights
#define WEIGHT_0 0.5
#define WEIGHT_1 1
#define WEIGHT_2 3
#define WEIGHT_3 5
#define WEIGHT_4 10
#define WEIGHT_5 20
#define WEIGHT_6 50
#define WEIGHT_7 75
#define WEIGHT_8 100
#define WEIGHT_X 1000

//Bullet speeds
#define BULLET_SPEED_MAX                  (TILE_SIZE-1)
#define BULLET_SPEED_SNIPER               BULLET_SPEED_MAX * 1
#define BULLET_SPEED_RIFLE_HEAVY          BULLET_SPEED_MAX * 0.8
#define BULLET_SPEED_RIFLE_LIGHT          BULLET_SPEED_MAX * 0.9
#define BULLET_SPEED_PISTOL_HEAVY         BULLET_SPEED_MAX * 0.7
#define BULLET_SPEED_PISTOL_LIGHT         BULLET_SPEED_MAX * 0.8
#define BULLET_SPEED_LARGE_PROJECTILE     BULLET_SPEED_MAX * 0.6

#define SURPLUS_PENALTY 0.9

//Battery sizes
#define CELL_SIZE_BASIC 30000
#define CELL_SIZE_ADVANCED 40000
#define CELL_SIZE_INDUSTRIAL 50000
#define CELL_SIZE_VEHICLE 100000
#define CELL_SIZE_BLUESPACE 100000

//Shuttle times
#define SHUTTLE_DEFAULT_TRANSIT_TIME 30 //In seconds.
#define SHUTTLE_DEFAULT_TRANSIT_TIME_NO_LIVING 15
#define SHUTTLE_DEFAULT_WAITING_TIME 30
#define SHUTTLE_DEFAULT_IDLE_TIME 10


//Insurance
#define INSURANCE_PAYOUT 3000


//Activity times
#define BASE_FEED_TIME 15 //In Deciseconds.
#define BASE_FEED_TIME_SELF 6

#define BASE_TREATMENT_TIME 3 //In Deciseconds.
#define BASE_TREATMENT_TIME_SELF 12

#define BASE_INJECT_TIME 4 //In, guess what, Deciseconds.
#define BASE_INJECT_TIME_SELF 4



//Ranges
#define VIEW_RANGE 11
#define ZOOM_RANGE 6

#define WHISPER_RANGE 2
#define TALK_RANGE VIEW_RANGE
#define YELL_RANGE VIEW_RANGE*1.5
#define SOUND_RANGE VIEW_RANGE + ZOOM_RANGE

#define AI_DETECTION_RANGE VIEW_RANGE * 0.6
#define AI_DETECTION_RANGE_NOISE VIEW_RANGE
#define AI_DETECTION_RANGE_CAUTION VIEW_RANGE + ZOOM_RANGE*0.5
#define AI_DETECTION_RANGE_COMBAT VIEW_RANGE + ZOOM_RANGE

#define BOSS_RANGE VIEW_RANGE + ZOOM_RANGE*2 //If you're out of this range, you're out of the boss fight.

//Probabilty
#define WEATHER_ADD_CHANCE 40
#define WEATHER_REMOVE_CHANCE 10


//Regeneration
#define HEALTH_REGEN_BUFFER_MAX 3
#define HEALTH_REGEN_BUFFER_MIN -10

#define STAMINA_REGEN_BUFFER_MAX 10
#define STAMINA_REGEN_BUFFER_MIN -10

#define MANA_REGEN_BUFFER_MAX 10
#define MANA_REGEN_BUFFER_MIN -10