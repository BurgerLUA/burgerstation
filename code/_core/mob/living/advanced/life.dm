/mob/living/advanced/pre_death()



	if(client)
		drop_all_items(exclude_soulbound = TRUE)
		var/savedata/client/mob/U = client.savedata
		U.save_current_character()
	else
		delete_all_items()


/mob/living/advanced/post_death()
	..()
	new/obj/effect/temp/death(get_turf(src))
	qdel(src)