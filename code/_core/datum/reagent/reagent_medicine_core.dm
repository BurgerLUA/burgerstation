/reagent/medicine/bicaridine
	name = "Bicaridine"
	desc = "Red for brute."
	color = "#FF0000"
	alpha = 200

	flavor = "bandaids"

	metabolism_blood = 0.5
	metabolism_stomach = 0.25
	experience_per_unit = 2.5

	value = 1.25

	liquid = 0.6

/reagent/medicine/bicaridine/on_metabolize_blood(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)

	. = ..()

	if(is_living(owner))
		var/mob/living/L = owner
		L.brute_regen_buffer += 5*.

	return .

/reagent/medicine/bicaridine/on_metabolize_stomach(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)

	. = ..()

	if(is_living(owner))
		var/mob/living/L = owner
		L.brute_regen_buffer += 4*.


	return .

/reagent/medicine/bicaridine_plus
	name = "Bicaridine+"
	color = "#FF0080"
	alpha = 225

	metabolism_blood = 0.5
	metabolism_stomach = 0.25
	experience_per_unit = 5

	value = 3

/reagent/medicine/bicaridine_plus/on_metabolize_blood(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()

	if(is_living(owner))
		var/mob/living/L = owner
		L.brute_regen_buffer += 10*.


	return .

/reagent/medicine/bicaridine_plus/on_metabolize_stomach(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()

	if(is_living(owner))
		var/mob/living/L = owner
		L.brute_regen_buffer += 8*.


	return .

/reagent/medicine/kelotane
	name = "Kelotane"
	desc = "Yellow for burn."
	color = "#FFFF00"
	alpha = 200

	flavor = "ointment"

	metabolism_blood = 0.5
	metabolism_stomach = 0.25
	experience_per_unit = 2.5

	value = 1

/reagent/medicine/kelotane/on_metabolize_blood(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()

	if(is_living(owner))
		var/mob/living/L = owner
		L.burn_regen_buffer += 5*.

	return .

/reagent/medicine/kelotane/on_metabolize_stomach(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()

	if(is_living(owner))
		var/mob/living/L = owner
		L.burn_regen_buffer += 4*.

	return .

/reagent/medicine/dylovene
	name = "Dylovene"
	desc = "Green for toxin."
	color = "#00FF00"
	alpha = 200

	flavor = "sweetness"

	metabolism_blood = 0.5
	metabolism_stomach = 0.25
	experience_per_unit = 2.5

	value = 1.25

/reagent/medicine/dylovene/on_metabolize_blood(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()

	if(is_living(owner))
		var/mob/living/L = owner
		L.tox_regen_buffer += ((L.health ? L.health.get_loss(TOX)*0.05 : 0) + 5)*.

	return .

/reagent/medicine/dylovene/on_metabolize_stomach(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()

	if(is_living(owner))
		var/mob/living/L = owner
		L.tox_regen_buffer += ((L.health ? L.health.get_loss(TOX)*0.04 : 0) + 4)*.


	return .

/reagent/medicine/dexalin
	name = "Dexalin"
	desc = "Blue for oxy."
	color = "#1111FF"
	alpha = 150

	flavor = "bitterness"

	metabolism_blood = 0.5
	metabolism_stomach = 0.25

	value = 1.5

/reagent/medicine/dexalin/on_add_living(var/mob/living/L,var/reagent_container/container,var/amount_added=0,var/current_volume=0)

	. = ..()

	L.blood_oxygen += 0.2

	return .

/reagent/medicine/dexalin/on_remove_living(var/mob/living/L,var/reagent_container/container)

	. = ..()

	L.blood_oxygen -= 0.2

	return .

/reagent/medicine/tricordrazine
	name = "Tricordrazine"
	desc = "Heals everything except for oxygen loss."
	color = "#B21FFF"
	alpha = 225

	flavor = "sourness"

	metabolism_blood = 0.5
	metabolism_stomach = 0.25
	experience_per_unit = 4

	value = 1.5

/reagent/medicine/tricordrazine/on_metabolize_blood(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()

	if(is_living(owner))
		var/mob/living/L = owner
		L.brute_regen_buffer += 4*.
		L.burn_regen_buffer += 4*.
		L.tox_regen_buffer += 4*.


	return .

/reagent/medicine/tricordrazine/on_metabolize_stomach(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()

	if(is_living(owner))
		var/mob/living/L = owner
		L.brute_regen_buffer += 3*.
		L.burn_regen_buffer += 3*.
		L.tox_regen_buffer += 3*.


	return .

/reagent/medicine/omnizine
	name = "Omnizine"
	desc = "Heals everything."
	desc_extended = "Works just as good when consumed."
	color = "#F7F7F7"
	alpha = 255

	flavor = "bitter sourness"

	metabolism_blood = 0.5
	metabolism_stomach = 0.25
	experience_per_unit = 3

	value = 2

/reagent/medicine/omnizine/on_metabolize_blood(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()

	if(is_living(owner))
		var/mob/living/L = owner
		L.brute_regen_buffer += 3*.
		L.burn_regen_buffer += 3*.
		L.tox_regen_buffer += 3*.
		L.health_regen_delay = max(0,L.health_regen_delay - .*2)


	return .

/reagent/medicine/omnizine/on_metabolize_stomach(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()

	if(is_living(owner))
		var/mob/living/L = owner
		L.brute_regen_buffer += 3*.
		L.burn_regen_buffer += 3*.
		L.tox_regen_buffer += 3*.
		L.health_regen_delay = max(0,L.health_regen_delay - .*2)

	return .

/reagent/medicine/adminomnizine
	name = "Adminomnizine"
	desc = "Heals everything. EVERYTHING."
	desc_extended = "Works just as good when consumed. Doesn't matter anyways because THIS IS THE STUFF OF THE GODS."
	color = "#FFFFFF"
	alpha = 255

	flavor = "god"

	metabolism_blood = 1
	metabolism_stomach = 1
	experience_per_unit = 10

	value = 5000

/reagent/medicine/adminomnizine/on_metabolize_blood(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()

	if(is_living(owner))
		var/mob/living/L = owner
		L.brute_regen_buffer = max(L.brute_regen_buffer,500*.)
		L.burn_regen_buffer = max(L.burn_regen_buffer,500*.)
		L.tox_regen_buffer = max(L.tox_regen_buffer,500*.)
		L.health_regen_delay = 0

	return .

/reagent/medicine/adminomnizine/on_metabolize_stomach(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()

	if(is_living(owner))
		var/mob/living/L = owner
		L.brute_regen_buffer = max(L.brute_regen_buffer,500*.)
		L.burn_regen_buffer = max(L.burn_regen_buffer,500*.)
		L.tox_regen_buffer = max(L.tox_regen_buffer,500*.)
		L.health_regen_delay = 0

	return .



/reagent/medicine/silver_sulfadiazine
	name = "Silver Sulfadiazine"
	desc = "Heals burn damage. Only works when applied to skin."
	desc_extended = ""
	color = "#E8BEED"
	alpha = 255

	flavor = "bitter silver"

	metabolism_skin = 1

	value = 2.5

	liquid = -0.5

	experience_per_unit = 5

/reagent/medicine/silver_sulfadiazine/on_splash(var/reagent_container/container,var/mob/caller,var/atom/target,var/volume_to_splash,var/strength_mod=1)

	. = ..()

	if(. && is_living(target))
		on_add(container,volume_to_splash*strength_mod,0)

	return .

/reagent/medicine/silver_sulfadiazine/on_add(var/reagent_container/container,var/amount_added=0,var/current_volume=0)

	. = ..()

	if(current_volume == 0 && container.owner && container.owner.health) //Added for the first time.
		. *= 0.5
		container.owner.health.adjust_loss_smart(burn=.*-10,robotic=FALSE)
		if(is_organ(container.owner))
			var/obj/item/organ/O = container.owner
			O.send_pain(50)

	return .

/reagent/medicine/silver_sulfadiazine/on_metabolize_skin(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()

	if(owner && owner.health)
		if(is_living(owner.loc))
			var/mob/living/L = owner.loc
			if(L.health)
				owner.health.adjust_loss_smart(burn=.*-5,robotic=FALSE)
				L.burn_regen_buffer += 3*.
				L.health_regen_delay = max(0,L.health_regen_delay - .*2)
		else
			owner.health.adjust_loss_smart(burn=.*-5,robotic=FALSE)


	return .

/reagent/medicine/styptic_powder
	name = "Styptic Powder"
	desc = "Heals brute damage. Only works when applied to skin."
	desc_extended = ""
	color = "#FFC9DD"
	alpha = 255

	flavor = "baby powder"

	metabolism_skin = 1

	value = 2

	liquid = -0.5

	experience_per_unit = 5

/reagent/medicine/styptic_powder/on_splash(var/reagent_container/container,var/mob/caller,var/atom/target,var/volume_to_splash,var/strength_mod=1)

	. = ..()

	if(. && is_living(target))
		on_add(container,volume_to_splash*strength_mod,0)

	return .


/reagent/medicine/styptic_powder/on_add(var/reagent_container/container,var/amount_added=0,var/current_volume=0)

	. = ..()

	if(current_volume == 0 && container.owner && container.owner.health) //Added for the first time.
		. *= 0.5
		container.owner.health.adjust_loss_smart(brute=.*-10,robotic=FALSE)
		if(is_organ(container.owner))
			var/obj/item/organ/O = container.owner
			O.send_pain(50)

	return .

/reagent/medicine/styptic_powder/on_metabolize_skin(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)

	. = ..()

	if(owner && owner.health)
		if(is_living(owner.loc))
			var/mob/living/L = owner.loc
			if(L.health)
				owner.health.adjust_loss_smart(brute=.*-5,robotic=FALSE)
				L.brute_regen_buffer += 3*.
				L.health_regen_delay = max(0,L.health_regen_delay - .*2)

		else
			owner.health.adjust_loss_smart(brute=.*-5,robotic=FALSE)

	return .


/reagent/medicine/synthflesh
	name = "synthflesh"
	desc = "Experimental synthetic flesh. Significantly heals brute and burn damage of the affected limb instantly while dealing slight toxin damage. Also decreases natural healing regeneration delay."
	color = "#FFEBEB"
	flavor = "rotten flesh"
	metabolism_skin = 1
	value = 5
	liquid = -0.5
	alpha = 255

	experience_per_unit = 5


/reagent/medicine/synthflesh/on_splash(var/reagent_container/container,var/mob/caller,var/atom/target,var/volume_to_splash,var/strength_mod=1)

	. = ..()

	if(. && is_living(target))
		on_add(container,volume_to_splash*strength_mod,0)

	return .


/reagent/medicine/synthflesh/on_add(var/reagent_container/container,var/amount_added=0,var/current_volume=0)

	. = ..()

	if(current_volume == 0 && container.owner && container.owner.health) //Added for the first time.
		container.owner.health.adjust_loss_smart(brute=.*-10,burn=.*-10,tox=.,robotic=FALSE)
		. = 0

	return .


/reagent/medicine/synthflesh/on_metabolize_skin(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)

	. = ..()

	if(owner && owner.health)
		if(is_living(owner.loc))
			var/mob/living/L = owner.loc
			L.health_regen_delay = max(0,L.health_regen_delay - .*10)

	return .
