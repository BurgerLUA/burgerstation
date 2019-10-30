/mob/living/advanced/on_progress_bar_completed(var/id,var/list/callback_list)

	switch(id)
		if("enter_vehicle")
			var/obj/vehicle/V = callback_list["vehicle"]
			src.Move(V)
			return TRUE
		if("loot_object")
			var/obj/structure/interactive/lootable/L = callback_list["object"]
			L.give_items(src,callback_list["left"])
			return TRUE
		if("teleport")
			var/atom/A = callback_list["end_turf"]
			src.force_move(A)
			return TRUE
		if("feed_self")
			var/obj/item/container/food/F = callback_list["object"]
			F.consume(src)
			return TRUE
		if("feed_other")
			var/obj/item/container/food/F = callback_list["object"]
			var/mob/living/advanced/A = callback_list["target"]
			src.to_chat(span("notice","You forcefeed \the [F] to \the [A]."))
			A.to_chat(span("warning","\The [src] forcefeeds you \the [F]!"))
			F.consume(A)
			return TRUE
		if("inject")
			var/obj/item/organ/O = callback_list["target"]
			var/obj/item/container/syringe/S = callback_list["object"]
			var/is_injecting = callback_list["injecting"]
			var/verb_to_use = is_injecting ? "inject" : "draw blood from"
			if(is_injecting)
				S.reagents.transfer_reagents_to(O.reagents,S.inject_amount)
			else
				O.reagents.transfer_reagents_to(S.reagents,S.draw_amount)

			src.to_chat(span("notice","You [verb_to_use] \the [O.name] with your [S.name]."))

			S.update_icon()

			return TRUE
		if("mine_ore")
			var/obj/structure/interactive/ore_deposit/OD = callback_list["deposit"]
			var/obj/item/ore/O = callback_list["ore"]

			if(OD.uses_current <= 0)
				src.to_chat(span("notice","This ore vein is depleted!."))
				return TRUE

			var/obj/item/ore/NO = new O(get_turf(src))

			var/move_direction = get_dir(OD,src)

			var/animation_offset_x = 0
			var/animation_offset_y = 0

			if(move_direction & NORTH)
				animation_offset_y -= 32

			if(move_direction & SOUTH)
				animation_offset_y += 32

			if(move_direction & EAST)
				animation_offset_x -= 32

			if(move_direction & WEST)
				animation_offset_x += 32

			NO.pixel_x = animation_offset_x
			NO.pixel_y = animation_offset_y

			animate(NO, pixel_x = rand(-16,16), pixel_y=rand(-16,16), time = 1)

			OD.uses_current -= 1
			OD.update_icon()

			if(OD.uses_current > 0 && get_dist(src,OD) <= 1)
				var/obj/item/I = callback_list["object"]
				add_progress_bar(src,"mine_ore",I.tool_time,callback_list)

			spawn(SECONDS_TO_DECISECONDS(60))
				if(OD)
					OD.uses_current += 1
					OD.update_icon()

			return TRUE

	..()

/mob/living/advanced/on_progress_bar_failed(var/id,var/list/callback_list)

	switch(id)
		if("enter_vehicle")
			to_chat(span("notice","You must remain still in order to enter the vehicle!"))
			return TRUE
		if("loot_object")
			to_chat(span("notice","You must remain still in order to find an object!"))
			return TRUE
		if("teleport")
			to_chat(span("notice","You need to be standing still in order to teleport!"))
			return TRUE
		if("feed_self") //TODO: Debate whether or not you should be standing still in order to eat food.
			to_chat(span("notice","You need to be standing still in order to eat!"))
			return TRUE
		if("feed_other")
			to_chat(span("notice","You and your target needs to be standing still in order to feed them!"))
			return TRUE
		if("mine_ore")
			to_chat(span("notice","You must remain still in order to mine!"))
			return TRUE

	..()