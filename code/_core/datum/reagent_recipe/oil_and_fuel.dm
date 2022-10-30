/reagent_recipe/chemistry/oil/

	name = "Crude Oil"
	desc = "crude oil, used in reactions."

	required_reagents = list(
		/reagent/fuel/welding = 1,
		/reagent/fuel/hydrogen = 1
	)

	results = list(
		/reagent/fuel/oil/crude = 2
	)

/reagent_recipe/chemistry/carbonized_oil

	name = "Carbonized Oil"
	desc = "refined oil, used in machines and reactions."

	required_reagents = list(
		/reagent/fuel/oil/crude = 2,
		/reagent/carbon = 1,
	)

	results = list(
		/reagent/fuel/oil/carbon = 3
	)

/reagent_recipe/chemistry/welding_fuel

	name = "Welding Fuel"
	desc = "used for fuel in welding tools, has... other applications."

	required_reagents = list(
		/reagent/fuel/hydrogen = 1,
		/reagent/fuel/oxygen = 1
	)

	results = list(
		/reagent/fuel/welding = 2
	)
