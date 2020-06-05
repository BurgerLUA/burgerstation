/mob/abstract/observer/
	name = "observer"
	desc = "Forever damned. Their spirit is powered by pure salt."
	desc_extended = "Those who perish in this world turn into these beings to then later be resurrected to die again and again."
	icon = 'icons/mob/abstract/ghosts.dmi'
	icon_state = "basic"
	invisibility = INVISIBLITY_GHOST
	see_invisible = INVISIBLITY_GHOST

	layer = LAYER_GHOST

	movement_delay = 1

	var/list/spawning_buttons = list(
		/obj/hud/button/menu/title,
		/obj/hud/button/menu/selection/character_new,
		/obj/hud/button/menu/selection/character_load,
		/obj/hud/button/menu/selection/observe,
		/obj/hud/button/menu/selection/macros
	)

	collision_flags = FLAG_COLLISION_ETHEREAL
	collision_bullet_flags = FLAG_COLLISION_BULLET_NONE

	var/savedata/client/mob/mobdata

	damage_type = null //Just in case.

	acceleration_mod = 1.5
	acceleration = 10
	deceleration = 5

	alpha = 0

	anchored = TRUE

/mob/abstract/observer/do_say(var/text_to_say, var/should_sanitize = TRUE, var/talk_type_to_use = TEXT_TALK)
	return ..(text_to_say,should_sanitize,TEXT_GHOST)

/mob/abstract/observer/on_left_click(var/atom/object,location,control,params)
	if(src.click_on_object(src,object,location,control,params))
		return TRUE
	return ..()

/mob/abstract/observer/on_right_click(var/atom/object,location,control,params)
	if(src.click_on_object(src,object,location,control,params))
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

	if(!mobdata)
		mobdata = new(client)

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