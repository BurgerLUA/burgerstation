/obj/item/material/sheet
	name = "sheet"
	desc = "I am error."
	icon = 'icons/obj/item/material.dmi'
	icon_state = "sheet"

	item_count_current = 1
	item_count_max = 50
	item_count_max_icon = 3

	crafting_id = "sheet"

	material_multiplier = 1

/obj/item/material/sheet/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)



	if(is_item(object))
		var/obj/item/I = object
		if(I.flags_tool & FLAG_TOOL_WIRECUTTER)
			INTERACT_CHECK
			INTERACT_CHECK_OBJECT
			INTERACT_DELAY(5)
			var/obj/item/material/rod/R = new(get_turf(src))
			R.material_id = material_id
			R.item_count_current = 4
			INITIALIZE(R)
			GENERATE(R)
			FINALIZE(R)
			caller.visible_message(span("notice","\The [caller.name] cuts some [src.name] into [R.name]s."),span("notice","You cut \the [src.name] into 4 [R.name]."))
			add_item_count(-1)
			R.Move(get_turf(I))
			return TRUE

	return ..()

/obj/item/material/sheet/steel
	material_id = /material/steel

/obj/item/material/sheet/steel/spawn_50/Generate()
	item_count_current = 50
	update_sprite()
	return ..()

/obj/item/material/sheet/steel/spawn_25/Generate()
	item_count_current = 25
	update_sprite()
	return ..()

/obj/item/material/sheet/steel/spawn_10/Generate()
	item_count_current = 10
	update_sprite()
	return ..()

/obj/item/material/sheet/glass
	material_id = /material/glass

	drop_sound = 'sound/items/drop/glass.ogg'

/obj/item/material/sheet/glass/spawn_50/Generate()
	item_count_current = 50
	update_sprite()
	return ..()