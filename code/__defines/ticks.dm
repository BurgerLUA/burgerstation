#define LIFE_TICK 5 //Deciseconds per life tick interval.
#define LIFE_TICK_SLOW 10 //Deciseconds per slow life tick interval.
#define AI_TICK 2 //Deciseconds per AI tick interval.
#define BOSS_TICK 1 //Deciseconds per boss tick interval. Also handles movement.

#define CLIENT_TICK 2 //FRAMES per life tick interval
#define CLIENT_TICK_SLOW FPS_SERVER //FRAMES per slow life tick internval
#define PROJECTILE_TICK 2 //FRAMES per Sprojectile tick interval

#define CLIENT_TICKS_PER_SLOW_CLIENT_TICKS (CLIENT_TICK_SLOW / CLIENT_TICK)
#define LIFE_TICKS_PER_SLOW_LIFE_TICKS (LIFE_TICK_SLOW / LIFE_TICK)