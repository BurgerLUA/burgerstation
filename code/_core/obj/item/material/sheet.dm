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
			var/material/material_id_path = src.material_id
			var/possible_rod_text = text("/obj/item/material/rod/[initial(material_id_path.name)]")
			var/possible_rod = text2path_safe(possible_rod_text)
			if(!length(subtypesof(possible_rod))) //If theres a rod coded for the material...
				var/obj/item/material/rod/R = new possible_rod(get_turf(src))
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

/obj/item/material/sheet/steel
	name = "steel sheet"
	material_id = /material/steel
	desc = "Builders best friend"

/obj/item/material/sheet/brass
	name = "brass sheet"
	material_id = /material/brass
	desc = "Rat-var?"

/obj/item/material/sheet/glass
	name = "glass sheet"
	material_id = /material/glass
	drop_sound = 'sound/items/drop/glass.ogg'

/obj/item/material/sheet/iron
	name = "iron sheet"
	material_id = /material/iron
	desc = "Cheap, but rusts."

/obj/item/material/sheet/cobalt
	name = "cobalt sheet"
	material_id = /material/cobalt
	desc = "Doesn't give momentum."

/obj/item/material/sheet/gold
	name = "gold sheet"
	material_id = /material/gold
	desc = "Shiny"

/obj/item/material/sheet/phoron
	name = "plasma sheet"
	material_id = /material/phoron
	desc = "Today I want my building to be EXTRA flammable."

/obj/item/material/sheet/silver
	name = "silver sheet"
	material_id = /material/silver
	desc = "Almost a mirror."

/obj/item/material/sheet/diamond
	name = "diamond sheet"
	material_id = /material/diamond
	desc = "I dont even question it anymore."

/obj/item/material/sheet/uranium
	name = "uranium sheet"
	material_id = /material/uranium
	desc = "Enrichment required."

/obj/item/material/sheet/titanium
	name = "titanium sheet"
	material_id = /material/titanium
	desc = "Lightweight and strong."

/obj/item/material/sheet/zinc
	name = "zinc sheet"
	material_id = /material/zinc
	desc = "Aren't you supposed to plate other things in zinc?"

/obj/item/material/sheet/magnesium
	name = "magnesium sheet"
	material_id = /material/magnesium
	desc = "Burns pretty."

/obj/item/material/sheet/electrum
	name = "electrum sheet"
	material_id = /material/electrum
	desc = "VERY Conductive!"

/obj/item/material/sheet/plasteel
	name = "plasteel sheet"
	material_id = /material/plasteel
	desc = "Space-grade plating."

/obj/item/material/sheet/aluminium
	name = "aluminium sheet"
	material_id = /material/aluminium
	desc = "Lighter than a feather."

/obj/item/material/sheet/nickel
	name = "nickel sheet"
	material_id = /material/nickel
	desc = "Could probably use this for something..."

/obj/item/material/sheet/copper
	name = "copper sheet"
	material = /material/copper
	desc = "Also still modded."

/obj/item/material/sheet/uranium_235
	name = "uranium 235 sheet"
	material = /material/uranium_235
	desc = "Its fissile, not fizzle."