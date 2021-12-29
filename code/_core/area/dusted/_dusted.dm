/area/dusted
	trackable = TRUE
	area_identifier = "Virtual Reality"
	flags_area = FLAGS_AREA_NO_TELEPORT | FLAGS_AREA_NO_CONSTRUCTION

	sunlight_freq = 4
	sunlight_color = "#C1AA7C"

/area/dusted/exterior
	name = "Dusted Exterior"
	icon_state = "purple"

/area/dusted/out_of_bounds
	name = "OUT OF BOUNDS"
	icon_state = "red"

/area/dusted/out_of_bounds/is_space()
	return TRUE

/area/dusted/interior
	name = "Dusted Interior"
	sunlight_freq = 0
	sunlight_color = "FFFFFF"
	icon_state = "blue"


/area/dusted/interior/grey
	name = "Grey Building"
	sunlight_freq = 0
	sunlight_color = "FFFFFF"
	icon_state = "green"

/area/dusted/exterior/fountain
	name = "Fountain"
	icon_state = "river"

/area/dusted/exterior/market
	name = "Market"
	icon_state = "shop"

/area/dusted/exterior/bar_zone
	name = "Outside Bar"
	icon_state = "bar"

/area/dusted/exterior/center_long_alley
	name = "Center Long Alley"
	icon_state = "hall_c"

/area/dusted/exterior/grass_alley
	name = "Grass Alley"
	icon_state = "hall_e"

/area/dusted/exterior/cargo_dump
	name = "Cargo Dump"
	icon_state = "cargo"