proc/get_date()
	return text2num(time2text(world.realtime,"YYMMDD")) //Just don't play this game around 2100

proc/get_time()
	return text2num(time2text(world.realtime,"hhmmss"))

proc/time_x_newer_than_y(var/x_date,var/x_time,var/y_date,var/y_time)
	if(x_date > y_date)
		return TRUE
	else if(x_date == y_date)
		return x_time > y_time

	return FALSE