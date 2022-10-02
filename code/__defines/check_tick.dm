#define DESIRED_TICK_LIMIT 99

#define CHECK_TICK_HARD(limit) \
	while(world.tick_usage > limit) {\
		sleep(TICK_LAG * (world.tick_usage/limit)) \
	}


#define CHECK_TICK_SAFE(limit,max_delays) \
	if(world_state != STATE_STARTING) {\
		CHECK_TICK_HARD(DESIRED_TICK_LIMIT)\
	}\
	else if(world.tick_usage > limit) { \
		var/safety_count=0; \
		while(world.tick_usage > limit && (max_delays <= safety_count)) {\
			safety_count++; \
			sleep(TICK_LAG * (world.tick_usage/limit)); \
		}\
	}
