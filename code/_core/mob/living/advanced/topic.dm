/mob/living/advanced/Topic(href,href_list[],hsrc)

	if(length(href_list))
		if(href_list["uncuff"])
			var/mob/living/advanced/A = locate(href_list["uncuff"])
			if(istype(A))
				A.try_uncuff(src)

	. = ..()