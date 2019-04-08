proc/should_static_view()
	return (VIEW_RANGE >= world.maxx/2 || VIEW_RANGE >= world.maxy/2)


//Stolen from /tg/
/proc/stoplag()
	while(world.cpu >= 90 || world.tick_usage >= 90)
		sleep(TICK_LAG)