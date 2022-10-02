
/obj/structure/interactive/bed/sleeper/medical
	name = "medical sleeper"
	desc = "Medical care in the future!"
	desc_extended = "A special medical sleeper that automatically treats all manner of wounds when an occupant is inside and the door is closed. The door must be closed manually."
	base_color = "#FFFFFF"
	secondary_color = "#0094FF"
	tertiary_color = "#0094FF"
	var/advanced = FALSE
	var/heal_multiplier = 1

/obj/structure/interactive/bed/sleeper/medical/weak
	name = "consumer grade medical sleeper"
	base_color = "#A59FBC"
	secondary_color = "#009469"
	tertiary_color = "#D8D8EC"
	heal_multiplier = 0.25

/obj/structure/interactive/bed/sleeper/medical/think()

	if(door_state == SLEEPER_CLOSED && buckled && is_living(buckled))
		var/mob/living/L = buckled
		L.brute_regen_buffer = min(L.brute_regen_buffer+heal_multiplier,10*heal_multiplier)
		L.burn_regen_buffer = min(L.burn_regen_buffer+heal_multiplier,10*heal_multiplier)
		L.tox_regen_buffer = min(L.tox_regen_buffer+heal_multiplier,10*heal_multiplier)
		L.pain_regen_buffer = min(L.pain_regen_buffer+heal_multiplier,10*heal_multiplier)
		if(advanced)
			L.rad_regen_buffer = min(L.rad_regen_buffer+heal_multiplier,1)
			L.sanity_regen_buffer = min(L.sanity_regen_buffer+heal_multiplier,10*heal_multiplier)
			L.mental_regen_buffer = min(L.mental_regen_buffer+heal_multiplier,10*heal_multiplier)
			if(L.blood_type)
				if(L.blood_volume > L.blood_volume_max)
					L.blood_volume = max(L.blood_volume - heal_multiplier,L.blood_volume_max)
				else if(L.blood_volume < L.blood_volume_max)
					L.blood_volume = min(L.blood_volume + heal_multiplier,L.blood_volume_max)

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
	STOP_THINKING(src)
	return TRUE

/obj/structure/interactive/bed/sleeper/medical/on_close(var/mob/caller)
	door_state = SLEEPER_CLOSED
	opened_time = 0
	update_icon()
	check_collisions()
	START_THINKING(src)
	return TRUE

/obj/structure/interactive/bed/sleeper/medical/syndicate
	name = "syndicate advanced medical sleeper"
	base_color = "#303030"
	secondary_color = "#7F0000"
	tertiary_color = "#7F0000"
	advanced = TRUE