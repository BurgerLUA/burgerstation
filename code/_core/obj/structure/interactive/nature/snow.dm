obj/structure/scenery/grass/snow
	name = "grass"
	icon = 'icons/obj/structure/flora/snowflora.dmi'
	icon_state = "snowgrass1"


obj/structure/scenery/grass/snow/New()
	..()
	icon_state = "snowgrass[rand(1,3)]"


obj/structure/scenery/bush/snow
	name = "berry bush"
	icon = 'icons/obj/structure/flora/snowflora.dmi'
	icon_state = "snowbush1"
	layer = LAYER_LARGE_OBJ


obj/structure/scenery/bush/snow/New()
	..()
	icon_state = "snowbush[rand(1,3)][prob(20) ? "_empty" : ""]"



/obj/structure/interactive/tree/
	layer = LAYER_LARGE_OBJ
	plane = PLANE_SCENERY
	collision_flags = FLAG_COLLISION_WALL
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC
	health = /health/construction/
	material_id = /material/wood
	health_base = 250
	mouse_opacity = 1
	density = TRUE

/obj/structure/interactive/tree/Finalize()
	. = ..()
	if(is_simulated(src.loc))
		var/turf/simulated/T = src.loc
		T.map_color = blend_colors((T.map_color ? T.map_color : "#FFFFFF"),"#597F0C",0.5)

/obj/structure/interactive/tree/New()
	. = ..()
	pixel_x += rand(-3,3)
	pixel_y += rand(-1,2)
	layer = (world.maxy - y)*10 + (world.maxx - x)*0.1

/obj/structure/interactive/tree/pine
	name = "pine tree"
	icon = 'icons/obj/structure/flora/pinetrees.dmi'
	icon_state = "pine_2"
	pixel_x = -16

/obj/structure/interactive/tree/pine/on_destruction(var/damage = TRUE)
	. = ..()
	QDEL_NULL(health)
	icon_state = "pine_stump"
	collision_flags = FLAG_COLLISION_CRAWLING
	collision_bullet_flags = FLAG_COLLISION_BULLET_SPECIFIC

/obj/structure/interactive/tree/pine/New(var/desired_loc)
	icon_state = "pine_[rand(1,3)]"
	return ..()

/obj/structure/interactive/tree/evergreen
	name = "evergreen tree"
	icon = 'icons/obj/structure/flora/evergreen.dmi'
	icon_state = "evergreen_2"
	pixel_x = -16
	color = "#d4d2ab"


/obj/structure/interactive/tree/evergreen/on_destruction(var/damage = TRUE)
	. = ..()
	QDEL_NULL(health)
	icon_state = "evergreen_stump"
	collision_flags = FLAG_COLLISION_NONE
	collision_bullet_flags = FLAG_COLLISION_BULLET_SPECIFIC

/obj/structure/interactive/tree/evergreen/New(var/desired_loc)
	icon_state = "evergreen_[rand(1,3)]"
	return ..()

/obj/structure/interactive/tree/jungle_small
	name = "small jungle tree"
	icon = 'icons/obj/structure/flora/jungletreesmall.dmi'
	icon_state = "tree"
	pixel_x = -32
	pixel_y = 0

/obj/structure/interactive/tree/jungle_small/on_destruction(var/damage = TRUE)
	. = ..()
	QDEL_NULL(health)
	icon_state = "stump"
	collision_flags = FLAG_COLLISION_CRAWLING
	collision_bullet_flags = FLAG_COLLISION_BULLET_SPECIFIC

/obj/structure/interactive/tree/jungle_small/New(var/desired_loc)
	icon_state = "tree[rand(1,6)]"
	return ..()

/obj/structure/interactive/tree/jungle_large
	name = "large jungle tree"
	icon = 'icons/obj/structure/flora/jungletrees.dmi'
	icon_state = "tree1"
	pixel_x = -48
	pixel_y = -16

/obj/structure/interactive/tree/jungle_large/on_destruction(var/damage = TRUE)
	. = ..()
	QDEL_NULL(health) //Important
	icon_state = "stump"
	collision_flags = FLAG_COLLISION_CRAWLING
	collision_bullet_flags = FLAG_COLLISION_BULLET_SPECIFIC

/obj/structure/interactive/tree/jungle_large/New(var/desired_loc)
	icon_state = "tree[rand(1,6)]"
	return ..()



/obj/structure/interactive/tree/palm
	name = "palm tree"
	icon = 'icons/obj/structure/flora/palm.dmi'
	icon_state = "palm1"

/obj/structure/interactive/tree/palm/New(var/desired_loc)
	icon_state = "palm[rand(1,2)]"
	return ..()
