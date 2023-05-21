/loadout/
	var/list/spawning_items = list() //Remember, order matters! Also accepts loot.

	var/obj/item/spawn_on_loot_fail //Put a backpack path here or something so failed loot goes in it if it can.

/loadout/proc/get_spawning_items()
	return spawning_items.Copy() //Copy is needed.

/loadout/proc/pre_add(var/mob/living/advanced/A,var/obj/item/I) //added before initialize and spawn
	return TRUE

/loadout/proc/on_add(var/mob/living/advanced/A,var/obj/item/I) //added after initialize and spawn

	. = TRUE

	if(!I.quick_equip(A,silent=TRUE))
		. = FALSE
		if(spawn_on_loot_fail)
			var/item_slot = initial(spawn_on_loot_fail.item_slot)
			for(var/k in A.inventories_by_id)
				var/obj/hud/inventory/INV = A.inventories_by_id[k]
				if(!(INV.item_slot & item_slot))
					continue
				if(length(INV.contents))
					continue
				var/obj/item/IF = new spawn_on_loot_fail(get_turf(A))
				INITIALIZE(IF)
				GENERATE(IF)
				FINALIZE(IF)
				INV.add_object(IF,messages=FALSE)
				if(IF.add_object_to_src_inventory(A,I,enable_messages=FALSE))
					. = TRUE
				break

		if(!.)
			log_error("Loadout Error: Could not add \the [I.type] to \the [A.get_debug_name()]!")
			qdel(I)
			return FALSE

	if(is_clothing(I))
		var/obj/item/clothing/C = I
		if(!C.additional_clothing)
			return TRUE
		C.equip_additional_clothing(A)

	return .

/loadout/proc/post_add(var/mob/living/advanced/A,var/list/added_items = list()) //Added after everything is added.

	for(var/obj/item/weapon/ranged/W in added_items) //So bullet weapons don't spawn empty.
		if(SSbalance.weapon_to_bullet[W.type])
			var/obj/item/weapon/ranged/bullet/W2 = W
			for(var/i=1,i<=length(W2.stored_bullets),i++)
				var/obj/item/bullet_cartridge/BC = SSbalance.weapon_to_bullet[W2.type]
				BC = new BC(W2)
				BC.amount = 1
				INITIALIZE(BC)
				GENERATE(BC)
				FINALIZE(BC)
				W2.stored_bullets[i] = BC
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

		if(is_wand(W))
			var/obj/item/weapon/ranged/wand/W2 = W
			if(!W2.socketed_spellgem)
				for(var/obj/item/weapon/ranged/spellgem/S in added_items)
					if(is_wand(S.loc))
						continue
					S.drop_item(W2)
					W2.socketed_spellgem = S
			if(length(W2.socketed_supportgems) < W2.sockets)
				for(var/obj/item/supportgem/S in added_items)
					if(is_wand(S.loc))
						continue
					if(length(W2.socketed_supportgems) >= W2.sockets)
						break
					S.drop_item(W2)
					W2.socketed_supportgems += S
			W2.update_sprite()
			W2.update_attachment_stats()


	return TRUE