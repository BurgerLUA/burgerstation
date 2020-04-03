/obj/item/material/rod
	name = "rod"
	desc = "I am error."
	icon = 'icons/obj/items/material.dmi'
	icon_state = "rod"

	item_count_current = 1
	item_count_max = 50
	item_count_max_icon = 3

	weight = 0.25

	crafting_id = "rod"

/obj/item/material/rod/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	INTERACT_CHECK

	if(is_floor(object))
		var/turf/simulated/floor/T = object
		var/area/A = T.loc
		if(A.flags_area & FLAGS_AREA_NO_CONSTRUCTION)
			caller.to_chat("You cannot build here!")
			return TRUE

		var/found_bad = FALSE
		for(var/obj/structure/S in T.contents)
			found_bad = TRUE
			break

		if(found_bad)
			caller.to_chat("There is something already built here!")
			return TRUE

		if(item_count_current >= 2)
			var/obj/structure/interactive/construction/frame/F = new(T)
			F.material_id = material_id
			F.color = color
			caller.to_chat("You place \the [F.name].")
			item_count_current -= 2
			update_sprite()
			return TRUE

	return ..()

/obj/item/material/rod/steel
	name = "steel rod"
	desc = "The basic building material."
	crafting_id = "rod_steel"
	color = COLOR_STEEL
	material_id = "steel"

/obj/item/material/rod/steel/spawn_50/on_spawn()
	item_count_current = 50
	update_sprite()
	return ..()

/obj/item/material/rod/steel/spawn_25/on_spawn()
	item_count_current = 25
	update_sprite()
	return ..()

/obj/item/material/rod/steel/spawn_10/on_spawn()
	item_count_current = 10
	update_sprite()
	return ..()