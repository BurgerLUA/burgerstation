/reagent/medicine/painkiller/
	name = "Painkiller"
	desc = "A generic painkiller."
	color = "#880000"
	alpha = 225
	flavor = "pure painkilling"
	metabolism_stomach = 5/60 // Lasts a minute per 5u
	metabolism_blood = 10/60 // Lasts a minute per 10u
	var/strength = 100

	experience_per_unit = 1

	value = 2

/reagent/medicine/painkiller/on_add_living(var/mob/living/L,var/reagent_container/container,var/amount_added=0,var/current_volume=0)

	. = ..()

	if(L.get_status_effect_magnitude(PAINKILLER) <= strength)
		L.add_status_effect(PAINKILLER,strength,-1)

	return .

/reagent/medicine/painkiller/on_remove_living(var/mob/living/L,var/reagent_container/container)

	. = ..()

	if(L.get_status_effect_magnitude(PAINKILLER) <= strength)
		L.remove_status_effect(PAINKILLER)

	return .


/reagent/medicine/painkiller/opium
	name = "Opium"
	desc = "A medicinal, addictive chemical found in poppies and some alien plants. Used in making opioids."
	color = "#913A00"
	alpha = 200

	flavor = "opium"

	metabolism_blood = 1
	metabolism_stomach = 0.5
	experience_per_unit = 4.5

	value = 1.75

	liquid = 0.5

	strength = 50

	addiction = /addiction/opium


/reagent/medicine/painkiller/opium/on_metabolize_blood(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)

	. = ..()

	if(is_living(owner))
		var/mob/living/L = owner
		if(L.health)
			L.brute_regen_buffer += .*3
			L.burn_regen_buffer += .*2
			L.pain_regen_buffer += .*5

	return .

/reagent/medicine/painkiller/opium/on_metabolize_stomach(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)

	. = ..()

	if(is_living(owner))
		var/mob/living/L = owner
		if(L.health)
			L.brute_regen_buffer += .*1.5
			L.burn_regen_buffer += .*1
			L.pain_regen_buffer += .*2.5

	return .