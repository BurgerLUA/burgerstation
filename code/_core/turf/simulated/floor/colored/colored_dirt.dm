/turf/simulated/floor/colored/dirt
	name = "dirt"
	color = "#5B4128"
	layer = LAYER_FLOOR_DIRT
	corner_category = "dirt_soft"

	real_icon = 'icons/turf/floor/ash.dmi'
	real_icon_state = "floor"

	footstep = /footstep/asteroid

	destruction_turf = /turf/simulated/floor/colored/dirt/soil

	delay_modifier = 1.05

	material_id = /material/dirt/

/turf/simulated/floor/colored/dirt/cave
	name = "dirt"
	color = "#493C2F"
	corner_category = "dirt_cave"


	destruction_turf = /turf/simulated/floor/cave_dirt/

/turf/simulated/floor/colored/dirt/snow
	name = "frosty dirt"
	color = "#C6B4A9"

/turf/simulated/floor/colored/dirt/jungle
	name = "jungle dirt"
	color = "#4C403A"

/turf/simulated/floor/colored/dirt/soil
	name = "soil"
	color = "#3D2414"
	desired_light_color = "#3D2414"
	corner_category = "soil"

	destruction_turf = /turf/simulated/floor/colored/dirt/cave

/turf/simulated/floor/colored/dirt/cake
	name = "cake"
	color = "#F779E6"
	corner_category = "cake"