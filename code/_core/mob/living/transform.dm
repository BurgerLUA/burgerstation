/mob/living/proc/get_horizontal()
	return dead || (grabbing_hand && grabbing_hand.grab_level >= 2) || has_status_effects(STUN,STAMCRIT,SLEEP,CRIT,REST,PAINCRIT)

/mob/living/proc/get_elevation()
	. = 0
	if(on_table)
		. += 10
	if(horizontal)
		. -= 14

/mob/living/proc/get_turn()
	. = 0
	if(horizontal)
		. += stun_angle


/mob/living/proc/get_plane()
	if(is_sneaking)
		return PLANE_MOB_STEALTH
	else if(horizontal)
		return PLANE_MOB_SMALL
	return initial(plane)

/mob/living/proc/handle_transform(var/force=FALSE)

	.  = FALSE

	var/time = 1

	var/desired_horizontal = get_horizontal()
	if(force || desired_horizontal != horizontal)
		horizontal = desired_horizontal
		. = TRUE
		if(horizontal)
			update_collisions(FLAG_COLLISION_CRAWLING)
			play_sound(pick('sound/effects/impacts/bodyfall2.ogg','sound/effects/impacts/bodyfall3.ogg','sound/effects/impacts/bodyfall4.ogg'),get_turf(src), volume = 25,range_max=VIEW_RANGE*0.5)
		else
			update_collisions(initial(collision_flags))
		if(!buckled_object)
			stun_angle *= pick(-1,1) //Alternate

	var/desired_turn = get_turn()
	if(force || turn != desired_turn)
		turn = desired_turn
		. = TRUE

	var/desired_elevation = get_elevation()
	if(force || elevation != desired_elevation)
		elevation = desired_elevation
		. = TRUE
		if(elevation >= 0)
			time += 2

	if(.)
		var/matrix/M = get_base_transform()
		M.Turn(turn)
		if(!buckled_object)
			M.Translate(sin(turn)*4,elevation)
		animate(src,transform = M, time = time) //flags = CIRCULAR_EASING | EASE_OUT

	var/desired_plane = get_plane()
	if(force || desired_plane != plane)
		plane = desired_plane

	return .