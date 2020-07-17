/obj/hud/button/chargen/change_name
	name = "change name"
	desc = "Click to change your name."
	icon = 'icons/hud/nameplate.dmi'
	icon_state = "nameplate"

	screen_loc = "CENTER-1,CENTER+2"

	maptext = "<center>Invalid Name</center>"
	maptext_height = TILE_SIZE
	maptext_width = TILE_SIZE*3

	user_colors = TRUE

/obj/hud/button/chargen/change_name/update_owner(var/desired_owner)

	if(desired_owner && is_player(desired_owner))
		var/mob/living/advanced/player/P = desired_owner
		maptext = "<center>[P.real_name]</center>"

	return ..()


/obj/hud/button/chargen/change_name/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	. = ..()

	if(is_player(caller))
		var/mob/living/advanced/player/P = caller

		var/choice = input(P,"What would you like your name to be?","Name Change",P.real_name) as text|null

		if(!choice)
			return .

		if(caller.client)
			choice = police_input(caller.client,choice,40)

		if(!choice)
			return .

		P.real_name = choice
		P.setup_name()
		maptext = "<center>[P.real_name]</center>"

	return .