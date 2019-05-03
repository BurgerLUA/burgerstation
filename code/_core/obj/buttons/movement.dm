/obj/button/sneak
	name = "sneak"
	desc = "sneaker no sneaking"
	desc_extended = "Press to sneak."
	icon_state = "sneak_0"
	screen_loc = "RIGHT-4,BOTTOM"

	var/sneaking = 0

	flags = FLAGS_HUD_MOB

/obj/button/sneak/clicked_by_object(var/mob/caller,object,location,control,params)

	if(!is_living(caller))
		return

	var/mob/living/L = caller

	sneaking = !sneaking
	L.toggle_sneak(sneaking)
	update_icon()
	..()

/obj/button/sneak/update_icon()
	icon_state = "sneak_[sneaking]"
	..()

/obj/button/move
	name = "move"
	desc = "who fucking walks lmao"
	desc_extended = "Where you press determines where you click"
	icon_state = "move_1"
	screen_loc = "RIGHT-4,BOTTOM"

	var/move_mode = 2 //1 = run, 2 = jog, 3 = sprint

	flags = FLAGS_HUD_MOB

/obj/button/move/update_icon()
	icon_state = "move_[move_mode]"
	..()

/obj/button/move/clicked_by_object(var/mob/caller,object,location,control,params)

	if(params["icon-x"] && params["icon-y"] && text2num(params["icon-y"]) >= 10)

		switch(text2num(params["icon-x"]))
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

	..()