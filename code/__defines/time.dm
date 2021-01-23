#define TICK_LAG (10 / FPS_SERVER)

#define DECISECONDS_TO_TICKS(x) ((x) * FPS_SERVER * 0.1)
#define TICKS_TO_DECISECONDS(x) (((x) / FPS_SERVER) * 10)

#define SECONDS_TO_TICKS(x) (FPS_SERVER * x)
#define TICKS_TO_SECONDS(x) ((x)/FPS_SERVER)


#define MINUTES_TO_SECONDS(x) ((x) * 60)


#define SECONDS_TO_DECISECONDS(x) ((x) * 10)
#define DECISECONDS_TO_SECONDS(x) ((x) / 10)
