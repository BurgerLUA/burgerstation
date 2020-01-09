/mob/living/advanced/player/Topic(href,href_list[],hsrc)

	if(length(href_list) && href_list["take"])
		var/obj/item/I = locate(href_list["take"])
		if(I && istype(I) && !I.qdeleting)
			if(get_dist(get_turf(I),get_turf(src)) <= 1)
				if(I && istype(I.loc,/obj/hud/inventory/organs/))
					var/list/callback_list = list()
					callback_list["target"] = I
					callback_list["start_turf"] = get_turf(src)
					callback_list["target_start_turf"] = get_turf(I)
					add_progress_bar(src,"take",SECONDS_TO_DECISECONDS(5),callback_list)
				else
					to_chat(span("notice","This object is no longer visible!"))
			else
				to_chat(span("notice","You're too far away!"))
		else
			to_chat(span("notice","Invalid item!"))

	return ..()