/obj/item/material/sheet
	name = "sheet"
	desc = "I am error."
	icon = 'icons/obj/item/material.dmi'
	icon_state = "sheet"

	amount_max = 50
	amount_max_icon = 3


	material_multiplier = 1

/obj/item/material/sheet/update_icon()
	var/material/M = SSmaterials.all_materials[material_id]
	if(!M)
		name = "ERROR sheet"
		log_error("Warning! [src.get_debug_name()] had incorrect material type \"[material_id]\"!")
	else
		name = "[deunderscore(M.name)] sheet"
		desc = "If you build it..."
		desc_extended = "A sheet made of [deunderscore(M.name)]. Useful for building and crafting."
		icon_state = "[M.icon_state_sheet]_[min(CEILING(amount/10,1),amount_max_icon)]"
		color = M.color
	return ..()

/obj/item/material/sheet/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(is_item(object))
		var/obj/item/I = object
		if(I.flags_tool & FLAG_TOOL_WIRECUTTER)
			INTERACT_CHECK
			INTERACT_CHECK_OBJECT
			INTERACT_DELAY(5)
			var/material/material_id_path = material_id
			var/possible_rod_text = text("/obj/item/material/rod/[initial(material_id_path.name)]")
			var/possible_rod = text2path_safe(possible_rod_text)
			if(!length(subtypesof(possible_rod))) //If theres a rod coded for the material...
				var/obj/item/material/rod/R = new possible_rod(get_turf(src))
				R.material_id = material_id
				R.amount = 4
				INITIALIZE(R)
				GENERATE(R)
				FINALIZE(R)
				caller.visible_message(span("notice","\The [caller.name] cuts some [src.name] into some [R.name]s."),span("notice","You cut \the [src.name] into 4 [R.name]."))
				add_item_count(-1)
				R.Move(get_turf(I))
			else // We cant find a rod for the material...
				var/obj/item/material/rod/R = new(get_turf(src))
				R.material_id = material_id
				R.amount = 4
				INITIALIZE(R)
				GENERATE(R)
				FINALIZE(R)
				caller.visible_message(span("notice","\The [caller.name] cuts some [src.name] into some [R.name]s."),span("notice","You cut \the [src.name] into 4 [R.name]."))
				add_item_count(-1)
				R.Move(get_turf(I))
			return TRUE
	return ..()