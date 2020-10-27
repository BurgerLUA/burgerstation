/obj/structure/interactive/lighting/gumdrop
	name = "gumdrop"
	icon = 'icons/obj/structure/flora/gumdrops.dmi'
	icon_state = "gumdrop"
	layer = LAYER_FLOOR_SCENERY

	alpha = 200

	desired_light_power = 0.5
	desired_light_range = 4
	desired_light_color = "#FFFFFF"

/obj/structure/interactive/lighting/gumdrop/New()

	switch(rand(1,3))
		if(1)
			color = rgb(255,pick(0,255),pick(0,255))
		if(2)
			color = rgb(pick(0,255),255,pick(0,255))
		if(3)
			color = rgb(pick(0,255),pick(0,255),255)

	desired_light_color = color

	return ..()