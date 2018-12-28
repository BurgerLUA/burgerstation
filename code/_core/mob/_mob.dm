var/global/list/all_mobs = list()
/mob/
	name = "MOB ERROR"
	icon = 'icons/debug/mobs.dmi'
	icon_state = ""
	layer = LAYER_MOB

	var/tmp/list/action_list = list()

	var/tmp/movement_flags = 0x0

	movement_delay = 4

/mob/New()
	all_mobs += src

/mob/proc/on_life_client()
	handle_movement(TRUE)
	return TRUE

/mob/proc/on_life()
	return TRUE

/mob/get_movement_delay()

	var/movedelay = movement_delay

	if(movement_flags & MOVEMENT_CROUCHING)
		movedelay *= 2

	if(movement_flags & MOVEMENT_WALKING)
		movedelay *= 2

	if(movement_flags & MOVEMENT_RUNNING)
		movedelay *= 0.5

	return movedelay

/*
/mob/Destroy() //TODO: Destroy system
	all_mobs -= src
*/