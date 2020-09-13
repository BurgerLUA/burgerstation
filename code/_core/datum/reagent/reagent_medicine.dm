#define METABOLISM_BLOOD 1
#define METABOLISM_STOMACH METABOLISM_BLOOD * 0.5
#define METABOLISM_SKIN METABOLISM_BLOOD * 4
#define OVERDOSE_THRESHOLD_MEDICINE 30

/reagent/medicine/
	metabolism_stomach = METABOLISM_STOMACH //How many units of the reagent to metabolize per second.
	metabolism_blood = METABOLISM_BLOOD //How many units of the reagent to metabolize per second.
	metabolism_skin = METABOLISM_SKIN //How many units of the reagent to metabolize per second.
	overdose_threshold = OVERDOSE_THRESHOLD_MEDICINE

	value = 1

/reagent/medicine/on_overdose(var/atom/original_owner,var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1,var/metabolism_amount=0)

	. = ..()

	if(original_owner && original_owner.health)
		original_owner.health.adjust_loss_smart(tox=.)

	return .

/reagent/medicine/bicaridine
	name = "Bicaridine"
	desc = "Red for brute."
	color = "#FF0000"

	flavor = "bandaids"

	value = 1.25

	liquid = 0.6

/reagent/medicine/bicaridine/on_metabolize_blood(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)

	. = ..()

	if(is_living(owner))
		var/mob/living/L = owner
		L.brute_regen_buffer += 5*.
		L.health_regen_delay = 0

	return .

/reagent/medicine/bicaridine/on_metabolize_stomach(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)

	. = ..()

	if(is_living(owner))
		var/mob/living/L = owner
		L.brute_regen_buffer += 4*.
		L.health_regen_delay = 0

	return .

/reagent/medicine/bicaridine_plus
	name = "Bicaridine+"
	color = "#FF0080"

	value = 3

/reagent/medicine/bicaridine_plus/on_metabolize_blood(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()

	if(is_living(owner))
		var/mob/living/L = owner
		L.brute_regen_buffer += 10*.
		L.health_regen_delay = 0

	return .

/reagent/medicine/bicaridine_plus/on_metabolize_stomach(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()

	if(is_living(owner))
		var/mob/living/L = owner
		L.brute_regen_buffer += 8*.
		L.health_regen_delay = 0

	return .

/reagent/medicine/kelotane
	name = "Kelotane"
	desc = "Yellow for burn."
	color = "#FFFF00"

	flavor = "ointment"

	value = 1

/reagent/medicine/kelotane/on_metabolize_blood(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()

	if(is_living(owner))
		var/mob/living/L = owner
		L.burn_regen_buffer += 5*.
		L.health_regen_delay = 0


	return .

/reagent/medicine/kelotane/on_metabolize_stomach(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()

	if(is_living(owner))
		var/mob/living/L = owner
		L.burn_regen_buffer += 4*.
		L.health_regen_delay = 0

	return .

/reagent/medicine/dylovene
	name = "Dylovene"
	desc = "Green for toxin."
	color = "#00FF00"

	flavor = "sweetness"

	value = 1.25

/reagent/medicine/dylovene/on_metabolize_blood(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()

	if(is_living(owner))
		var/mob/living/L = owner
		L.tox_regen_buffer += ((L.health ? L.health.get_tox_loss()*0.05 : 0) + 5)*.
		L.health_regen_delay = 0

	return .

/reagent/medicine/dylovene/on_metabolize_stomach(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()

	if(is_living(owner))
		var/mob/living/L = owner
		L.tox_regen_buffer += ((L.health ? L.health.get_tox_loss()*0.04 : 0) + 4)*.
		L.health_regen_delay = 0

	return .

/reagent/medicine/dexalin //Shit chem, rework.
	name = "Dexalin"
	desc = "Blue for oxy."
	color = "#0000FF"

	flavor = "bitterness"

	value = 1.5

/reagent/medicine/dexalin/on_metabolize_blood(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()

	if(owner && owner.health)
		owner.health.adjust_loss_smart(oxy=.*-5)

	return .

/reagent/medicine/dexalin/on_metabolize_stomach(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()

	if(owner && owner.health)
		owner.health.adjust_loss_smart(oxy=.*-4)

	return .

/reagent/medicine/tricordrazine
	name = "Tricordrazine"
	desc = "Heals everything except for oxygen loss."
	color = "#B21FFF"

	flavor = "sourness"

	metabolism_blood = METABOLISM_BLOOD*0.75
	metabolism_stomach = METABOLISM_STOMACH*0.75

	value = 1.5

/reagent/medicine/tricordrazine/on_metabolize_blood(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()

	if(is_living(owner))
		var/mob/living/L = owner
		L.brute_regen_buffer += 4*.
		L.burn_regen_buffer += 4*.
		L.tox_regen_buffer += 4*.
		L.health_regen_delay = 0

	return .

/reagent/medicine/tricordrazine/on_metabolize_stomach(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()

	if(is_living(owner))
		var/mob/living/L = owner
		L.brute_regen_buffer += 3*.
		L.burn_regen_buffer += 3*.
		L.tox_regen_buffer += 3*.
		L.health_regen_delay = 0

	return .

/reagent/medicine/omnizine
	name = "Omnizine"
	desc = "Heals everything."
	desc_extended = "Works just as good when consumed."
	color = "#F7F7F7"

	flavor = "bitter sourness"

	metabolism_blood = METABOLISM_BLOOD*0.5
	metabolism_stomach = METABOLISM_STOMACH*0.5

	value = 2

/reagent/medicine/omnizine/on_metabolize_blood(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()

	if(is_living(owner))
		var/mob/living/L = owner
		L.brute_regen_buffer += 3*.
		L.burn_regen_buffer += 3*.
		L.tox_regen_buffer += 3*.
		L.health_regen_delay = 0

	return .

/reagent/medicine/omnizine/on_metabolize_stomach(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()

	if(is_living(owner))
		var/mob/living/L = owner
		L.brute_regen_buffer += 3*.
		L.burn_regen_buffer += 3*.
		L.tox_regen_buffer += 3*.
		L.health_regen_delay = 0

	return .


/reagent/medicine/silver_sulfadiazine
	name = "Silver Sulfadiazine"
	desc = "Heals burn damage. Only works when applied to skin."
	desc_extended = ""
	color = "#E8BEED"

	flavor = "bitter silver"

	metabolism_skin = 1

	value = 2.5

	liquid = -0.5

/reagent/medicine/silver_sulfadiazine/on_splash(var/reagent_container/container,var/mob/caller,var/atom/target,var/volume_to_splash)

	. = ..()

	if(. && is_living(target))
		on_add(container,volume_to_splash*0.5,0)

	return .

/reagent/medicine/silver_sulfadiazine/on_add(var/reagent_container/container,var/amount_added=0,var/current_volume=0)

	. = ..()

	if(current_volume == 0 && container.owner && container.owner.health) //Added for the first time.
		. *= 0.5
		container.owner.health.adjust_loss_smart(burn=.*-10)

	return .

/reagent/medicine/silver_sulfadiazine/on_metabolize_skin(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()

	if(owner && owner.health)
		if(is_living(owner.loc))
			var/mob/living/L = owner.loc
			if(L.health)
				owner.health.adjust_loss_smart(burn=.*-5,update=FALSE)
				L.burn_regen_buffer += 3*.
		else
			owner.health.adjust_loss_smart(burn=.*-5)


	return .

/reagent/medicine/styptic_powder
	name = "Styptic Powder"
	desc = "Heals brute damage. Only works when applied to skin."
	desc_extended = ""
	color = "#FFC9DD"

	flavor = "baby powder"

	metabolism_skin = 1

	value = 2

	liquid = -0.5

/reagent/medicine/styptic_powder/on_splash(var/reagent_container/container,var/mob/caller,var/atom/target,var/volume_to_splash)

	. = ..()

	if(. && is_living(target))
		on_add(container,volume_to_splash*0.5,0)

	return .


/reagent/medicine/styptic_powder/on_add(var/reagent_container/container,var/amount_added=0,var/current_volume=0)

	. = ..()

	if(current_volume == 0 && container.owner && container.owner.health) //Added for the first time.
		. *= 0.5
		container.owner.health.adjust_loss_smart(brute=.*-10)

	return .

/reagent/medicine/styptic_powder/on_metabolize_skin(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)

	. = ..()

	if(owner && owner.health)
		if(is_living(owner.loc))
			var/mob/living/L = owner.loc
			if(L.health)
				owner.health.adjust_loss_smart(brute=.*-5,update=FALSE)
				L.brute_regen_buffer += 3*.
				L.health_regen_delay = 0
		else
			owner.health.adjust_loss_smart(brute=.*-5)

	return .

/reagent/medicine/adrenaline
	name = "adrenaline"
	desc = "Pure adrenaline. Prevents people from dying by increasing the amount of damage one must take before succumbing to death, as well as a speed bonus."
	color = "#880000"
	flavor = "pure speed"
	metabolism_blood = 1
	var/strength = 100
	var/duration = 10 * 60 //Deciseconds, 1 Minute

	value = 2

/reagent/medicine/adrenaline/on_add(var/reagent_container/container,var/amount_added=0,var/current_volume=0)

	. = ..()

	if(is_living(container.owner))
		var/mob/living/L = container.owner
		if(L.get_status_effect_magnitude(ADRENALINE) <= strength)
			L.add_status_effect(ADRENALINE,strength,-1)

	return .

/reagent/medicine/adrenaline/on_remove(var/reagent_container/container)

	. = ..()

	if(is_living(container.owner))
		var/mob/living/L = container.owner
		if(L.get_status_effect_magnitude(ADRENALINE) <= strength)
			L.remove_status_effect(ADRENALINE)

	return .


/reagent/medicine/adrenaline/epinephrine
	name = "epinephrine"
	desc = "Used for stabilizing dying patients. Prevents people from dying by increasing the amount of damage one must take before succumbing to death, and also regulating oxyloss."
	desc_extended = ""
	color = "#FFFFFF"
	flavor = "bandaids"
	strength = 50
	duration = 10 * 60 //1 minute.

	value = 1.5

/reagent/medicine/adrenaline/epinephrine/on_add(var/reagent_container/container,var/amount_added=0,var/current_volume=0)

	. = ..()

	if(. + current_volume >= 10 && is_living(container.owner))
		var/mob/living/L = container.owner
		if(L.dead && !L.check_death() && L.client)
			L.revive()
			L.visible_message("\The [L.name] jolts to life!")
		else
			L.visible_message("\The [L.name] twitches for a moment, but falls back limp...")

	return .



/reagent/medicine/health_potion
	name = "Healing Juice"
	desc = "Heals brute and burn damage. Metabolizes fast."
	desc_extended = "Works just as good when consumed."
	color = "#FF0000"

	flavor = "cherry"

	metabolism_blood = METABOLISM_BLOOD * 10
	metabolism_stomach = METABOLISM_BLOOD * 10

	value = 3

/reagent/medicine/health_potion/on_metabolize_blood(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)

	. = ..()

	if(is_living(owner))
		var/mob/living/L = owner
		L.brute_regen_buffer += 5*.
		L.burn_regen_buffer += 5*.
		L.health_regen_delay = 0

	return .

/reagent/medicine/health_potion/on_metabolize_stomach(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)

	. = ..()

	if(owner && owner.health)
		owner.health.adjust_loss_smart(brute=.*-5,burn=.*-5,tox=.*-5,oxy=.*-5)

	return .


/reagent/medicine/stamina_potion
	name = "Stamina Juice"
	desc = "Restores your energy. Magical!"
	desc_extended = "Works just as good when consumed."
	color = "#00FF00"

	flavor = "lime"

	metabolism_blood = METABOLISM_BLOOD * 10
	metabolism_stomach = METABOLISM_BLOOD * 10

	value = 3

/reagent/medicine/stamina_potion/on_metabolize_blood(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()

	if(owner && owner.health)
		owner.health.adjust_stamina(.*10)

	return .

/reagent/medicine/stamina_potion/on_metabolize_stomach(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()

	if(owner && owner.health)
		owner.health.adjust_stamina(.*10)

	return .


/reagent/medicine/mana_potion
	name = "Mana Juice"
	desc = "Restores your magical powers. Super magical!"
	desc_extended = "Works just as good when consumed."
	color = "#0000FF"

	flavor = "blueberry"

	metabolism_blood = METABOLISM_BLOOD * 10
	metabolism_stomach = METABOLISM_BLOOD * 10

	value = 3

/reagent/medicine/mana_potion/on_metabolize_blood(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()

	if(owner && owner.health)
		owner.health.adjust_mana(.*10)

	return .

/reagent/medicine/mana_potion/on_metabolize_stomach(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()

	if(owner && owner.health)
		owner.health.adjust_mana(.*10)

	return .


/reagent/medicine/antihol
	name = "Antihol"
	desc = "Purges alcohol from your system quickly."
	desc_extended = "Works just as good when consumed."

	color = "#999999"

	flavor = "bitter grass"

	metabolism_blood = METABOLISM_BLOOD * 5
	metabolism_stomach = METABOLISM_BLOOD * 5

	value = 5

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