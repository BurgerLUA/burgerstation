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

	sight = SEE_THRU | SEE_PIXELS

/mob/abstract/observer/on_left_click(var/atom/object,location,control,params)
	if(src.click_on_object(src,object,location,control,params))
		return TRUE
	if(object.clicked_on_by_object(src,src,location,control,params))
		return TRUE
	return ..()

/mob/abstract/observer/on_right_click(var/atom/object,location,control,params)
	return on_left_click(object,location,control,params)

/mob/abstract/observer/on_right_down(var/atom/object,location,control,params)
	return on_left_click(object,location,control,params)

/mob/abstract/observer/on_left_down(var/atom/object,location,control,params)
	return on_left_click(object,location,control,params)

/mob/abstract/observer/MouseDrop(var/atom/over_object, var/atom/src_location, var/atom/over_location, src_control, over_control, params)
	. = ..()
	if(over_object)
		if(is_player(over_object))
			if(!client || !(client.permissions & FLAG_PERMISSION_MODERATOR))
				return
			if(alert("Do you want to possess this mob?", "Switch Ckey", "Yes", "No") != "Yes") return
			if(!over_object || !src) return //Extra checks
			var/mob/living/advanced/player/P = over_object
			client.control_mob(P)
			P.add_species_buttons()
			QUEUE_HEALTH_UPDATE(P)

/mob/abstract/observer/can_attack(var/atom/attacker,var/atom/victim,var/atom/weapon,var/params,var/damagetype/damage_type)
	return FALSE

/mob/abstract/observer/can_be_attacked(var/atom/attacker,var/atom/weapon,var/params,var/damagetype/damage_type)
	return FALSE

/mob/abstract/observer/Logout()
	. = ..()
	if(src.qdeleting)
		return .
	qdel(src)

/mob/abstract/observer/Initialize()

	. = ..()

	if(!client)
		qdel(src)
		CRASH("Tired to initialize an observer without a client!")

	name = "ghost of [ckey]"

	for(var/v in spawning_buttons)
		var/obj/hud/button/B = new v(src)
		B.update_owner(src)

	to_chat(span("notice","Please load a character or create a new character to play using the buttons below."))

	for(var/k in SSlanguage.all_languages)
		src.known_languages |= k