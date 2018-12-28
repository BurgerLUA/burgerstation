var/global/list/all_mobs = list()
/mob/
	name = "MOB ERROR"
	icon = 'icons/debug/mobs.dmi'
	icon_state = ""
	step_size = 64
	step_
	layer = LAYER_MOB





	var/tmp/list/action_list = list()


/mob/New()
	all_mobs += src

/mob/proc/on_life_client()
	handle_movement()
	return TRUE


/mob/proc/on_life()
	return TRUE












/*
/mob/Destroy() //TODO: Destroy system
	all_mobs -= src
*/