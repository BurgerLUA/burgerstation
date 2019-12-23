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


/proc/get_nice_time(var/seconds)

	var/time_list = list()

	var/day_value = floor(seconds/(60*60*24))
	time_list += "[day_value] day\s"
	seconds -= day_value*60*60*24

	var/hour_value = floor(seconds/(60*60))
	time_list += "[hour_value] hour\s"
	seconds -= hour_value*60*60

	var/minute_value = floor(seconds/60)
	time_list += "[minute_value] minute\s"
	seconds -= minute_value*60

	var/second_value = floor(seconds)
	time_list += "[seconds] second\s"
	seconds -= second_value

	return time_list

/proc/get_clock_time(var/seconds)

	var/minute_value = floor(seconds/60)
	var/second_value = seconds - minute_value*60

	var/minute_text = "[minute_value]"
	if(minute_value < 10)
		minute_text = "0[minute_text]"

	var/second_text = "[second_value]"
	if(second_value < 10)
		second_text = "0[second_value]"

	return "[minute_text]:[second_text]"

