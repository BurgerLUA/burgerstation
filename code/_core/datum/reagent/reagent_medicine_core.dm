/reagent/medicine/bicaridine
	name = "Bicaridine"
	desc = "Red for brute."
	color = "#FF0000"
	alpha = 200

	flavor = "bandaids"

	metabolism_blood = 0.5
	metabolism_stomach = 0.25
	experience_per_unit = 2.5

	value = 0.75

	liquid = 0.6

	particle_size = 0.3

/reagent/medicine/bicaridine/on_metabolize_blood(var/mob/living/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()
	owner.brute_regen_buffer += 5*.

/reagent/medicine/bicaridine/on_metabolize_stomach(var/mob/living/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()
	owner.brute_regen_buffer += 4*.

/reagent/medicine/bicaridine_plus
	name = "Bicaridine+"
	color = "#FF0080"
	alpha = 225

	metabolism_blood = 0.5
	metabolism_stomach = 0.25
	experience_per_unit = 5

	value = 1.25

	particle_size = 0.4

/reagent/medicine/bicaridine_plus/on_metabolize_blood(var/mob/living/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()
	owner.brute_regen_buffer += 10*.

/reagent/medicine/bicaridine_plus/on_metabolize_stomach(var/mob/living/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()
	owner.brute_regen_buffer += 8*.

/reagent/medicine/caridone
	name = "Caridone"
	desc = "Red for brute."
	color = "#FFEB87"
	alpha = 200

	flavor = "bandaids"

	metabolism_blood = 0.2
	metabolism_stomach = 0.2
	experience_per_unit = 2

	value = 1

	liquid = 0.75

	particle_size = 0.3

/reagent/medicine/caridone/on_metabolize_blood(var/mob/living/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()
	owner.brute_regen_buffer += rand(1,10)*.

/reagent/medicine/caridone/on_metabolize_stomach(var/mob/living/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()
	owner.brute_regen_buffer += rand(1,10)*.

/reagent/medicine/percardone
	name = "Percardone"
	desc = "Red for brute."
	color = "#B200FF"
	alpha = 150

	flavor = "bandaids"

	metabolism_blood = 0.4
	metabolism_stomach = 0.4
	experience_per_unit = 4

	value = 1

	liquid = 0.5

	particle_size = 0.2

/reagent/medicine/percardone/on_metabolize_blood(var/mob/living/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()
	if(owner.health)
		owner.brute_regen_buffer += CEILING(1 + owner.health.damage[BRUTE]*0.01,1)*.

/reagent/medicine/percardone/on_metabolize_stomach(var/mob/living/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()
	if(owner.health)
		owner.brute_regen_buffer += CEILING(1 + owner.health.damage[BRUTE]*0.01,1)*.

/reagent/medicine/dicarditane
	name = "Dicarditane"
	desc = "Red for brute."
	color = "#E4FF00"
	alpha = 200

	flavor = "bandaids"

	metabolism_blood = 0.4
	metabolism_stomach = 0.4
	experience_per_unit = 4

	value = 1

	liquid = 0.5

	particle_size = 0.2

/reagent/medicine/dicarditane/on_metabolize_blood(var/mob/living/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()
	owner.brute_regen_buffer += 4*.
	owner.burn_regen_buffer += 2*.

/reagent/medicine/dicarditane/on_metabolize_stomach(var/mob/living/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()
	owner.brute_regen_buffer += 8*.*(owner.nutrition/1000)
	owner.burn_regen_buffer += 4*.*(owner.nutrition/1000)


/reagent/medicine/kelotane
	name = "Kelotane"
	desc = "Yellow for burn."
	color = "#FFFF00"
	alpha = 200

	flavor = "ointment"

	metabolism_blood = 0.5
	metabolism_stomach = 0.25
	experience_per_unit = 2.5

	value = 0.5

	particle_size = 0.4

/reagent/medicine/kelotane/on_metabolize_blood(var/mob/living/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()
	owner.burn_regen_buffer += 5*.

/reagent/medicine/kelotane/on_metabolize_stomach(var/mob/living/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()
	owner.burn_regen_buffer += 4*.

/reagent/medicine/arentane
	name = "Arentane"
	desc = "Red for brute."
	color = "#0080C9"
	alpha = 150

	flavor = "bandaids"

	metabolism_blood = 0.2
	metabolism_stomach = 0.2
	experience_per_unit = 2

	value = 0.75

	liquid = 0.75

	particle_size = 0.3

/reagent/medicine/arentane/on_metabolize_blood(var/mob/living/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()
	owner.burn_regen_buffer += rand(1,10)*.

/reagent/medicine/arentane/on_metabolize_stomach(var/mob/living/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()
	owner.burn_regen_buffer += rand(1,10)*.

/reagent/medicine/kenotone
	name = "Kenotone"
	desc = "Red for brute."
	color = "#0080C9"
	alpha = 225

	flavor = "bandaids"

	metabolism_blood = 0.2
	metabolism_stomach = 0.2
	experience_per_unit = 2

	value = 0.75

	liquid = 0.75

	particle_size = 0.3

/reagent/medicine/kenotone/on_metabolize_blood(var/mob/living/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()
	owner.burn_regen_buffer += rand(2,20)*.
	owner.tox_regen_buffer -= rand(1,10)*.
	owner.stamina_regen_buffer -= rand(1,10)*.

/reagent/medicine/kenotone/on_metabolize_stomach(var/mob/living/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()
	owner.burn_regen_buffer += rand(2,20)*.
	owner.tox_regen_buffer -= rand(1,10)*.
	owner.stamina_regen_buffer -= rand(1,10)*.

/reagent/medicine/extinatane
	name = "Extinatane"
	desc = "Red for brute."
	color = "#FFF0BF"
	alpha = 150

	flavor = "bandaids"

	metabolism_blood = 1
	metabolism_stomach = 1
	metabolism_skin = 10
	experience_per_unit = 2

	value = 1.5

	liquid = 0.5

	particle_size = 0.1

/reagent/medicine/extinatane/on_metabolize_skin(var/mob/living/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()
	if(container.owner.health && container.owner.health.organic)
		container.owner.health.adjust_loss_smart(burn=.*-2,robotic=FALSE)
		owner.burn_regen_buffer += 2*.
		owner.adjust_fire_stacks(-5*.)

/reagent/medicine/carotane
	name = "Carotane"
	desc = "Red for brute."
	color = "#808080"
	alpha = 225

	flavor = "bandaids"

	metabolism_blood = 0.1
	metabolism_stomach = 0.1
	experience_per_unit = 2

	value = 0.75

	liquid = 0.25

	particle_size = 0.5

/reagent/medicine/carotane/on_metabolize_blood(var/mob/living/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()
	var/mul = (container.stored_reagents[type]/starting_volume)
	owner.brute_regen_buffer += 5*.*mul
	owner.burn_regen_buffer += 5*.*mul

/reagent/medicine/carotane/on_metabolize_stomach(var/mob/living/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()
	var/mul = (container.stored_reagents[type]/starting_volume)
	owner.brute_regen_buffer += 5*.*mul
	owner.burn_regen_buffer += 5*.*mul

/reagent/medicine/dylovene
	name = "Dylovene"
	desc = "Green for toxin."
	color = "#00FF00"
	alpha = 200

	flavor = "sweetness"

	metabolism_blood = 0.5
	metabolism_stomach = 0.25
	experience_per_unit = 2.5

	value = 0.5

	particle_size = 0.2

/reagent/medicine/dylovene/on_metabolize_blood(var/mob/living/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()
	owner.tox_regen_buffer += ((owner.health ? owner.health.get_loss(TOX)*0.05 : 0) + 5)*.

/reagent/medicine/dylovene/on_metabolize_stomach(var/mob/living/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()
	owner.tox_regen_buffer += ((owner.health ? owner.health.get_loss(TOX)*0.04 : 0) + 4)*.

/reagent/medicine/dexalin
	name = "Dexalin"
	desc = "Blue for oxy."
	color = "#1111FF"
	alpha = 150

	flavor = "bitterness"

	metabolism_blood = 0.5
	metabolism_stomach = 0.25

	value = 0.5

	particle_size = 0.2

/reagent/medicine/dexalin/on_add_living(var/mob/living/L,var/reagent_container/container,var/amount_added=0,var/current_volume=0)
	. = ..()
	L.blood_oxygen += 0.2

/reagent/medicine/dexalin/on_remove_living(var/mob/living/L,var/reagent_container/container)
	. = ..()
	L.blood_oxygen -= 0.2

/reagent/medicine/tricordrazine
	name = "Tricordrazine"
	desc = "Heals everything except for oxygen loss."
	color = "#B21FFF"
	alpha = 225

	flavor = "sourness"

	metabolism_blood = 0.5
	metabolism_stomach = 0.25
	experience_per_unit = 4

	value = 0.75

	particle_size = 0.5

/reagent/medicine/tricordrazine/on_metabolize_blood(var/mob/living/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()
	owner.brute_regen_buffer += 4*.
	owner.burn_regen_buffer += 4*.
	owner.tox_regen_buffer += 4*.

/reagent/medicine/tricordrazine/on_metabolize_stomach(var/mob/living/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()
	owner.brute_regen_buffer += 3*.
	owner.burn_regen_buffer += 3*.
	owner.tox_regen_buffer += 3*.

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

	value = 1

	particle_size = 0.75

/reagent/medicine/omnizine/on_metabolize_blood(var/mob/living/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()
	owner.brute_regen_buffer += 3*.
	owner.burn_regen_buffer += 3*.
	owner.tox_regen_buffer += 3*.

/reagent/medicine/omnizine/on_metabolize_stomach(var/mob/living/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()
	owner.brute_regen_buffer += 3*.
	owner.burn_regen_buffer += 3*.
	owner.tox_regen_buffer += 3*.

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

	value = 500

	particle_size = 0

/reagent/medicine/adminomnizine/on_metabolize_blood(var/mob/living/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()
	owner.brute_regen_buffer = max(owner.brute_regen_buffer,500*.)
	owner.burn_regen_buffer = max(owner.burn_regen_buffer,500*.)
	owner.tox_regen_buffer = max(owner.tox_regen_buffer,500*.)
	owner.health_regen_delay = 0

/reagent/medicine/adminomnizine/on_metabolize_stomach(var/mob/living/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()
	owner.brute_regen_buffer = max(owner.brute_regen_buffer,500*.)
	owner.burn_regen_buffer = max(owner.burn_regen_buffer,500*.)
	owner.tox_regen_buffer = max(owner.tox_regen_buffer,500*.)
	owner.health_regen_delay = 0

/reagent/medicine/silver_sulfadiazine
	name = "Silver Sulfadiazine"
	desc = "Heals burn damage. Only works when applied to skin."
	desc_extended = ""
	color = "#E8BEED"
	alpha = 255

	flavor = "bitter silver"

	metabolism_skin = 1

	value = 1

	liquid = -0.5

	experience_per_unit = 5

	particle_size = 0.5

/reagent/medicine/silver_sulfadiazine/on_splash(var/reagent_container/container,var/mob/caller,var/atom/target,var/volume_to_splash,var/strength_mod=1)
	. = ..()
	if(.)
		on_add(container,volume_to_splash*strength_mod,0)

/reagent/medicine/silver_sulfadiazine/on_add(var/reagent_container/container,var/amount_added=0,var/current_volume=0)
	. = ..()
	if(current_volume == 0 && container.owner && container.owner.health && container.owner.health.organic) //Added for the first time.
		. *= 0.5
		container.owner.health.adjust_loss_smart(burn=.*-10,robotic=FALSE)
		if(is_organ(container.owner))
			var/obj/item/organ/O = container.owner
			O.send_pain(50)

/reagent/medicine/silver_sulfadiazine/on_metabolize_skin(var/mob/living/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()
	if(container.owner.health && container.owner.health.organic)
		container.owner.health.adjust_loss_smart(burn=.*-5,robotic=FALSE)
		owner.burn_regen_buffer += 3*.

/reagent/medicine/styptic_powder
	name = "Styptic Powder"
	desc = "Heals brute damage. Only works when applied to skin."
	desc_extended = ""
	color = "#FFC9DD"
	alpha = 255

	flavor = "baby powder"

	metabolism_skin = 1

	value = 1.25

	liquid = -0.5

	experience_per_unit = 5

	particle_size = 0.5

/reagent/medicine/styptic_powder/on_splash(var/reagent_container/container,var/mob/caller,var/atom/target,var/volume_to_splash,var/strength_mod=1)
	. = ..()
	if(. && is_living(target))
		on_add(container,volume_to_splash*strength_mod,0)

/reagent/medicine/styptic_powder/on_add(var/reagent_container/container,var/amount_added=0,var/current_volume=0)
	. = ..()
	if(current_volume == 0 && container.owner && container.owner.health && container.owner.health.organic) //Added for the first time.
		. *= 0.5
		container.owner.health.adjust_loss_smart(brute=.*-10,robotic=FALSE)
		if(is_organ(container.owner))
			var/obj/item/organ/O = container.owner
			O.send_pain(50)

/reagent/medicine/styptic_powder/on_metabolize_skin(var/mob/living/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()
	if(container.owner.health && container.owner.health.organic)
		container.owner.health.adjust_loss_smart(brute=.*-5,robotic=FALSE)
		owner.brute_regen_buffer += 3*.

/reagent/medicine/synthflesh
	name = "synthflesh"
	desc = "Experimental synthetic flesh. Significantly heals brute and burn damage of the affected limb instantly. Warning: Do not use on open cuts."
	color = "#FFEBEB"
	flavor = "rotten flesh"
	metabolism_skin = 1
	value = 1.5
	liquid = -0.5
	alpha = 255

	experience_per_unit = 5

	particle_size = 0.75


/reagent/medicine/synthflesh/on_splash(var/reagent_container/container,var/mob/caller,var/atom/target,var/volume_to_splash,var/strength_mod=1)

	. = ..()

	if(.)
		on_add(container,volume_to_splash*strength_mod,0)

/reagent/medicine/synthflesh/on_add(var/reagent_container/container,var/amount_added=0,var/current_volume=0)

	. = ..()

	if(current_volume == 0 && container.owner && container.owner.health && container.owner.health.organic) //Added for the first time.
		. *= 0.5
		var/tox_to_adjust = 0
		if(is_organ(container.owner))
			var/obj/item/organ/O = container.owner
			if(O.bleeding >= 0.5)
				tox_to_adjust = .*5
				O.bleeding = 0
				O.send_pain(50)
		container.owner.health.adjust_loss_smart(brute=.*-10,burn=.*-10,tox=tox_to_adjust,robotic=FALSE)

/reagent/medicine/synthflesh/on_metabolize_skin(var/mob/living/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()
	owner.brute_regen_buffer += .*2
	owner.burn_regen_buffer += .*2



/reagent/medicine/vitamins
	name = "space vitamins"
	desc = "All the essential vitamins as spaceman needs. Consume vitamins normalizes your nutrition to a healthy level. Note that taking too much is bad for you. Metabolizes slowly, and addictive."
	color = "#DCFF9B"
	alpha = 255

	flavor = "gummy vitamins"

	overdose_threshold = 20

	metabolism_blood = 1
	metabolism_stomach = 0.1
	experience_per_unit = 0

	value = 2

	liquid = 0.75

	particle_size = 0.2

	addiction_strength = 0.25
	addiction_threshold = 15
	addiction = /addiction/health

/reagent/medicine/vitamins/on_metabolize_blood(var/mob/living/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()
	//Injecting these vitamins is pretty bad and does nothing for you.
	owner.tox_regen_buffer -= .*2

/reagent/medicine/vitamins/on_metabolize_stomach(var/mob/living/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()
	owner.brute_regen_buffer += 1*.
	owner.burn_regen_buffer += 1*.
	owner.tox_regen_buffer += 1*.
	owner.add_nutrition_quality(30*.)
	owner.add_nutrition(4*.)