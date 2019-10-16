/mob/living/simple/npc/silicon/
	name = "robot"
	icon = 'icons/mob/living/simple/robots.dmi'
	icon_state = "robot_old"

	damage_type = "cult_blade"


/mob/living/simple/npc/silicon/engineer
	name = "engineer cyborg"
	icon_state = "engineer"

	damage_type = "cult_blade"


/mob/living/simple/npc/silicon/engineer/Initialize()
	..()
	flick("engineer_transform",src)


/mob/living/simple/npc/silicon/squats
	name = "S.Q.U.A.T.S."
	icon_state = "squats"

	damage_type = "cult_blade"


/mob/living/simple/npc/silicon/squats/update_icon()

	if(!health)
		return ..()


	if(icon_state == "squats-roll" || (health.get_overall_health() / health.health_max) <= 0.5 )
		return ..()
	var/icon/new_icon = icon(icon,icon_state)
	var/icon/shield_icon = icon(icon,"squats-shield")
	new_icon.Blend(shield_icon,ICON_OVERLAY)
	icon = new_icon

/mob/living/simple/npc/silicon/squats/on_sprint()
	. = ..()
	if(.)
		if(icon_state != "squats-roll")
			icon_state = "squats-roll"
			update_icon()

	return .

/mob/living/simple/npc/silicon/squats/on_jog()
	. = ..()
	if(.)
		if(icon_state != "squats")
			icon_state = "squats"
			update_icon()

	return .

/mob/living/simple/npc/silicon/squats/on_walk()
	. = ..()
	if(.)
		if(icon_state != "squats")
			icon_state = "squats"
			update_icon()

	return .