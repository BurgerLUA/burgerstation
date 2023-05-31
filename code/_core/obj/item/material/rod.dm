/obj/item/material/rod
	name = "rod"
	desc = "I am error."
	icon = 'icons/obj/item/material.dmi'
	icon_state = "rod"

	amount_max = 50
	amount_max_icon = 3

	crafting_id = "rod"

	material_multiplier = 0.25

/obj/item/material/rod/update_icon()
	var/material/M = SSmaterials.all_materials[material_id]
	if(!M)
		name = "ERROR rod"
		log_error("Warning! [src.get_debug_name()] had incorrect material type \"[material_id]\"!")
	else
		name = "[deunderscore(M.name)] rod"
		desc = "...they will come."
		desc_extended = "A rod made of [deunderscore(M.name)]. Useful for building and crafting."
		icon_state = "[M.icon_state_rod]_[min(CEILING(amount/10,1),amount_max_icon)]"
		color = M.color
	return ..()

/obj/item/material/rod/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(is_item(object))
		var/obj/item/I = object
		if(I.flags_tool & FLAG_TOOL_WIRECUTTER)
			INTERACT_CHECK
			INTERACT_CHECK_OBJECT
			INTERACT_DELAY(5)
			var/obj/item/material/pellets/R = new(get_turf(src))
			R.material_id = material_id
			R.amount = 8
			INITIALIZE(R)
			GENERATE(R)
			FINALIZE(R)
			caller.visible_message(span("notice","\The [caller.name] cuts some [src.name] into some [R.name]."),span("notice","You cut \the [src.name] into 8 [R.name]."))
			add_item_count(-1)
			R.Move(get_turf(I))
			return TRUE
		if(I.flags_tool & FLAG_TOOL_WELDER)
			INTERACT_CHECK
			INTERACT_CHECK_OBJECT
			INTERACT_DELAY(5)
			if(amount < 4)
				caller.to_chat(span("notice","You need 4 rods to weld a sheet!"))
				return ..()
			var/obj/item/material/sheet/R = new(get_turf(src))
			R.material_id = material_id
			R.amount = 1
			INITIALIZE(R)
			GENERATE(R)
			FINALIZE(R)
			caller.visible_message(span("notice","\The [caller.name] crudely welds the [src.name] into \a [R.name]s."),span("notice","You crudely weld \the [src.name] into \a [R.name]."))
			add_item_count(-4)
			R.Move(get_turf(I))
			return TRUE
	return ..()