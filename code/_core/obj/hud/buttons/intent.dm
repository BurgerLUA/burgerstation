/obj/hud/button/intent
	name = "intent"
	desc = "Harm intent or bust."
	icon_state = "intent"
	screen_loc = "RIGHT:1-2,BOTTOM:11"

	flags_hud = FLAG_HUD_MOB

	var/intent = INTENT_HELP

	var/active = FALSE

/obj/hud/button/intent/update_owner()

	. = ..()

	if(is_living(owner))
		var/mob/living/L = owner
		active = L.intent == intent
		update_overlays()

/obj/hud/button/intent/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	. = ..()

	if(. && is_living(caller))
		var/mob/living/L = caller
		L.selected_intent = intent
		L.update_intent()

/obj/hud/button/intent/update_overlays()

	overlays.Cut()

	. = ..()

	if(active)
		var/icon/I = new/icon(initial(icon),"[icon_state]_active")
		add_overlay(I)


//The reason why this isn't one button is to support button binds.
/obj/hud/button/intent/help
	name = "help intent"
	desc_extended = "Clicking this will change your stance to help intent. Help intent is a more passive stance that will make you appear less aggressive and cause your unarmed attacks to do strictly fatigue damage."
	icon_state = "intent_help"
	intent = INTENT_HELP

/obj/hud/button/intent/harm
	name = "harm intent"
	desc_extended = "Clicking this will change your stance to harm intent. Harm intent is an aggressive stance that will cause your character to face towards your cursor and cause your unarmed attacks to deal more damage."
	icon_state = "intent_harm"
	intent = INTENT_HARM

/obj/hud/button/intent/disarm
	name = "disarm intent"
	desc_extended = "Clicking this will change your stance to disarm intent. Disarm intent is a defensive stance that will change your unarmed attacks to shove or disarm the enemy's weapon."
	icon_state = "intent_disarm"
	intent = INTENT_DISARM

/obj/hud/button/intent/grab
	name = "grab intent"
	desc_extended = "Clicking this will change your stance to grab intent. Grab intent is an offensive stance that will change your unarmed attacks to grab the enemy. Enemies can still attack you when grabbed, unless they are on the ground or facing away from you. Enemies grabbed by you will always take critical hits."
	icon_state = "intent_grab"
	intent = INTENT_GRAB