//Change your abilities here.

/obj/structure/interactive/ability_machine
	name = "ability machine"
	desc = "It's science, I ain't gotta explain shit."
	desc_extended = "An almost magical genetic manipulation machine that practically grants the user superpowers. Customize your genetic-based abilities here."

	icon = 'icons/obj/structure/ability_machine.dmi'
	icon_state = "ability_machine"

	density = TRUE
	anchored = TRUE
	collision_flags = FLAG_COLLISION_WALL
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC

	pixel_x = -16

	pixel_y = 6

	var/list/ability_types = list(
		/ability/cqc,
		/ability/dash,
		/ability/quick_draw
	)



/obj/structure/interactive/ability_machine/clicked_on_by_object(var/mob/activator,var/atom/object,location,control,params)

	if(activator.ckey && is_advanced(activator) && is_inventory(object))
		INTERACT_CHECK
		INTERACT_DELAY(10)
		SPAM_CHECK(10)
		show_ability_choices(activator,src)
		return TRUE

	. = ..()


/obj/structure/interactive/ability_machine/tall
	name = "spell table"
	desc_extended = "It's magic, I ain't gotta explain shit."
	desc_extended = "A magical spell manipulation machine that practically grants the user superpowers. Customize your spell-based abilities here."
	icon = 'icons/obj/structure/ability_machine_tall.dmi'
	pixel_x = 0
	ability_types = list(
		/ability/magic
	)