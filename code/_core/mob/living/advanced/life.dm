/mob/living/advanced/pre_death()

	drop_all_items(exclude_soulbound = TRUE)

	if(client)
		var/savedata/client/mob/U = client.savedata
		U.save_current_character()


/mob/living/advanced/post_death()
	new/obj/effect/temp/death(get_turf(src))
	qdel(src)