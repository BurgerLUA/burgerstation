/loadout/
	var/list/obj/item/spawning_items = list() //Remember, order matters!

/loadout/proc/get_spawning_items()
	return spawning_items.Copy()

/loadout/proc/pre_add(var/mob/living/advanced/A,var/obj/item/I) //added before initialize and spawn
	return TRUE

/loadout/proc/on_add(var/mob/living/advanced/A,var/obj/item/I) //added after initialize and spawn

	if(!I.quick_equip(A,silent=TRUE))
		log_error("Loadout Error: Could not add \the [I] to \the [A.get_debug_name()]!")
		qdel(I)
		return FALSE

	if(is_clothing(I))
		var/obj/item/clothing/C = I
		if(!C.additional_clothing)
			return TRUE
		C.equip_additional_clothing(A)

	return TRUE

/loadout/proc/post_add(var/mob/living/advanced/A,var/list/added_items = list()) //Added after everything is added.

	var/list/found_magazines = list()
	for(var/obj/item/magazine/M in added_items)
		found_magazines += M

	for(var/obj/item/weapon/ranged/bullet/magazine/R in added_items)
		for(var/obj/item/magazine/M in found_magazines)
			if(!M.weapon_whitelist[R.type])
				continue
			M.drop_item(R)
			R.stored_magazine = M
			R.open = FALSE
			R.load_new_bullet_from_magazine(A)
			R.update_sprite()
			found_magazines -= M
			break

	return TRUE