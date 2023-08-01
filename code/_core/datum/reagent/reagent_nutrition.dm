/reagent/nutrition/
	name = "nutrients"
	desc = "A source of nutrition."
	color = "#FFFFFF"
	alpha = 255

	metabolism_blood = 0.5
	metabolism_stomach = 0.05

	var/nutrition_normal_amount = 0 //Per unit
	var/nutrition_fast_amount = 0 //Per unit
	var/nutrition_quality_amount = 0 //Per unit.


	var/hydration_amount = 0 //Per unit
	var/heal_factor = 2 //Per unit.

	value = 1 //Acts as a multiplier.

	liquid = -0.25

	heated_reagent = /reagent/carbon
	heated_reagent_temp = 450
	heated_reagent_amount = 0
	heated_reagent_mul = 0.01

	particle_size = 0.5

	var/list/attribute_experience_per_nutrition
	var/list/skill_experience_per_nutrition

	blood_toxicity_multiplier = 0

	flags_metabolism = REAGENT_METABOLISM_STOMACH | REAGENT_METABOLISM_BLOOD | REAGENT_METABOLISM_PLANT

/reagent/nutrition/get_flammability()
	return max(0,((nutrition_normal_amount+nutrition_quality_amount*2+nutrition_fast_amount*4)/40)*0.1 - (hydration_amount/10)*0.1)


/reagent/nutrition/New(var/desired_loc)
	//Automatically set value.
	value *= 0.1 + max(0.1,(abs(nutrition_normal_amount)+abs(nutrition_quality_amount)*4+abs(nutrition_fast_amount)*0.25)*0.035) + max(0,hydration_amount*0.015) + max(0,heal_factor) + max(0,0.05*flavor_strength)
	. = ..()
	value = CEILING(value,0.01)

/reagent/nutrition/on_splash(var/reagent_container/container,var/mob/caller,var/atom/target,var/volume_to_splash,var/strength_mod=1)

	. = ..()

	if(. && hydration_amount > 0 && is_living(target))
		var/mob/living/L = target
		L.adjust_fire_stacks(-hydration_amount*volume_to_splash*0.01*strength_mod)

/reagent/nutrition/on_add_living(var/mob/living/L,var/reagent_container/container,var/amount_added=0,var/current_volume=0)

	. = ..()

	if(amount_added && (container.flags_metabolism & REAGENT_METABOLISM_STOMACH))
		if(hydration_amount)
			L.add_hydration(hydration_amount*.*0.5)
		if(nutrition_quality_amount)
			L.add_nutrition_quality(nutrition_quality_amount*.*0.5)
		if(nutrition_normal_amount)
			L.add_nutrition_normal(nutrition_normal_amount*.*0.5)
		//Fast nutrition not included here people people stuff their face easier.

/reagent/nutrition/on_metabolize_plant(var/obj/structure/interactive/plant/plant,var/reagent_container/container,var/amount_to_metabolize=0,var/starting_volume=0,var/multiplier=1)

	. = ..()

	if(nutrition_normal_amount + nutrition_quality_amount)
		plant.add_nutrition(.*( (nutrition_normal_amount+nutrition_quality_amount)/14)*multiplier*2) //plant food has 14 nutrition, so we want 10u plant food = 20 nutrition point.

	if(hydration_amount)
		plant.add_hydration(.*(hydration_amount/25)*multiplier*3) //water has 25 hydration, and we want 10u water = 30 hydration point

/reagent/nutrition/on_metabolize_stomach(var/mob/living/owner,var/reagent_container/container,var/amount_to_metabolize=0,var/starting_volume=0,var/multiplier=1)

	. = ..()

	if(.)


		if(hydration_amount)
			owner.add_hydration(hydration_amount*.*multiplier)

		if(nutrition_fast_amount)
			owner.add_nutrition_fast(nutrition_fast_amount*.*multiplier)

		if(nutrition_normal_amount)
			owner.add_nutrition_normal(nutrition_fast_amount*.*multiplier)

		if(nutrition_quality_amount)
			owner.add_nutrition_quality(nutrition_quality_amount)
			if(nutrition_quality_amount > 0 && owner.client)
				if(length(attribute_experience_per_nutrition))
					for(var/k in attribute_experience_per_nutrition)
						owner.add_attribute_xp(k,attribute_experience_per_nutrition[k]*nutrition_quality_amount*.*multiplier)
				if(length(skill_experience_per_nutrition))
					for(var/k in skill_experience_per_nutrition)
						owner.add_skill_xp(k,skill_experience_per_nutrition[k]*nutrition_quality_amount*.*multiplier)

		if(heal_factor && owner && owner.health)
			var/amount_to_heal = heal_factor*.*multiplier
			if(amount_to_heal < 0 && is_advanced(owner)) //Amount to heal is negative.
				var/mob/living/advanced/A = owner
				var/species/S = SPECIES(A.species)
				if(S.flags_flavor_love & FLAG_FLAVOR_RAW)
					amount_to_heal = 0 //Not affected by bad food.
			//Do healing.
			if(amount_to_heal > 0)
				owner.brute_regen_buffer += amount_to_heal
				owner.burn_regen_buffer += amount_to_heal

				if(owner.blood_volume < owner.blood_volume_max)
					owner.blood_volume = clamp(owner.blood_volume + amount_to_heal,0,owner.blood_volume_max)
					QUEUE_HEALTH_UPDATE(owner)
			else if(amount_to_heal < 0)
				owner.tox_regen_buffer += amount_to_heal

		if(owner.health && (nutrition_normal_amount + nutrition_quality_amount + hydration_amount) != 0)
			owner.stamina_regen_buffer += (nutrition_normal_amount + nutrition_quality_amount + hydration_amount) * . *multiplier

/reagent/nutrition/on_metabolize_blood(var/mob/living/owner,var/reagent_container/container,var/amount_to_metabolize=0,var/starting_volume=0,var/multiplier=1)
	. = ..()
	owner.blood_toxicity += .
	on_metabolize_stomach(owner,container,.,starting_volume,multiplier*0.5)
	return
