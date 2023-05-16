/reagent_container/weapon
	volume_max = 20
	should_update_owner = FALSE

/reagent_container/weapon/flamethrower
	volume_max = 200
	allow_recipe_processing = FALSE
	var/allowed_reagents = list(/reagent/fuel/phoron,/reagent/fuel/oil,/reagent/fuel/welding)

/reagent_container/weapon/flamethrower/add_reagent(reagent_type, amount, temperature, should_update, check_recipes, mob/living/caller)

	if(!(reagent_type in allowed_reagents) && amount > 0)
		caller.to_chat(span("warning","That would ruin the flamethrower!I bet phoron,oil or welding fuel would work however..."))
		return 0
	. = ..()

