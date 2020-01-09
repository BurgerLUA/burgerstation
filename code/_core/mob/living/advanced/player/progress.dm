/mob/living/advanced/player/on_progress_bar_completed(var/id,var/list/callback_list)

	switch(id)
		if("take")
			var/obj/item/I = callback_list["target"]
			if(!I || I.qdeleting)
				to_chat(span("notice","The object no longer exists!"))
				return TRUE
			if(right_hand && !length(right_hand.held_objects))
				I.transfer_item(right_hand)
			else if(left_hand && !length(left_hand.held_objects))
				I.transfer_item(left_hand)
			else
				to_chat(span("notice","One of your hands needs to be empty on order to do this!"))

			return TRUE

	..()

/mob/living/advanced/player/on_progress_bar_failed(var/id,var/list/callback_list)

	switch(id)
		if("take")
			to_chat(span("notice","You and the target must remain still!"))

	..()