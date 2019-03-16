/obj/trigger/transparency_trigger
	name = "transparency trigger"
	desc = "Adjusts transparency."
	icon = null
	icon_state = null

	var/obj/structure/interactive/nature/linked_object

/obj/trigger/transparency_trigger/New(var/new_loc,var/atom/new_linked_object)
	..()
	linked_object = new_linked_object

/obj/trigger/transparency_trigger/Crossed(var/atom/crosser)
	..()

	linked_object.crossed_objects += crosser

	spawn(0)
		if(length(linked_object.crossed_objects))
			animate(linked_object,alpha = 100, time = SECONDS_TO_DECISECONDS(0.7))

/obj/trigger/transparency_trigger/Uncrossed(var/atom/crosser)
	..()

	linked_object.crossed_objects -= crosser

	spawn(0)
		if(!length(linked_object.crossed_objects))
			animate(linked_object,alpha = 255, time = SECONDS_TO_DECISECONDS(0.7))

