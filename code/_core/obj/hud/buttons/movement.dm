/obj/hud/button/sneak
	name = "sneak"
	desc = "sneaker no sneaking"
	desc_extended = "Click here to toggle sneak. Sneaking makes it much harder to be detected by NPCs, and prevents players from seeing you unless you are in their character's line of sight. Moving while sneaking costs stamina."
	icon_state = "sneak_0"
	screen_loc = "RIGHT-3,BOTTOM:12"

	var/sneaking = 0

	flags = FLAG_HUD_MOB

/obj/hud/button/sneak/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	. = ..()

	if(. && is_living(caller))
		var/mob/living/L = caller
		L.sneak()
		sneaking = L.is_sneaking


/obj/hud/button/sneak/update_icon()
	icon_state = "sneak_[sneaking]"
	..()

/obj/hud/button/move
	name = "change movement"
	desc = "who fucking walks lmao"
	desc_extended = "Changes your default movement stance."
	icon_state = "move_1"
	screen_loc = "RIGHT:1-3,BOTTOM:11"

	var/move_mod_button = 0

	flags = FLAG_HUD_MOB

/obj/hud/button/move/update_icon()
	icon_state = "move_[move_mod_button+2]"
	..()

/obj/hud/button/move/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	. = ..()

	if(.)
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


/obj/hud/button/rest
	name = "rest"
	desc = "No sleeping on the job!"
	desc_extended = "Click here to allow your character to rest. Resting makes it much more unlikely to be hit by stray projectiles and makes it harder to be detected by NPCs."
	icon_state = "rest"
	screen_loc = "RIGHT-2:8,BOTTOM:10+1"

	flags = FLAG_HUD_MOB

/obj/hud/button/rest/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	. = ..()

	if(. && is_living(caller))
		var/mob/living/L = caller
		L.rest()


/obj/hud/button/stand
	name = "stand"
	desc = "Summons and unsummons your stand."
	desc_extended = "Press to toggle your stand. Put yourself on harm intent to make your stand attack your enemies. Help intent doesn't."
	icon_state = "stand"
	screen_loc = "RIGHT-2:8,BOTTOM:12+1"

	flags = FLAG_HUD_MOB

/obj/hud/button/stand/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	. = ..()

	if(. && is_living(caller))
		var/mob/living/L = caller
		if(L.stand && L.stand.linked_stand)
			L.stand.linked_stand.set_enabled(!L.stand.linked_stand.enabled)
		else
			L.to_chat(span("danger","You don't have a stand for some reason!"))

