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

	..()