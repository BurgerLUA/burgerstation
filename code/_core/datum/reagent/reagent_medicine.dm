#define OVERDOSE_THRESHOLD_MEDICINE 30

/reagent/medicine/
	overdose_threshold = OVERDOSE_THRESHOLD_MEDICINE
	value = 1

	var/experience_per_unit = 0 //Medical XP per unit added.

	flags_flavor = FLAG_FLAVOR_MEDICINE

	blood_toxicity_multiplier = 1

/reagent/medicine/on_add_living(var/mob/living/L,var/reagent_container/container,var/amount_added=0,var/current_volume=0,var/mob/living/caller)

	. = ..()

	if(!L.dead && experience_per_unit*. > 0 && is_player(caller) && caller.client)
		caller.add_skill_xp(SKILL_MEDICINE,CEILING(experience_per_unit*.,1))

/reagent/medicine/on_overdose(var/mob/living/owner,var/reagent_container/container,var/metabolism_amount=0,var/starting_volume=0,var/multiplier=1)

	. = ..()

	if(owner)
		owner.tox_regen_buffer -= metabolism_amount //Deal tox damage.

/reagent/medicine/adrenaline
	name = "adrenaline"
	desc = "Increases heartrate."
	color = "#880000"
	alpha = 225
	flavor = "pure speed"
	metabolism_stomach = 5/60 // Lasts a minute per 5u
	metabolism_blood = 10/60 // Lasts a minute per 10u
	var/strength = 100

	experience_per_unit = 1

	value = 1

	particle_size = 0.5

	overdose_threshold = 20

	flags_metabolism = REAGENT_METABOLISM_STOMACH | REAGENT_METABOLISM_BLOOD

/reagent/medicine/adrenaline/on_add_living(var/mob/living/L,var/reagent_container/container,var/amount_added=0,var/current_volume=0)

	. = ..()

	if((container.flags_metabolism & (REAGENT_METABOLISM_BLOOD | REAGENT_METABOLISM_STOMACH)) && STATUS_EFFECT_MAGNITUDE(L,ADRENALINE) <= strength)
		L.add_status_effect(ADRENALINE,strength,-1)

/reagent/medicine/adrenaline/on_remove_living(var/mob/living/L,var/reagent_container/container)

	. = ..()

	if((container.flags_metabolism & (REAGENT_METABOLISM_BLOOD | REAGENT_METABOLISM_STOMACH)) && STATUS_EFFECT_MAGNITUDE(L,ADRENALINE) <= strength)
		L.remove_status_effect(ADRENALINE)

/reagent/medicine/adrenaline/epinephrine
	name = "epinephrine"
	desc = "Used for reviving dying patients."
	desc_extended = ""
	color = "#FFFFFF"
	alpha = 225
	flavor = "bandaids"
	strength = 50

	value = 0.75

	particle_size = 0.25

	flags_metabolism = REAGENT_METABOLISM_STOMACH | REAGENT_METABOLISM_BLOOD

/reagent/medicine/adrenaline/epinephrine/on_add_living(var/mob/living/L,var/reagent_container/container,var/amount_added=0,var/current_volume=0)

	. = ..()

	if(. + current_volume >= 10 && L.dead && (container.flags_metabolism & (REAGENT_METABOLISM_BLOOD | REAGENT_METABOLISM_STOMACH)))
		if(!L.check_death() && L.is_player_controlled() && !L.suicide)
			L.revive()
			L.visible_message(span("danger","\The [L.name] jolts to life!"))
		else
			L.visible_message(span("warning","\The [L.name] twitches for a moment, but falls back limp..."))

/reagent/medicine/health_potion
	name = "Healing Juice"
	desc = "Heals brute and burn damage. Metabolizes fast."
	desc_extended = "Works just as good when consumed."
	color = "#FF0000"
	alpha = 255

	flavor = "cherry"

	metabolism_blood = 5
	metabolism_stomach = 5

	experience_per_unit = 3

	value = 1.25

	particle_size = 0.4

	flags_metabolism = REAGENT_METABOLISM_STOMACH | REAGENT_METABOLISM_BLOOD

/reagent/medicine/health_potion/on_metabolize_blood(var/mob/living/owner,var/reagent_container/container,var/amount_to_metabolize=0,var/starting_volume=0,var/multiplier=1)
	. = ..()
	owner.brute_regen_buffer += 2*.*multiplier
	owner.burn_regen_buffer += 2*.*multiplier
	owner.tox_regen_buffer += 2*.*multiplier

/reagent/medicine/health_potion/on_metabolize_stomach(var/mob/living/owner,var/reagent_container/container,var/amount_to_metabolize=0,var/starting_volume=0,var/multiplier=1)
	. = ..()
	owner.brute_regen_buffer += 3*.*multiplier
	owner.burn_regen_buffer += 3*.*multiplier
	owner.tox_regen_buffer += 3*.*multiplier

/reagent/medicine/stamina_potion
	name = "Stamina Juice"
	desc = "Restores your energy. Magical!"
	desc_extended = "Works better when consumed."
	color = "#00FF00"
	alpha = 255

	flavor = "lime"

	metabolism_blood = 5
	metabolism_stomach = 5

	experience_per_unit = 2

	value = 1

	particle_size = 0.5

	flags_metabolism = REAGENT_METABOLISM_STOMACH | REAGENT_METABOLISM_BLOOD

/reagent/medicine/stamina_potion/on_metabolize_blood(var/mob/living/owner,var/reagent_container/container,var/amount_to_metabolize=0,var/starting_volume=0,var/multiplier=1)
	. = ..()

	if(owner && owner.health)
		owner.stamina_regen_buffer += .*2*multiplier

/reagent/medicine/stamina_potion/on_metabolize_stomach(var/mob/living/owner,var/reagent_container/container,var/amount_to_metabolize=0,var/starting_volume=0,var/multiplier=1)
	. = ..()

	if(owner && owner.health)
		owner.stamina_regen_buffer += .*3*multiplier

/reagent/medicine/mana_potion
	name = "Mana Juice"
	desc = "Restores your magical powers. Super magical!"
	desc_extended = "Works better when consumed."
	color = "#0000FF"
	alpha = 255

	flavor = "blueberry"

	metabolism_blood = 5
	metabolism_stomach = 5

	experience_per_unit = 2

	value = 1

	particle_size = 0.3

	flags_metabolism = REAGENT_METABOLISM_STOMACH | REAGENT_METABOLISM_BLOOD

/reagent/medicine/mana_potion/on_metabolize_blood(var/mob/living/owner,var/reagent_container/container,var/amount_to_metabolize=0,var/starting_volume=0,var/multiplier=1)
	. = ..()

	if(owner && owner.health)
		owner.mana_regen_buffer += .*2*multiplier

/reagent/medicine/mana_potion/on_metabolize_stomach(var/mob/living/owner,var/reagent_container/container,var/amount_to_metabolize=0,var/starting_volume=0,var/multiplier=1)
	. = ..()

	if(owner && owner.health)
		owner.mana_regen_buffer += .*3*multiplier

/reagent/medicine/antihol
	name = "Antihol"
	desc = "Purges alcohol from your system quickly."
	desc_extended = "Works just as good when consumed."
	alpha = 225

	color = "#999999"

	flavor = "bitter grass"

	metabolism_blood = 5
	metabolism_stomach = 1

	experience_per_unit = 2

	value = 1.25

	particle_size = 0.6

	flags_metabolism = REAGENT_METABOLISM_STOMACH | REAGENT_METABOLISM_BLOOD

/reagent/medicine/antihol/on_metabolize_blood(var/mob/living/owner,var/reagent_container/container,var/amount_to_metabolize=0,var/starting_volume=0,var/multiplier=1)

	. = ..()

	if(owner.health)
		if(owner.health.organic)
			owner.intoxication = max(0,owner.intoxication - .*10*multiplier)
		else
			owner.intoxication = owner.intoxication + .*10*multiplier

	for(var/reagent_id in container.stored_reagents)
		var/reagent/R = REAGENT(reagent_id)
		if(istype(R,/reagent/nutrition/ethanol))
			container.add_reagent(reagent_id,-.*3*multiplier)

/reagent/medicine/antihol/on_metabolize_stomach(var/mob/living/owner,var/reagent_container/container,var/amount_to_metabolize=0,var/starting_volume=0,var/multiplier=1)

	. = ..()

	if(owner.health)
		if(owner.health.organic)
			owner.intoxication = max(0,owner.intoxication - .*10*multiplier)
		else
			owner.intoxication = owner.intoxication + .*10*multiplier

	for(var/reagent_id in container.stored_reagents)
		var/reagent/R = REAGENT(reagent_id)
		if(istype(R,/reagent/nutrition/ethanol))
			container.add_reagent(reagent_id,-.*3*multiplier)

/reagent/medicine/purge
	name = "Calomel"
	desc = "Purges all chemicals from the system quickly. Deals toxin damage as a consequences, relative to the amount purged. Works better when injected."
	color = "#315F77"
	alpha = 225
	flavor = "old shoes"

	value = 2

	experience_per_unit = 2

	var/list/purge_blacklist = list()

	particle_size = 0.8

	flags_metabolism = REAGENT_METABOLISM_STOMACH | REAGENT_METABOLISM_BLOOD

/reagent/medicine/purge/on_metabolize_blood(var/mob/living/owner,var/reagent_container/container,var/amount_to_metabolize=0,var/starting_volume=0,var/multiplier=1)

	. = ..()

	for(var/reagent_id in container.stored_reagents)
		if(purge_blacklist[reagent_id])
			continue
		var/reagent/R = REAGENT(reagent_id)
		if(R.type == src.type)
			continue
		owner.tox_regen_buffer += container.add_reagent(reagent_id,-.*4*multiplier)

/reagent/medicine/purge/on_metabolize_stomach(var/mob/living/owner,var/reagent_container/container,var/amount_to_metabolize=0,var/starting_volume=0,var/multiplier=1)

	. = ..()

	for(var/reagent_id in container.stored_reagents)
		if(purge_blacklist[reagent_id])
			continue
		var/reagent/R = REAGENT(reagent_id)
		if(R.type == src.type)
			continue
		owner.tox_regen_buffer += container.add_reagent(reagent_id,-.*4*multiplier)

/reagent/medicine/charcoal
	name = "charcoal"
	desc = "Purges poisons from the system while healing a slight amount of toxins. Works just as well when consumed."
	color = "#404040"
	alpha = 255
	flavor = "old shoes"

	var/list/purge_blacklist = list()

	experience_per_unit = 2

	value = 1.5

	particle_size = 1

	flags_metabolism = REAGENT_METABOLISM_STOMACH | REAGENT_METABOLISM_BLOOD

/reagent/medicine/charcoal/on_metabolize_blood(var/mob/living/owner,var/reagent_container/container,var/amount_to_metabolize=0,var/starting_volume=0,var/multiplier=1)

	. = ..()

	for(var/reagent_id in container.stored_reagents)
		if(purge_blacklist[reagent_id])
			continue
		var/reagent/R = REAGENT(reagent_id)
		if(!R.lethal)
			continue
		container.add_reagent(reagent_id,-.)
		owner.tox_regen_buffer += 3*.*multiplier

/reagent/medicine/charcoal/on_metabolize_stomach(var/mob/living/owner,var/reagent_container/container,var/amount_to_metabolize=0,var/starting_volume=0,var/multiplier=1)

	. = ..()

	for(var/reagent_id in container.stored_reagents)
		if(purge_blacklist[reagent_id])
			continue
		var/reagent/R = REAGENT(reagent_id)
		if(!R.lethal)
			continue
		container.add_reagent(reagent_id,-.*2*multiplier)
		owner.tox_regen_buffer += 2*.*multiplier


/reagent/medicine/mitogen
	name = "Mitogen"
	desc = "A wonder medicine that is more effective when the user is critically damaged at the cost of some toxin damage. Metabolizes fast."
	color = "#9400D3"
	alpha = 200

	flavor = "fat"

	metabolism_blood = 2
	metabolism_stomach = 0.2
	experience_per_unit = 4.5

	value = 0.75

	liquid = 0.5

	particle_size = 0.6

	flags_metabolism = REAGENT_METABOLISM_STOMACH | REAGENT_METABOLISM_BLOOD

/reagent/medicine/mitogen/on_metabolize_blood(var/mob/living/owner,var/reagent_container/container,var/amount_to_metabolize=0,var/starting_volume=0,var/multiplier=1)

	. = ..()

	if(owner.health)
		owner.brute_regen_buffer += 10*.*clamp(1 - owner.health.health_current/owner.health.health_max,0,1)*multiplier
		owner.tox_regen_buffer -= 0.1*.*multiplier

/reagent/medicine/mitogen/on_metabolize_stomach(var/mob/living/owner,var/reagent_container/container,var/amount_to_metabolize=0,var/starting_volume=0,var/multiplier=1)

	. = ..()

	if(owner.health)
		owner.brute_regen_buffer += 8*.*clamp(1 - owner.health.health_current/owner.health.health_max,0,1)*multiplier
		owner.tox_regen_buffer -= 0.1*.*multiplier



/reagent/medicine/nicotine
	name = "Nicotine"
	desc = "A very addictive pesticide commonly found in household products such as Bugs-B-Gone and Space Cigarettes."
	color = "#E2E2E2"
	alpha = 255
	flavor = "nicotine"

	metabolism_stomach = 2/60 // Lasts a minute per 2u
	metabolism_blood = 2/60 // Lasts a minute per 2u
	metabolism_skin = 2/60 // Lasts a minute per 2u

	experience_per_unit = 0

	value = 1

	addiction_strength = 0.1
	addiction_threshold = 5
	addiction = /addiction/nicotine

	lethal = TRUE //For now...

	particle_size = 0.4

	flags_metabolism = REAGENT_METABOLISM_STOMACH | REAGENT_METABOLISM_BLOOD | REAGENT_METABOLISM_SKIN

/reagent/medicine/synthblood
	name = "synthblood"
	desc = "A special synthetic blood that replicates the blood type of any organic being when injected. Usually more expensive than just using real blood, however it has some chemical applications."
	color = "#D50052"
	alpha = 225
	flavor = "melted wax putty"
	value = 2

	experience_per_unit = 2

	liquid = 0.25

	particle_size = 0.1

	flags_metabolism = REAGENT_METABOLISM_BLOOD

/reagent/medicine/synthblood/on_metabolize_blood(var/mob/living/owner,var/reagent_container/container,var/amount_to_metabolize=0,var/starting_volume=0,var/multiplier=1)
	. = ..()
	if(owner.blood_type && owner.health.organic)
		owner.blood_volume += .*0.75*multiplier

/reagent/medicine/rad_b_gone
	name = "Rad-B-Gone"
	desc = "A special mixture of radiation treating chemicals. Use for when you're heavily irradiated. Injection only."
	color = "#BA7C00"
	alpha = 225
	flavor = "gunk"
	value = 0.75

	experience_per_unit = 1

	liquid = 0.5
	particle_size = 0.2

	overdose_threshold = 150

	flags_metabolism = REAGENT_METABOLISM_BLOOD

/reagent/medicine/rad_b_gone/on_metabolize_blood(var/mob/living/owner,var/reagent_container/container,var/amount_to_metabolize=0,var/starting_volume=0,var/multiplier=1)
	. = ..()
	owner.rad_regen_buffer += .*2*multiplier


/reagent/medicine/potassium_iodide
	name = "Potassium Iodide"
	desc = "A common and cheap medicine used to prevent further lingering radiation damage, but not cure it."
	color = "#FFF4EC"
	alpha = 255
	flavor = "salty bananas"
	value = 0.1

	metabolism_blood = 0.5
	metabolism_stomach = 0.5

	experience_per_unit = 0.5

	liquid = -0.5
	particle_size = 0.4

	flags_metabolism = REAGENT_METABOLISM_BLOOD

/reagent/medicine/potassium_iodide/on_metabolize_blood(var/mob/living/owner,var/reagent_container/container,var/amount_to_metabolize=0,var/starting_volume=0,var/multiplier=1)
	. = ..()
	if(owner.rad_regen_buffer < 0)
		owner.rad_regen_buffer = min(0,owner.rad_regen_buffer + 3*.*multiplier)

/reagent/medicine/space_prussian_blue
	name = "Space Prussian Blue"
	desc = "A relatively uncommon but inexpensive pigment that acts as a great dye as well as an excellent way to treat radiation poisoning caused by consuming radioactive substances. Only works when STOMACHed."
	color = "#1D2A60"
	alpha = 255
	flavor = "salty bananas"
	value = 1.3

	metabolism_blood = 0.5
	metabolism_stomach = 0.5

	experience_per_unit = 0.5

	liquid = -0.2
	particle_size = 0.5

	flags_metabolism = REAGENT_METABOLISM_STOMACH


/reagent/medicine/space_prussian_blue/on_metabolize_stomach(var/mob/living/owner,var/reagent_container/container,var/amount_to_metabolize=0,var/starting_volume=0,var/multiplier=1)

	. = ..()

	for(var/reagent_id in container.stored_reagents)
		var/reagent/R = REAGENT(reagent_id)
		if(!istype(R,/reagent/radioactive/))
			continue
		container.add_reagent(reagent_id,-.*10*multiplier)