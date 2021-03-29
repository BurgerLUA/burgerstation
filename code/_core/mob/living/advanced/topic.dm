/mob/living/advanced/Topic(href,href_list[],hsrc)

	if(length(href_list))
		if(href_list["view_inventory"])
			var/mob/living/advanced/A = locate(href_list["view_inventory"])
			if(istype(A))
				A.examine_body_inventory(src)

		if(href_list["uncuff"])
			var/mob/living/advanced/A = locate(href_list["uncuff"])
			if(istype(A))
				A.try_uncuff(src)

	. = ..()