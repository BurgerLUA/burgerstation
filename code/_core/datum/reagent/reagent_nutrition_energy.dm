/reagent/nutrition/energy/
	nutrition_amount = 0
	hydration_amount = 0
	nutrition_quality_amount = 0

	metabolism_stomach = 20/60 // Lasts a minute per 20u
	metabolism_blood = 10/60 // Lasts a minute per 10u

	value = 1.25

	var/adrenaline_strength = 100
	var/stamina_strength = 10

	heal_factor = 0

/reagent/nutrition/energy/on_metabolize_blood(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()

	if(owner && owner.health)
		owner.health.adjust_stamina(.*stamina_strength)

	return .

/reagent/nutrition/energy/on_metabolize_stomach(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)

	. = ..()

	if(owner && owner.health)
		owner.health.adjust_stamina(.*stamina_strength)

	return .

/reagent/nutrition/energy/on_add_living(var/mob/living/L,var/reagent_container/container,var/amount_added=0,var/current_volume=0)

	. = ..()

	if(L.get_status_effect_magnitude(ADRENALINE) <= adrenaline_strength)
		L.add_status_effect(ADRENALINE,adrenaline_strength,-1)

	return .

/reagent/nutrition/energy/on_remove_living(var/mob/living/L,var/reagent_container/container)

	. = ..()

	if(L.get_status_effect_magnitude(ADRENALINE) <= adrenaline_strength)
		L.remove_status_effect(ADRENALINE)

	return .

/reagent/nutrition/energy/grey_bull
	name = "\improper Grey Bull"
	desc = "Grey Bull gives you gloves!"
	color = "#F2C12E"

	flavor = "electricity"

	nutrition_amount = 3
	hydration_amount = 10
	nutrition_quality_amount = -10

	adrenaline_strength = 200
	stamina_strength = 10

/reagent/nutrition/energy/coffee
	name = "coffee"
	desc = "Basic black coffee."
	color = "#824C28"

	flavor = "coffee"

	nutrition_amount = 3
	hydration_amount = 10
	nutrition_quality_amount = -2

	adrenaline_strength = 50
	stamina_strength = 5

	flavor_strength = 2.5


/reagent/nutrition/energy/coffee/expresso
	name = "espresso"
	desc = "Coffee in its purest form."
	color = "#824C28"

	flavor = "expresso"

	nutrition_amount = 3
	hydration_amount = 6
	nutrition_quality_amount = -4

	adrenaline_strength = 100
	stamina_strength = 10

	flavor_strength = 5