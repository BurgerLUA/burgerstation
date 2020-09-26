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

/reagent/drug/on_metabolize_stomach(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)

	. = ..()

	if(is_living(owner))
		var/mob/living/L = owner
		L.add_status_effect(
			DRUGGY,
			magnitude = strength,
			duration = . * duration_mod //Every 20 units should last 5 minutes.
		)

	return .

/reagent/drug/on_metabolize_blood(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)

	. = ..()

	if(is_living(owner))
		var/mob/living/L = owner
		L.add_status_effect(
			DRUGGY,
			magnitude = strength*2,
			duration = . * duration_mod //Every 20 units should last 5 minutes.
		)

	return .

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

/reagent/drug/space
	name = "space drugs"
	desc = "It's like space weed."
	color = "#FFFFFF"
	alpha = 255

	flavor = "dude weed bro"

	strength = 25
	duration_mod = 15

	value = 4.5


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