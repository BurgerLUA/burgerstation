/mob/abstract/observer/ghost

	alpha = 200
	anchored = FALSE

	spawning_buttons = list(
		/obj/hud/button/new_character,
		/obj/hud/button/load_character,
		/obj/hud/button/become_antag,
		/obj/hud/button/teleport_to_player
	)

	invisibility = INVISIBLITY_GHOST
	see_invisible = INVISIBLITY_GHOST

	density = FALSE

/mob/abstract/observer/ghost/get_lighting_alpha()
	return 100

/mob/abstract/observer/ghost/do_say(text_to_say, should_sanitize = TRUE, talk_type_to_use = TEXT_TALK,talk_range=TALK_RANGE,language_to_use=null)
	talk_type_to_use = TEXT_GHOST
	return ..()

/mob/abstract/observer/ghost/add_inherent_verbs()
	verbs += /mob/abstract/observer/ghost/verb/move_up
	verbs += /mob/abstract/observer/ghost/verb/move_down
	return ..()

/mob/abstract/observer/ghost/verb/move_up()
	set name = "Move Up"
	set category = "Game"
	var/turf/T = locate(x,y,z+1)

	if(T)
		force_move(T)

/mob/abstract/observer/ghost/verb/move_down()
	set name = "Move Down"
	set category = "Game"
	var/turf/T = locate(x,y,z-1)

	if(T)
		force_move(T)