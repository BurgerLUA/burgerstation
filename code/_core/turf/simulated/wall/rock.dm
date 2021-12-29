/turf/simulated/wall/rock
	name = "rock wall"

	desc = "Rock hard"
	desc_extended = "A natural wall made of rock, might have something behind it, might not, occasionally has minerals."

	icon = 'icons/turf/wall/rock_preview.dmi'
	icon_state = "rock"


	real_icon = 'icons/turf/wall/rock.dmi'
	real_icon_state = "wall"

	corner_icons = TRUE
	corner_category = "rock"

	material_id = /material/rock

	health = /health/turf/
	health_base = 500

	destruction_turf = /turf/simulated/floor/cave_dirt

	organic = TRUE

	map_color = COLOR_GREY_DARK

/turf/simulated/wall/rock/on_destruction(var/mob/caller,var/damage = FALSE)
	CREATE(/obj/structure/scenery/rocks,src)
	return ..()

/turf/simulated/wall/rock/snow
	real_icon = 'icons/turf/wall/rock_snow.dmi'
	real_icon_state = "wall"

	desc = "Rock hard"
	desc_extended = "A natural wall made of rock, might have something behind it, might not, occasionally has minerals. This one has snow on it."

	icon_state = "snow"

	corner_icons = TRUE
	corner_category = "rock_snow"

	map_color = COLOR_GREY

/turf/simulated/wall/rock/basalt
	real_icon = 'icons/turf/wall/rock_basalt.dmi'
	real_icon_state = "wall"

	desc = "Rock hard"
	desc_extended = "A natural wall made of basalt, occasionally has minerals."

	icon_state = "basalt"

	corner_icons = TRUE
	corner_category = "rock_basalt"

	destruction_turf = /turf/simulated/floor/basalt

	map_color = COLOR_BLACK


/turf/simulated/wall/rock/brown
	real_icon = 'icons/turf/wall/rock_brown.dmi'
	real_icon_state = "wall"

	desc = "Rock hard"
	desc_extended = "A natural wall made of rock, might have something behind it, might not, occasionally has minerals. This one is brown."

	icon_state = "brown"

	corner_icons = TRUE
	corner_category = "rock_brown"

	map_color = COLOR_BROWN_DARK

/turf/simulated/wall/rock/moss
	real_icon = 'icons/turf/wall/rock_moss.dmi'
	real_icon_state = "wall"

	desc = "Rock hard"
	desc_extended = "A natural wall made of rock, might have something behind it, might not, occasionally has minerals. this one has moss on it."

	icon_state = "moss"

	corner_icons = TRUE
	corner_category = "rock_moss"

	map_color = COLOR_BROWN_DARK

/turf/simulated/wall/rock/desert
	real_icon = 'icons/turf/wall/rock_desert.dmi'
	real_icon_state = "wall"

	desc = "Rock hard"
	desc_extended = "A natural wall made of rock, might have something behind it, might not, occasionally has minerals. This one is sandy."

	icon_state = "desert"

	corner_icons = TRUE
	corner_category = "rock_desert"



	map_color = COLOR_BROWN_DARK

/turf/simulated/wall/rock/ice
	real_icon = 'icons/turf/wall/rock_ice.dmi'
	real_icon_state = "ice"

	desc = "Rock hard"
	desc_extended = "A natural wall made of rock, might have something behind it, might not, occasionally has minerals. This one is icey."

	icon_state = "ice"

	corner_icons = TRUE
	corner_category = "rock_ice"

	destruction_turf = /turf/simulated/floor/ice

	map_color = "#004A7F"

/turf/simulated/wall/rock/indestructable
	name = "bedrock wall"

	desc = "End of the line Bucko"
	desc_extended = "An impassable barrier of stone, go around or turn around."

	real_icon = 'icons/turf/wall/rock_bedrock.dmi'
	real_icon_state = "wall"

	icon_state = "bedrock"

	corner_icons = TRUE
	corner_category = "rock_bedrock"

	material_id = null
	health = null
	health_base = null
	destruction_turf = null

	organic = FALSE

	map_color = "#000000"

/turf/simulated/wall/rock/indestructable/can_be_attacked(var/atom/attacker,var/atom/weapon,var/params,var/damagetype/damage_type)
	return FALSE