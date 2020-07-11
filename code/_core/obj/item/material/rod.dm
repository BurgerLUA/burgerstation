/obj/item/material/rod
	name = "rod"
	desc = "I am error."
	icon = 'icons/obj/item/material.dmi'
	icon_state = "rod"

	item_count_current = 1
	item_count_max = 50
	item_count_max_icon = 3

	crafting_id = "rod"

/obj/item/material/rod/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	INTERACT_CHECK

	if(isturf(object))
		var/turf/T = object

		if(item_count_current < 2)
			caller.to_chat(span("warning","You need 2 rods in order to build a frame!"))
			return TRUE

		if(!T.can_construct_on(caller,/obj/structure/interactive/construction/frame/))
			return TRUE

		var/obj/structure/interactive/construction/frame/F = new(T)
		F.material_id = material_id
		F.color = color
		INITIALIZE(F)
		GENERATE(F)
		caller.to_chat("You place \the [F.name].")
		add_item_count(-2)
		return TRUE

	return ..()

/obj/item/material/rod/steel
	name = "steel rod"
	desc = "The basic building material."
	material_id = /material/steel

/obj/item/material/rod/steel/spawn_50/Generate()
	item_count_current = 50
	update_sprite()
	return ..()

/obj/item/material/rod/steel/spawn_25/Generate()
	item_count_current = 25
	update_sprite()
	return ..()

/obj/item/material/rod/steel/spawn_10/Generate()
	item_count_current = 10
	update_sprite()
	return ..()