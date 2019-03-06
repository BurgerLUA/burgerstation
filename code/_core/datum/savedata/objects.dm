/savedata/proc/load_and_create_object(var/list/object_data,var/loc)

	var/o_type = object_data["type"]
	var/obj/O = new o_type(loc)

	//General Information
	if(object_data["color"])
		O.color = object_data["color"]

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