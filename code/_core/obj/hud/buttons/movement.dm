/obj/hud/button/sneak
	name = "sneak"
	desc = "sneaker no sneaking"
	desc_extended = "Press to sneak."
	icon_state = "sneak_0"
	screen_loc = "RIGHT-3,BOTTOM"

	var/sneaking = 0

	flags = FLAGS_HUD_MOB

/obj/hud/button/sneak/clicked_on_by_object(var/mob/caller,object,location,control,params)

	if(!is_living(caller))
		return
	var/mob/living/L = caller
	L.toggle_sneak(!sneaking)

	return TRUE

/obj/hud/button/sneak/update_icon()
	icon_state = "sneak_[sneaking]"
	..()

/obj/hud/button/move
	name = "move"
	desc = "who fucking walks lmao"
	desc_extended = "Where you press determines where you click"
	icon_state = "move_1"
	screen_loc = "RIGHT-3,BOTTOM"

	var/move_mode = 2 //1 = run, 2 = jog, 3 = sprint

	flags = FLAGS_HUD_MOB

/obj/hud/button/move/update_icon()
	icon_state = "move_[move_mode]"
	..()

/obj/hud/button/move/clicked_on_by_object(var/mob/caller,object,location,control,params)

	if(params[PARAM_ICON_X] && params[PARAM_ICON_Y] && text2num(params[PARAM_ICON_Y]) >= 10)

		switch(text2num(params[PARAM_ICON_X]))
			if(1 to 10)
				caller.move_mod = 1
			if(12 to 21)
				caller.move_mod = 2
			if(23 to 32)
				caller.move_mod = 3
	else
		caller.move_mod += 1

	if(caller.move_mod > 3)
		caller.move_mod = 1

	move_mode = caller.move_mod

	update_icon()

	return TRUE