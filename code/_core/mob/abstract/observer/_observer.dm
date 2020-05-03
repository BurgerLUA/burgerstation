/mob/abstract/observer/
	name = "observer"
	desc = "Forever damned. Their spirit is powered by pure salt."
	desc_extended = "Those who perish in this world turn into these beings to then later be resurrected to die again and again."
	icon = 'icons/mob/abstract/ghosts.dmi'
	icon_state = "basic"
	//ghost = TRUE
	layer = LAYER_GHOST

	movement_delay = 1

	var/list/spawning_buttons = list(
		/obj/hud/button/load_character,
		/obj/hud/button/new_character
	)

	collision_flags = FLAG_COLLISION_ETHEREAL
	collision_bullet_flags = FLAG_COLLISION_BULLET_NONE

	var/savedata/client/mob/mobdata

	damage_type = null //Just in case.

	acceleration_mod = 1.5
	acceleration = 10
	deceleration = 5

/mob/abstract/observer/on_left_click(var/atom/object,location,control,params)
	if(src.click_on_object(src,object,location,control,params))
		return TRUE
	return ..()

/mob/abstract/observer/on_right_click(var/atom/object,location,control,params)
	if(src.click_on_object(src,object,location,control,params))
		return TRUE
	return ..()

/mob/abstract/observer/can_attack(var/atom/victim,var/atom/weapon,var/params)
	return FALSE

/mob/abstract/observer/can_be_attacked(var/atom/attacker)
	return FALSE

/mob/abstract/observer/Logout()
	. = ..()
	qdel(src)
	return .

/mob/abstract/observer/Initialize()

	. = ..()

	if(!client)
		qdel(src)
		CRASH("Tired to initialize an observer without a client!")
		return FALSE

	if(!mobdata)
		mobdata = new(client)

	name = "ghost of [ckey]"

	for(var/v in spawning_buttons)
		var/obj/hud/button/B = new v
		B.update_owner(src)

	to_chat(span("notice","Please load a character or create a new character to play using the buttons below."))

	return .


/mob/abstract/observer/update_eyes()

	. = ..()

	sight |= SEE_THRU

	return .