var/global/list/ore_deposit_weights = list(
	/material/iron = 100,
	/material/phoron = 10,
	/material/carbon = 50,
	/material/gold = 20,
	/material/silver = 30,
	/material/diamond = 5,
	/material/uranium = 30,
	/material/titanium = 20,
	/material/platinum = 20,
)

/obj/marker/generation/ore

	grow_amount_min = 25
	grow_amount_max = 50
	objects_max = 25
	skip_chance = 30
	hole_chance = 0

	color = COLOR_GREY

	priority = 3

	bypass_disallow_generation = TRUE

	var/material/selected_ore_type

	custom_object_to_place = TRUE

	ignore_existing = TRUE

/obj/marker/generation/ore/New(var/desired_loc)
	. = ..()
	selected_ore_type = pickweight(ore_deposit_weights)
	objects_max *= 0.5 + (ore_deposit_weights[object_to_place]/100)*0.5
	objects_max = CEILING(objects_max,1)

/obj/marker/generation/ore/floor
	turf_whitelist = /turf/simulated/floor/
	object_to_place = /obj/structure/interactive/ore_deposit/floor

/obj/marker/generation/ore/floor/get_object_to_place(var/turf/T,var/objects_placed=0,var/grow_left=0)
	var/ore_amount = (objects_max*2 - objects_placed) + 5 + grow_left*5
	ore_amount *= (ore_deposit_weights[selected_ore_type]/100)
	ore_amount = CEILING(ore_amount,1)
	if(ore_amount > 0)
		var/obj/structure/interactive/ore_deposit/OD = new object_to_place(T)
		OD.material_id = selected_ore_type
		OD.ore_amount = ore_amount
		return OD
	return null


/obj/marker/generation/ore/wall
	turf_whitelist = /turf/simulated/wall/rock
	object_to_place = /obj/structure/interactive/ore_deposit/wall

/obj/marker/generation/ore/wall/New(var/atom/desired_loc)
	. = ..()
	if(desired_loc && is_wall(desired_loc))
		turf_whitelist = desired_loc.type

/obj/marker/generation/ore/wall/get_object_to_place(var/turf/T,var/objects_placed=0,var/grow_left=0)
	var/obj/structure/interactive/ore_deposit/OD = new object_to_place(T)
	OD.material_id = selected_ore_type
	OD.ore_amount = 5
	return OD
