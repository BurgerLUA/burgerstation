/obj/structure/interactive/ground_ore_deposit
	name = "deep ore deposit"
	icon = 'icons/lighting.dmi'
	icon_state = "white"
	var/ore_score = 0
	//invisibility = 101
	var/material_id
	plane = PLANE_OBJ
	layer = LAYER_FLOOR_DECAL

/obj/structure/interactive/ground_ore_deposit/Initialize()

	. = ..()

	if(ore_score > 10)
		for(var/turf/simulated/floor/T in orange(1,src))
			if(locate(/obj/structure/interactive/ground_ore_deposit/) in T.contents)
				continue
			if(prob(50 + ore_score))
				var/obj/structure/interactive/ground_ore_deposit/GOD = new(T)
				GOD.material_id = material_id
				GOD.ore_score = ore_score * rand_precise(0.1,0.75)
				GOD.Initialize()

	update_icon()

	return .

/obj/structure/interactive/ground_ore_deposit/proc/mine()
	var/obj/item/material/ore/O = new(src.loc)
	O.material_id = src.material_id
	O.on_spawn()
	O.Move(get_step(src,SOUTH))
	src.ore_score--
	update_icon()
	return TRUE

/obj/structure/interactive/ground_ore_deposit/update_icon()
	var/color_mod = (Clamp(ore_score,0,100)/100)*255
	color = rgb(255 - color_mod,color_mod,0)
	return ..()

/obj/structure/interactive/ground_ore_deposit/map
	color = "#00FF00"
	ore_score = 200

/obj/structure/interactive/ground_ore_deposit/map/iron
	material_id = "iron"






