#define CHECK_TICK(limit,max_delays) \
	if(world_state < STATE_RUNNING) {\
		while(world.tick_usage > limit) {\
			sleep(TICK_LAG * (world.tick_usage/limit)) \
		}\
	}\
	else if(world.tick_usage > limit) { \
		var/safety_count=0; \
		while(world.tick_usage > limit && (max_delays >= safety_count)) {\
			safety_count++; \
			if(limit <= 0) { \
				sleep(1) \
			} \
			else{ \
				sleep(TICK_LAG * (1 + min(FPS_SERVER,world.tick_usage/limit)*3)); \
			} \
		}\
	}

#define CHECK_TICK_HARD sleep(-1)