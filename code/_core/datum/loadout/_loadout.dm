/loadout/
	var/list/spawning_items = list() //Remember, order matters! Also accepts loot.

/loadout/proc/get_spawning_items()
	return spawning_items.Copy() //Copy is needed.

/loadout/proc/pre_add(var/mob/living/advanced/A,var/obj/item/I) //added before initialize and spawn
	return TRUE

/loadout/proc/on_add(var/mob/living/advanced/A,var/obj/item/I) //added after initialize and spawn

	if(!I.quick_equip(A,silent=TRUE))
		log_error("Loadout Error: Could not add \the [I] to \the [A.get_debug_name()]!")
		qdel(I)
		return FALSE

	if(istype(I,/obj/item/clothing))
		var/obj/item/clothing/C = I
		if(!C.additional_clothing)
			return TRUE
		C.equip_additional_clothing(A)

	return TRUE

/loadout/proc/post_add(var/mob/living/advanced/A,var/list/added_items = list()) //Added after everything is added.

	for(var/obj/item/weapon/ranged/bullet/W in added_items) //So weapons don't spawn empty.
		if(SSbalance.weapon_to_bullet[W.type])
			for(var/i=1,i<=length(W.stored_bullets),i++)
				var/obj/item/bullet_cartridge/BC = SSbalance.weapon_to_bullet[W.type]
				BC = new BC(W)
				BC.amount = 1
				INITIALIZE(BC)
				GENERATE(BC)
				FINALIZE(BC)
				W.stored_bullets[i] = BC
		if(SSbalance.weapon_to_magazine[W.type])
			var/obj/item/weapon/ranged/bullet/magazine/W2 = W
			var/obj/item/magazine/M = SSbalance.weapon_to_magazine[W2.type]
			M = new M(W2)
			INITIALIZE(M)
			GENERATE(M)
			FINALIZE(M)
			W2.stored_magazine = M
			W2.open = FALSE
			W2.update_sprite()

	return TRUE