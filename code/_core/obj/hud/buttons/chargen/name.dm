/obj/hud/button/chargen/change_name
	name = "change name"
	desc = "What's in a name?"
	desc_extended = "Your current character's name. Click here to change it. Names are limited to latin characters only, with no numbers."
	icon = 'icons/hud/nameplate.dmi'
	icon_state = "nameplate"

	screen_loc = "CENTER-1,CENTER+2"

	maptext = "<center>Invalid Name</center>"
	maptext_y = 5
	maptext_height = TILE_SIZE
	maptext_width = TILE_SIZE*3

	user_colors = TRUE

/obj/hud/button/chargen/change_name/update_owner(var/mob/desired_owner)

	if(desired_owner && is_player(desired_owner))
		var/mob/living/advanced/player/P = desired_owner
		maptext = "<center>[P.real_name]</center>"

	return ..()


/obj/hud/button/chargen/change_name/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	. = ..()

	if(is_player(caller) && caller.client)
		var/mob/living/advanced/player/P = caller

		var/choice = input(P,"What would you like your name to be?","Name Change",P.real_name) as text|null

		if(!choice) return

		if(caller.client)
			choice = police_text(P.client,choice,check_name=TRUE,check_characters=TRUE,min_length=2,max_length=40)

		if(!choice) return

		P.real_name = choice
		P.setup_name()
		maptext = "<center>[P.real_name]</center>"

