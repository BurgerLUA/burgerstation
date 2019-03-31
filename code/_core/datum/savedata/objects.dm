/savedata/proc/load_and_create_object(var/list/object_data,var/loc)

	var/o_type = object_data["type"]
	var/obj/O = new o_type(loc)

	//General Information
	if(object_data["color"])
		O.color = object_data["color"]

	if(is_item(O))
		var/obj/item/I = O
		if(object_data["inventories"])
			world.log << "NOTICE: [O] HAS INVENTORIES."
			for(var/i=1,i<=length(object_data["inventories"]),i++)
				apply_inventory_data(I,object_data["inventories"][i])
		else
			world.log << "NOTICE: [O] DOES NOT HAVE INVENTORIES."
	else
		world.log << "NOTICE: [O] IS NOT AN ITEM"

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
		var/obj/item/consumable/soulgem/S = O
		if(object_data["total_charge"])
			S.total_charge = object_data["total_charge"]

	if(is_currency(O))
		var/obj/item/currency/C = O
		if(object_data["value"])
			C.value = object_data["value"]

	if(is_bullet(O))
		var/obj/item/bullet/B = O
		if(object_data["bullet_count"])
			B.bullet_count = object_data["bullet_count"]
		else
			B.bullet_count = 1

	if(is_bullet_gun(O))
		var/obj/item/weapon/ranged/bullet/BG = O
		if(object_data["stored_magazine"])
			BG.stored_magazine = load_and_create_object(object_data["stored_magazine"],BG.loc)
		if(object_data["stored_bullets"])
			for(var/i=1, i <= length(object_data["stored_bullets"]), i++)
				var/b_type = object_data["stored_bullets"][i]
				var/obj/item/bullet/B = new b_type(BG.loc)
				B.update_icon()
				BG.stored_bullets += B

	if(is_magazine(O))
		var/obj/item/magazine/M = O
		if(object_data["stored_bullets"])
			for(var/i=1, i <= length(object_data["stored_bullets"]), i++)
				var/b_type = object_data["stored_bullets"][i]
				var/obj/item/bullet/B = new b_type(M.loc)
				B.update_icon()
				M.stored_bullets += B

	O.force_move(loc)
	O.update_icon()

	return O

/savedata/proc/get_inventory_data(var/obj/inventory/I)
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


/savedata/proc/apply_inventory_data(var/obj/item/O,var/list/inventory_data)

	var/obj/inventory/I

	world.log << "[O] has a total of [length(O.inventories)] inventories."


	for(var/obj/inventory/I2 in O.inventories)
		if(I2.id == inventory_data["id"])
			I = I2
			break

	if(I)
		if(inventory_data["held"])
			for(var/i=1,i<=length(inventory_data["held"]),i++)
				var/obj/item/I2 = load_and_create_object(inventory_data["held"][i],get_turf(I))
				I.add_held_object(I2,FALSE,TRUE)

		if(inventory_data["worn"])
			for(var/i=1,i<=length(inventory_data["worn"]),i++)
				var/obj/item/I2 = load_and_create_object(inventory_data["worn"][i],get_turf(I))
				I.add_worn_object(I2,FALSE,TRUE)

		return TRUE


	return FALSE

/savedata/proc/get_item_data(var/obj/I)
	if(!I)
		return list()

	var/list/returning_list = list()
	returning_list["type"] = I.type
	if(I.color && lowertext(I.color) != "#ffffff")
		returning_list["color"] = I.color

	var/list/blend_data = generate_blend_data(I)
	if(length(blend_data))
		returning_list["blend_data"] = blend_data

	if(is_item(I))
		var/obj/item/IT = I
		if(length(IT.inventories))
			returning_list["inventories"] = new/list(length(IT.inventories))
			for(var/i=1,i<=length(IT.inventories),i++)
				var/obj/inventory/IN = IT.inventories[i]
				returning_list["inventories"][i] = get_inventory_data(IN)

	if(is_soulgem(I))
		var/obj/item/consumable/soulgem/S = I
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

	if(is_bullet(I))
		var/obj/item/bullet/B = I
		if(B.bullet_count > 1)
			returning_list["bullet_count"] = B.bullet_count

	if(is_currency(I))
		var/obj/item/currency/C = I
		if(C.value > 1)
			returning_list["value"] = C.value

	if(is_bullet_gun(I))
		var/obj/item/weapon/ranged/bullet/BG = I
		if(BG.stored_magazine)
			returning_list["stored_magazine"] = get_item_data(BG.stored_magazine)
		if(length(BG.stored_bullets))
			returning_list["stored_bullets"] = new/list(length(BG.stored_bullets))
			for(var/i=1,i<=length(BG.stored_bullets),i++)
				var/obj/item/bullet/B = BG.stored_bullets[i]
				if(B) returning_list["stored_bullets"][i] = B.type

	if(is_magazine(I))
		var/obj/item/magazine/M = I
		if(length(M.stored_bullets))
			returning_list["stored_bullets"] = new/list(length(M.stored_bullets))
			for(var/i=1,i<=length(M.stored_bullets),i++)
				var/obj/item/bullet/B = M.stored_bullets[i]
				if(B) returning_list["stored_bullets"][i] = B.type

	return returning_list


/savedata/proc/generate_blend_data(var/atom/A)

	var/list/returning_list = list()
	for(var/id in A.additional_blends)

		var/icon_blend/IB = A.additional_blends[id]

		if(IB.should_save)
			returning_list[id] = list()
		else
			continue

		if(IB.id)
			returning_list[id]["id"] = IB.id

		if(IB.icon)
			returning_list[id]["icon"] = IB.icon

		if(IB.icon_state)
			returning_list[id]["icon_state"] = IB.icon_state

		if(IB.color)
			returning_list[id]["color"] = IB.color

		if(IB.blend)
			returning_list[id]["blend"] = IB.blend

		if(IB.special_type)
			returning_list[id]["special_type"] = IB.special_type

	return returning_list