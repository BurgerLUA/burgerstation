#define CHECK_TICK(limit,max_delays) \
	if(limit <= 0 || world_state < STATE_RUNNING) { \
		CHECK_TICK_HARD\
	}\
	else if(world.tick_usage > limit) { \
		var/safety_count=0; \
		while(world.tick_usage > limit && (max_delays >= safety_count)) {\
			var/time_to_sleep = CEILING(1 + (world.tick_usage - limit)/5,1); \
			safety_count += time_to_sleep; \
			sleep(TICK_LAG * time_to_sleep) \
		}\
	}

#define CHECK_TICK_HARD sleep(-1)