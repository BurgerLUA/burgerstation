/reagent_recipe/magic/
	category = "Chemistry"
	results = list()

/reagent_recipe/magic/health_potion

	name = "Healing Juice"
	desc = "heals over time."

	required_reagents = list(
		/reagent/blood/ancient = 1,
		/reagent/blood/reptile = 1,
		/reagent/medicine/bicaridine = 1,
		/reagent/medicine/painkiller/opium = 1
	)

	results = list(
		/reagent/medicine/health_potion = 1
	)


/reagent_recipe/magic/stamina_potion

	name = "Stamina Juice"
	desc = "restores stamina over time."

	required_reagents = list(
		/reagent/blood/xeno = 1,
		/reagent/blood/plant = 1,
		/reagent/medicine/dylovene = 1,
		/reagent/nutrition/energy/grey_bull = 1
	)

	results = list(
		/reagent/medicine/stamina_potion = 1
	)

/reagent_recipe/magic/mana_potion

	name = "Mana Juice"
	desc = "restores mana over time."

	required_reagents = list(
		/reagent/blood/goliath = 1,
		/reagent/blood/goblin = 1,
		/reagent/medicine/dexalin = 1,
		/reagent/drug/space = 1
	)

	results = list(
		/reagent/medicine/mana_potion = 1
	)
