/turf/simulated/floor/diona
	name = "biomass floor"
	icon = 'icons/turf/floor/diona.dmi'
	icon_state = "1"

	destruction_turf = /turf/simulated/floor/colored/dirt

/turf/simulated/floor/diona/New()
	icon_state = "[rand(1,4)]"
	..()
