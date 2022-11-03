/reagent_recipe/chemistry/
	category = "Chemistry"
	name = "chemistry recipe"
	desc = "a chemistry recipe"
	results = list()

/reagent_recipe/chemistry/sodium_chloride

	name = "Sodium Chloride"
	desc = "no dude, that is iodized table salt, which in addition to sodium chloride, contains anti-caking agents and potassium iodide- Which is added to prevent iodide defficiency. So not only are you being overly pretentious by insisting on using scientific terminology for every day items, you are factually wrong. Your arrogance will be your downfall."

	required_reagents = list(
		/reagent/sodium = 1,
		/reagent/chlorine = 1,
		/reagent/nutrition/water = 1
	)

	results = list(
		/reagent/salt/sodium_chloride = 1
	)

/reagent_recipe/chemistry/ammonia

	name = "Ammonia"
	desc = "Ammonia from lifeforms."

	required_reagents = list(
		/reagent/fuel/hydrogen = 3,
		/reagent/nitrogen = 1
	)

	results = list(
		/reagent/ammonia = 1
	)

/reagent_recipe/chemistry/sulfur_dioxide

	name = "Sulfur Dioxide"
	desc = "Toxic fumes from burning sulfur with coal."

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

/reagent_recipe/chemistry/space_cleaner

	name = "Space Cleaner"
	desc = "Cleaner in space."

	required_reagents = list(
		/reagent/ammonia = 1,
		/reagent/nutrition/water = 1
	)

	results = list(
		/reagent/space_cleaner = 2
	)

/reagent_recipe/chemistry/space_lube

	name = "Space Lube"
	desc = "If I get an AHELP where someone has released smoke grenades of this all over the station, I am going to code it out. -V"

	required_reagents = list(
		/reagent/fuel/oxygen = 1,
		/reagent/silicon = 1,
		/reagent/potassium = 1,
	)

	results = list(
		/reagent/lube = 1
	)

/reagent_recipe/chemistry/acetone

	name = "Acetone"
	desc = "A colorless, corrosive flammable liquid used for solvents."

	required_reagents = list(
		/reagent/fuel/oil = 1,
		/reagent/fuel/welding = 1,
		/reagent/fuel/oxygen = 1
	)

	results = list(
		/reagent/fuel/acetone = 3
	)


/reagent_recipe/chemistry/diethylamine

	name = "Diethylamine"
	desc = "A solvent of sorts."

	required_reagents = list(
		/reagent/ammonia = 1,
		/reagent/nutrition/ethanol = 1
	)

	results = list(
		/reagent/fuel/diethylamine  = 2
	)

/reagent_recipe/chemistry/phenol

	name = "Phenol"
	desc = "A corrosive flammable solid used as a component in most recipes. Works as a good disinfectant."

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
	desc = "A mineral."

	required_reagents = list(
		/reagent/fuel/oxygen = 3,
		/reagent/potassium = 1,
		/reagent/nitrogen = 1
	)

	results = list(
		/reagent/saltpetre  = 3
	)


/reagent_recipe/chemistry/lye

	name = "Lye"
	desc = "The Never Song: WKYK."

	required_reagents = list(
		/reagent/sodium = 1,
		/reagent/fuel/welding = 1
	)

	results = list(
		/reagent/lye  = 3
	)



/reagent_recipe/chemistry/hydrogen_peroxide

	name = "Hydrogen Peroxide"
	desc = "an antiseptic."

	required_reagents = list(
		/reagent/chlorine = 1,
		/reagent/fuel/oxygen = 1,
		/reagent/nutrition/water = 1
	)

	results = list(
		/reagent/hydrogen_peroxide = 3
	)


/reagent_recipe/chemistry/sugar_breakdown_01

	name = "Sugar into Glucose"
	desc = "turn sugar into glucose."

	required_reagents = list(
		/reagent/nutrition/sugar = 1,
		/reagent/enzymes = 1
	)

	results = list(
		/reagent/nutrition/sugar/glucose = 1
	)

/reagent_recipe/chemistry/sugar_breakdown_02

	name = "Sugar into Glucose"
	desc = "turn cane sugar into glucose."

	required_reagents = list(
		/reagent/nutrition/sugar/cane = 1,
		/reagent/enzymes = 1
	)

	results = list(
		/reagent/nutrition/sugar/glucose = 1
	)

	secret = TRUE
