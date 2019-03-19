obj/structure/interactive/nature/jungle_grass
	name = "jungle grass"
	icon = 'icons/obj/structure/flora/jungleflora.dmi'
	icon_state = "grassa1"
	density = 0

obj/structure/interactive/nature/jungle_grass/New()
	..()
	switch(rand(1,2))
		if(1)
			icon_state = "grassa[rand(1,5)]"
		if(2)
			icon_state = "grassb[rand(1,5)]"

obj/structure/interactive/nature/jungle_rock
	name = "jungle grass"
	icon = 'icons/obj/structure/flora/jungleflora.dmi'
	icon_state = "rock1"
	density = 0

obj/structure/interactive/nature/jungle_rock/New()
	..()
	icon_state = "rock[rand(1,5)]"


obj/structure/interactive/nature/jungle_trees
	name = "jungle tree"
	icon = 'icons/obj/structure/flora/jungletrees.dmi'
	icon_state = "tree1"
	density = 1
	pixel_x = -48
	pixel_y = -16
	layer = LAYER_LARGE_OBJ

obj/structure/interactive/nature/jungle_trees/New()
	..()
	icon_state = "tree[rand(1,6)]"


obj/structure/interactive/nature/jungle_trees_small
	name = "small jungle tree"
	icon = 'icons/obj/structure/flora/jungletreesmall.dmi'
	icon_state = "tree1"
	density = 1
	pixel_x = -32
	pixel_y = 0
	layer = LAYER_LARGE_OBJ

obj/structure/interactive/nature/jungle_trees/New()
	..()
	icon_state = "tree[rand(1,6)]"