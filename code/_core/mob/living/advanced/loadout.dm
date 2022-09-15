/mob/living/advanced/proc/equip_loadout(var/loadout_id,var/soul_bound=FALSE)

	var/loadout/spawning_outfit = all_loadouts[loadout_id]
	if(!spawning_outfit)
		CRASH("Tried adding an invalid spawnoutfit ([loadout_id]) to [src.get_debug_name()]!")

	if(src.qdeleting)
		CRASH("Tried adding a loadout to to [src.get_debug_name()], which was qdeleting!")

	if(!src.initialized)
		CRASH("Tried adding a loadout to to [src.get_debug_name()], which wasn't initialized!")

	if(!length(src.labeled_organs))
		CRASH("Tried adding a loadout to to [src.get_debug_name()], which didn't have any organs!")

	var/list/items_to_add = spawning_outfit.get_spawning_items()

	var/list/added_items = list()

	var/turf/T = get_turf(src)
	for(var/k in items_to_add)
		if(ispath(k,/loot/))
			var/loot/spawning_loot = LOOT(k)
			var/list/loot_table = spawning_loot.create_loot_table()
			for(var/j in loot_table) //Items only.
				if(!ispath(j,/obj/item/))
					CREATE(j,T)
					continue
				var/obj/item/I = new j(T)
				spawning_loot.pre_spawn(I)
				spawning_outfit.pre_add(src,I)
				INITIALIZE(I)
				GENERATE(I)
				FINALIZE(I)
				spawning_loot.post_spawn(I)
				if(spawning_outfit.on_add(src,I))
					added_items += I
		else
			var/atom/movable/I = new k(T)
			spawning_outfit.pre_add(src,I)
			INITIALIZE(I)
			GENERATE(I)
			FINALIZE(I)
			if(spawning_outfit.on_add(src,I))
				added_items += I

	spawning_outfit.post_add(src,added_items)

	return TRUE
