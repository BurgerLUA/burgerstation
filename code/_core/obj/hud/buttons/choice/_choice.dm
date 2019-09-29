/obj/hud/button/choice
	name = "choice"
	desc = "Press this."
	desc_extended = "Press this button."
	icon_state = "square"
	screen_loc = "CENTER,CENTER"

	icon = 'icons/hud/prompts.dmi'

	flags = FLAGS_HUD_SPECIAL

	var/choice/linked_choice

/obj/hud/button/choice/New(var/desired_loc,var/desired_choice)
	linked_choice = desired_choice
	return ..()

/obj/hud/button/choice/clicked_on_by_object(var/mob/caller,object,location,control,params)
	linked_choice.choice_made = id
	return TRUE

/obj/hud/button/choice/yes
	name = "yes"
	id = "yes"
	icon_state = "yes"
	screen_loc = "CENTER+2,CENTER"

/obj/hud/button/choice/no
	name = "no"
	id = "no"
	icon_state = "no"
	screen_loc = "CENTER-2,CENTER"


