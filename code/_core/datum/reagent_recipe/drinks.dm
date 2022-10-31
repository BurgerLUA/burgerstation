/reagent_recipe/drink
    name = "Drink recipe"
    desc = "a recipe for a drink"
    category = "drinks"
    results = list()

/reagent_recipe/drink/hearty_punch
    name = "Hearty Punch"
    desc = "stoic players rejoice"
    category = "drinks"

    required_reagents = list(
		/reagent/nutrition/ethanol = 2,
		/reagent/medicine/health_potion = 1,
		/reagent/nutrition/sugar  = 1
	)

    results = list(
        /reagent/nutrition/ethanol/hearty_punch = 3
    )



