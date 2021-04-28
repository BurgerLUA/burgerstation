/reagent/drug/ //Found in the snow biome as a magic plant
	name = "drug"
	desc = "What the fuck is this?"
	color = "#FFFFFF"
	alpha = 255
	metabolism_stomach = 1
	metabolism_blood = 2

	var/strength = 50
	var/duration_mod = 10

	liquid = -0.4

	var/status_effect = DRUGGY

/reagent/drug/on_metabolize_stomach(var/mob/living/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)

	. = ..()

	owner.add_status_effect(
		status_effect,
		magnitude = strength,
		duration = . * duration_mod //Every 20 units should last 5 minutes.
	)

/reagent/drug/on_metabolize_blood(var/mob/living/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)

	. = ..()

	owner.add_status_effect(
		status_effect,
		magnitude = strength*2,
		duration = . * duration_mod //Every 20 units should last 5 minutes.
	)

/reagent/drug/liberty_dust
	name = "space liberty dust"
	desc = "The taste of liberty AND FREEDOM."
	color = "#FFFFFF"
	alpha = 255

	flavor = "freedom"

	strength = 75
	duration_mod = 10

	value = 7.5

	liquid = -0.6

	particle_size = 0.4

/reagent/drug/space
	name = "space drugs"
	desc = "It's like space weed."
	color = "#FFFFFF"
	alpha = 255

	flavor = "dude weed bro"

	strength = 25
	duration_mod = 15

	value = 4.5

	particle_size = 0.6


/reagent/drug/dust
	name = "space dust"
	desc = "It's like space weed but better."
	color = "#7A9BFF"
	alpha = 255

	flavor = "regret"

	strength = 200
	duration_mod = 15

	value = 12

	liquid = -0.6

	particle_size = 0.4


/reagent/drug/lithium
	name = "lithium"
	desc = "Batteries!"
	color = "#B6D8D8"
	alpha = 255

	flavor = "batteries"

	strength = 100
	duration_mod = 10

	value = 4

	liquid = -0.8

	particle_size = 0.7

	status_effect = CONFUSED