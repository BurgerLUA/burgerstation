/ability/dash
	name = "Dash"
	desc = "Dash towards the targeted tile. Maximum distance is 2 tiles."
	icon_state = "dash"
	cost = 10
	cooldown = SECONDS_TO_DECISECONDS(4)
	var/dash_strength = 2

/ability/dash/on_cast(var/mob/caller,var/atom/target)
	var/mob/living/L = caller
	L.dash(target,instances_left=2)
	return TRUE

/ability/dash/plus
	name = "Dash+"
	icon_state = "dash_plus"
	desc = "Dash towards the targeted tile. Maximum distance is 4 tiles."
	cooldown = SECONDS_TO_DECISECONDS(10)
	cost = 40