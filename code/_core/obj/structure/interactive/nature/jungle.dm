obj/structure/scenery/jungle_grass
	name = "jungle grass"
	icon = 'icons/obj/structure/flora/jungleflora.dmi'
	icon_state = "grassa1"
	layer = LAYER_FLOOR_SCENERY

obj/structure/scenery/jungle_grass/New()
	..()
	switch(rand(1,2))
		if(1)
			icon_state = "grassa[rand(1,5)]"
		if(2)
			icon_state = "grassb[rand(1,5)]"

obj/structure/scenery/jungle_rock
	name = "jungle grass"
	icon = 'icons/obj/structure/flora/jungleflora.dmi'
	icon_state = "rock1"
	layer = LAYER_FLOOR_SCENERY
	plane = PLANE_FLOOR

obj/structure/scenery/jungle_rock/New()
	..()
	icon_state = "rock[rand(1,5)]"

/*
obj/structure/scenery/jungle_trees
	name = "jungle tree"
	icon = 'icons/obj/structure/flora/jungletrees.dmi'
	icon_state = "tree1"
	collision_flags = FLAG_COLLISION_WALKING
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC
	pixel_x = -48
	pixel_y = -16
	layer = LAYER_LARGE_OBJ

	plane = PLANE_SCENERY

obj/structure/scenery/jungle_trees/New()
	..()
	icon_state = "tree[rand(1,6)]"


obj/structure/scenery/jungle_trees_small
	name = "small jungle tree"
	icon = 'icons/obj/structure/flora/jungletreesmall.dmi'
	icon_state = "tree1"
	collision_flags = FLAG_COLLISION_WALKING
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC
	pixel_x = -32
	pixel_y = 0
	layer = LAYER_LARGE_OBJ

	plane = PLANE_SCENERY

obj/structure/scenery/jungle_trees/New()
	..()
	icon_state = "tree[rand(1,6)]"
*/