/mob/living/vehicle/mech
	name = "mech"
	desc = "Weaponized Anime."
	desc_extended = "A humanoid armoured weapons platform that can be modified with an array of different parts and weapon modules to navigate and perform in any environment. Manufactures its own ammo using internal battery power, making it highly self-sufficient and expensive."
	icon = 'icons/obj/vehicles/mechs.dmi'

	collision_flags = FLAG_COLLISION_WALKING
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC

	anchored = TRUE

	movement_delay = DECISECONDS_TO_TICKS(4)

	change_dir_on_move = FALSE

	blood_type = /reagent/blood/robot
	blood_volume = 1000

/mob/living/vehicle/mech/get_footsteps(var/list/original_footsteps,var/enter=TRUE)
	return original_footsteps + /footstep/mech_step

/mob/living/vehicle/mech/set_dir(var/desired_dir,var/force=FALSE)

	. = ..()

	if(.)
		var/turf/T = get_turf(src)
		play_sound('sound/effects/footsteps/mechmove.ogg',T)
		if(length(passengers) && passengers[1])
			create_alert(VIEW_RANGE,T,passengers[1],ALERT_LEVEL_NOISE)


/mob/living/vehicle/mech/Move(NewLoc,Dir=0,step_x=0,step_y=0)
	var/real_dir = get_dir(src,NewLoc)
	if(real_dir & dir)
		return ..()
	set_dir(real_dir)
	return FALSE

/mob/living/vehicle/mech/post_death()
	. = ..()
	update_sprite()

/mob/living/vehicle/mech/get_movement_delay()
	return movement_delay

/mob/living/vehicle/mech/update_icon()

	icon_state = initial(icon_state)

	if(dead)
		icon_state = "[icon_state]_dead"
	else if(!ai && !length(passengers))
		icon_state = "[icon_state]_open"

	..()