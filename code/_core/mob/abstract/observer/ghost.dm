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

/mob/abstract/observer/ghost/do_say(var/text_to_say, var/should_sanitize = TRUE, var/talk_type_to_use = TEXT_TALK)
	return ..(text_to_say,should_sanitize,TEXT_GHOST)

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