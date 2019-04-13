/mob/living/advanced/on_progress_bar_completed(var/id,var/list/callback_list)

	switch(id)
		if("enter_vehicle")
			var/obj/vehicle/V = callback_list["vehicle"]
			src.Move(V)
			return TRUE


	..()

/mob/living/advanced/on_progress_bar_failed(var/id,var/list/callback_list)

	switch(id)
		if("enter_vehicle")
			to_chat(span("notice","You must remain still in order to enter the vehicle!"))
			return TRUE

	..()