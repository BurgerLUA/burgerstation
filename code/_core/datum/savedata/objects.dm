/proc/load_and_create_object(var/list/object_data,var/atom/loc)

	if(!object_data)
		log_error("Tried to create an object with a blank object_data list!")
		return FALSE

	if(!loc)
		log_error("Tried to create an object in a null location!")
		return FALSE

	var/o_type = object_data["type"]
	var/obj/O

	if(!o_type)
		return FALSE

	try
		O = new o_type(loc)
	catch
		log_error("ERROR: \"[o_type]\" attempted to be loaded inside [loc.get_debug_name()], but it does not exist in code!")
		return FALSE

	//General Information
	if(object_data["color"])
		O.color = object_data["color"]

	if(is_item(O))
		var/obj/item/I = O
		if(object_data["inventories"])
			for(var/i=1,i<=length(object_data["inventories"]),i++)
				apply_inventory_data(I,object_data["inventories"][i])
		if(object_data["soul_bound"])
			I.soul_bound = object_data["soul_bound"]
		if(object_data["item_count_current"])
			I.item_count_current = object_data["item_count_current"]
		if(object_data["delete_on_drop"])
			I.delete_on_drop = TRUE

	if(istype(O,/obj/item/radio) && object_data["stored_radio"])
		var/obj/item/radio/R = O
		R.stored_radio = load_and_create_object(object_data["stored_radio"],R)

	if(istype(O,/obj/item/clothing/ears/headset) && object_data["stored_radio"])
		var/obj/item/clothing/ears/headset/R = O
		R.stored_radio = load_and_create_object(object_data["stored_radio"],R)

	if(istype(O,/obj/item/weapon/ranged/))
		var/obj/item/weapon/ranged/R = O
		R.firing_pin = load_and_create_object(object_data["firing_pin"],R)

	if(is_food(O))
		var/obj/item/container/food/F = O
		F.original_volume = object_data["original_volume"]

	if(is_clothing(O) && length(object_data["polymorphs"]))
		var/obj/item/clothing/C = O
		C.polymorphs = object_data["polymorphs"]

	if(is_pill(O))
		var/obj/item/container/pill/P = O
		if(object_data["double"])
			P.double = TRUE
		if(object_data["reagents_2"] && length(object_data["reagents_2"]))
			for(var/r_id in object_data["reagents_2"])
				var/volume = object_data["reagents_2"][r_id]
				P.reagents_2.add_reagent(r_id,volume,TNULL,FALSE)
			P.reagents_2.update_container()

	if(is_scroll(O))
		var/obj/item/weapon/ranged/magic/scroll/S = O
		if(object_data["scroll_count"])
			S.scroll_count = object_data["scroll_count"]
		else
			S.scroll_count = 0

	if(is_weapon(O))
		var/obj/item/weapon/W = O
		if(object_data["open"])
			W.open = object_data["open"]
		else
			W.open = FALSE

	if(is_soulgem(O))
		var/obj/item/soulgem/S = O
		if(object_data["total_charge"])
			S.total_charge = object_data["total_charge"]

	if(is_powercell(O))
		var/obj/item/powercell/P = O
		if(object_data["charge_current"])
			P.charge_current = object_data["charge_current"]

	if(istype(O,/obj/item/container/food/dynamic))
		var/obj/item/container/food/dynamic/D = O
		D.icon_state = object_data["icon_state"]

	if(istype(O,/obj/item/container/food/dynamic/bread))
		var/obj/item/container/food/dynamic/bread/B = O
		B.cooked_icon_state = object_data["cooked_icon_state"]
		B.raw_icon_state = object_data["raw_icon_state"]

	if(istype(O,/obj/item/container/food/dynamic/meat))
		var/obj/item/container/food/dynamic/meat/M = O
		object_data["last_cooked"] = M.last_cooked

	if(is_bullet_gun(O))
		var/obj/item/weapon/ranged/bullet/BG = O

		if(object_data["chambered_bullet"])
			var/b_type = object_data["chambered_bullet"]
			var/obj/item/bullet_cartridge/B = new b_type(BG)
			INITIALIZE(B)
			BG.chambered_bullet = B

		if(object_data["stored_bullets"] && length(object_data["stored_bullets"]))
			for(var/i=1, i <= length(object_data["stored_bullets"]), i++)
				var/b_type = object_data["stored_bullets"][i]
				if(b_type)
					var/obj/item/bullet_cartridge/B = new b_type(BG)
					INITIALIZE(B)
					BG.stored_bullets[i] = B

	if(is_magazine_gun(O))
		var/obj/item/weapon/ranged/bullet/magazine/MG = O
		if(object_data["stored_magazine"])
			MG.stored_magazine = load_and_create_object(object_data["stored_magazine"],MG)
/*
	if(is_pump_gun(O))
		var/obj/item/weapon/ranged/bullet/pump/P = O
		if(object_data["stored_chamber"])
			var/b_type = object_data["stored_chamber"]
			var/obj/item/bullet_cartridge/B = new b_type(P)
			INITIALIZE(B)
			P.stored_chamber += B
*/

	if(is_magazine(O))
		var/obj/item/magazine/M = O
		if(object_data["stored_bullets"])
			for(var/k in object_data["stored_bullets"])
				var/v = object_data["stored_bullets"][k]
				for(var/i=1,i<=v,i++)
					var/obj/item/bullet_cartridge/B = new k(M)
					INITIALIZE(B)
					M.stored_bullets += B

	if(istype(O,/obj/item/firing_pin/))
		var/obj/item/firing_pin/FP = O
		if(object_data["iff_tag"])
			FP.iff_tag = object_data["iff_tag"]

	if(istype(O,/obj/item/supply_remote))
		var/obj/item/supply_remote/D = O
		D.stored_object_types = object_data["stored_object_types"]
		D.charges = object_data["charges"]

	INITIALIZE(O)

	if(is_item(O) && object_data["reagents"] && length(object_data["reagents"]))
		var/obj/item/I = O
		for(var/r_id in object_data["reagents"])
			var/volume = object_data["reagents"][r_id]
			I.reagents.add_reagent(text2path(r_id),volume,TNULL,FALSE)
		I.reagents.update_container()
		I.update_sprite()

	O.force_move(loc)
	O.update_sprite()

	return O

/proc/get_inventory_data(var/obj/hud/inventory/I)
	if(!I)
		return list()

	var/list/returning_list = list()
	returning_list["type"] = I.type
	returning_list["id"] = I.id

	if(length(I.held_objects))
		returning_list["held"] = new/list(length(I.held_objects))
		for(var/i=1,i<=length(I.held_objects),i++)
			returning_list["held"][i] = get_item_data(I.held_objects[i])

	if(length(I.worn_objects))
		returning_list["worn"] = new/list(length(I.worn_objects))
		for(var/i=1,i<=length(I.worn_objects),i++)
			returning_list["worn"][i] = get_item_data(I.worn_objects[i])

	return returning_list

/proc/get_item_data(var/obj/I,var/save_inventory = TRUE)

	try
		if(!I || !I.should_save)
			return list()

		var/list/returning_list = list()
		returning_list["type"] = I.type
		if(I.color && lowertext(I.color) != "#ffffff")
			returning_list["color"] = I.color

		if(is_organ(I)) //Only organs should save blend data.
			var/list/blend_data = generate_blend_data(I)
			if(length(blend_data))
				returning_list["blend_data"] = blend_data

		if(is_item(I))
			var/obj/item/IT = I
			if(save_inventory && length(IT.inventories))
				returning_list["inventories"] = new/list(length(IT.inventories))
				for(var/i=1,i<=length(IT.inventories),i++)
					var/obj/hud/inventory/IN = IT.inventories[i]
					returning_list["inventories"][i] = get_inventory_data(IN)
			if(IT.soul_bound)
				returning_list["soul_bound"] = IT.soul_bound
			if(IT.item_count_current > 1)
				returning_list["item_count_current"] = IT.item_count_current
			if(IT.delete_on_drop)
				returning_list["delete_on_drop"] = TRUE
			if(IT.reagents && IT.reagents.stored_reagents && length(IT.reagents.stored_reagents))
				returning_list["reagents"] = list()
				for(var/r_id in IT.reagents.stored_reagents)
					var/volume = IT.reagents.stored_reagents[r_id]
					returning_list["reagents"][r_id] = volume

		if(istype(I,/obj/item/weapon/ranged/))
			var/obj/item/weapon/ranged/R = I
			if(R.firing_pin)
				returning_list["firing_pin"] = get_item_data(R.firing_pin)

		if(is_food(I))
			var/obj/item/container/food/F = I
			returning_list["original_volume"] = F.original_volume

		if(istype(I,/obj/item/container/food/dynamic))
			var/obj/item/container/food/dynamic/D = I
			returning_list["icon_state"] = D.icon_state

		if(istype(I,/obj/item/container/food/dynamic/bread))
			var/obj/item/container/food/dynamic/bread/B = I
			returning_list["cooked_icon_state"] = B.cooked_icon_state
			returning_list["raw_icon_state"] = B.raw_icon_state

		if(istype(I,/obj/item/container/food/dynamic/meat))
			var/obj/item/container/food/dynamic/meat/M = I
			returning_list["last_cooked"] = M.last_cooked

		if(is_clothing(I))
			var/obj/item/clothing/C = I
			if(length(C.polymorphs))
				returning_list["polymorphs"] = C.polymorphs

		if(is_pill(I))
			var/obj/item/container/pill/P = I
			if(P.reagents_2 && P.reagents_2.stored_reagents && length(P.reagents_2.stored_reagents))
				returning_list["reagents_2"] = list()
				for(var/r_id in P.reagents_2.stored_reagents)
					returning_list["reagents_2"][r_id] = P.reagents_2.stored_reagents[r_id]

		if(is_soulgem(I))
			var/obj/item/soulgem/S = I
			if(S.total_charge)
				returning_list["total_charge"] = S.total_charge

		if(is_weapon(I))
			var/obj/item/weapon/W = I
			if(W.open)
				returning_list["open"] = TRUE

		if(is_scroll(I))
			var/obj/item/weapon/ranged/magic/scroll/S = I
			if(S.scroll_count)
				returning_list["scroll_count"] = S.scroll_count

		if(is_powercell(I))
			var/obj/item/powercell/P = I
			if(P.charge_current)
				returning_list["charge_current"] = P.charge_current

		if(istype(I,/obj/item/radio))
			var/obj/item/radio/R = I
			returning_list["stored_radio"] = get_item_data(R.stored_radio)

		if(istype(I,/obj/item/clothing/ears/headset))
			var/obj/item/clothing/ears/headset/R = I
			returning_list["stored_radio"] = get_item_data(R.stored_radio)

		if(is_bullet_gun(I))
			var/obj/item/weapon/ranged/bullet/BG = I

			if(BG.chambered_bullet)
				returning_list["chambered_bullet"] = BG.chambered_bullet.type

			if(length(BG.stored_bullets))
				returning_list["stored_bullets"] = new/list(length(BG.stored_bullets))
				for(var/i=1,i<=length(BG.stored_bullets),i++)
					var/obj/item/bullet_cartridge/B = BG.stored_bullets[i]
					if(B) returning_list["stored_bullets"][i] = B.type


		/*
		if(is_pump_gun(I))
			var/obj/item/weapon/ranged/bullet/pump/P = I
			if(P.stored_chamber)
				returning_list["stored_chamber"] = P.stored_chamber.type
		*/

		if(is_magazine_gun(I))
			var/obj/item/weapon/ranged/bullet/magazine/MG = I
			if(MG.stored_magazine)
				returning_list["stored_magazine"] = get_item_data(MG.stored_magazine)

		if(is_magazine(I))
			var/obj/item/magazine/M = I
			if(length(M.stored_bullets))
				returning_list["stored_bullets"] = list()
				for(var/i=1,i<=length(M.stored_bullets),i++)
					var/obj/item/bullet_cartridge/B = M.stored_bullets[i]
					if(B) returning_list["stored_bullets"][B.type] += 1

		if(istype(I,/obj/item/firing_pin/))
			var/obj/item/firing_pin/FP = I
			returning_list["iff_tag"] = FP.iff_tag

		if(istype(I,/obj/item/supply_remote))
			var/obj/item/supply_remote/D = I
			returning_list["stored_object_types"] = D.stored_object_types
			returning_list["charges"] = D.charges

		return returning_list

	catch(var/exception/e)
		log_error("ERROR: Could not save [I.get_debug_name()]! [e.name] in [e.file]:[e.line].\n[e.desc]")

	return null