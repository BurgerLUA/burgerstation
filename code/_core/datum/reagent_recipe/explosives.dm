/reagent_recipe/explosion/
	category = "Explosives"
	results = list()

/reagent_recipe/explosion/emp
	name = "Electro-Magnetic Pulse"
	desc = "Disables electronics."

	required_reagents = list(
		/reagent/iron = 1,
		/reagent/radioactive/uranium = 1
	)

	results = list()

/reagent_recipe/explosion/emp/on_react(var/mob/caller,var/reagent_container/container,var/magnitude)

	var/tag_to_use
	if(is_living(caller))
		var/mob/living/L = caller
		tag_to_use = L.loyalty_tag

	emp(get_turf(container.owner),magnitude/20,caller,container.owner,tag_to_use)

	return TRUE


/reagent_recipe/explosion/holy_water_potassium
	name = "Holy Water-Potassium Explosion"
	desc = "hallelujah!"

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

	var/explosion_power = round( ((magnitude*2 ** 0.3) * 0.5) + magnitude*2*0.025, 0.01)

	var/tag_to_use
	if(is_living(caller))
		var/mob/living/L = caller
		tag_to_use = L.loyalty_tag

	explode(explosion_location,explosion_power,caller,container.owner,tag_to_use)
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
	desc = "a grayshirt's favorite recipe."

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

	explode(explosion_location,explosion_power,caller,container.owner,tag_to_use)
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
	desc = "PROBABLY a warcrime!"

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
	desc = "do. not. inhale."

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
	desc = "blind your friends with this."

	required_reagents = list(
		/reagent/fuel/potassium_perchlorate = 1,
		/reagent/aluminium = 1
	)
	results = list(
		/reagent/fuel/flash_powder = 3,
	)
