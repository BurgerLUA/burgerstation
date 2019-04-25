/obj/button/slot
	name = "slot button"
	desc = "Slot button for quick actions."
	desc_extended = "Press this button to activate that item on the tile you're pointing."
	icon_state = "1"
	screen_loc = "LEFT,TOP"
	alpha = 100

	flags = FLAGS_HUD_MOB

	var/obj/item/stored_item

	var/active = FALSE

/obj/button/slot/update_icon()
	..()
	overlays = list()
	overlays += stored_item
	if(active)
		color = "#00FF00"
	else
		color = "#FFFFFF"

/obj/button/slot/proc/clear_object(var/mob/living/advanced/A)
	if(stored_item)
		A.to_chat(span("notice","\The [stored_item] was unbound from slot [icon_state]."))
		stored_item = null
		animate(src,alpha=100,time=SECONDS_TO_DECISECONDS(1))
		update_icon()
	return TRUE

/obj/button/slot/clicked_by_object(caller,object,location,control,params)

	if(!is_advanced(caller))
		return ..()

	var/mob/living/advanced/A = caller

	clear_object(A)

	if(!is_item(object))
		return ..()

	var/obj/item/I = object

	if(!I.has_quick_function)
		A.to_chat(span("notice","\The [stored_item] doesn't have a quick bind function."))
		return TRUE

	stored_item = object
	A.to_chat(span("notice","\The [stored_item] was bound to slot [icon_state]."))
	animate(src,alpha=255,time=SECONDS_TO_DECISECONDS(1))
	update_icon()

	return TRUE

/obj/button/slot/A
	id = "1"
	icon_state = "1"
	screen_loc = "LEFT,TOP"

/obj/button/slot/B
	id = "2"
	icon_state = "2"
	screen_loc = "LEFT+1,TOP"

/obj/button/slot/C
	id = "3"
	icon_state = "3"
	screen_loc = "LEFT+2,TOP"

/obj/button/slot/D
	id = "4"
	icon_state = "4"
	screen_loc = "LEFT+3,TOP"

/obj/button/slot/E
	id = "5"
	icon_state = "5"
	screen_loc = "LEFT+4,TOP"

/obj/button/slot/F
	id = "6"
	icon_state = "6"
	screen_loc = "LEFT+5,TOP"

/obj/button/slot/G
	id = "7"
	icon_state = "7"
	screen_loc = "LEFT+6,TOP"

/obj/button/slot/H
	id = "8"
	icon_state = "8"
	screen_loc = "LEFT+7,TOP"

/obj/button/slot/I
	id = "96"
	icon_state = "9"
	screen_loc = "LEFT+8,TOP"

/obj/button/slot/J
	id = "0"
	icon_state = "0"
	screen_loc = "LEFT+9,TOP"