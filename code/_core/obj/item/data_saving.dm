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
		if(IB.layer) .[id]["layer"] = IB.layer

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
		var/desired_layer = value_or_null(blend_list,"layer")
		src.add_blend(desired_id,desired_icon,desired_icon_state,desired_color,desired_blend,desired_type,TRUE,desired_layer)

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

	if(ispath(object_data["type"],/obj/item/))
		log_error("ERROR: \"[o_type]\" attempted to be loaded inside [loc.get_debug_name()], but it does not exist in code!")
		return FALSE

	var/obj/item/I = new o_type(loc)
	I.load_item_data_pre(P,object_data)
	INITIALIZE(I)
	I.load_item_data_post(P,object_data)
	I.force_move(loc)
	I.update_sprite()

	return I

/obj/item/proc/save_item_data(var/save_inventory = TRUE)

	if(!should_save)
		return list()

	. = list()

	.["type"] = type

	if(color && lowertext(color) != "#ffffff")
		.["color"] = color

	if(save_inventory && length(inventories))
		.["inventories"] = new/list(length(inventories))
		for(var/i=1,i<=length(inventories),i++)
			var/obj/hud/inventory/IN = inventories[i]
			.["inventories"][i] = IN.get_inventory_data()
	if(soul_bound)
		.["soul_bound"] = soul_bound
	if(item_count_current > 1)
		.["item_count_current"] = item_count_current
	if(delete_on_drop)
		.["delete_on_drop"] = TRUE
	if(reagents && reagents.stored_reagents && length(reagents.stored_reagents))
		.["reagents"] = list()
		for(var/r_id in reagents.stored_reagents)
			.["reagents"][r_id] = reagents.stored_reagents[r_id]

	return .

/obj/item/organ/save_item_data(var/save_inventory = TRUE)

	. = ..()

	var/list/blend_data = get_blend_data()
	if(length(blend_data)) .["blend_data"] = blend_data

	return .

/obj/item/organ/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data)

	. = ..()

	if(object_data["blend_data"])
		LOG_DEBUG("Blend data for [src.type]:")
		debug_list(object_data["blend_data"])
		set_blend_data(object_data["blend_data"])
	else
		LOG_DEBUG("No blend data found for: [src.type].")

	return .

/obj/item/proc/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data)

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

	return TRUE


/obj/item/proc/load_item_data_post(var/mob/living/advanced/player/P,var/list/object_data)
	if(object_data["reagents"] && length(object_data["reagents"]))
		for(var/r_id in object_data["reagents"])
			var/volume = object_data["reagents"][r_id]
			reagents.add_reagent(text2path(r_id),volume,TNULL,FALSE)
		reagents.update_container()
	return TRUE

/obj/hud/inventory/proc/set_inventory_data(var/mob/living/advanced/player/P,var/list/inventory_data) //Setting the data found.

	if(inventory_data["held"])
		for(var/i=1,i<=length(inventory_data["held"]),i++)
			var/obj/item/I = load_and_create(P,inventory_data["held"][i],get_turf(src))
			if(I) src.add_held_object(I,TRUE,TRUE)

	if(inventory_data["worn"])
		for(var/i=1,i<=length(inventory_data["worn"]),i++)
			var/obj/item/I = load_and_create(P,inventory_data["worn"][i],get_turf(src))
			if(I) src.add_worn_object(I,TRUE,TRUE)

	return TRUE

/obj/hud/inventory/proc/get_inventory_data() //Getting the inventory and their contents for saving.

	. = list()
	.["type"] = type
	.["id"] = id

	if(length(held_objects))
		.["held"] = new/list(length(held_objects))
		for(var/i=1,i<=length(held_objects),i++)
			.["held"][i] = held_objects[i].save_item_data()

	if(length(worn_objects))
		.["worn"] = new/list(length(worn_objects))
		for(var/i=1,i<=length(worn_objects),i++)
			.["worn"][i] = worn_objects[i].save_item_data()

	return .