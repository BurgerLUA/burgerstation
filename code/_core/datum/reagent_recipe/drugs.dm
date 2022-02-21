/reagent_recipe/drugs/
	category = "Chemistry"
	results = list()

/reagent_recipe/drugs/space_drugs

	name = "Space Drugs"

	required_reagents = list(
		/reagent/drug/lithium = 1,
		/reagent/toxin/mercury = 1,
		/reagent/nutrition/sugar/glucose = 1
	)

	results = list(
		/reagent/drug/space = 1
	)


/reagent_recipe/drugs/space_dust

	name = "Space Dust"

	required_reagents = list(
		/reagent/fuel/acetone = 1,
		/reagent/drug/space = 1,
		/reagent/medicine/dexalin = 1
	)

	results = list(
		/reagent/drug/dust = 1
	)