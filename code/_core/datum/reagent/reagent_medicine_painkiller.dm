/reagent/medicine/painkiller/
	name = "Painkiller"
	desc = "A generic painkiller."
	color = "#880000"
	alpha = 225
	flavor = "pure painkilling"
	metabolism_stomach = 5/30
	metabolism_blood = 5/15
	overdose_threshold = 15
	var/strength = 50/5 //Per unit metabolized. (200 per 5u)
	var/strength_max = 100/5 //Per starting_volume unit. Should generally be smaller than strength. (100 per 5u)

	experience_per_unit = 0.5

	addiction_strength = 1
	addiction_threshold = 40
	addiction = /addiction/painkillers

	value = 0.5

	flags_metabolism = REAGENT_METABOLISM_STOMACH | REAGENT_METABOLISM_BLOOD

/reagent/medicine/painkiller/on_metabolize_blood(var/mob/living/owner,var/reagent_container/container,var/amount_to_metabolize=0,var/starting_volume=0,var/multiplier=1)

	. = ..()

	if(strength > 0)
		var/pain_regen_buffer_allowed = max(0,strength_max*starting_volume*2 - owner.pain_regen_buffer)
		if(pain_regen_buffer_allowed > 0)
			owner.pain_regen_buffer += min(pain_regen_buffer_allowed,.*multiplier*2*strength)
	else
		owner.pain_regen_buffer += .*multiplier

/reagent/medicine/painkiller/on_metabolize_stomach(var/mob/living/owner,var/reagent_container/container,var/amount_to_metabolize=0,var/starting_volume=0,var/multiplier=1)

	. = ..()

	if(strength > 0)
		var/pain_regen_buffer_allowed = max(0,strength_max*starting_volume - max(0,owner.pain_regen_buffer))
		if(pain_regen_buffer_allowed > 0)
			owner.pain_regen_buffer += min(pain_regen_buffer_allowed,.*multiplier*strength)
	else
		owner.pain_regen_buffer += .*multiplier

/reagent/medicine/painkiller/on_overdose(var/mob/living/owner,var/reagent_container/container,var/metabolism_amount=0,var/starting_volume=0,var/multiplier=1)

	. = ..()




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

	particle_size = 0.3

	overdose_threshold = 30

	blood_toxicity_multiplier = 5

	addiction_strength = 2
	addiction_threshold = 20

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

	particle_size = 0.2

	addiction_strength = 1.5
	addiction_threshold = 30

	overdose_threshold = 30

	blood_toxicity_multiplier = 3

/reagent/medicine/painkiller/assprin
	name = "Assprin"
	desc = "A generic painkiller."
	color = "#D1DBDB"
	alpha = 255

	flavor = "ass"

	metabolism_stomach = 10/60 // Takes a minute to metabolize 10u
	metabolism_blood = 20/60 // Takes a minute to metabolize 20u
	experience_per_unit = 0.25

	strength = 100/5 //100 healed per 5u.
	strength_max = 50/5 //Limit of 50 per 5u.

	addiction_strength = 1
	addiction_threshold = 40
	overdose_threshold = 30

	value = 0.5

