/obj/item/material/rod
	name = "rod"
	desc = "I am error."
	icon = 'icons/obj/item/material.dmi'
	icon_state = "rod"

	amount_max = 50
	amount_max_icon = 3

	crafting_id = "rod"

	material_multiplier = 0.25

/obj/item/material/rod/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(is_item(object))
		var/obj/item/I = object
		if(I.flags_tool & FLAG_TOOL_WIRECUTTER)
			INTERACT_CHECK
			INTERACT_CHECK_OBJECT
			INTERACT_DELAY(5)
			var/material/material_id_path = src.material_id
			var/possible_pellets_text = text("/obj/item/material/pellets/[initial(material_id_path.name)]")
			var/possible_pellets = text2path_safe(possible_pellets_text)
			if(!length(subtypesof(possible_pellets))) //If theres a pellets coded for the material...
				var/obj/item/material/pellets/R = new possible_pellets(get_turf(src))
				R.amount = 4
				INITIALIZE(R)
				GENERATE(R)
				FINALIZE(R)
				caller.visible_message(span("notice","\The [caller.name] cuts some [src.name] into some [R.name]s."),span("notice","You cut \the [src.name] into 4 [R.name]."))
				add_item_count(-1)
				R.Move(get_turf(I))
			else // We cant find a pellets for the material...
				var/obj/item/material/pellets/R = new(get_turf(src))
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

/obj/item/material/rod/steel
	name = "steel rod"
	desc = "The basic building material."
	material_id = /material/steel

/obj/item/material/rod/glass
	name = "glass rod"
	desc = "How did you do that."
	material_id = /material/glass

/obj/item/material/rod/iron
	name = "iron rod"
	material_id = /material/iron
	desc = "I.AM.IRON-ROD."

/obj/item/material/rod/brass
	name = "brass rod"
	material_id = /material/brass
	desc = "Great for cults!"

/obj/item/material/rod/cobalt
	name = "cobalt rod"
	material_id = /material/cobalt
	desc = "Doesn't give momentum."

/obj/item/material/rod/gold
	name = "gold rod"
	material_id = /material/gold
	desc = "Shiny"

/obj/item/material/rod/phoron
	name = "plasma rod"
	material_id = /material/phoron
	desc = "Kinda like a match, except it burns all at once."

/obj/item/material/rod/silver
	name = "silver rod"
	material_id = /material/silver
	desc = "Spoon, but without the head."

/obj/item/material/rod/diamond
	name = "diamond rod"
	material_id = /material/diamond
	desc = "How and WHY"

/obj/item/material/rod/uranium
	name = "uranium rod"
	material_id = /material/uranium
	desc = "Almost a fuel rod."

/obj/item/material/rod/titanium
	name = "titanium rod"
	material_id = /material/titanium
	desc = "Lightweight and strong."

/obj/item/material/rod/zinc
	name = "zinc rod"
	material_id = /material/zinc
	desc = "Makes a good anode."

/obj/item/material/rod/magnesium
	name = "magnesium rod"
	material_id = /material/magnesium
	desc = "Firestarter, anyone?"

/obj/item/material/rod/electrum
	name = "electrum rod"
	material_id = /material/electrum
	desc = "VERY Conductive!"

/obj/item/material/rod/plasteel
	name = "plasteel rod"
	material_id = /material/plasteel
	desc = "A very expensive chopstick."

/obj/item/material/rod/aluminium
	name = "aluminium rod"
	material_id = /material/aluminium
	desc = "Lighter than a feather."

/obj/item/material/rod/nickel
	name = "nickel rod"
	material_id = /material/nickel
	desc = "Thats a lot of coins."

/obj/item/material/rod/copper
	name = "copper rod"
	material = /material/copper
	desc = "Still modded."

/obj/item/material/rod/uranium_235
	name = "uranium 235 fuel rod"
	material = /material/uranium_235
	desc = "Im waking up."