/reagent_recipe/chemistry/
	category = "Chemistry"

/reagent_recipe/chemistry/ash

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

/reagent_recipe/chemistry/oil/

	name = "Crude Oil"

	required_reagents = list(
		/reagent/fuel/welding = 1,
		/reagent/fuel/hydrogen = 1
	)

	results = list(
		/reagent/fuel/oil/crude = 2
	)

/reagent_recipe/chemistry/oil/carbon

	name = "Carbonized Oil"

	required_reagents = list(
		/reagent/fuel/oil/crude = 2,
		/reagent/carbon = 1,
	)

	results = list(
		/reagent/fuel/oil/carbon = 3
	)


/reagent_recipe/chemistry/ammonia

	name = "Ammonia"

	required_reagents = list(
		/reagent/fuel/hydrogen = 3,
		/reagent/nitrogen = 1
	)

	results = list(
		/reagent/ammonia = 1
	)

/reagent_recipe/chemistry/sulfur_dioxide

	name = "Sulfur Dioxide"

	required_reagents = list(
		/reagent/sulfur = 1,
		/reagent/carbon = 1
	)

	results = list(
		/reagent/toxin/sulfur_dioxide = 1
	)

	required_temperature_min = list(
		/reagent/carbon = 480
	)


/reagent_recipe/chemistry/sulfur_dioxide/alt

	name = "Sulfur Dioxide"

	required_reagents = list(
		/reagent/sulfur = 5,
		/reagent/fuel/oil/carbon = 1
	)

	results = list(
		/reagent/toxin/sulfur_dioxide = 5
	)

	required_temperature_min = list(
		/reagent/fuel/oil/carbon = 480
	)

/reagent_recipe/chemistry/space_cleaner

	name = "Space Cleaner"

	required_reagents = list(
		/reagent/ammonia = 1,
		/reagent/nutrition/water = 1
	)

	results = list(
		/reagent/space_cleaner = 2
	)

/reagent_recipe/chemistry/space_lube

	name = "Space Lube"

	required_reagents = list(
		/reagent/nutrition/water = 1,
		/reagent/silicon = 1,
		/reagent/potassium = 1,
	)

	results = list(
		/reagent/lube = 1
	)

/reagent_recipe/chemistry/acetone

	name = "Acetone"

	required_reagents = list(
		/reagent/fuel/oil = 1,
		/reagent/fuel/welding = 1,
		/reagent/oxygen = 1
	)

	results = list(
		/reagent/fuel/acetone = 3
	)


/reagent_recipe/chemistry/diethylamine

	name = "Diethylamine"

	required_reagents = list(
		/reagent/ammonia = 1,
		/reagent/nutrition/ethanol = 1
	)

	results = list(
		/reagent/fuel/diethylamine  = 2
	)

/reagent_recipe/chemistry/phenol

	name = "Phenol"

	required_reagents = list(
		/reagent/fuel/oil = 1,
		/reagent/chlorine = 1,
		/reagent/nutrition/water = 1
	)

	results = list(
		/reagent/phenol  = 3
	)

/reagent_recipe/chemistry/saltpetre

	name = "Saltpetre"

	required_reagents = list(
		/reagent/oxygen = 3,
		/reagent/potassium = 1,
		/reagent/nitrogen = 1
	)

	results = list(
		/reagent/saltpetre  = 3
	)


/reagent_recipe/chemistry/lye

	name = "Lye"

	required_reagents = list(
		/reagent/sodium = 1,
		/reagent/fuel/hydrogen = 1,
		/reagent/oxygen = 1
	)

	results = list(
		/reagent/lye  = 3
	)
