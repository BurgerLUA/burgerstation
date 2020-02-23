obj/structure/smooth/table
	name = "table"
	desc = "What does it do?"
	icon = 'icons/obj/structure/smooth/table/normal.dmi'
	icon_state = "table"

	corner_category = "table"
	corner_icons = TRUE

	layer = LAYER_TABLE

	collision_flags = FLAG_COLLISION_WALKING
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC

obj/structure/smooth/rack
	name = "table"
	desc = "What does it do?"
	icon = 'icons/obj/structure/rack.dmi'
	icon_state = "rack"

	corner_category = "rack"
	corner_icons = FALSE

	collision_flags = FLAG_COLLISION_WALKING
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC

obj/structure/smooth/rack/grey
	color = COLOR_GREY

obj/structure/smooth/rack/steel
	color = COLOR_STEEL

obj/structure/smooth/table/dark
	color = "#999999"

obj/structure/smooth/table/wood
	name = "wood table"
	color = "#A05120"

	corner_category = "table_wood"

obj/structure/smooth/table/wood/poor
	name = "wood table"
	color = "#6B4E3A"


obj/structure/smooth/table/reinforced
	name = "reinforced table"
	desc = "Extra sturdy."
	icon = 'icons/obj/structure/smooth/table/reinforced.dmi'
	icon_state = "table"

	corner_category = "table_reinforced"


obj/structure/smooth/table/reinforced/dark
	color = "#999999"

obj/structure/smooth/table/reinforced/yellow
	color = "#FFFF00"



obj/structure/smooth/table/brass
	name = "clockwork table"
	desc = "Extra sturdy."
	icon = 'icons/obj/structure/clockwork/table.dmi'
	icon_state = "table"

	corner_category = "table_clockwork"

	desired_light_power = 0.5
	desired_light_range = 2
	desired_light_color = "#E29E00"

obj/structure/smooth/table/cult

	name = "cult table"
	color = "#261E1C"



	corner_category = "table_cult"
