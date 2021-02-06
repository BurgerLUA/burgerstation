/mob/abstract/observer/
	name = "observer"
	desc = "Forever damned. Their spirit is powered by pure salt."
	desc_extended = "Those who perish in this world turn into these beings to then later be resurrected to die again and again."
	icon = 'icons/mob/abstract/ghosts.dmi'
	icon_state = "basic"

	invisibility = INVISIBILITY_DEFAULT
	see_invisible = INVISIBILITY_DEFAULT

	layer = LAYER_GHOST

	movement_delay = 1

	var/list/spawning_buttons = list()

	collision_flags = FLAG_COLLISION_ETHEREAL
	collision_bullet_flags = FLAG_COLLISION_BULLET_NONE

	damage_type = null //Just in case.

/mob/abstract/observer/on_left_click(var/atom/object,location,control,params)
	if(src.click_on_object(src,object,location,control,params))
		return TRUE
	if(object.clicked_on_by_object(src,src,location,control,params))
		return TRUE
	return ..()

/mob/abstract/observer/on_right_click(var/atom/object,location,control,params)
	if(src.click_on_object(src,object,location,control,params))
		return TRUE
	if(object.clicked_on_by_object(src,src,location,control,params))
		return TRUE
	return ..()

/mob/abstract/observer/can_attack(var/atom/victim,var/atom/weapon,var/params,var/damagetype/damage_type)
	return FALSE

/mob/abstract/observer/can_be_attacked(var/atom/attacker,var/atom/weapon,var/params,var/damagetype/damage_type)
	return FALSE

/mob/abstract/observer/Logout()
	. = ..()
	if(!src.qdeleting) qdel(src)
	return .

/mob/abstract/observer/Initialize()

	. = ..()

	if(!client)
		qdel(src)
		CRASH_SAFE("Tired to initialize an observer without a client!")
		return FALSE

	name = "ghost of [ckey]"

	for(var/v in spawning_buttons)
		var/obj/hud/button/B = new v(src)
		B.update_owner(src)

	to_chat(span("notice","Please load a character or create a new character to play using the buttons below."))

	return .


/mob/abstract/observer/update_eyes()

	. = ..()

	sight |= SEE_THRU

	return .