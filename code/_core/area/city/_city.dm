var/global/list/vr_possible_nuke_areas = list()

/area/city
	trackable = TRUE
	area_identifier = "Virtual Reality"

/area/city/exterior/
	sunlight_freq = 4
	sunlight_color = "#2C4D59"

/area/city/exterior/streets
	name = "City Streets"
	icon_state = "grass"

/area/city/interior
	sunlight_freq = 0
	sunlight_color = "FFFFFF"

/area/city/interior/New(var/desired_loc)
	. = ..()
	vr_possible_nuke_areas |= src

/area/city/interior/codebus
	name = "coderbus"
	icon_state = "pink"

/area/city/interior/greytide
	name = "greytide"
	icon_state = "blue"

/area/city/interior/traitor_joes
	name = "traitor joes"
	icon_state = "red"

/area/city/interior/die_lab
	name = "die lab"
	icon_state = "purple"

/area/city/interior/warehouse
	name = "warehouse"
	icon_state = "yellow"

/area/city/interior/combo_cafe
	name = "combo cafe"
	icon_state = "green"

/area/city/interior/light
	name = "lightbulb"
	icon_state = "white"

/area/city/interior/mall/
	name = "central mall"
	icon_state = "hallway"

/area/city/interior/hive
	name = "hive"
	icon_state = "purple"

/area/city/interior/scotch
	name = "Scotch Servin' Willy's"
	icon_state = "orange"

/area/city/interior/mall/bathroom
	name = "central mall bathroom"
	icon_state = "bathroom"

/area/city/interior/discount
	name = "Discount Dan's"
	icon_state = "orange"

/area/city/interior/space
	name = "Outer Spess"
	icon_state = "space"

/area/city/interior/harmbaton
	name = "Harmbaton"
	icon_state = "security"

/area/city/interior/chem_lab
	name = "Chem Lab"
	icon_state = "chemistry"

/area/city/interior/the_net
	name = "The Net"
	icon_state = "green"

/area/city/interior/honk
	name = "HONKed'n LOADED"
	icon_state = "yellow"