/mob/abstract/observer/ghost

	alpha = 100
	anchored = FALSE

	spawning_buttons = list(
		/obj/hud/button/new_character,
		/obj/hud/button/load_character
	)

/mob/abstract/observer/ghost/proc/add_verbs()
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