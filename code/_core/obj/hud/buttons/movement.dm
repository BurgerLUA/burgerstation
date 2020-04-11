/obj/hud/button/sneak
	name = "sneak"
	desc = "sneaker no sneaking"
	desc_extended = "Press to sneak."
	icon_state = "sneak_0"
	screen_loc = "RIGHT-2,BOTTOM"

	var/sneaking = 0

	flags = FLAGS_HUD_MOB

/obj/hud/button/sneak/clicked_on_by_object(var/mob/caller,object,location,control,params)

	if(!is_living(caller))
		return
	var/mob/living/L = caller
	L.toggle_sneak(!sneaking)

	return ..()

/obj/hud/button/sneak/update_icon()
	icon_state = "sneak_[sneaking]"
	..()

/obj/hud/button/move
	name = "move"
	desc = "who fucking walks lmao"
	desc_extended = "Where you press determines where you click"
	icon_state = "move_1"
	screen_loc = "RIGHT-2,BOTTOM"

	var/move_mod_button = 0

	flags = FLAGS_HUD_MOB

/obj/hud/button/move/update_icon()
	icon_state = "move_[move_mod_button+2]"
	..()

/obj/hud/button/move/clicked_on_by_object(var/mob/caller,object,location,control,params)

	if(params[PARAM_ICON_X] && params[PARAM_ICON_Y] && text2num(params[PARAM_ICON_Y]) >= 10)

		switch(text2num(params[PARAM_ICON_X]))
			if(1 to 10)
				caller.move_mod_button = -1
			if(12 to 21)
				caller.move_mod_button = 0
			if(23 to 32)
				caller.move_mod_button = 1
	else
		move_mod_button += 1

	if(caller.move_mod_button > 1)
		caller.move_mod_button = -1

	move_mod_button = caller.move_mod_button

	update_sprite()

	return ..()

/obj/hud/button/rest
	name = "rest"
	desc = "No sleeping on the job!"
	desc_extended = "Press to toggle laying down."
	icon_state = "rest"
	screen_loc = "RIGHT,BOTTOM+1"

	flags = FLAGS_HUD_MOB

/obj/hud/button/rest/clicked_on_by_object(var/mob/caller,object,location,control,params)

	if(is_living(caller))
		var/mob/living/L = caller
		if(L.rest_time == 0)
			L.rest_time = -1
			L.check_status_effects()
		else if(L.rest_time == -1)
			L.rest_time = 5
			L.check_status_effects()

	return ..()


/obj/hud/button/stand
	name = "rest"
	desc = "No sleeping on the job!"
	desc_extended = "Press to toggle laying down."
	icon_state = "rest"
	screen_loc = "RIGHT-1,BOTTOM+1"

	flags = FLAGS_HUD_MOB

/obj/hud/button/stand/clicked_on_by_object(var/mob/caller,object,location,control,params)

	if(is_living(caller))
		var/mob/living/L = caller
		if(L.stand && L.stand.linked_stand)
			L.stand.linked_stand.set_enabled(!L.stand.linked_stand.enabled)
		else
			L.to_chat("You don't have a stand for some reason!")

	return ..()