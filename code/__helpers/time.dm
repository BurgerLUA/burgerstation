proc/get_date()
	return time2text(world.realtime,"YYMMDD") //Just don't play this game around 2100

proc/get_time()
	return time2text(world.realtime,"hhmmss")

proc/time_x_newer_than_y(var/x_date,var/x_time,var/y_date,var/y_time)

	x_date = text2num(x_date)
	x_time = text2num(x_time)

	y_date = text2num(y_date)
	y_time = text2num(y_time)

	if(x_date > y_date)
		return TRUE
	else if(x_date == y_date)
		return x_time > y_time

	return FALSE