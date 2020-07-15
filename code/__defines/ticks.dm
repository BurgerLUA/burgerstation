#define TICK_USAGE world.tick_usage
#define TICK_LIMIT 90 //This is default.

#define CHECK_TICK ( (TICK_USAGE > TICK_LIMIT) ? stoplag() : FALSE )


#define CHECK_TICK_ADV(v) ( (TICK_USAGE > v) ? stoplag(v) : FALSE )