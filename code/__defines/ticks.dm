#define TICK_USAGE world.tick_usage
#define TICK_LIMIT 75

#define TICK_CHECK TICK_USAGE > TICK_LIMIT

#define CHECK_TICK ( TICK_CHECK ? stoplag() : FALSE )