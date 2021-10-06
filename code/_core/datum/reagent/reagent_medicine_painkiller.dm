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

	value = 0.5

/reagent/medicine/painkiller/on_add_living(var/mob/living/L,var/reagent_container/container,var/amount_added=0,var/current_volume=0)

	. = ..()

	if(L.get_status_effect_magnitude(PAINKILLER) <= strength)
		L.add_status_effect(PAINKILLER,strength,-1)

/reagent/medicine/painkiller/on_remove_living(var/mob/living/L,var/reagent_container/container)

	. = ..()

	if(L.get_status_effect_magnitude(PAINKILLER) <= strength)
		L.remove_status_effect(PAINKILLER)

/reagent/medicine/painkiller/opium
	name = "Opium"
	desc = "A medicinal, addictive chemical found in poppies and some alien plants. Used in making opioids."
	color = "#913A00"
	alpha = 200

	flavor = "opium"

	metabolism_blood = 2/60 // Lasts a minute per 2u
	metabolism_stomach = 4/60 // Lasts a minute per 4u
	experience_per_unit = 2

	value = 2

	liquid = 0.5

	strength = 200

	addiction_strength = 4
	addiction_threshold = 20

	addiction = /addiction/opium

	particle_size = 0.3

	overdose_threshold = 30


/reagent/medicine/painkiller/opium/on_metabolize_blood(var/mob/living/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()
	owner.pain_regen_buffer += .*50

/reagent/medicine/painkiller/opium/on_metabolize_stomach(var/mob/living/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()
	owner.pain_regen_buffer += .*25

/reagent/medicine/painkiller/opium/on_overdose(var/mob/living/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1,var/metabolism_amount=0)
	. = ..()
	owner.pain_regen_buffer -= .*10


/reagent/medicine/painkiller/morphine
	name = "Morphine"
	desc = "A potent painkilling and addictive chemical extracted from opium in a pure form. More stronger and addictive than opium."
	color = "#C2D1C5"
	alpha = 225

	flavor = "opium"

	metabolism_blood = 2/60 // Lasts a minute per 2u
	metabolism_stomach = 4/60 // Lasts a minute per 4u
	experience_per_unit = 4.5

	value = 5

	liquid = 0.75

	strength = 300

	addiction = /addiction/opium

	particle_size = 0.2

	addiction_strength = 4
	addiction_threshold = 30

	overdose_threshold = 30


/reagent/medicine/painkiller/morphine/on_metabolize_blood(var/mob/living/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()
	owner.pain_regen_buffer += .*100

/reagent/medicine/painkiller/morphine/on_metabolize_stomach(var/mob/living/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()
	owner.pain_regen_buffer += .*25

/reagent/medicine/painkiller/morphine/on_overdose(var/mob/living/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1,var/metabolism_amount=0)
	. = ..()
	owner.pain_regen_buffer -= .*20

/reagent/medicine/painkiller/assprin
	name = "Assprin"
	desc = "A generic painkiller."
	color = "#D1DBDB"
	alpha = 255
	flavor = "ass"
	metabolism_stomach = 5/60 // Lasts a minute per 5u
	metabolism_blood = 10/60 // Lasts a minute per 10u
	strength = 50

	experience_per_unit = 0.25

	overdose_threshold = 30

	value = 0.5

/reagent/medicine/painkiller/assprin/on_metabolize_blood(var/mob/living/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()
	owner.pain_regen_buffer += .*25

/reagent/medicine/painkiller/assprin/on_metabolize_stomach(var/mob/living/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()
	owner.pain_regen_buffer += .*10

/reagent/medicine/painkiller/assprin/on_overdose(var/mob/living/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1,var/metabolism_amount=0)
	. = ..()
	owner.pain_regen_buffer -= .*10
