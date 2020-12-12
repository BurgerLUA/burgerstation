#define CHECK_TICK(limit,max_delays) \
	if(world.tick_usage > limit) { \
		var/safety_count=0; \
		while(world.tick_usage > limit && (max_delays <= safety_count || !max_delays)) {\
			safety_count++; \
			sleep(TICK_LAG); \
		}\
	}

