/obj/structure/interactive/ground_ore_deposit
	name = "deep ore deposit"
	icon = 'icons/lighting.dmi'
	icon_state = "white"
	var/ore_score = 1
	//invisibility = 101
	var/material_id
	plane = PLANE_OBJ
	layer = LAYER_FLOOR_DECAL
	initialize_type = INITIALIZE_LATE

/obj/structure/interactive/ground_ore_deposit/Initialize(var/desired_loc)

	. = ..()

	if(ore_score > 10)
		for(var/turf/simulated/floor/T in orange(1,src))
			if(locate(/obj/structure/interactive/ground_ore_deposit/) in T.contents)
				continue
			if(prob(50 + ore_score))
				var/obj/structure/interactive/ground_ore_deposit/GOD = new(T)
				GOD.material_id = material_id
				GOD.ore_score = ore_score * RAND_PRECISE(0.1,0.75)
				GOD.initialize_type = INITIALIZE_NONE
				INITIALIZE(GOD)

	update_sprite()

	return .

/obj/structure/interactive/ground_ore_deposit/proc/mine()
	if(src.ore_score <= 0)
		CRASH_SAFE("Tried to mine ore from a ground ore deposit that had no ore!")
		return FALSE
	src.ore_score--
	var/obj/item/material/ore/O = new(src.loc)
	O.material_id = src.material_id
	INITIALIZE(O)
	GENERATE(O)
	var/obj/structure/interactive/ore_box/OB = locate() in range(1,src)
	if(OB)
		O.force_move(OB)
	else
		O.force_move(get_step(src,pick(DIRECTIONS_ALL)))
	if(ore_score <= 0)
		qdel(src)
	update_sprite()
	return TRUE

/obj/structure/interactive/ground_ore_deposit/get_examine_list(var/mob/examiner)
	. = ..()
	. += div("notice","The meter detects an ore concentration of [ore_score]%.")
	return .

/obj/structure/interactive/ground_ore_deposit/update_icon()
	var/color_mod = (clamp(ore_score,0,100)/100)*255
	color = rgb(255 - color_mod,color_mod,0)
	return ..()

/obj/structure/interactive/ground_ore_deposit/map
	color = "#00FF00"
	ore_score = 200

/obj/structure/interactive/ground_ore_deposit/map/iron
	material_id = "iron"

/obj/structure/interactive/ground_ore_deposit/map/carbon
	material_id = "carbon"

/obj/structure/interactive/ground_ore_deposit/map/random/New(var/desired_loc)

	var/list/possible_materials = list(
		"iron" = 100,
		"phoron" = 10,
		"carbon" = 50,
		"gold" = 20,
		"silver" = 30,
		"diamond" = 5,
		"uranium" = 30,
		"titanium" = 20
	)

	var/material_to_choose = pickweight(possible_materials)

	material_id = material_to_choose
	ore_score *= possible_materials[material_to_choose]/100

	return ..()







