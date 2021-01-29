#define OVERDOSE_THRESHOLD_MEDICINE 30

/reagent/medicine/
	overdose_threshold = OVERDOSE_THRESHOLD_MEDICINE
	value = 1

	var/experience_per_unit = 0 //Medical XP per unit added.

	flags_flavor = FLAG_FLAVOR_MEDICINE

/reagent/medicine/on_add_living(var/mob/living/L,var/reagent_container/container,var/amount_added=0,var/current_volume=0,var/mob/living/caller)

	. = ..()

	if(!L.dead && experience_per_unit && caller && is_player(caller))
		caller.add_skill_xp(SKILL_MEDICINE,experience_per_unit*.)

	return .

/reagent/medicine/on_overdose(var/atom/original_owner,var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1,var/metabolism_amount=0)

	. = ..()

	if(original_owner && original_owner.health)
		original_owner.health.adjust_loss_smart(tox=.,robotic=FALSE)

	return .

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

	value = 2

/reagent/medicine/adrenaline/on_add_living(var/mob/living/L,var/reagent_container/container,var/amount_added=0,var/current_volume=0)

	. = ..()

	if(L.get_status_effect_magnitude(ADRENALINE) <= strength)
		L.add_status_effect(ADRENALINE,strength,-1)

	return .

/reagent/medicine/adrenaline/on_remove_living(var/mob/living/L,var/reagent_container/container)

	. = ..()

	if(L.get_status_effect_magnitude(ADRENALINE) <= strength)
		L.remove_status_effect(ADRENALINE)

	return .


/reagent/medicine/adrenaline/epinephrine
	name = "epinephrine"
	desc = "Used for stabilizing dying patients. Prevents people from dying by increasing the amount of damage one must take before succumbing to death, and also regulating oxyloss."
	desc_extended = ""
	color = "#FFFFFF"
	alpha = 225
	flavor = "bandaids"
	strength = 50

	value = 1.5

/reagent/medicine/adrenaline/epinephrine/on_add_living(var/mob/living/L,var/reagent_container/container,var/amount_added=0,var/current_volume=0)

	. = ..()

	if(. + current_volume >= 10)
		if(L.dead && !L.check_death() && L.is_player_controlled() && !L.suicide)
			L.revive()
			L.visible_message(span("danger","\The [L.name] jolts to life!"))
		else
			L.visible_message(span("warning","\The [L.name] twitches for a moment, but falls back limp..."))

	return .



/reagent/medicine/health_potion
	name = "Healing Juice"
	desc = "Heals brute and burn damage. Metabolizes fast."
	desc_extended = "Works just as good when consumed."
	color = "#FF0000"
	alpha = 255

	flavor = "cherry"

	metabolism_blood = METABOLISM_BLOOD * 10
	metabolism_stomach = METABOLISM_BLOOD * 10

	experience_per_unit = 5

	value = 3

/reagent/medicine/health_potion/on_metabolize_blood(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)

	. = ..()

	if(owner && owner.health)
		owner.health.adjust_loss_smart(brute=.*-3,burn=.*-3,tox=.*-3,oxy=.*-3,robotic = FALSE)

	return .

/reagent/medicine/health_potion/on_metabolize_stomach(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)

	. = ..()

	if(owner && owner.health)
		owner.health.adjust_loss_smart(brute=.*-3,burn=.*-3,tox=.*-3,oxy=.*-3,robotic = FALSE)

	return .


/reagent/medicine/stamina_potion
	name = "Stamina Juice"
	desc = "Restores your energy. Magical!"
	desc_extended = "Works just as good when consumed."
	color = "#00FF00"
	alpha = 255

	flavor = "lime"

	metabolism_blood = METABOLISM_BLOOD * 10
	metabolism_stomach = METABOLISM_BLOOD * 10

	experience_per_unit = 5

	value = 3

/reagent/medicine/stamina_potion/on_metabolize_blood(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()

	if(owner && owner.health)
		owner.health.adjust_stamina(.*5)

	return .

/reagent/medicine/stamina_potion/on_metabolize_stomach(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()

	if(owner && owner.health)
		owner.health.adjust_stamina(.*5)

	return .


/reagent/medicine/mana_potion
	name = "Mana Juice"
	desc = "Restores your magical powers. Super magical!"
	desc_extended = "Works just as good when consumed."
	color = "#0000FF"
	alpha = 255

	flavor = "blueberry"

	metabolism_blood = METABOLISM_BLOOD * 10
	metabolism_stomach = METABOLISM_BLOOD * 10

	experience_per_unit = 5

	value = 3

/reagent/medicine/mana_potion/on_metabolize_blood(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()

	if(owner && owner.health)
		owner.health.adjust_mana(.*5)

	return .

/reagent/medicine/mana_potion/on_metabolize_stomach(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()

	if(owner && owner.health)
		owner.health.adjust_mana(.*5)

	return .


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

	value = 3

/reagent/medicine/antihol/on_metabolize_blood(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)

	. = ..()

	if(owner && is_living(owner))
		var/mob/living/L = owner
		L.intoxication = max(0,L.intoxication - .*10)
		for(var/reagent_id in container.stored_reagents)
			var/reagent/R = REAGENT(reagent_id)
			if(istype(R,/reagent/nutrition/ethanol))
				container.remove_reagent(reagent_id,.*3)

	return .

/reagent/medicine/antihol/on_metabolize_stomach(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)

	. = ..()

	if(owner && is_living(owner))
		var/mob/living/L = owner
		L.intoxication = max(0,L.intoxication - .*10)
		for(var/reagent_id in container.stored_reagents)
			var/reagent/R = REAGENT(reagent_id)
			if(istype(R,/reagent/nutrition/ethanol))
				container.remove_reagent(reagent_id,.*3)

	return .


/reagent/medicine/purge
	name = "Calomel"
	desc = "Purges all chemicals from the system quickly. Deals toxin damage as a consequences, relative to the amount purged. Works better when injected."
	color = "#315F77"
	alpha = 225
	flavor = "old shoes"

	value = 12

	experience_per_unit = 2

	var/list/purge_blacklist = list(/reagent/toxin/zombie_toxin = TRUE)

/reagent/medicine/purge/on_metabolize_blood(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)

	. = ..()

	if(owner && is_living(owner))
		var/mob/living/L = owner
		for(var/reagent_id in container.stored_reagents)
			if(purge_blacklist[reagent_id])
				continue
			var/reagent/R = REAGENT(reagent_id)
			if(R.type == src.type)
				continue
			owner.health.adjust_loss_smart(tox=container.remove_reagent(reagent_id,.*1.5), robotic = FALSE)
		L.queue_health_update = TRUE

	return .

/reagent/medicine/purge/on_metabolize_stomach(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)

	. = ..()

	if(owner && is_living(owner))
		var/mob/living/L = owner
		for(var/reagent_id in container.stored_reagents)
			if(purge_blacklist[reagent_id])
				continue
			var/reagent/R = REAGENT(reagent_id)
			if(R.type == src.type)
				continue
			owner.health.adjust_loss_smart(tox=container.remove_reagent(reagent_id,.*1.5),robotic = FALSE)
		L.queue_health_update = TRUE

	return .



/reagent/medicine/charcoal
	name = "charcoal"
	desc = "Purges poisons from the system while healing a slight amount of toxins. Works just as well when consumed."
	color = "#315F77"
	alpha = 255
	flavor = "old shoes"

	var/list/purge_blacklist = list(/reagent/toxin/zombie_toxin = TRUE)

	experience_per_unit = 2

	value = 8

/reagent/medicine/charcoal/on_metabolize_blood(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)

	. = ..()

	if(owner && is_living(owner))
		var/mob/living/L = owner
		for(var/reagent_id in container.stored_reagents)
			if(purge_blacklist[reagent_id])
				continue
			var/reagent/R = REAGENT(reagent_id)
			if(!R.lethal)
				continue
			container.remove_reagent(reagent_id,.*2)
			L.tox_regen_buffer += 3*.

	return .

/reagent/medicine/charcoal/on_metabolize_stomach(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)

	. = ..()

	if(owner && is_living(owner))
		var/mob/living/L = owner
		for(var/reagent_id in container.stored_reagents)
			if(purge_blacklist[reagent_id])
				continue
			var/reagent/R = REAGENT(reagent_id)
			if(!R.lethal)
				continue
			container.remove_reagent(reagent_id,.*2)
			L.tox_regen_buffer += 2*.


	return .


/reagent/medicine/zombie_antidote
	name = "zombie antidote"
	desc = "An zombie bite immunity injection that automatically counter-acts zombie poison as long as the volume of the antidote exceeds the poison volume. Does not actually purge the medicine."
	color = "#9FFF2A"
	alpha = 225
	flavor = "not brains"
	value = 15

	experience_per_unit = 3

/reagent/medicine/zombie_antidote/on_metabolize_blood(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()
	owner.reagents.remove_reagent(/reagent/toxin/zombie_toxin,.)
	return .

/reagent/medicine/zombie_antidote/on_metabolize_stomach(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()
	if(owner.reagents)
		return owner.reagents.add_reagent(/reagent/medicine/zombie_antidote/,.*0.75)
	return 0

/reagent/medicine/mitogen
	name = "Mitogen"
	desc = "A wonder medicine that is more effective when the user is critically damaged at the cost of some toxin damage. Metabolizes fast."
	color = "#9400D3"
	alpha = 200

	flavor = "fat"

	metabolism_blood = 1
	metabolism_stomach = 0.5
	experience_per_unit = 4.5

	value = 1.75

	liquid = 0.5

/reagent/medicine/mitogen/on_metabolize_blood(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)

	. = ..()

	if(is_living(owner))
		var/mob/living/L = owner
		if(L.health)
			L.brute_regen_buffer += 10*.*(1 - L.health.health_current/L.health.health_max)
			L.tox_regen_buffer -= 0.1*.

	return .

/reagent/medicine/mitogen/on_metabolize_stomach(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)

	. = ..()

	if(is_living(owner))
		var/mob/living/L = owner
		if(L.health)
			L.brute_regen_buffer += 8*.*(1 - L.health.health_current/L.health.health_max)
			L.tox_regen_buffer -= 0.1*.

	return .