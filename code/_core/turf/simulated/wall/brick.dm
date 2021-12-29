/turf/simulated/wall/brick
	name = "wall"

	desc = "Like a brick to the head"
	desc_extended = "A wall made of bricks."

	icon = 'icons/turf/wall/rock_preview.dmi'
	icon_state = "brick"

	real_icon = 'icons/turf/wall/brick.dmi'
	real_icon_state = "wall"

	corner_icons = TRUE
	corner_category = "brick"

	destruction_turf = /turf/simulated/floor/plating

/turf/simulated/wall/brick/New(var/desired_loc)
	. = ..()
	map_color = color

/turf/simulated/wall/brick/red
	color = "#C66B59"
	desc = "Like a brick to the head"
	desc_extended = "A wall made of bricks. This one is made of red bricks."

/turf/simulated/wall/brick/red/rev //for the rev compound
	color = "#C66B59"
	desc = "Like a brick to the head"
	desc_extended = "A wall made of bricks. This one is made of red bricks."
	health = 5000

/turf/simulated/wall/brick/red/dark
	color = "#824439"
	desc = "Like a brick to the head"
	desc_extended = "A wall made of bricks. This one is made of dark red bricks."

/turf/simulated/wall/brick/red/dark/rev //for the rev compound, has infinite HP
	color = "#824439"
	desc = "Like a brick to the head"
	desc_extended = "A wall made of bricks. This one is made of dark red bricks."
	health = 6000

/turf/simulated/wall/brick/sand
	name = "sandstone wall"
	color = "#FFC68C"
	desc = "It gets everywhere"
	desc_extended = "A wall made of sandstone bricks."

/turf/simulated/wall/brick/sand/ish
	color = "#9E866E"
	desc = "Like a brick to the head"
	desc_extended = "A wall made of bricks. This one is a bit sandy"

/turf/simulated/wall/brick/marble
	name = "marble wall"
	color = "#E1DFD2"
	desc = "Ohh, fancy"
	desc_extended = "A wall made of marble bricks."

/turf/simulated/wall/brick/chapel
	name = "chapel wall"
	color = COLOR_GREY_DARK
	desc = "In the name of Burger"
	desc_extended = "A wall made of bricks. This one is part of a chapel."

/turf/simulated/wall/brick/banana
	name = "banana brick wall"
	color = "#FFFF00"
	desc = "HOOOOONK"
	desc_extended = "A wall made of banana bricks."

/turf/simulated/wall/brick/uranium
	name = "uranium brick wall"
	color = COLOR_URANIUM
	//material = /material/uranium
	desc = "Radioactive"
	desc_extended = "A wall made of uranium bricks."


/turf/simulated/wall/brick/grey
	color = "#647064"
	desc = "Like a brick to the head"
	desc_extended = "A wall made of bricks. These are grey."

/turf/simulated/wall/brick/grey/dark
	color = COLOR_GREY_DARK
	desc = "Like a brick to the head"
	desc_extended = "A wall made of bricks."


