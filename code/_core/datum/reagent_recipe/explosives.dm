/reagent_recipe/explosion/
	category = "Explosives"
	results = list()

/reagent_recipe/explosion/holy_water_potassium
	name = "Holy Water-Potassium Explosion"
	category = "Explosions"
	required_reagents = list(
		/reagent/nutrition/water/holy = 1,
		/reagent/potassium = 1
	)

	results = list()

	secret = TRUE

/reagent_recipe/explosion/holy_water_potassium/on_react(var/mob/caller,var/reagent_container/container,var/magnitude)

	var/turf/explosion_location = get_turf(container.owner)

	if(is_item(container.owner))
		var/obj/item/I = container.owner
		I.drop_item(explosion_location)

	var/explosion_power = round( ((magnitude*2 ** 0.3) * 0.5) + magnitude*2*0.0125, 0.01)

	var/tag_to_use
	if(is_living(caller))
		var/mob/living/L = caller
		tag_to_use = L.loyalty_tag

	explode(explosion_location,explosion_power*10,caller,container.owner,tag_to_use)
	smoke(
		explosion_location,
		magnitude*0.05*2,
		40,
		container,
		caller
	)

	return TRUE




/reagent_recipe/explosion/water_potassium
	name = "Water-Potassium Explosion"
	category = "Explosions"
	required_reagents = list(
		/reagent/nutrition/water = 1,
		/reagent/potassium = 1
	)

	results = list()

/reagent_recipe/explosion/water_potassium/on_react(var/mob/caller,var/reagent_container/container,var/magnitude)

	var/turf/explosion_location = get_turf(container.owner)

	if(is_item(container.owner))
		var/obj/item/I = container.owner
		I.drop_item(explosion_location)

	var/explosion_power = round( ((magnitude ** 0.3) * 0.5) + magnitude*0.0125, 0.01)

	var/tag_to_use
	if(is_living(caller))
		var/mob/living/L = caller
		tag_to_use = L.loyalty_tag

	explode(explosion_location,explosion_power*10,caller,container.owner,tag_to_use)
	smoke(
		explosion_location,
		magnitude*0.05,
		40,
		container,
		caller
	)

	return TRUE

/reagent_recipe/explosion/smoke
	name = "Sugar-Phosphorous-Potassium Smoke"
	category = "Explosions"
	required_reagents = list(
		/reagent/nutrition/sugar = 1,
		/reagent/phosphorous = 1,
		/reagent/potassium = 1
	)
	results = list()

/reagent_recipe/explosion/smoke/on_react(var/mob/caller,var/reagent_container/container,var/magnitude)
	var/turf/T = get_turf(container.owner)
	smoke(
		T,
		magnitude*0.4,
		40 + magnitude*1.5,
		container,
		caller
	)
	return TRUE

/reagent_recipe/explosion/potassium_perchlorate
	name = "Potassium Perchlorate"
	required_reagents = list(
		/reagent/potassium = 1,
		/reagent/chlorine = 1,
		/reagent/fuel/oxygen = 1
	)

	results = list(
		/reagent/fuel/potassium_perchlorate = 3,
	)

/reagent_recipe/explosion/flash_powder
	name = "Aluminium Flash Powder"
	required_reagents = list(
		/reagent/fuel/potassium_perchlorate = 1,
		/reagent/aluminium = 1
	)
	results = list(
		/reagent/fuel/flash_powder = 3,
	)