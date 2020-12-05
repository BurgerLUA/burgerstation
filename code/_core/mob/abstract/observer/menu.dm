/mob/abstract/observer/menu

	spawning_buttons = list(
		/obj/hud/button/menu/title,
		/obj/hud/button/menu/selection/character_new,
		/obj/hud/button/menu/selection/character_load,
		/obj/hud/button/menu/selection/join_antagonist,
		/obj/hud/button/menu/selection/observe,
		/obj/hud/button/menu/selection/macros
	)

	alpha = 0

	anchored = TRUE

	var/current_lobby_position = 1
	var/next_lobby_cycle = SECONDS_TO_DECISECONDS(10)

	invisibility = INVISIBILITY_ALWAYS

/mob/abstract/observer/menu/do_say(var/text_to_say, var/should_sanitize = TRUE, var/talk_type_to_use = TEXT_TALK,var/talk_range=TALK_RANGE,var/language_to_use=null)
	return FALSE

/mob/abstract/observer/menu/think()

	. = ..()

	var/positions = length(lobby_positions)

	if(positions)
		next_lobby_cycle -= 1 //This runs every decisecond.
		if(next_lobby_cycle <= 0)
			current_lobby_position++
			if(current_lobby_position >= positions)
				current_lobby_position = 1
			force_move(get_turf(lobby_positions[current_lobby_position]))
			next_lobby_cycle = initial(next_lobby_cycle)

	return .

/mob/abstract/observer/menu/PostInitialize()
	. = ..()
	start_thinking(src)
	return .