/reagent_recipe/bicaridine

	name = "bicaridine"
	id = "bicaridine"

	required_reagents = list(
		/reagent/carbon = 1,
		/reagent/nutrition/sugar = 1,
		/reagent/carbon = 1
	)

	results = list(
		/reagent/medicine/bicaridine = 3
	)

/reagent_recipe/kelotane

	name = "kelotane"
	id = "kelotane"

	required_reagents = list(
		/reagent/carbon = 1,
		/reagent/silicon = 1,
	)

	results = list(
		/reagent/medicine/kelotane = 2
	)


/reagent_recipe/dylovene

	name = "dylovene"
	id = "dylovene"

	required_reagents = list(
		/reagent/nitrogen = 1,
		/reagent/silicon = 1,
		/reagent/potassium = 1,
	)

	results = list(
		/reagent/medicine/dylovene = 3
	)

/reagent_recipe/tricordrazine

	name = "tricordrazine"
	id = "tricordrazine"

	required_reagents = list(
		/reagent/medicine/bicaridine = 1,
		/reagent/medicine/kelotane = 1,
		/reagent/medicine/dylovene = 1
	)

	results = list(
		/reagent/medicine/tricordrazine = 3
	)