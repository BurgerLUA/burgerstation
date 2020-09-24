/reagent_recipe/ash

	name = "Ash"

	required_reagents = list(
		/reagent/fuel/oil/carbon = 1
	)

	results = list(
		/reagent/ash = 1
	)

	required_temperature_min = list(
		/reagent/fuel/oil/carbon = 480
	)

/reagent_recipe/oil/

	name = "Crude Oil"

	required_reagents = list(
		/reagent/fuel/welding = 1,
		/reagent/fuel/hydrogen = 1
	)

	results = list(
		/reagent/fuel/oil/crude = 2
	)

/reagent_recipe/oil/carbon

	name = "Carbonized Oil"

	required_reagents = list(
		/reagent/fuel/oil/crude = 2,
		/reagent/carbon = 1,
	)

	results = list(
		/reagent/fuel/oil/carbon = 3
	)


/reagent_recipe/ammonia

	name = "Ammonia"

	required_reagents = list(
		/reagent/fuel/hydrogen = 3,
		/reagent/nitrogen = 1
	)

	results = list(
		/reagent/ammonia = 1
	)