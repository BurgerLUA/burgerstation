/reagent/nutrition/energy/

	nutrition_fast_amount = 0
	nutrition_normal_amount = 0
	nutrition_quality_amount = 0
	hydration_amount = 0

	metabolism_stomach = 20/60 // Lasts a minute per 20u
	metabolism_blood = 10/60 // Lasts a minute per 10u

	value = 1.25

	var/adrenaline_strength = 100
	var/stamina_strength = 10

	heal_amount = 0

/reagent/nutrition/energy/on_metabolize_blood(var/mob/living/owner,var/reagent_container/container,var/amount_to_metabolize=0,var/starting_volume=0,var/multiplier=1)
	. = ..()

	if(owner && owner.health)
		owner.stamina_regen_buffer += .*stamina_strength*multiplier

/reagent/nutrition/energy/on_metabolize_stomach(var/mob/living/owner,var/reagent_container/container,var/amount_to_metabolize=0,var/starting_volume=0,var/multiplier=1)

	. = ..()

	if(owner && owner.health)
		owner.stamina_regen_buffer += .*stamina_strength*0.5*multiplier

/reagent/nutrition/energy/on_add_living(var/mob/living/L,var/reagent_container/container,var/amount_added=0,var/current_volume=0)

	. = ..()

	if((container.flags_metabolism & (REAGENT_METABOLISM_BLOOD | REAGENT_METABOLISM_STOMACH)) && STATUS_EFFECT_MAGNITUDE(L,ADRENALINE) <= adrenaline_strength)
		var/local_strength = adrenaline_strength * (container.flags_metabolism & REAGENT_METABOLISM_BLOOD ? 1 : 0.25)
		if(STATUS_EFFECT_MAGNITUDE(L,ADRENALINE) <= local_strength)
			L.add_status_effect(ADRENALINE,local_strength,-1)

/reagent/nutrition/energy/on_remove_living(var/mob/living/L,var/reagent_container/container)

	. = ..()

	if((container.flags_metabolism & (REAGENT_METABOLISM_BLOOD | REAGENT_METABOLISM_STOMACH)) && STATUS_EFFECT_MAGNITUDE(L,ADRENALINE) <= adrenaline_strength)
		L.remove_status_effect(ADRENALINE)

/reagent/nutrition/energy/grey_bull
	name = "\improper Grey Bull"
	desc = "Grey Bull gives you gloves!"
	color = "#F2C12E"

	flavor = "electricity"

	nutrition_fast_amount = 15
	nutrition_normal_amount = 0
	nutrition_quality_amount = 0
	hydration_amount = 10

	adrenaline_strength = 200
	stamina_strength = 10

	particle_size = 0.25

/reagent/nutrition/energy/coffee
	name = "coffee"
	desc = "Basic black coffee."
	color = "#824C28"

	flavor = "coffee"

	nutrition_fast_amount = 0
	nutrition_normal_amount = 5
	nutrition_quality_amount = 5
	hydration_amount = 10

	adrenaline_strength = 50
	stamina_strength = 5

	flavor_strength = 2.5

	particle_size = 0.3


/reagent/nutrition/energy/coffee/espresso
	name = "espresso"
	desc = "Coffee in its purest form."
	color = "#824C28"

	flavor = "expresso"

	nutrition_fast_amount = 0
	nutrition_normal_amount = 5
	nutrition_quality_amount = 10
	hydration_amount = 5

	adrenaline_strength = 100
	stamina_strength = 10

	flavor_strength = 5