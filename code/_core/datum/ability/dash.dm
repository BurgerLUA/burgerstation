/ability/dash
	name = "Dash"
	desc = "Dash towards the targeted tile. Maximum distance is 3 tiles."
	icon_state = "dash"
	cost = 10
	cooldown = SECONDS_TO_DECISECONDS(4)
	var/dash_strength = 3

/ability/dash/on_cast(var/mob/caller,var/atom/target)
	var/mob/living/L = caller
	L.dash_target = target
	L.dash_amount = dash_strength
	play_sound('sound/effects/dodge.ogg',get_turf(caller))
	return TRUE

/ability/dash/plus
	name = "Dash+"
	icon_state = "dash_plus"
	desc = "Dash towards the targeted tile. Maximum distance is 5 tiles."
	dash_strength = 5
	cooldown = SECONDS_TO_DECISECONDS(10)
	cost = 40