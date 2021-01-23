/obj/structure/scenery
	mouse_opacity = 0

obj/structure/scenery/grass_bush
	name = "grassy bush"
	icon = 'icons/obj/structure/flora/ausflora.dmi'
	icon_state = "grassybush_1"

obj/structure/scenery/grass_bush/New()
	..()
	icon_state = "grassybush_[rand(1,4)]"

obj/structure/scenery/flowers
	name = "flowers"
	icon = 'icons/obj/structure/flora/ausflora.dmi'
	icon_state = "ywflowers_1"
	layer = LAYER_FLOOR_SCENERY

obj/structure/scenery/flowers/New()
	..()
	switch(rand(1,4))
		if(1)
			icon_state = "ywflowers_[rand(1,4)]"
		if(2)
			icon_state = "brflowers_[rand(1,4)]"
		if(3)
			icon_state = "brflowers_[rand(1,3)]"

obj/structure/scenery/grass
	name = "uncut grass"
	icon = 'icons/obj/structure/flora/ausflora.dmi'
	icon_state = "sparsegrass_1"
	layer = LAYER_FLOOR_SCENERY

obj/structure/scenery/grass/New()
	..()
	switch(rand(1,2))
		if(1)
			icon_state = "sparsegrass_[rand(1,3)]"
		if(2)
			icon_state = "fullgrass_[rand(1,3)]"

obj/structure/scenery/rocks
	name = "rocks"
	icon = 'icons/obj/structure/flora/rocks_new.dmi'
	icon_state = "rock_1"
	layer = LAYER_FLOOR_SCENERY

obj/structure/scenery/rocks/New()
	..()
	icon_state = "rock_[rand(1,10)]"

/*
obj/structure/scenery/evergreen
	name = "evergreen tree"
	icon = 'icons/obj/structure/flora/evergreen.dmi'
	icon_state = "evergreen_1"

	collision_flags = FLAG_COLLISION_WALKING
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC

	pixel_x = -16
	pixel_y = 0
	layer = LAYER_LARGE_OBJ

	mouse_opacity = 0

	plane = PLANE_SCENERY

obj/structure/scenery/evergreen/New()
	..()
	icon_state = "evergreen_[rand(1,3)]"
*/



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

obj/structure/scenery/lolipop_tree/New()

	switch(rand(1,3))
		if(1)
			top_color = rgb(255,pick(0,255),pick(0,255))
		if(2)
			top_color = rgb(pick(0,255),255,pick(0,255))
		if(3)
			top_color = rgb(pick(0,255),pick(0,255),255)

	update_sprite()

	return ..()


obj/structure/scenery/lolipop_tree/update_icon()

	icon = initial(icon)
	icon_state = initial(icon_state)

	var/icon/I = new/icon(icon,icon_state)
	var/icon/I2 = new/icon(icon,"top")

	I2.Blend(top_color,ICON_MULTIPLY)
	I.Blend(I2,ICON_OVERLAY)

	icon = I

	return ..()

obj/structure/scenery/peppermint
	name = "red peppermint"
	icon = 'icons/obj/structure/flora/peppermint.dmi'
	icon_state = "peppermint_red"
	layer = LAYER_FLOOR_SCENERY


obj/structure/scenery/peppermint/green
	name = "green peppermint"
	icon_state = "peppermint_green"

