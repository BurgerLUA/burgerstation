/mob/living/proc/get_horizontal()
	return dead || (grabbing_hand && grabbing_hand.grab_level >= 2) || has_status_effects(STUN,STAMCRIT,SLEEP,CRIT,REST,PAINCRIT)

/mob/living/proc/get_elevation()
	. = 0
	if(on_table)
		. += 10
	if(on_liquid > 0)
		. -= on_liquid
	else if(horizontal)
		. += stun_elevation

/mob/living/proc/get_turn()
	. = 0
	if(horizontal)
		. += stun_angle


/mob/living/proc/get_plane()
	if(horizontal)
		return PLANE_MOVABLE_DEAD
	if(is_sneaking)
		return PLANE_MOVABLE_STEALTH
	return initial(plane)

/mob/living/proc/handle_transform(var/force=FALSE)

	.  = FALSE

	if(qdeleting)
		return .

	var/time = 1

	var/desired_horizontal = get_horizontal()
	if(force || desired_horizontal != horizontal)
		horizontal = desired_horizontal
		. = TRUE
		if(horizontal)
			update_collisions(FLAG_COLLISION_CRAWLING)
			play_sound(pick('sound/effects/impacts/bodyfall2.ogg','sound/effects/impacts/bodyfall3.ogg','sound/effects/impacts/bodyfall4.ogg'),get_turf(src), volume = 25,range_max=VIEW_RANGE*0.5)
			can_be_bumped = TRUE
		else
			update_collisions(initial(collision_flags))
			can_be_bumped = initial(can_be_bumped)
		if(!buckled_object)
			stun_angle *= pick(-1,1) //Alternate
		handle_blocking()

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

	var/x_mod = 0
	var/y_mod = 0
	if(grabbed)
		var/list/offsets = get_directional_offsets(src,grabbing_hand.owner)
		x_mod = offsets[1]*8
		y_mod = offsets[2]*8
		. = TRUE
		grabbed = grabbing_hand?.owner ? TRUE : FALSE

	if(.)
		var/matrix/M = get_base_transform()
		M.Turn(turn)
		if(!buckled_object)
			M.Translate(x_mod + sin(turn)*4,y_mod + elevation)
		animate(src,transform = M, time = time) //flags = CIRCULAR_EASING | EASE_OUT

	var/desired_plane = get_plane()
	if(force || desired_plane != plane)
		plane = desired_plane

	return .