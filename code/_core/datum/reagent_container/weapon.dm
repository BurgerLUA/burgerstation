/reagent_container/weapon
	volume_max = 20
	should_update_owner = FALSE

/reagent_container/weapon/flamethrower
	volume_max = 200
	allow_recipe_processing = FALSE

/reagent_container/weapon/flamethrower/add_reagent(reagent_type, amount, temperature, should_update, check_recipes, mob/living/caller)

	if(!(ispath(reagent_type,/reagent/fuel)) && amount > 0)
		caller.to_chat(span("warning","That would ruin the Flamethrower! I think a fuel might work better..."))
		return 0
	var/reagent/fuel/R = REAGENT(reagent_type)
	if(R.fire_strength_per_unit <= 0 && amount > 0)
		caller.to_chat(span("warning","That would ruin the Flamethrower! I bet something more Flammable would work well though..."))
		return 0
	. = ..()

