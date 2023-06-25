/obj/marker/spawning/
	name = "spawning marker"
	icon = 'icons/obj/markers/spawning.dmi'
	icon_state = "spawn"
	initialize_type = INITIALIZE_EARLY
	plane = PLANE_MOVABLE

/obj/marker/spawning/Initialize()
	do_spawn(src.loc)
	. = ..()

/obj/marker/spawning/Finalize()
	. = ..()
	qdel(src)

/obj/marker/spawning/proc/do_spawn(var/turf/T)
	return TRUE

/obj/marker/spawning/window/
	name = "full window"
	icon_state = "window_grille"
	alpha = 200

/obj/marker/spawning/window/proc/setup_airlock()

	var/turf/simulated/T = src.loc
	if(istype(T))
		T.map_color = "#222222"

	var/touching_space = src.get_best_touching_space()
	if(!touching_space)
		return FALSE

	var/obj/structure/interactive/door/alarm/D = new(src.loc)
	LATE_INIT(D)

	//This forces it to be one of 4 directions.
	if(touching_space & NORTH)
		D.set_dir(NORTH)
	else if(touching_space & SOUTH)
		D.set_dir(SOUTH)
	else if(touching_space & EAST)
		D.set_dir(EAST)
	else if(touching_space & WEST)
		D.set_dir(WEST)

	return D

/obj/marker/spawning/window/
	color = "#6E9CAD"

/obj/marker/spawning/window/do_spawn(var/turf/T)
	var/obj/structure/table/window/G = new(T)
	var/obj/structure/window/W = new(T)
	LATE_INIT(G)
	LATE_INIT(W)
	setup_airlock()

/obj/marker/spawning/window/tinted
	color = "#353535"

/obj/marker/spawning/window/tinted/do_spawn(var/turf/T)
	var/obj/structure/table/window/G = new(T)
	var/obj/structure/window/W = new(T)
	LATE_INIT(G)
	LATE_INIT(W)
	W.color = "#353535"
	W.opacity = 0
	setup_airlock()

/obj/marker/spawning/window/rcd/do_spawn(var/turf/T)
	var/obj/structure/interactive/construction/grille/G = new(T)
	var/obj/structure/window/W = new(T)
	INITIALIZE(G)
	INITIALIZE(W)
	GENERATE(G)
	GENERATE(W)
	FINALIZE(G)
	FINALIZE(W)
	if(SSsmoothing.initialized)
		SSsmoothing.queue_update_edges(T)

/obj/marker/spawning/window/reinforced/
	icon_state = "window_grille_reinforced"
	color = "#345A68"

/obj/marker/spawning/window/reinforced/do_spawn(var/turf/T)
	var/obj/structure/table/window/G = new(T)
	var/obj/structure/window/reinforced/W = new(T)
	LATE_INIT(G)
	LATE_INIT(W)
	setup_airlock()

/obj/marker/spawning/window/reinforced/grilled
	icon_state = "window_grille_reinforced"
	color = "#FFFF00"

/obj/marker/spawning/window/reinforced/grilled/do_spawn(var/turf/T)
	var/obj/structure/table/window/G = new(T)
	var/obj/structure/interactive/construction/grille/A = new(T)
	var/obj/structure/window/reinforced/W = new(T)
	LATE_INIT(G)
	LATE_INIT(A)
	LATE_INIT(W)
	setup_airlock()

/obj/marker/spawning/window/shuttle
	icon_state = "window_grille_reinforced"
	color = "#394D5B"

/obj/marker/spawning/window/shuttle/do_spawn(var/turf/T)
	var/obj/structure/table/window/G = new(T)
	G.plane = PLANE_SHUTTLE
	G.color = "#FFFFFF"
	var/obj/structure/window/reinforced/W = new(T)
	W.plane = PLANE_SHUTTLE
	W.color = "#394D5B"
	W.alpha = 200
	LATE_INIT(G)
	LATE_INIT(W)
	setup_airlock()

/obj/marker/spawning/window/extra/
	icon_state = "window_grille_extra"
	color = "#E423C9"

/obj/marker/spawning/window/extra/do_spawn(var/turf/T)
	var/obj/structure/table/window/G = new(T)
	var/obj/structure/window/reinforced/plasma/W = new(T)
	LATE_INIT(G)
	LATE_INIT(W)
	setup_airlock()

/obj/marker/spawning/random
	var/list/possible_objects = list()
	var/chance_none = 0


/obj/marker/spawning/random/do_spawn(var/turf/T)

	if(!prob(chance_none))
		var/datum/D = pickweight(possible_objects)
		if(ispathcache(D,/turf/))
			T.change_turf(D)
		else if(ispath(D,/loot/))
			SPAWN_LOOT(D,T)
		else if(ispath(D,/atom/movable))
			if(ispathcache(D,/obj/item/))
				var/obj/item/I = D
				I = new I(T)
				if(I.amount_max == 1 && I.amount > I.amount_max)
					var/tried_amount = I.amount
					I.amount = 1
					for(var/i=1,i<=tried_amount,i++)
						var/obj/item/I2 = new I.type(T)
						I2.amount = 1
						LATE_INIT(I2)
				LATE_INIT(I)
			else
				var/atom/movable/A = D
				A = new A(T)
				LATE_INIT(A)

/obj/marker/spawning/random/maintenance
	icon_state = "maint"
	chance_none = 20
	possible_objects = list(
		//Trash piles and loot
		/obj/structure/interactive/storage/trash_pile/station = 100,
		/obj/marker/spawning/random/supply_crate = 1,
		/obj/structure/interactive/bookcase = 5,
		//Crates
		/obj/structure/interactive/crate = 30,
		/obj/structure/interactive/crate/closet = 20,
		/obj/structure/interactive/crate/engineering = 10,
		/obj/structure/interactive/crate/closet/emergency = 10,
		/obj/structure/interactive/crate/closet/emergency/filled = 5,
		/obj/structure/interactive/crate/closet/fire = 10,
		/obj/structure/interactive/crate/closet/fire/filled = 5,
		/obj/structure/interactive/crate/coffin = 5,
		/obj/structure/interactive/crate/bodybag = 5,
		//Reagents
		/obj/structure/interactive/reagent_tank/rolly/water = 50,
		/obj/structure/interactive/reagent_tank/rolly/ethanol = 50,
		/obj/structure/interactive/reagent_tank/barrel/oil = 5,
		/obj/structure/interactive/reagent_tank/barrel/water = 5,
		/obj/structure/interactive/reagent_tank/rolly/lube = 5,

		//Tables
		/obj/structure/table/rack/grey = 50,
		/obj/structure/table/steel = 10,

		//Structures
		/obj/structure/interactive/construction/grille = 20,
		/obj/structure/interactive/construction/girder = 10,
		/obj/structure/interactive/potted_plant/nanotrasen = 10,

		//Turfs
		/turf/simulated/wall/metal = 10,
		/turf/simulated/floor/colored/dirt = 5,

		//Vending
		/obj/structure/interactive/vending/random = 10,

		//Misc
		/obj/structure/interactive/ore_box = 5
	)

/obj/marker/spawning/random/supply_crate
	name = "random supply crate"
	icon_state = "supply"
	possible_objects = list(
		/obj/item/supply_crate/solarian = 1,
		/obj/item/supply_crate/magic = 2,
		/obj/item/supply_crate/nanotrasen = 3,
		/obj/item/supply_crate/slavic = 2,
		/obj/item/supply_crate/syndicate = 2,
		/obj/item/supply_crate/medicine = 20
	)
	chance_none = 75

/obj/marker/spawning/random/vault_loot
	name = "random vault loot"
	icon_state = "vault"
	possible_objects = list(
		/loot/syndicate/vault = 1,
	)

/obj/marker/spawning/random/misc
	name = "misc loot"
	icon_state = "misc"
	possible_objects = list(
		/loot/misc = 1
	)

/obj/marker/spawning/random/dangerous
	name = "dangerous loot"
	icon_state = "misc"
	possible_objects = list(
		/loot/misc/dangerous = 1
	)
	color = COLOR_CRIMSON

/obj/marker/spawning/random/valuable
	name = "valuable loot"
	icon_state = "misc"
	possible_objects = list(
		/loot/misc/safe = 1
	)
	color = COLOR_GOLD

/obj/marker/spawning/random/trash
	name = "trash(?) loot"
	icon_state = "misc"
	possible_objects = list(
		/loot/random/trash/lots = 1
	)
	color = COLOR_GREY

/obj/marker/spawning/random/ashwalker
	name = "ashwalker(?) loot"
	icon_state = "misc"
	possible_objects = list(
		/loot/misc/ashwalker = 100,
		/loot/misc/dangerous = 20,
		/obj/marker/spawning/random/valuable = 10,
		/obj/marker/spawning/random/vault_loot = 1
	)
	color = COLOR_GREEN



/obj/marker/spawning/random/kitchen
	name = "kitchen loot"
	icon_state = "kitchen"
	possible_objects = list(
		/loot/misc/kitchen = 1
	)

/obj/marker/spawning/random/food
	name = "food and drink loot"
	icon_state = "food"
	possible_objects = list(
		/loot/misc/food = 1
	)


/obj/marker/spawning/random/vault_loot/secure
	name = "random secure vault loot"
	icon_state = "vault_secure"
	possible_objects = list(
		/loot/syndicate/vault/secure = 1,
	)