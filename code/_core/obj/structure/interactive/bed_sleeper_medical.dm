
/obj/structure/interactive/bed/sleeper/medical
	name = "medical sleeper"
	desc = "Medical care in the future!"
	desc_extended = "A special medical sleeper that automatically treats all manner of wounds when an occupant is inside and the door is closed. The door must be closed manually."
	base_color = "#FFFFFF"
	secondary_color = "#0094FF"

/obj/structure/interactive/bed/sleeper/medical/think()
	if(buckled || is_living(buckled))
		var/mob/living/L = buckled
		if(L.health)
			L.health.adjust_loss_smart(brute=-1,burn=-1,tox=-1,pain=-1,rad=-1,robotic=FALSE)
		if(L.blood_type)
			L.blood_volume = min(L.blood_volume + 1,L.blood_volume_max)
	return TRUE

/obj/structure/interactive/bed/sleeper/medical/close(var/mob/caller)
	var/mob/living/advanced/A = locate() in get_turf(src)
	if(A)
		buckle(A,caller)
	if(close_sound)
		play_sound(close_sound,src.loc,range_max=VIEW_RANGE)
		create_alert(VIEW_RANGE,src.loc,caller,ALERT_LEVEL_NOISE)
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
	name = "syndicate medical sleeper"
	base_color = "#303030"
	secondary_color = "#7F0000"