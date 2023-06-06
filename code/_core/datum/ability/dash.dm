
//Simple Dash.
/ability/dash
	name = "Dash"
	desc = "Dash in your character's movement direction. If you are not moving, you will dash in the facing direction instead. Distance is 4 tiles."
	icon_state = "dash"

	resource_type = STAMINA

	var/dash_strength = 4
	cost = 30
	cooldown = SECONDS_TO_DECISECONDS(2)

	category = "Dash"

/ability/dash/on_cast(var/mob/caller,var/atom/target,location,params)
	var/mob/living/L = caller
	L.dash_direction = L.move_dir ? L.move_dir : L.dir
	L.dash_amount = dash_strength
	play_sound('sound/effects/dodge.ogg',get_turf(caller))
	return TRUE


//Controlled Dash
/ability/dash/controlled
	name = "Controlled Dash"
	desc = "Dash towards your character's facing direction. Can be controlled mid-dash. Distance is 3 tiles."
	icon_state = "dash_plus"
	dash_strength = 3
	cooldown = SECONDS_TO_DECISECONDS(5)
	cost = 50

/ability/dash/controlled/on_cast(var/mob/caller,var/atom/target,location,params)
	var/mob/living/L = caller
	L.dash_amount = dash_strength
	play_sound('sound/effects/dodge.ogg',get_turf(caller))
	return TRUE


//Targeted Dash
/ability/dash/targeted
	name = "Targeted Dash"
	desc = "Dash towards the targeted tile. Maximum distance is 3 tiles."
	icon_state = "dash_targeted"
	dash_strength = 3
	cost = 40
	cooldown = SECONDS_TO_DECISECONDS(3)

	category = "Dash"

/ability/dash/targeted/on_cast(var/mob/caller,var/atom/target,location,params)
	var/mob/living/L = caller
	L.dash_target = target
	L.dash_amount = dash_strength
	play_sound('sound/effects/dodge.ogg',get_turf(caller))
	return TRUE

//Random dash.
/ability/dash/random
	name = "Random Dash"
	desc = "Dash in a random direction. Distance is 2 tiles."
	icon_state = "dash"
	dash_strength = 2
	cost = 10
	cooldown = SECONDS_TO_DECISECONDS(0.5)

	category = "Dash"

/ability/dash/random/on_cast(var/mob/caller,var/atom/target,location,params)
	var/mob/living/L = caller
	L.dash_direction = pick(DIRECTIONS_ALL)
	L.dash_amount = dash_strength
	play_sound('sound/effects/dodge.ogg',get_turf(caller))
	return TRUE

//Fleeting dash.
/ability/dash/fleeting
	name = "Fleeting Dash"
	desc = "Dash away from the targeted location. Distance is 2 tiles."
	icon_state = "dash"
	dash_strength = 2
	cost = 20
	cooldown = SECONDS_TO_DECISECONDS(1)

	category = "Dash"

/ability/dash/fleeting/on_cast(var/mob/caller,var/atom/target,location,params)
	var/mob/living/L = caller
	L.dash_direction = get_dir(target,caller)
	L.dash_amount = dash_strength
	play_sound('sound/effects/dodge.ogg',get_turf(caller))
	return TRUE



