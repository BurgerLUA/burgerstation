/reagent_recipe/explosion_water_potassium

	name = "water potassium explosion"
	id = "explosion_water_potassium"

	required_reagents = list(
		"water" = 1,
		"potassium" = 1
	)

	results = list()


/reagent_recipe/explosion_water_potassium/on_react(var/mob/caller,var/reagent_container/container,var/magnitude)

	var/turf/explosion_location = get_turf(container.owner)

	var/explosion_power = magnitude*0.025

	explode(explosion_location,explosion_power,caller,container.owner)

	return TRUE