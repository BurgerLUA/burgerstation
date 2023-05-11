/turf/simulated/wall/clockwork
	name = "clockwork wall"
	desc = "Tick Tock motherfucker"
	desc_extended = "A wall made of brass, a faint ticking can be heard inside."
	icon = 'icons/turf/wall/clockwork.dmi'
	icon_state = "wall"
	corner_category = "clockwork"
	corner_icons = TRUE

	destruction_turf = /turf/simulated/floor/plating

	health_base = 1500

	map_color = "#704326"

/turf/simulated/wall/clockwork/indestructable
	name = "indestructable clockwork wall"
	desc = "Tick Tock motherfucker"
	desc_extended = "A wall made of brass, a faint ticking can be heard inside. This one is empowered by the energies of Ratvar and is therefore indestructible"
	destruction_turf = null
	color = "#C0C0C0"

/turf/simulated/wall/clockwork/tough
	name = "heated clockwork wall"
	desc = "That's hot"
	desc_extended = "A wall made of brass, a faint ticking can be heard inside. This one seems to be heated and is more durable."
	color = "#FFC9C9"


	destruction_turf = /turf/simulated/floor/plating

	health_base = 2000