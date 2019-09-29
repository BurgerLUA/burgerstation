obj/structure/interactive/computer
	name = "computer"
	desc = "Beep boop."
	icon = 'icons/obj/structure/computer.dmi'

obj/structure/interactive/computer/console
	name = "computer console"
	var/computer_type = "generic"
	var/keyboard_type = "generic_key"

	icon_state = "computer"

	var/on = TRUE

obj/structure/interactive/computer/console/New(var/desired_loc)
	. = ..()
	update_icon()
	return .

obj/structure/interactive/computer/console/update_icon()

	icon = initial(icon)
	icon_state = initial(icon_state)

	var/icon/I = new/icon(icon,icon_state)

	if(computer_type && on)
		var/icon/I2 = new/icon(icon,computer_type)
		I.Blend(I2,ICON_OVERLAY)

	if(keyboard_type)
		var/icon/I3 = new/icon(icon,keyboard_type)
		I.Blend(I3,ICON_OVERLAY)

	icon = I

obj/structure/interactive/computer/console/laptop
	name = "personal laptop"
	icon_state = "laptop"


obj/structure/interactive/computer/console/old
	name = "old computer"
	icon_state = "oldcomp"


obj/structure/interactive/computer/console/old/chargen_job
	name = "\improper IMB piece of shit"
	computer_type = "library"
	keyboard_type = ""

obj/structure/interactive/computer/console/old/chargen_job/clicked_on_by_object(caller,object,location,control,params)

	if(!is_player(caller))
		return TRUE

	INTERACT_CHECK

	var/mob/living/advanced/player/P = caller

	if(!P.appearance_changed)
		P.to_chat(span("thought","I should probably give myself a long, semi-motivational look in the mirror before I start my day."))
		return TRUE

	P.dialogue_target_id = "chargen_computer"
	open_menu(P,"dialogue")

	return TRUE


obj/structure/interactive/computer/console/medical
	name = "medical console"
	computer_type = "medcomp"
	keyboard_type = "med_key"