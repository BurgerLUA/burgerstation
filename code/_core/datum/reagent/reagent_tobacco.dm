/reagent/tobacco
	name = "Tobacco"
	desc = "Space Tobacco grown on space plantations."
	color = "#63391C"
	alpha = 255

	flavor = "tobacco"
	flavor_strength = 10

	liquid = -0.75

	var/hidden_chance = 0
	var/list/hidden_reagents = list()

	metabolism_blood = 0.5
	metabolism_stomach = 0.5

	blood_toxicity_multiplier = 3

	flags_metabolism = REAGENT_METABOLISM_STOMACH | REAGENT_METABOLISM_BLOOD

/reagent/tobacco/on_metabolize_blood(var/mob/living/owner,var/reagent_container/container,var/amount_to_metabolize=0,var/starting_volume=0,var/multiplier=1)

	. = ..()

	if(container)
		var/reagent/R = /reagent/medicine/nicotine
		if(hidden_chance && prob(hidden_chance))
			R = pickweight(hidden_reagents)
		container.add_reagent(R,.*0.1)

/reagent/tobacco/cigarette
	name = "Low-grade Tobacco"
	flavor = "cheap tobacco"
	hidden_chance = 25
	hidden_reagents = list(
		/reagent/fuel/welding = 25,
		/reagent/fuel/acetone = 10,
		/reagent/ammonia = 10,
		/reagent/toxin/spider_toxin = 1,
		/reagent/toxin/xeno_acid = 1
	)