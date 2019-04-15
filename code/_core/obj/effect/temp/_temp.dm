obj/effect/temp
	name = "temp effect"
	desc = "Effect that gets deleted after a while."
	var/duration = 10 //Deciseconds

obj/effect/temp/New(var/desired_location,var/desired_time)
	..()
	if(desired_time)
		duration = desired_time
	queue_delete(src,duration)

