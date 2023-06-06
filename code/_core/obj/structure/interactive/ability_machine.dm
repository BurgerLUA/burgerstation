//Change your abilities here.

/obj/structure/interactive/ability_machine
	name = "ability machine"
	desc = "It's science, I ain't gotta explain shit."
	desc_extended = "An almost magical genetic manipulation machine that practically grants the user superpowers. Customize your abilities here."

	icon = 'icons/obj/structure/ability_machine.dmi'
	icon_state = "ability_machine"

	density = TRUE

	pixel_x = -16

	pixel_y = 6

	var/list/ability_types = list(
		/ability/cqc,
		/ability/dash,
		/ability/quick_draw
	)



/obj/structure/interactive/ability_machine/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(caller.ckey && is_advanced(caller) && is_inventory(object))
		INTERACT_CHECK
		INTERACT_DELAY(10)
		SPAM_CHECK(10)
		show_ability_choices(caller,src)
		return TRUE

	. = ..()