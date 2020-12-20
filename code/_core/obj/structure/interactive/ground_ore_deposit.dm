/obj/structure/interactive/ground_ore_deposit
	name = "deep ore deposit"
	icon = 'icons/obj/structure/ore.dmi'
	icon_state = "deposit"
	var/ore_score = 1
	var/material_id
	plane = PLANE_FLOOR
	layer = 0
	initialize_type = INITIALIZE_LATE

	desired_light_range = 1
	desired_light_power = 0.25
	desired_light_color = "#FFFFFF"

/obj/structure/interactive/ground_ore_deposit/Initialize(var/desired_loc)

	if(!istype(loc,/turf/simulated/floor/))
		qdel(src)
		return TRUE

	. = ..()

	if(ore_score > 10)
		for(var/turf/simulated/floor/T in orange(1,src)) //Floors only. Yes it can spawn on tiles and reinforced plating, but that's fine.
			if(locate(/obj/structure/interactive/ground_ore_deposit/) in T.contents)
				continue
			if(prob(25 + ore_score))
				var/obj/structure/interactive/ground_ore_deposit/GOD = new(T)
				GOD.material_id = material_id
				GOD.ore_score = ore_score * RAND_PRECISE(0.1,0.75)
				GOD.initialize_type = INITIALIZE_NONE
				INITIALIZE(GOD)
				FINALIZE(GOD)

	return .
/obj/structure/interactive/ground_ore_deposit/PostInitialize()
	. = ..()
	update_sprite()
	return .

/obj/structure/interactive/ground_ore_deposit/proc/mine()
	if(src.ore_score <= 0)
		qdel(src)
		return FALSE
	src.ore_score--
	var/obj/item/material/ore/O = new(src.loc)
	O.material_id = src.material_id
	INITIALIZE(O)
	GENERATE(O)
	FINALIZE(O)
	var/obj/structure/interactive/ore_box/OB = locate() in range(1,src)
	if(OB)
		O.drop_item(OB)
	else
		O.drop_item(get_step(src,pick(DIRECTIONS_ALL)))
	if(ore_score <= 0)
		qdel(src)
	update_sprite()
	return TRUE

/obj/structure/interactive/ground_ore_deposit/get_examine_list(var/mob/examiner)
	. = ..()
	. += div("notice","The meter detects an ore concentration of [ore_score]%.")
	return .

/obj/structure/interactive/ground_ore_deposit/update_sprite()

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

/obj/structure/interactive/ground_ore_deposit/map
	ore_score = 200

/obj/structure/interactive/ground_ore_deposit/map/iron
	material_id = /material/iron

/obj/structure/interactive/ground_ore_deposit/map/carbon
	material_id = /material/carbon

/obj/structure/interactive/ground_ore_deposit/map/random/New(var/desired_loc)

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







