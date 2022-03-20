
/obj/structure/interactive/bed/sleeper/medical
	name = "medical sleeper"
	desc = "Medical care in the future!"
	desc_extended = "A special medical sleeper that automatically treats all manner of wounds when an occupant is inside and the door is closed. The door must be closed manually."
	base_color = "#FFFFFF"
	secondary_color = "#0094FF"
	tertiary_color = "#0094FF"
	var/advanced = FALSE

/obj/structure/interactive/bed/sleeper/medical/think()
	if(door_state == SLEEPER_CLOSED && buckled && is_living(buckled))
		var/mob/living/L = buckled
		L.brute_regen_buffer = min(L.brute_regen_buffer+1,10)
		L.burn_regen_buffer = min(L.burn_regen_buffer+1,10)
		L.tox_regen_buffer = min(L.tox_regen_buffer+1,10)
		L.pain_regen_buffer = min(L.pain_regen_buffer+1,10)
		if(advanced)
			L.rad_regen_buffer = min(L.rad_regen_buffer+1,1)
			L.sanity_regen_buffer = min(L.sanity_regen_buffer+1,10)
			L.mental_regen_buffer = min(L.mental_regen_buffer+1,10)
			if(L.blood_type)
				L.blood_volume = min(L.blood_volume + 1,L.blood_volume_max)
	return TRUE

/obj/structure/interactive/bed/sleeper/medical/close(var/mob/caller)
	if(!buckled)
		var/mob/living/advanced/A = locate() in get_turf(src)
		if(A)
			buckle(A,caller)
	if(close_sound)
		play_sound(close_sound,src.loc,range_max=VIEW_RANGE)
	door_state = SLEEPER_CLOSING
	update_icon()
	CALLBACK("on_close_\ref[src]",close_time,src,.proc/on_close,caller)

/obj/structure/interactive/bed/sleeper/medical/on_open(var/mob/caller)
	door_state = SLEEPER_OPENED
	opened_time = 0
	update_icon()
	check_collisions()
	stop_thinking(src)
	return TRUE

/obj/structure/interactive/bed/sleeper/medical/on_close(var/mob/caller)
	door_state = SLEEPER_CLOSED
	opened_time = 0
	update_icon()
	check_collisions()
	start_thinking(src)
	return TRUE

/obj/structure/interactive/bed/sleeper/medical/syndicate
	name = "syndicate advanced medical sleeper"
	base_color = "#303030"
	secondary_color = "#7F0000"
	tertiary_color = "#7F0000"
	advanced = TRUE