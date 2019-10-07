/area/singleplayer/
	name = "local area"
	desc = "Players cannot see or hear other players in this area."
	icon = 'icons/area/safezone.dmi'
	icon_state = "one"
	dynamic_lighting = TRUE
	safe = TRUE

/area/singleplayer/exterior
	area_light_power = DEFAULT_BRIGHTNESS_MUL_EXTERIOR

/area/singleplayer/exterior/river_lights
	icon_state = "blue"

	sunlight_freq = 4

	desired_light_range = 4
	desired_light_power = 1
	desired_light_color = "#1E6489"

/area/singleplayer/interior
	icon_state = "one_alt"
	area_light_power = DEFAULT_BRIGHTNESS_MUL_INTERIOR

/area/singleplayer/Entered(var/atom/movable/enterer,var/atom/old_loc)
	. = ..()
	if(. && is_player(enterer))
		var/mob/living/advanced/player/P = enterer
		P.see_invisible = INVISIBILITY_NO_PLAYERS

	return .


/area/singleplayer/Exited(var/atom/movable/exiter,var/atom/old_loc)
	. = ..()
	if(. && is_player(exiter))
		var/mob/living/advanced/player/P = exiter
		P.see_invisible = initial(P.see_invisible)

	return .