/obj/item/material/sheet
	name = "sheet"
	desc = "I am error."
	icon = 'icons/obj/item/material.dmi'
	icon_state = "sheet"

	amount_max = 50
	amount_max_icon = 3


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
			R.amount = 4
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

/obj/item/material/sheet/glass
	material_id = /material/glass
	drop_sound = 'sound/items/drop/glass.ogg'