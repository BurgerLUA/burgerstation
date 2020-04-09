#define TICK_USAGE world.tick_usage
#define TICK_LIMIT 90

#define CHECK_TICK ( (TICK_USAGE > TICK_LIMIT) ? stoplag() : FALSE )