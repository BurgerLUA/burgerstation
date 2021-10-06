#define OVERDOSE_THRESHOLD_MEDICINE 30

/reagent/medicine/
	overdose_threshold = OVERDOSE_THRESHOLD_MEDICINE
	value = 1

	var/experience_per_unit = 0 //Medical XP per unit added.

	flags_flavor = FLAG_FLAVOR_MEDICINE

	blood_toxicity_multiplier = 1

/reagent/medicine/on_add_living(var/mob/living/L,var/reagent_container/container,var/amount_added=0,var/current_volume=0,var/mob/living/caller)

	. = ..()

	if(!L.dead && experience_per_unit && caller && is_player(caller))
		caller.add_skill_xp(SKILL_MEDICINE,experience_per_unit*.)

/reagent/medicine/on_overdose(var/mob/living/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1,var/metabolism_amount=0)

	. = ..()

	if(owner)
		owner.tox_regen_buffer -= . //Deal tox damage.

/reagent/medicine/adrenaline
	name = "adrenaline"
	desc = "Pure adrenaline. Prevents people from dying by increasing the amount of damage one must take before succumbing to death, as well as a speed bonus."
	color = "#880000"
	alpha = 225
	flavor = "pure speed"
	metabolism_stomach = 5/60 // Lasts a minute per 5u
	metabolism_blood = 10/60 // Lasts a minute per 10u
	var/strength = 100

	experience_per_unit = 1

	value = 1

	particle_size = 0.5

/reagent/medicine/adrenaline/on_add_living(var/mob/living/L,var/reagent_container/container,var/amount_added=0,var/current_volume=0)

	. = ..()

	if(L.get_status_effect_magnitude(ADRENALINE) <= strength)
		L.add_status_effect(ADRENALINE,strength,-1)

/reagent/medicine/adrenaline/on_remove_living(var/mob/living/L,var/reagent_container/container)

	. = ..()

	if(L.get_status_effect_magnitude(ADRENALINE) <= strength)
		L.remove_status_effect(ADRENALINE)

/reagent/medicine/adrenaline/epinephrine
	name = "epinephrine"
	desc = "Used for stabilizing dying patients. Prevents people from dying by increasing the amount of damage one must take before succumbing to death, and also regulating oxyloss."
	desc_extended = ""
	color = "#FFFFFF"
	alpha = 225
	flavor = "bandaids"
	strength = 50

	value = 0.75

	particle_size = 0.25

/reagent/medicine/adrenaline/epinephrine/on_add_living(var/mob/living/L,var/reagent_container/container,var/amount_added=0,var/current_volume=0)

	. = ..()

	if(. + current_volume >= 10 && L.dead)
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

	metabolism_blood = METABOLISM_BLOOD * 10
	metabolism_stomach = METABOLISM_BLOOD * 10

	experience_per_unit = 3

	value = 1.25

	particle_size = 0.4

/reagent/medicine/health_potion/on_metabolize_blood(var/mob/living/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()
	owner.brute_regen_buffer += 2*.
	owner.burn_regen_buffer += 2*.
	owner.tox_regen_buffer += 2*.

/reagent/medicine/health_potion/on_metabolize_stomach(var/mob/living/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()
	owner.brute_regen_buffer += 3*.
	owner.burn_regen_buffer += 3*.
	owner.tox_regen_buffer += 3*.

/reagent/medicine/stamina_potion
	name = "Stamina Juice"
	desc = "Restores your energy. Magical!"
	desc_extended = "Works better when consumed."
	color = "#00FF00"
	alpha = 255

	flavor = "lime"

	metabolism_blood = METABOLISM_BLOOD * 10
	metabolism_stomach = METABOLISM_BLOOD * 10

	experience_per_unit = 2

	value = 1

	particle_size = 0.5

/reagent/medicine/stamina_potion/on_metabolize_blood(var/mob/living/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()

	if(owner && owner.health)
		owner.health.adjust_stamina(.*2)

/reagent/medicine/stamina_potion/on_metabolize_stomach(var/mob/living/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()

	if(owner && owner.health)
		owner.health.adjust_stamina(.*3)

/reagent/medicine/mana_potion
	name = "Mana Juice"
	desc = "Restores your magical powers. Super magical!"
	desc_extended = "Works better when consumed."
	color = "#0000FF"
	alpha = 255

	flavor = "blueberry"

	metabolism_blood = METABOLISM_BLOOD * 10
	metabolism_stomach = METABOLISM_BLOOD * 10

	experience_per_unit = 2

	value = 1

	particle_size = 0.3

/reagent/medicine/mana_potion/on_metabolize_blood(var/mob/living/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()

	if(owner && owner.health)
		owner.health.adjust_mana(.*2)

/reagent/medicine/mana_potion/on_metabolize_stomach(var/mob/living/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()

	if(owner && owner.health)
		owner.health.adjust_mana(.*3)

/reagent/medicine/antihol
	name = "Antihol"
	desc = "Purges alcohol from your system quickly."
	desc_extended = "Works just as good when consumed."
	alpha = 225

	color = "#999999"

	flavor = "bitter grass"

	metabolism_blood = METABOLISM_BLOOD * 5
	metabolism_stomach = METABOLISM_BLOOD * 5

	experience_per_unit = 2

	value = 1.25

	particle_size = 0.6

/reagent/medicine/antihol/on_metabolize_blood(var/mob/living/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)

	. = ..()

	if(owner.health)
		if(owner.health.organic)
			owner.intoxication = max(0,owner.intoxication - .*10)
		else
			owner.intoxication = owner.intoxication + .*10

	for(var/reagent_id in container.stored_reagents)
		var/reagent/R = REAGENT(reagent_id)
		if(istype(R,/reagent/nutrition/ethanol))
			container.remove_reagent(reagent_id,.*3)

/reagent/medicine/antihol/on_metabolize_stomach(var/mob/living/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)

	. = ..()

	if(owner.health)
		if(owner.health.organic)
			owner.intoxication = max(0,owner.intoxication - .*10)
		else
			owner.intoxication = owner.intoxication + .*10

	for(var/reagent_id in container.stored_reagents)
		var/reagent/R = REAGENT(reagent_id)
		if(istype(R,/reagent/nutrition/ethanol))
			container.remove_reagent(reagent_id,.*3)

/reagent/medicine/purge
	name = "Calomel"
	desc = "Purges all chemicals from the system quickly. Deals toxin damage as a consequences, relative to the amount purged. Works better when injected."
	color = "#315F77"
	alpha = 225
	flavor = "old shoes"

	value = 2

	experience_per_unit = 2

	var/list/purge_blacklist = list(/reagent/toxin/zombie_toxin = TRUE)

	particle_size = 0.8

/reagent/medicine/purge/on_metabolize_blood(var/mob/living/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)

	. = ..()

	for(var/reagent_id in container.stored_reagents)
		if(purge_blacklist[reagent_id])
			continue
		var/reagent/R = REAGENT(reagent_id)
		if(R.type == src.type)
			continue
		owner.tox_regen_buffer -= container.remove_reagent(reagent_id,.*4)

/reagent/medicine/purge/on_metabolize_stomach(var/mob/living/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)

	. = ..()

	for(var/reagent_id in container.stored_reagents)
		if(purge_blacklist[reagent_id])
			continue
		var/reagent/R = REAGENT(reagent_id)
		if(R.type == src.type)
			continue
		owner.tox_regen_buffer -= container.remove_reagent(reagent_id,.*4)

/reagent/medicine/charcoal
	name = "charcoal"
	desc = "Purges poisons from the system while healing a slight amount of toxins. Works just as well when consumed."
	color = "#315F77"
	alpha = 255
	flavor = "old shoes"

	var/list/purge_blacklist = list(/reagent/toxin/zombie_toxin = TRUE)

	experience_per_unit = 2

	value = 1.5

	particle_size = 1

/reagent/medicine/charcoal/on_metabolize_blood(var/mob/living/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)

	. = ..()

	for(var/reagent_id in container.stored_reagents)
		if(purge_blacklist[reagent_id])
			continue
		var/reagent/R = REAGENT(reagent_id)
		if(!R.lethal)
			continue
		container.remove_reagent(reagent_id,.)
		owner.tox_regen_buffer += 3*.

/reagent/medicine/charcoal/on_metabolize_stomach(var/mob/living/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)

	. = ..()

	for(var/reagent_id in container.stored_reagents)
		if(purge_blacklist[reagent_id])
			continue
		var/reagent/R = REAGENT(reagent_id)
		if(!R.lethal)
			continue
		container.remove_reagent(reagent_id,.*2)
		owner.tox_regen_buffer += 2*.

/reagent/medicine/zombie_antidote
	name = "zombie antidote"
	desc = "An zombie bite immunity injection that automatically counter-acts zombie poison as long as the volume of the antidote exceeds the poison volume. Does not actually purge the medicine."
	color = "#9FFF2A"
	alpha = 225
	flavor = "not brains"
	value = 10

	experience_per_unit = 3

	liquid = 0.25

	particle_size = 0.5

/reagent/medicine/zombie_antidote/on_metabolize_blood(var/mob/living/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()
	owner.reagents.remove_reagent(/reagent/toxin/zombie_toxin,.)

/reagent/medicine/zombie_antidote/on_metabolize_stomach(var/mob/living/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()
	owner.reagents.add_reagent(/reagent/medicine/zombie_antidote/,.*0.75)

/reagent/medicine/mitogen
	name = "Mitogen"
	desc = "A wonder medicine that is more effective when the user is critically damaged at the cost of some toxin damage. Metabolizes fast."
	color = "#9400D3"
	alpha = 200

	flavor = "fat"

	metabolism_blood = 1
	metabolism_stomach = 0.5
	experience_per_unit = 4.5

	value = 0.75

	liquid = 0.5

	particle_size = 0.6

/reagent/medicine/mitogen/on_metabolize_blood(var/mob/living/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)

	. = ..()

	if(owner.health)
		owner.brute_regen_buffer += 10*.*clamp(1 - owner.health.health_current/owner.health.health_max,0,1)
		owner.tox_regen_buffer -= 0.1*.

/reagent/medicine/mitogen/on_metabolize_stomach(var/mob/living/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)

	. = ..()

	if(owner.health)
		owner.brute_regen_buffer += 8*.*clamp(1 - owner.health.health_current/owner.health.health_max,0,1)
		owner.tox_regen_buffer -= 0.1*.



/reagent/medicine/nicotine
	name = "Nicotine"
	desc = "A very addictive pesticide commonly found in household products such as Bugs-B-Gone and Space Cigarettes."
	color = "#E2E2E2"
	alpha = 255
	flavor = "nicotine"

	metabolism_stomach = 2/60 // Lasts a minute per 2u
	metabolism_blood = 2/60 // Lasts a minute per 2u

	experience_per_unit = 0

	value = 1

	addiction_strength = 0.1
	addiction_threshold = 5
	addiction = /addiction/nicotine

	lethal = TRUE //For now...

	particle_size = 0.4

/reagent/medicine/nicotine/on_metabolize_blood(var/mob/living/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()

	//Regenerate 5 sanity per second while nicotine is in your system, as long as the metabolism exceeds metabolism_blood
	//You also get hungrier and thirstier.
	if(. >= metabolism_blood)
		var/true_multiplier = TICKS_TO_SECONDS(LIFE_TICK_SLOW) * (. / metabolism_blood) * multiplier
		owner.sanity_regen_buffer += 5*true_multiplier
		owner.add_hydration(-0.05*true_multiplier)
		owner.add_nutrition(-0.1*true_multiplier)

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

/reagent/medicine/synthblood/on_metabolize_blood(var/mob/living/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()
	if(owner.blood_type && owner.health.organic)
		owner.blood_volume += .*0.75

/reagent/medicine/rad_b_gone
	name = "Rad-B-Gone"
	desc = "A special mixture of radiation treating chemicals. Use for when you're heavily irradiated. Injection only."
	color = "#BA7C00"
	alpha = 225
	flavor = "gunk"
	value = 1.5

	experience_per_unit = 2

	liquid = 0.5
	particle_size = 0.2

/reagent/medicine/rad_b_gone/on_metabolize_blood(var/mob/living/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()
	owner.rad_regen_buffer += .*5