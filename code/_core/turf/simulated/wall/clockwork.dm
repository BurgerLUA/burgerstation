/turf/simulated/wall/clockwork
	name = "clockwork wall"
	icon = 'icons/turf/wall/clockwork.dmi'
	icon_state = "wall"
	corner_category = "clockwork"
	corner_icons = TRUE

	destruction_turf = /turf/simulated/floor/plating

	health_base = 500

/turf/simulated/wall/clockwork/indestructable
	name = "indestructable clockwork wall"
	destruction_turf = null
	health = null
	color = "#C0C0C0"

/turf/simulated/wall/clockwork/tough
	name = "heated clockwork wall"
	color = "#FFC9C9"

	destruction_turf = /turf/simulated/floor/plating

	health_base = 2000