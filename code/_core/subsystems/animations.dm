/datum/subsystem/animations/
	name = "Mob Animation Subsystem"
	desc = "Controls animations for player controled mobs."
	tick_rate = 1
	priority = 100

/datum/subsystem/animations/on_life()
	for(var/mob/M in all_mobs)
		var/animation_count = 0
		var/list/current_animations = list("pixel_x" = 0, "pixel_y" = 0, "dir" = 0)
		for(var/datum/animation/A in M.animations)
			if(A.delay > 0)
				A.delay -= tick_rate * TICK_LAG
				continue

			if(A.time <= 0)
				M.animations -= A
				qdel(A)
				continue

			var/time_to_remove = min(A.time,tick_rate * TICK_LAG)
			A.time -= time_to_remove
			animation_count += 1
			current_animations["pixel_x"] += A.inital_time ? A.pixel_x * (time_to_remove/A.inital_time) : A.pixel_x
			current_animations["pixel_y"] += A.inital_time ? A.pixel_y * (time_to_remove/A.inital_time) : A.pixel_y
			current_animations["dir"] += A.dir

		if(animation_count)
			current_animations["pixel_x"] = current_animations["pixel_x"] / animation_count
			current_animations["pixel_y"] = current_animations["pixel_y"] / animation_count
			M.animation_pixel_x += current_animations["pixel_x"]
			M.animation_pixel_y += current_animations["pixel_y"]

			M.pixel_x = round(M.animation_pixel_x,1)
			M.pixel_y = round(M.animation_pixel_y,1)


	return TRUE

/mob/proc/add_animation(var/pixel_x = 0, var/pixel_y = 0, var/dir = 0, var/time = 0, var/delay = 0)
	//time = how long to perform the animation for
	//delay = wait until how long to start this animation
	animations += new /datum/animation(src,pixel_x,pixel_y,dir,time,delay)
	return TRUE

/datum/animation/
	var/pixel_x = 0
	var/pixel_y = 0
	var/dir = 0
	var/time = 0
	var/delay = 0
	var/inital_time = 0
	var/mob/owner

/datum/animation/New(var/mob/M,var/px,var/py,var/new_dir,var/animation_time,var/animation_delay)
	owner = M
	pixel_x = px
	pixel_y = py
	dir = new_dir
	inital_time = animation_time
	time = animation_time
	delay = animation_delay