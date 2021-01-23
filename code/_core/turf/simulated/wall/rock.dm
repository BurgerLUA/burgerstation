/turf/simulated/wall/rock
	name = "rock wall"

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

/turf/simulated/wall/rock/on_destruction(var/mob/caller,var/damage = FALSE)
	CREATE(/obj/structure/scenery/rocks,src)
	return ..()

/turf/simulated/wall/rock/snow
	real_icon = 'icons/turf/wall/rock_snow.dmi'
	real_icon_state = "wall"

	icon_state = "snow"

	corner_icons = TRUE
	corner_category = "rock_snow"

/turf/simulated/wall/rock/basalt
	real_icon = 'icons/turf/wall/rock_basalt.dmi'
	real_icon_state = "wall"

	icon_state = "basalt"

	corner_icons = TRUE
	corner_category = "rock_basalt"

	destruction_turf = /turf/simulated/floor/basalt


/turf/simulated/wall/rock/brown
	real_icon = 'icons/turf/wall/rock_brown.dmi'
	real_icon_state = "wall"

	icon_state = "brown"

	corner_icons = TRUE
	corner_category = "rock_brown"

/turf/simulated/wall/rock/moss
	real_icon = 'icons/turf/wall/rock_moss.dmi'
	real_icon_state = "wall"

	icon_state = "moss"

	corner_icons = TRUE
	corner_category = "rock_moss"

/turf/simulated/wall/rock/desert
	real_icon = 'icons/turf/wall/rock_desert.dmi'
	real_icon_state = "wall"

	icon_state = "desert"

	corner_icons = TRUE
	corner_category = "rock_desert"

/turf/simulated/wall/rock/indestructable
	name = "bedrock wall"

	real_icon = 'icons/turf/wall/rock_bedrock.dmi'
	real_icon_state = "wall"

	icon_state = "bedrock"

	corner_icons = TRUE
	corner_category = "rock_bedrock"

	material_id = null
	health = null
	health_base = null
	destruction_turf = null

/turf/simulated/wall/rock/indestructable/can_be_attacked(var/atom/attacker,var/atom/weapon,var/params,var/damagetype/damage_type)
	return FALSE