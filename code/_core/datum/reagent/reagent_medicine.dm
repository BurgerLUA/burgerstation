#define METABOLISM_BLOOD 0.2
#define METABOLISM_STOMACH METABOLISM_BLOOD * 0.75
#define METABOLISM_SKIN METABOLISM_BLOOD * 10
#define OVERDOSE_THRESHOLD_MEDICINE 30

/reagent/medicine/
	metabolism_stomach = METABOLISM_STOMACH //How many units of the reagent to metabolize per second.
	metabolism_blood = METABOLISM_BLOOD //How many units of the reagent to metabolize per second.
	metabolism_skin = METABOLISM_SKIN //How many units of the reagent to metabolize per second.
	overdose_threshold = OVERDOSE_THRESHOLD_MEDICINE

	value = 0.1

/reagent/medicine/on_overdose(var/atom/original_owner,var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1,var/metabolism_amount=0)

	. = ..()

	if(original_owner && original_owner.health)
		original_owner.health.adjust_loss_smart(tox=.)

	return .

/reagent/medicine/bicaridine
	name = "Bicaridine"
	id = "bicaridine"
	desc = "Red for brute."
	color = "#FF0000"

	flavor = "bandaids"

/reagent/medicine/bicaridine/on_metabolize_blood(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()

	if(owner && owner.health)
		owner.health.adjust_loss_smart(brute=.*-5)

	return .

/reagent/medicine/bicaridine/on_metabolize_stomach(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()

	if(owner && owner.health)
		owner.health.adjust_loss_smart(brute=.*-2.5)

	return .

/reagent/medicine/bicaridine_plus
	name = "Bicaridine+"
	id = "bicaridine_plus"
	color = "#FF0080"

/reagent/medicine/bicaridine_plus/on_metabolize_blood(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()

	if(owner && owner.health)
		owner.health.adjust_loss_smart(brute=.*-10)

	return .

/reagent/medicine/bicaridine_plus/on_metabolize_stomach(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()

	if(owner && owner.health)
		owner.health.adjust_loss_smart(brute=.*-5)

	return .

/reagent/medicine/kelotane
	name = "Kelotane"
	id = "kelotane"
	desc = "Yellow for burn."
	color = "#FFFF00"

	flavor = "ointment"

/reagent/medicine/kelotane/on_metabolize_blood(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()

	if(owner && owner.health)
		owner.health.adjust_loss_smart(burn=.*-5)


	return .

/reagent/medicine/kelotane/on_metabolize_stomach(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()

	if(owner && owner.health)
		owner.health.adjust_loss_smart(burn=.*-2.5)

	return .

/reagent/medicine/dylovene
	name = "Dylovene"
	id = "dylovene"
	desc = "Green for toxin."
	color = "#00FF00"

	flavor = "sweetness"

/reagent/medicine/dylovene/on_metabolize_blood(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()

	if(owner && owner.health)
		owner.health.adjust_loss_smart(tox=.*-5)

	return .

/reagent/medicine/dylovene/on_metabolize_stomach(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()

	if(owner && owner.health)
		owner.health.adjust_loss_smart(tox=.*-2.5)

	return .

/reagent/medicine/dexalin
	name = "Dexalin"
	id = "dexalin"
	desc = "Blue for oxy."
	color = "#0000FF"

	flavor = "bitterness"

/reagent/medicine/dexalin/on_metabolize_blood(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()

	if(owner && owner.health)
		owner.health.adjust_loss_smart(oxy=.*-5)

	return .

/reagent/medicine/dexalin/on_metabolize_stomach(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()

	if(owner && owner.health)
		owner.health.adjust_loss_smart(oxy=.*-2.5)

	return .

/reagent/medicine/tricordrazine
	name = "Tricordrazine"
	id = "tricordrazine"
	desc = "Heals everything except for oxygen loss."
	color = "#B21FFF"

	flavor = "sourness"

	metabolism_blood = METABOLISM_BLOOD*0.75
	metabolism_stomach = METABOLISM_STOMACH*0.75

/reagent/medicine/tricordrazine/on_metabolize_blood(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()

	if(owner && owner.health)
		owner.health.adjust_loss_smart(brute=.*-2,burn=.*-2,tox=.*-2)

	return .

/reagent/medicine/tricordrazine/on_metabolize_stomach(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()

	if(owner && owner.health)
		owner.health.adjust_loss_smart(brute=.*-1,burn=.*-1,tox=.*-1)

	return .

/reagent/medicine/omnizine
	name = "Omnizine"
	id = "omnizine"
	desc = "Heals everything."
	desc_extended = "Works just as good when consumed."
	color = "#F7F7F7"

	flavor = "bitter sourness"

	metabolism_blood = METABOLISM_BLOOD*0.5
	metabolism_stomach = METABOLISM_STOMACH*0.5

/reagent/medicine/omnizine/on_metabolize_blood(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()

	if(owner && owner.health)
		owner.health.adjust_loss_smart(brute=.*-2,burn=.*-2,tox=.*-2,oxy=.*-2)

	return .

/reagent/medicine/omnizine/on_metabolize_stomach(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()

	if(owner && owner.health)
		owner.health.adjust_loss_smart(brute=.*-2,burn=.*-2,tox=.*-2,oxy=.*-2)

	return .


/reagent/medicine/silver_sulfadiazine
	name = "Silver Sulfadiazine"
	id = "silver_sulfadiazine"
	desc = "Heals burn damage. Only works when applied to skin."
	desc_extended = ""
	color = "#E8BEED"

	flavor = "bitter silver"

	metabolism_skin = METABOLISM_STOMACH

/reagent/medicine/silver_sulfadiazine/on_metabolize_skin(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()

	if(owner && owner.health)
		owner.health.adjust_loss_smart(burn=.*-10)

	return .

/reagent/medicine/silver_sulfadiazine/on_add(var/reagent_container/container,var/amount_added=0)

	. = ..()

	if(container.owner && container.owner.health)
		container.owner.health.adjust_loss_smart(burn=.*-10)
		container.remove_reagent(id,. * 0.5)

	return .

/reagent/medicine/styptic_powder
	name = "Styptic Powder"
	id = "styptic_powder"
	desc = "Heals brute damage. Only works when applied to skin."
	desc_extended = ""
	color = "#FFC9DD"

	flavor = "baby powder"

	metabolism_skin = METABOLISM_STOMACH


/reagent/medicine/styptic_powder/on_add(var/reagent_container/container,var/amount_added=0)

	. = ..()

	if(container.owner && container.owner.health)
		container.owner.health.adjust_loss_smart(brute=.*-10)
		container.remove_reagent(id,. * 0.5)

	return .

/reagent/medicine/styptic_powder/on_metabolize_skin(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)

	. = ..()

	if(owner && owner.health)
		owner.health.adjust_loss_smart(brute=.*-10)

	return .

/reagent/medicine/adrenaline
	name = "adrenaline"
	id = "adrenaline"
	desc = "Pure adrenaline. Prevents people from dying by increasing the amount of damage one must take before succumbing to death, as well as a speed bonus."
	color = "#880000"
	flavor = "pure speed"
	metabolism_blood = 1
	var/strength = 100
	var/duration = 30

/reagent/medicine/adrenaline/on_metabolize_blood(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)

	. = ..()

	if(is_living(owner))
		var/mob/living/L = owner
		L.add_status_effect(ADRENALINE,strength,.*50)

	return .


/reagent/medicine/adrenaline/epinephrine
	name = "epinephrine"
	id = "epinephrine"
	desc = "Used for stabilizing dying patients. Prevents people from dying by increasing the amount of damage one must take before succumbing to death, and also regulating oxyloss."
	desc_extended = ""
	color = "#FFFFFF"
	flavor = "bandaids"
	strength = 50
	duration = 50

/reagent/medicine/adrenaline/epinephrine/on_metabolize_blood(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)

	. = ..()

	if(is_living(owner))
		var/mob/living/L = owner
		if(L.health && L.health.get_oxy_loss() > 100 - strength)
			L.health.set_oxy_loss(100 - strength)
			L.health.update_health()

	return .

/reagent/medicine/adrenaline/epinephrine/on_add(var/reagent_container/container,var/amount_added=0)

	. = ..()

	if(amount_added >= 15 && is_living(container.owner))
		var/mob/living/L = container.owner
		if(L.dead && !L.check_death())
			L.revive()
			L.visible_message("\The [L.name] jolts to life!")
			L.add_status_effect(ADRENALINE,100,100)
			. = 100


	return .