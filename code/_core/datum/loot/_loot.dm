/loot/
	var/name = "random loot"
	var/desc = "Loot is spawned."
	var/id

	var/list/loot_table = list()
	var/loot_count = 1 //Only works on spawn_loot_turf

	var/account_bound = FALSE

/loot/proc/spawn_loot(var/spawn_loc)

	var/obj/item/I = pickweight(loot_table)
	I = new I(spawn_loc)

	return I

/loot/proc/spawn_loot_advanced(var/mob/living/advanced/A,var/left = FALSE)
	var/obj/item/I = spawn_loot(get_turf(A))
	A.pickup(I,left)

/loot/proc/spawn_loot_turf(var/turf/T)

	for(var/i=1,i <= loot_count,i++)
		var/obj/item/I = spawn_loot(T)
		step_rand(I)




