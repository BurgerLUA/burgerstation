/reagent_container/weapon
	volume_max = 20
	should_update_owner = FALSE
/reagent_container/weapon/flamethrower
	volume_max = 200
	allow_recipe_processing = FALSE
/reagent_container/weapon/flamethrower/add_reagent(reagent_type, amount, temperature, should_update, check_recipes, mob/living/caller)
	if(!ispath(reagent_type,/reagent/fuel/phoron) && amount > 0)
		caller.to_chat(span("warning","That would ruin the flamethrower! Maybe try some Liquid Phoron?"))
		return 0
	. = ..()
