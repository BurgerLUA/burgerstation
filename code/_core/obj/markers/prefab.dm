/obj/marker/prefab
	name = "prefab marker"
	var/category
	icon_state = null
	var/chance_none = 0
	var/list/prefabs = null
	var/unique = TRUE //Only allow one prefab of type.

	//Tile offsets.
	var/offset_x = 0
	var/offset_y = 0

	//invisibility = 101

	var/rotational_offset = 0 //For when the prefab gets rotated by dmm_suite.

	var/chosen_file //For debug only.
	var/chosen_file_above //For debug only.
	var/chosen_file_below //For debug only.


/obj/marker/prefab/on_dmm_suite_rotate(var/angle_offset=0)
	. = ..()
	switch(angle_offset)
		if(90)
			offset_y -= (rotational_offset-1)
		if(180)
			offset_x -= (rotational_offset-1)
			offset_y -= (rotational_offset-1)
		if(270)
			offset_x -= (rotational_offset-1)

/obj/marker/prefab/proc/prepare_prefab()
	return TRUE

/obj/marker/prefab/New(var/desired_loc)

	if(prob(chance_none))
		qdel(src)
		return

	if(!category) category = "none"

	. = ..()

	if(!qdeleting) SSdmm_suite.prefab_markers += src

/obj/marker/prefab/PreDestroy()
	SSdmm_suite.prefab_markers -= src
	. = ..()

//Basic Prefabs
/obj/marker/prefab/large
	icon = 'icons/obj/markers/prefab_64x64.dmi'
	category = "64x64"
	chance_none = 20
	rotational_offset = 64

/obj/marker/prefab/medium
	icon = 'icons/obj/markers/prefab_32x32.dmi'
	category = "32x32"
	chance_none = 40
	rotational_offset = 32

/obj/marker/prefab/small
	icon = 'icons/obj/markers/prefab_16x16.dmi'
	icon_state = "nodir"
	category = "16x16"
	chance_none = 70
	rotational_offset = 16

/obj/marker/prefab/ashwalker_village
	icon = 'icons/obj/markers/prefab_16x16.dmi'
	icon_state = null
	category = "ashwalker_village"
	chance_none = 10
	rotational_offset = 16

/obj/marker/prefab/shuttle
	icon = 'icons/obj/markers/prefab_16x16.dmi'
	icon_state = null
	category = "shuttle"
	chance_none = 0
	rotational_offset = 16


/obj/marker/prefab/shuttle_mini
	icon = 'icons/obj/markers/prefab_minishuttle.dmi'
	icon_state = null
	category = "shuttle_mini"
	chance_none = 0
	rotational_offset = 9

//Special Prefabs

/obj/marker/prefab/antag
	icon = 'icons/obj/markers/prefab_antag.dmi'
	category = "antag"
	rotational_offset = 32

/obj/marker/prefab/boss
	category = "boss"
	icon = 'icons/obj/markers/prefab_32x32.dmi'
	rotational_offset = 32

/obj/marker/prefab/boss/lavaland
	category = "boss_lavaland"

/obj/marker/prefab/boss/jungle
	category = "boss_jungle"

/obj/marker/prefab/boss/desert
	category = "boss_desert"

/obj/marker/prefab/boss/forest
	category = "boss_forest"

/obj/marker/prefab/forest
	icon = 'icons/obj/markers/prefab_32x32.dmi'
	category = "forest"
	chance_none = 25
	rotational_offset = 32

/obj/marker/prefab/forest/New(var/desired_loc)
	. = ..()
	dir = pick(DIRECTIONS_CARDINAL)

/obj/marker/prefab/base
	icon = 'icons/obj/markers/prefab_64x64.dmi'
	category = "base"
	chance_none = 0
	rotational_offset = 64


//City prefabs.
/obj/marker/prefab/house
	icon = 'icons/obj/markers/prefab_16x16.dmi'
	category = "house"
	chance_none = 0
	rotational_offset = 16

/obj/marker/prefab/alley
	icon = 'icons/obj/markers/prefab_5x5.dmi'
	icon_state = "alley"
	category = "city_alley_straight" //or "city_alley_corner"
	chance_none = 0
	unique = FALSE
	rotational_offset = 8

/obj/marker/prefab/alley/prepare_prefab()

	if(dir in DIRECTIONS_INTERCARDINAL) //Corner
		category = "city_alley_corner"
	else
		category = "city_alley_straight"

	. = ..()

/obj/marker/prefab/alley_end
	icon = 'icons/obj/markers/prefab_8x8.dmi'
	icon_state = "alley_end"
	category = "alley_end"
	chance_none = 0
	unique = FALSE
	rotational_offset = 8


/obj/marker/prefab/landing
	icon = 'icons/obj/markers/prefab_16x16.dmi'
	icon_state = "nodir"
	category = "landing"
	rotational_offset = 16
	unique = FALSE

/obj/marker/prefab/yard
	icon = 'icons/obj/markers/prefab_8x8.dmi'
	icon_state = "yard"
	category = "yard"
	chance_none = 10
	rotational_offset = 8

/obj/marker/prefab/city
	name = "city prefab"
	unique = FALSE
	chance_none = 0
	rotational_offset = 64

/obj/marker/prefab/city/store
	name = "city store prefab"
	icon = 'icons/obj/markers/prefab_16x16.dmi'
	category = "city"
	icon_state = null
	unique = TRUE
	chance_none = 0
	rotational_offset = 16
	color = COLOR_GOLD

/obj/marker/prefab/city/line
	icon = 'icons/obj/markers/prefab_64x64_city.dmi'
	icon_state = null
	category = "city_street_straight" //or "city_street_corner"
	unique = FALSE

/obj/marker/prefab/city/line/prepare_prefab()

	if(dir in DIRECTIONS_INTERCARDINAL) //Corner
		category = "city_street_corner"
		switch(dir)
			if(SOUTHWEST)
				dir = SOUTH
			if(NORTHWEST)
				dir = WEST
			if(NORTHEAST)
				dir = NORTH
			if(SOUTHEAST)
				dir = EAST
	else
		category = "city_street_straight"

	. = ..()


/obj/marker/prefab/city/intersection
	icon = 'icons/obj/markers/prefab_64x64_city_intersection.dmi'
	icon_state = "cross"
	category = "city_street_intersection"
	unique = TRUE

/obj/marker/prefab/city/intersection/New(var/desired_loc)
	. = ..()
	dir = pick(NORTH,EAST,SOUTH,WEST)



/obj/marker/prefab/city/sol_base
	icon = 'icons/obj/markers/prefab_64x64_city_intersection.dmi'
	icon_state = "t"
	category = "sol_base"
	unique = TRUE

/obj/marker/prefab/city/city_hall
	icon = 'icons/obj/markers/prefab_64x64_city_offset.dmi' //Shitty solution but it works.
	icon_state = null
	category = "city_special"
	unique = TRUE

/obj/marker/prefab/city/t_junction
	icon = 'icons/obj/markers/prefab_64x64_city_intersection.dmi'
	icon_state = "t"
	category = "city_street_t"
	unique = TRUE

/obj/marker/prefab/city/end
	icon = 'icons/obj/markers/prefab_64x64_city_end.dmi'
	icon_state = null
	category = "city_street_end"
	unique = FALSE

/obj/marker/prefab/city/farm
	icon = 'icons/obj/markers/prefab_64x64_farm.dmi'
	icon_state = null
	category = "farm"
	unique = FALSE

/obj/marker/prefab/city/parking
	icon = 'icons/obj/markers/prefab_10x10.dmi'
	icon_state = "parking"
	category = "city_parking_straight" //or "city_parking_corner"
	alpha = 150
	rotational_offset = 10
	unique = FALSE

/obj/marker/prefab/city/parking/prepare_prefab()

	if(dir in DIRECTIONS_INTERCARDINAL) //Corner
		category = "city_parking_corner"
		switch(dir)
			if(SOUTHWEST)
				dir = SOUTH
			if(NORTHWEST)
				dir = WEST
			if(NORTHEAST)
				dir = NORTH
			if(SOUTHEAST)
				dir = EAST
	else
		category = "city_parking_straight"

	. = ..()


/obj/marker/prefab/fob
	icon = 'icons/obj/markers/prefab_16x16.dmi'
	category = "fob"
	chance_none = 0
	rotational_offset = 16

/obj/marker/prefab/vault
	icon = 'icons/obj/markers/prefab_10x10.dmi'
	icon_state = null
	category = "vault"
	chance_none = 0
	rotational_offset = 10



/obj/marker/prefab/debug1
	icon = 'icons/obj/markers/prefab_10x10.dmi'
	icon_state = null
	category = "debug"
	chance_none = 0
	rotational_offset = 10
	unique = FALSE


/obj/marker/prefab/debug2
	icon = 'icons/obj/markers/prefab_10x10.dmi'
	icon_state = null
	category = "debug2"
	chance_none = 0
	rotational_offset = 10
	unique = FALSE