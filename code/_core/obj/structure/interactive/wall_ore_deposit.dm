/obj/structure/interactive/wall_ore_deposit
	name = "ore deposit"
	icon = 'icons/obj/structure/ore.dmi'
	icon_state = "deposit"
	var/ore_score = 1
	var/material_id
	plane = PLANE_WALL
	layer = 99
	initialize_type = INITIALIZE_LATE

/obj/structure/interactive/wall_ore_deposit/Initialize(var/desired_loc)

	if(!istype(loc,/turf/simulated/wall/rock/))
		qdel(src)
		return TRUE

	. = ..()

	if(ore_score > 10)
		for(var/turf/simulated/wall/rock/T in orange(1,src)) //Rock Wall only.
			if(locate(/obj/structure/interactive/wall_ore_deposit/) in T.contents)
				continue
			if(prob(25 + ore_score))
				var/obj/structure/interactive/wall_ore_deposit/GOD = new(T)
				GOD.material_id = material_id
				GOD.ore_score = ore_score * RAND_PRECISE(0.1,0.75)
				GOD.initialize_type = INITIALIZE_NONE
				INITIALIZE(GOD)
				FINALIZE(GOD)

	return .
/obj/structure/interactive/wall_ore_deposit/PostInitialize()

	. = ..()

	if(loc)
		HOOK_ADD("on_destruction","ore_on_destruction",loc,src,.proc/mine)

	update_sprite()

	return .

/obj/structure/interactive/wall_ore_deposit/Destroy()

	if(loc)
		HOOK_REMOVE("on_destruction","ore_on_destruction",loc)

	return ..()


/obj/structure/interactive/wall_ore_deposit/proc/mine(var/turf/T,var/mob/caller,var/damage = FALSE)

	for(var/i=1,i<=CEILING(ore_score/10,1),i++)
		var/obj/item/material/ore/O = new(src.loc)
		O.material_id = src.material_id
		INITIALIZE(O)
		GENERATE(O)
		FINALIZE(O)

		var/move_direction = get_dir(src,caller)

		var/animation_offset_x = 0
		var/animation_offset_y = 0

		if(move_direction & NORTH)
			animation_offset_y -= 32

		if(move_direction & SOUTH)
			animation_offset_y += 32

		if(move_direction & EAST)
			animation_offset_x -= 32

		if(move_direction & WEST)
			animation_offset_x += 32

		O.pixel_x = animation_offset_x
		O.pixel_y = animation_offset_y

		animate(O, pixel_x = rand(-16,16), pixel_y=rand(-16,16), time = 1)

	qdel(src)

	return TRUE

/obj/structure/interactive/wall_ore_deposit/get_examine_list(var/mob/examiner)
	. = ..()
	. += div("notice","The meter detects an ore concentration of [ore_score]%.")
	return .

/obj/structure/interactive/wall_ore_deposit/update_sprite()

	. = ..()

	var/material/M = SSmaterials.all_materials[material_id]

	if(!M)
		log_error("Warning: Material id [material_id] does not exist for ground deposit!")
		return .


	if(M.icon_state_ore_deposit)
		icon_state = M.icon_state_ore_deposit
		color = "#FFFFFF"
	else
		icon_state = "deposit"
		color = M.color

	alpha = min(40 + (ore_score/100)*255,255)

	return .

/obj/structure/interactive/wall_ore_deposit/map
	ore_score = 200

/obj/structure/interactive/wall_ore_deposit/map/random/New(var/desired_loc)

	var/list/possible_materials = list(
		/material/iron = 100,
		/material/phoron = 10,
		/material/carbon = 50,
		/material/gold = 20,
		/material/silver = 30,
		/material/diamond = 5,
		/material/uranium = 30,
		/material/titanium = 20
	)

	var/material_to_choose = pickweight(possible_materials)
	material_id = material_to_choose
	ore_score *= possible_materials[material_to_choose]/100

	return ..()







