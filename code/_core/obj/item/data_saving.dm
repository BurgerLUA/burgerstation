/obj/item/proc/get_blend_data()

	. = list()

	for(var/id in additional_blends)

		var/icon_blend/IB = additional_blends[id]

		if(IB.should_save)
			.[id] = list()
		else
			continue

		if(IB.id) .[id]["id"] = IB.id
		if(IB.icon) .[id]["icon"] = IB.icon
		if(IB.icon_state) .[id]["icon_state"] = IB.icon_state
		if(IB.color) .[id]["color"] = IB.color
		if(IB.blend) .[id]["blend"] = IB.blend
		if(IB.special_type) .[id]["special_type"] = IB.special_type

	return .

/obj/item/proc/set_blend_data(var/list/blend_data)

	for(var/id in blend_data)
		var/list/blend_list = blend_data[id]
		var/desired_id = value_or_null(blend_list,"id")
		var/desired_icon = value_or_null(blend_list,"icon")
		if(desired_icon) desired_icon = file(desired_icon) //TODO: Kind of a weird statement.
		var/desired_icon_state = value_or_null(blend_list,"icon_state")
		var/desired_color = value_or_null(blend_list,"color")
		var/desired_blend = value_or_null(blend_list,"blend")
		var/desired_type = value_or_null(blend_list,"type")
		//var/desired_layer = value_or_null(blend_list,"layer")
		src.add_blend(desired_id,desired_icon,desired_icon_state,desired_color,desired_blend,desired_type,TRUE)

	return TRUE

/proc/load_and_create(var/mob/living/advanced/player/P,var/list/object_data,var/atom/loc,var/initialize=TRUE)

	if(!object_data)
		log_error("Tried to create an object with a null object_data list!")
		return FALSE

	if(length(object_data) <= 0 )
		log_error("Tried to create an object with an empty object_data list!")
		return FALSE

	if(!loc)
		log_error("Tried to create an object in a null location!")
		return FALSE

	if(!object_data["type"])
		log_error("Tried to create an object that didn't have a type!")
		return FALSE

	var/o_type = object_data["type"]

	if(!o_type)
		log_error("ERROR: Tried to load a null item inside [loc.get_debug_name()]!")
		return FALSE

	var/obj/item/I = text2path(o_type)

	if(!I)
		log_error("ERROR: Tried to load an item that did not exist in code ([o_type]) inside the [loc.get_debug_name()]!")
		return FALSE

	I = new I(loc)
	I.load_item_data_pre(P,object_data)
	INITIALIZE(I)
	I.load_item_data_post(P,object_data)
	FINALIZE(I)
	I.drop_item(loc,silent=TRUE)
	I.update_sprite()

	return I

/obj/item/proc/save_item_data(var/save_inventory = TRUE)

	. = list()

	if(!should_save)
		return .

	if(name != initial(name))
		.["name"] = name

	if(label != initial(label))
		.["label"] = label

	if(last_marker)
		.["last_marker"] = last_marker

	.["type"] = type

	if(color && lowertext(color) != "#ffffff")
		.["color"] = color

	if(save_inventory && length(inventories))
		.["inventories"] = new/list(length(inventories))
		for(var/i=1,i<=length(inventories),i++)
			var/obj/hud/inventory/IN = inventories[i]
			var/list/inventory_data = list()
			try
				inventory_data = IN.get_inventory_data(save_inventory)
			catch(var/exception/e)
				log_error("Failed to save inventory data of [src.get_debug_name()]. Some information may be lost.")
				log_error("Save Error: [e] on [e.file]:[e.line]\n[e.desc]!")
			.["inventories"][i] = inventory_data
	if(soul_bound)
		.["soul_bound"] = soul_bound
	if(item_count_current > 1)
		.["item_count_current"] = item_count_current
	if(delete_on_drop)
		.["delete_on_drop"] = TRUE
	if(reagents && reagents.stored_reagents && length(reagents.stored_reagents))
		.["reagents"] = reagents.stored_reagents

	if(quality && quality != initial(quality))
		.["quality"] = quality

	if(luck && luck != initial(luck))
		.["luck"] = luck

	return .

/obj/item/organ/save_item_data(var/save_inventory = TRUE)

	. = ..()

	var/list/blend_data = get_blend_data()
	if(length(blend_data)) .["blend_data"] = blend_data

	return .

/obj/item/organ/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data)

	. = ..()

	if(object_data["blend_data"])
		log_debug("Blend data for [src.type]:")
		debug_list(object_data["blend_data"])
		set_blend_data(object_data["blend_data"])
	else
		log_debug("No blend data found for: [src.type].")

	return .

/obj/item/proc/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data)

	if(object_data["name"])
		name = object_data["name"]
	if(object_data["label"])
		name = object_data["label"]
	if(object_data["last_marker"])
		last_marker = object_data["last_marker"]
	if(object_data["color"])
		color = object_data["color"]
	if(object_data["inventories"])
		for(var/i=1,i<=length(object_data["inventories"]),i++)
			var/obj/hud/inventory/I = inventories[i]
			I.set_inventory_data(P,object_data["inventories"][i])
	if(object_data["soul_bound"])
		soul_bound = object_data["soul_bound"]
	if(object_data["item_count_current"])
		item_count_current = object_data["item_count_current"]
	if(object_data["delete_on_drop"])
		delete_on_drop = TRUE
	if(object_data["quality"])
		quality = object_data["quality"]
	if(object_data["luck"])
		luck = object_data["luck"]

	return TRUE


/obj/item/proc/load_item_data_post(var/mob/living/advanced/player/P,var/list/object_data)
	if(object_data["reagents"] && length(object_data["reagents"]))
		for(var/r_id in object_data["reagents"])
			var/volume = object_data["reagents"][r_id]
			reagents.add_reagent(text2path(r_id),volume,TNULL,FALSE)
		reagents.update_container()
	return TRUE

/obj/hud/inventory/proc/set_inventory_data(var/mob/living/advanced/player/P,var/list/inventory_data) //Setting the data found.

	if(!inventory_data)
		log_error("Warning: [src.get_debug_name()] in [P.get_debug_name()] had no inventory data!")
		return TRUE

	if(is_assoc_list(inventory_data))
		if(inventory_data["held"])
			for(var/i=1,i<=length(inventory_data["held"]),i++)
				var/obj/item/I = load_and_create(P,inventory_data["held"][i],get_turf(src))
				if(I && !src.add_object(I,TRUE,TRUE,silent=TRUE))
					log_error("WARNING: Could not add \the [I.get_debug_name()] to \the [src.get_debug_name()]!")
					I.drop_item(get_step(P,P.dir),silent=TRUE)

		if(inventory_data["worn"])
			for(var/i=1,i<=length(inventory_data["worn"]),i++)
				var/obj/item/I = load_and_create(P,inventory_data["worn"][i],get_turf(src))
				if(I && !src.add_object(I,TRUE,TRUE,silent=TRUE))
					log_error("WARNING: Could not add \the [I.get_debug_name()] to \the [src.get_debug_name()]!")
					I.drop_item(get_step(P,P.dir),silent=TRUE)
	else
		for(var/i=1,i<=length(inventory_data),i++)
			var/obj/item/I = load_and_create(P,inventory_data[i],get_turf(src))
			if(I && !src.add_object(I,TRUE,TRUE,silent=TRUE))
				log_error("WARNING: Could not add \the [I.get_debug_name()] to \the [src.get_debug_name()]!")
				I.drop_item(get_step(P,P.dir),silent=TRUE)


	return TRUE

/obj/hud/inventory/proc/get_inventory_data(var/save_inventory=TRUE) //Getting the inventory and their contents for saving.

	var/content_length = length(contents)

	. = new/list(content_length)

	for(var/i=1,i<=content_length,i++)
		.[i] = contents[i].save_item_data(save_inventory)

	return .