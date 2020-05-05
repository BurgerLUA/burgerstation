/client/proc/post_move(var/atom/old_loc,var/atom/new_loc)

	if(mob)
		for(var/obj/parallax/P in mob.parallax)
			var/desired_x = FLOOR(-(mob.x - (WORLD_SIZE*0.5)) * P.ratio,1)
			var/desired_y = FLOOR(-(mob.y - (WORLD_SIZE*0.5)) * P.ratio,1)
			P.screen_loc = "CENTER-7:[desired_x],CENTER-7:[desired_y]"

	return TRUE
