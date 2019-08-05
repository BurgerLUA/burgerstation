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
			var/obj/item/food/F = callback_list["object"]
			src.to_chat(span("notice","You [F.consume_verb] \the [F]."))
			F.consume(src)
			return TRUE
		if("feed_other")
			var/obj/item/food/F = callback_list["object"]
			var/mob/living/advanced/A = callback_list["target"]
			src.to_chat(span("notice","You forcefeed \the [F] to \the [A]."))
			A.to_chat(span("warning","\The [src] forcefeeds you \the [F]!"))
			F.consume(A)
			return TRUE
		if("mine_ore")
			var/obj/structure/interactive/localmachine/ore_deposit/OD = callback_list["deposit"]
			var/obj/item/ore/O = callback_list["ore"]

			for(var/i=1,i<=pick(2,5),i++)
				var/obj/item/ore/NO = new O(get_turf(OD))
				step(NO,get_dir(OD,src))
				animate(NO,pixel_x = rand(-16,16),pixel_y=rand(-16,16),time=SECONDS_TO_DECISECONDS(1))

			OD.disallowed_mobs += src
			if(src.client)
				src.client.images -= OD.cached_image
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