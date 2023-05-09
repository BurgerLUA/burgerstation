/obj/structure/scenery
	mouse_opacity = 0
	plane = PLANE_JUNK

obj/structure/scenery/bush/
	plane = PLANE_GRASS
	layer = LAYER_FLOOR_SCENERY

obj/structure/scenery/bush/Finalize()
	. = ..()
	if(is_simulated(src.loc))
		var/turf/simulated/T = src.loc
		T.map_color = blend_colors((T.map_color ? T.map_color : "#FFFFFF"),"#597F0C",0.25)

obj/structure/scenery/bush/grass
	name = "grassy bush"
	icon = 'icons/obj/structure/flora/ausflora.dmi'
	icon_state = "grassybush_1"

obj/structure/scenery/bush/grass/New()
	..()
	icon_state = "grassybush_[rand(1,4)]"

obj/structure/scenery/flowers
	name = "flowers"
	icon = 'icons/obj/structure/flora/ausflora.dmi'
	icon_state = "ywflowers_1"
	plane = PLANE_GRASS
	layer = LAYER_FLOOR_SCENERY

obj/structure/scenery/flowers/New()
	..()
	switch(rand(1,3))
		if(1)
			icon_state = "ywflowers_[rand(1,4)]"
		if(2)
			icon_state = "brflowers_[rand(1,3)]"
		if(3)
			icon_state = "ppflowers_[rand(1,3)]"

obj/structure/scenery/flowers/Finalize()
	. = ..()
	if(is_simulated(src.loc))
		var/turf/simulated/T = src.loc
		T.map_color = blend_colors((T.map_color ? T.map_color : "#FFFFFF"),"#597F0C",0.1)

obj/structure/scenery/grass
	name = "grass type"
	plane = PLANE_GRASS
	layer = LAYER_FLOOR_SCENERY


obj/structure/scenery/grass/Finalize()
	. = ..()
	if(is_simulated(src.loc))
		var/turf/simulated/T = src.loc
		T.map_color = blend_colors((T.map_color ? T.map_color : "#FFFFFF"),"#597F0C",0.1)


/obj/structure/scenery/grass/normal/
	name = "uncut grass"
	icon = 'icons/obj/structure/flora/ausflora.dmi'
	icon_state = "sparsegrass_1"
	layer = LAYER_FLOOR_SCENERY

obj/structure/scenery/grass/normal/New()
	..()
	switch(rand(1,2))
		if(1)
			icon_state = "sparsegrass_[rand(1,3)]"
		if(2)
			icon_state = "fullgrass_[rand(1,3)]"


obj/structure/scenery/grass/lavender
	name = "lavender grass"
	icon = 'icons/obj/structure/flora/ausflora.dmi'
	icon_state = "lavendergrass_1"
	layer = LAYER_FLOOR_SCENERY

obj/structure/scenery/grass/lavender/New()
	..()
	icon_state = "lavendergrass_[rand(1,4)]"


obj/structure/scenery/rocks
	name = "rocks"
	icon = 'icons/obj/structure/flora/rocks_new.dmi'
	icon_state = "rock_1"
	plane = PLANE_GRASS
	layer = LAYER_FLOOR_SCENERY

obj/structure/scenery/rocks/New()
	..()
	icon_state = "rock_[rand(1,10)]"

/obj/structure/interactive/basalt
	name = "basalt rocks"
	icon = 'icons/obj/structure/flora/lavaland.dmi'
	icon_state = "basalt_1"

	collision_flags = FLAG_COLLISION_BARICADE
	collision_bullet_flags = FLAG_COLLISION_BULLET_ORGANIC

	pixel_x = 8

	plane = PLANE_WIRE
	layer = LAYER_FLOOR_SCENERY

obj/structure/interactive/basalt/New()
	..()
	icon_state = "basalt_[rand(1,4)]"


obj/structure/scenery/lolipop_tree
	name = "giant lolipop"
	icon = 'icons/obj/structure/flora/lolipop_tree.dmi'
	icon_state = "stick"

	collision_flags = FLAG_COLLISION_WALKING
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC

	pixel_x = 0
	pixel_y = 0
	layer = LAYER_LARGE_OBJ

	mouse_opacity = 0

	var/top_color = "#FFFFFF"

/obj/structure/scenery/lolipop_tree/New()

	switch(rand(1,3))
		if(1)
			top_color = rgb(255,pick(0,255),pick(0,255))
		if(2)
			top_color = rgb(pick(0,255),255,pick(0,255))
		if(3)
			top_color = rgb(pick(0,255),pick(0,255),255)

	. = ..()

/obj/structure/scenery/lolipop_tree/Finalize()
	. = ..()
	update_sprite()


obj/structure/scenery/lolipop_tree/update_overlays()

	. = ..()

	var/image/I2 = new/image(initial(icon),"top")
	I2.color = top_color
	add_overlay(I2)


obj/structure/scenery/peppermint
	name = "red peppermint"
	icon = 'icons/obj/structure/flora/peppermint.dmi'
	icon_state = "peppermint_red"
	layer = LAYER_FLOOR_SCENERY


obj/structure/scenery/peppermint/green
	name = "green peppermint"
	icon_state = "peppermint_green"

