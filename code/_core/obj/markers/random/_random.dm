/obj/marker/random
	name = "random marker"
	var/loot_to_spawn
	var/spawn_count = 1
	var/spawn_chance = 100
	icon = 'icons/obj/markers/random.dmi'
	icon_state = "random"

/obj/marker/random/New(var/desired_loc)

	if(loot_to_spawn && all_loot[loot_to_spawn])
		var/loot/L = all_loot[loot_to_spawn]
		for(var/i=1,i<=spawn_count,i++)
			if(!prob(spawn_chance))
				continue
			L.spawn_loot(desired_loc)

	. = ..()

	qdel(src)

/obj/marker/random/disposals_trash
	name = "disposals trash random loot"
	loot_to_spawn = "disposals_trash"
	spawn_count = 5
	spawn_chance = 90