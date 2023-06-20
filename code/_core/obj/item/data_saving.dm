/obj/item/proc/get_blend_data()

	. = list()

	for(var/id in additional_blends)

		var/icon_blend/IB = additional_blends[id]

		if(IB.can_save)
			.[id] = list()
		else
			continue

		if(IB.id) .[id]["id"] = IB.id
		if(IB.icon) .[id]["icon"] = IB.icon
		if(IB.icon_state) .[id]["icon_state"] = IB.icon_state
		if(IB.color) .[id]["color"] = IB.color
		if(IB.blend) .[id]["blend"] = IB.blend
		if(IB.special_type) .[id]["special_type"] = IB.special_type


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

/proc/load_and_create(var/mob/living/advanced/player/P,var/list/object_data,var/atom/loc,var/initialize=TRUE,var/loadout=FALSE)

	if(!object_data)
		//log_error("Tried to create an object with a null object_data list!")
		//Not actually an error. It is intentional to load/save blank spots in order to preserve inventory item location.
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

	var/obj/item/I = text2path_safe(o_type,.proc/ec_valid_item)

	if(!I)
		log_error("ERROR: Tried to load an item that did not exist in code ([o_type]) inside the [loc.get_debug_name()]!")
		return FALSE

	I = new I(loc)
	if(!I.load_item_data_pre(P,object_data,loadout=loadout))
		qdel(I)
		return null
	INITIALIZE(I)
	if(!I.load_item_data_post(P,object_data,loadout=loadout))
		qdel(I)
		return null
	FINALIZE(I)

	if(I.contraband || !I.can_save)
		qdel(I)
		return null

	if(loadout && !SSbalance.can_save_loadout[I.type])
		qdel(I)
		return null

	I.drop_item(loc,silent=TRUE)

	return I

/obj/item/proc/save_item_data(var/mob/living/advanced/player/P,var/save_inventory = TRUE,var/died=FALSE,var/loadout=FALSE)

	if( (contraband || !can_save) && !length(inventories)) //The inventory check prevents people from losing their stuff if a dev is dumb and adds a contraband item with storage.
		if(contraband) P.to_chat(span("warning","Notice: \The [src.name] could not be saved because it is considered contraband."))
		return null

	if(loadout && !SSbalance.can_save_loadout[src.type])
		P.to_chat(span("warning","Notice: \The [src.name] could not be stored in the loadout system because it isn't a standard item."))
		return null

	. = list()

	if(name != initial(name))
		.["name"] = name

	if(label != initial(label))
		.["label"] = label

	if(last_marker)
		.["last_marker"] = last_marker

	.["type"] = "[type]" //Type is a path. This makes it a string just in case.

	if(color && lowertext(color) != "#ffffff")
		.["color"] = color

	if(save_inventory && length(inventories))
		.["inventories"] = new/list(length(inventories))
		for(var/i=1,i<=length(inventories),i++)
			var/obj/hud/inventory/IN = inventories[i]
			var/list/inventory_data = list()
			try
				inventory_data = IN.save_inventory_data(P,save_inventory,died,loadout=loadout)
			catch(var/exception/e)
				log_error("Failed to save inventory data of [src.get_debug_name()]. Some information may be lost.")
				log_error("Save Error: [e] on [e.file]:[e.line]\n[e.desc]!")
			.["inventories"][i] = inventory_data
	if(soul_bound)
		.["soul_bound"] = soul_bound
	if(amount > 1)
		.["amount"] = amount
	if(delete_on_drop)
		.["delete_on_drop"] = TRUE
	if(reagents && length(reagents.stored_reagents))
		.["reagents"] = reagents.stored_reagents

	var/desired_quality = quality
	if(died)
		desired_quality *= 0.75
		desired_quality -= 25
		desired_quality = FLOOR(desired_quality,1)
	if(desired_quality != initial(quality))
		.["quality"] = clamp(desired_quality,0,200)

	if(luck && luck != initial(luck))
		.["luck"] = luck

	SAVEPATH("loot_to_generate")

/obj/item/organ/save_item_data(var/mob/living/advanced/player/P,var/save_inventory = TRUE,var/died=FALSE,var/loadout=FALSE)

	RUN_PARENT_SAFE

	var/list/blend_data = get_blend_data()
	if(length(blend_data)) .["blend_data"] = blend_data


/obj/item/organ/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data,var/loadout=FALSE)

	RUN_PARENT_SAFE

	if(object_data["blend_data"])
		log_debug("Blend data for [src.type]:")
		debug_list(object_data["blend_data"])
		set_blend_data(object_data["blend_data"])
	else
		log_debug("No blend data found for: [src.type].")


/obj/item/proc/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data,var/loadout=FALSE)

	if(object_data["name"])
		name = object_data["name"]
		if(can_rename)
			name = police_text(P.client,name,check_name=TRUE,check_characters=TRUE,min_length=2,max_length=40)
		if(!name)
			name = initial(name)
	if(object_data["label"])
		label = object_data["label"]
		label = police_text(P.client,label,check_name=TRUE,check_characters=TRUE,min_length=2,max_length=40)
		if(!label)
			label = initial(label)
	if(object_data["last_marker"])
		last_marker = object_data["last_marker"]
	if(object_data["color"])
		color = object_data["color"]
	if(object_data["inventories"])
		for(var/i=1,i<=length(object_data["inventories"]),i++)
			var/obj/hud/inventory/I = inventories[i]
			I.load_inventory_data(P,object_data["inventories"][i],loadout=loadout)
	if(object_data["soul_bound"])
		soul_bound = object_data["soul_bound"]
	if(object_data["amount"])
		amount = object_data["amount"]
	if(object_data["delete_on_drop"])
		delete_on_drop = TRUE
	if(object_data["quality"] && quality != -1)
		quality = clamp(object_data["quality"],0,200)
	if(object_data["luck"])
		luck = object_data["luck"]

	LOADPATH("loot_to_generate")

	return TRUE


/obj/item/proc/load_item_data_post(var/mob/living/advanced/player/P,var/list/object_data,var/loadout=FALSE)
	if(length(object_data["reagents"]))
		for(var/r_id in object_data["reagents"])
			var/volume = object_data["reagents"][r_id]
			var/reagent/R_path = text2path(r_id)
			if(!R_path)
				log_error("LOAD ERROR: Tried loading an invalid reagent [r_id]!")
				continue
			reagents.add_reagent(R_path,volume)
	return TRUE

/obj/hud/inventory/proc/load_inventory_data(var/mob/living/advanced/player/P,var/list/inventory_data,var/loadout=FALSE) //Setting the data found.

	if(!inventory_data)
		log_error("Warning: [src.get_debug_name()] in [P.get_debug_name()] had no inventory data!")
		return TRUE

	var/turf/T = get_turf(src)

	if(is_assoc_list(inventory_data))
		if(inventory_data["held"])
			for(var/i=1,i<=length(inventory_data["held"]),i++)
				var/obj/item/I = load_and_create(P,inventory_data["held"][i],T)
				if(I && !src.add_object(I,bypass_checks=TRUE,silent=TRUE))
					log_error("LOAD ERROR: Could not add \the [I.get_debug_name()] to \the [src.get_debug_name()]!")
					if(!I.qdeleting) I.drop_item(get_step(P,P.dir),silent=TRUE)

		if(inventory_data["worn"])
			for(var/i=1,i<=length(inventory_data["worn"]),i++)
				var/obj/item/I = load_and_create(P,inventory_data["worn"][i],T)
				if(I && !src.add_object(I,bypass_checks=TRUE,silent=TRUE))
					log_error("LOAD ERROR: Could not add \the [I.get_debug_name()] to \the [src.get_debug_name()]!")
					if(!I.qdeleting) I.drop_item(get_step(P,P.dir),silent=TRUE)
	else
		for(var/i=1,i<=length(inventory_data),i++)
			var/obj/item/I = load_and_create(P,inventory_data[i],T)
			if(I && !src.add_object(I,bypass_checks=TRUE,silent=TRUE))
				log_error("LOAD ERROR: Could not add \the [I.get_debug_name()] to \the [src.get_debug_name()]!")
				if(!I.qdeleting) I.drop_item(get_step(P,P.dir),silent=TRUE)

	if(ultra_persistant)
		for(var/k in all_players)
			var/mob/living/advanced/player/P2 = k
			if(P2.death_ckey != P.ckey_last) //Different ckey.
				continue
			if(P2.unique_pid != P.unique_pid) //Different player save.
				continue
			if(P2 == P)
				continue
			var/obj/hud/inventory/I = P2.inventories_by_id[src.id]
			for(var/j in I.contents)
				var/atom/A = j
				qdel(A)

	return TRUE

/obj/hud/inventory/proc/save_inventory_data(var/mob/living/advanced/player/P,var/save_inventory=TRUE,var/died=FALSE,var/loadout=FALSE) //Getting the inventory and their contents for saving.

	var/content_length = length(contents)

	. = new/list(content_length)

	for(var/i=1,i<=content_length,i++)
		var/obj/item/I = contents[i]
		if(!istype(I))
			log_error("Tried saving invalid item ([I ? I : "NULL"]) in an inventory!")
			continue
		if(died && (src.flags_hud & FLAG_HUD_MOB) && !src.ultra_persistant && !I.save_on_death)
			continue
		var/result = I.save_item_data(P,save_inventory,died,loadout)
		.[i] = result ? result : null //Forces null





