/reagent_recipe/bicaridine

	name = "Bicaridine"

	required_reagents = list(
		/reagent/carbon = 1,
		/reagent/oxygen = 1,
		/reagent/nutrition/sugar/glucose = 1,
	)

	results = list(
		/reagent/medicine/bicaridine = 3
	)

/reagent_recipe/kelotane

	name = "Kelotane"

	required_reagents = list(
		/reagent/carbon = 1,
		/reagent/silicon = 1,
	)

	results = list(
		/reagent/medicine/kelotane = 2
	)


/reagent_recipe/dylovene

	name = "Dylovene"

	required_reagents = list(
		/reagent/nitrogen = 1,
		/reagent/silicon = 1,
		/reagent/potassium = 1,
	)

	results = list(
		/reagent/medicine/dylovene = 3
	)

/reagent_recipe/tricordrazine

	name = "Tricordrazine"

	required_reagents = list(
		/reagent/medicine/bicaridine = 1,
		/reagent/medicine/kelotane = 1,
		/reagent/medicine/dylovene = 1
	)

	results = list(
		/reagent/medicine/tricordrazine = 3
	)

/reagent_recipe/charcoal

	name = "Charcoal"

	required_reagents = list(
		/reagent/ash = 1,
		/reagent/salt/sodium_chloride = 1
	)

	results = list(
		/reagent/medicine/charcoal = 2
	)

	required_temperature_min = list(
		/reagent/ash = 380,
		/reagent/salt/sodium_chloride = 380
	)

/reagent_recipe/silver_sulfadiazine
	name = "Silver Sulfadiazine"
	required_reagents = list(
		/reagent/ammonia = 1,
		/reagent/silver = 1,
		/reagent/sulfur = 1,
		/reagent/oxygen = 1,
		/reagent/chlorine = 1
	)

	results = list(
		/reagent/medicine/silver_sulfadiazine = 1
	)