/reagent_recipe/chemistry/oil/

	name = "Crude Oil"

	required_reagents = list(
		/reagent/fuel/welding = 1,
		/reagent/fuel/hydrogen = 1
	)

	results = list(
		/reagent/fuel/oil/crude = 2
	)

/reagent_recipe/chemistry/carbonized_oil

	name = "Carbonized Oil"

	required_reagents = list(
		/reagent/fuel/oil/crude = 2,
		/reagent/carbon = 1,
	)

	results = list(
		/reagent/fuel/oil/carbon = 3
	)

/reagent_recipe/chemistry/welding_fuel

	name = "Welding Fuel"

	required_reagents = list(
		/reagent/fuel/hydrogen = 1,
		/reagent/oxygen = 1
	)

	results = list(
		/reagent/fuel/welding = 2
	)