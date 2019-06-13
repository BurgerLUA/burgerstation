/mob/living/advanced/pre_death()

	if(client)
		var/obj/item/storage/heavy/H = new(src.loc)
		var/list/dropped_items = drop_all_items(exclude_soulbound = TRUE,exclude_containers=TRUE)

		var/savedata/client/mob/U = client.savedata
		U.save_current_character()

		for(var/obj/item/I in dropped_items)
			H.add_to_inventory(src,I,FALSE)

	else
		delete_all_items()


/mob/living/advanced/post_death()
	..()
	new/obj/effect/temp/death(get_turf(src))
	qdel(src)