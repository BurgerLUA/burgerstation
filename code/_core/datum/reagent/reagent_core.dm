/reagent/lube //Found through organic things
	name = "Space Lube"
	desc = "Lube in space!"
	color = "#B6F0FF"
	alpha = 150

	flavor = "cherries"
	flavor_strength = 2

	liquid = 2

	value = 2

	particle_size = 0.1


/reagent/lube/on_splash(var/reagent_container/container,var/mob/caller,var/atom/target,var/volume_to_splash,var/strength_mod=1)

	. = ..()

	if(. && is_simulated(target))
		var/turf/simulated/S = target
		S.add_wet(volume_to_splash*100*strength_mod)

/reagent/carbon //Found while mining carbon ore deposits. Or burning food.
	name = "Carbon"
	desc = "What most lifeforms are made out of."
	color = "#000000"
	alpha = 255

	flavor = "burnt food"

	liquid = -0.75

	heated_reagent = /reagent/ash
	heated_reagent_temp = 600
	heated_reagent_amount = 0
	heated_reagent_mul = 0.01

/reagent/iron //Found while mining iron ore deposits
	name = "Iron"
	desc = "What most lifeforms build weapons out of."
	color = COLOR_IRON
	alpha = 255

	flavor = "iron"

	liquid = -0.25

	overdose_threshold = 40

/reagent/iron/on_metabolize_blood(var/mob/living/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)

	. = ..()

	if(owner.blood_type)
		owner.blood_volume = clamp(owner.blood_volume + .*4,0,owner.blood_volume_max)
		owner.queue_health_update = TRUE
		owner.tox_regen_buffer -= . * 0.5

/reagent/iron/on_metabolize_stomach(var/mob/living/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)

	. = ..()

	if(owner.blood_type)
		owner.blood_volume = clamp(owner.blood_volume + .*2,0,owner.blood_volume_max)
		owner.queue_health_update = TRUE

/reagent/steel
	name = "Steel"
	desc = "What most lifeforms build weapons out of."
	color = COLOR_STEEL
	alpha = 255

	flavor = "steel"

	liquid = -0.25

/reagent/copper
	name = "Copper"
	desc = "What most lifeforms build low-level currency out of."
	color = "#DD842F"
	alpha = 255

	flavor = "copper"

	liquid = -0.25

/reagent/silver
	name = "Silver"
	desc = "What most lifeforms build weapons out of."
	color = COLOR_SILVER
	alpha = 255

	flavor = "metal"

	liquid = -0.25

/reagent/aluminium
	name = "Aluminium"
	desc = "What most lifeforms build weapons out of."
	color = COLOR_SILVER
	alpha = 255

	flavor = "metal"

	liquid = -0.25

/reagent/oxygen //Found in the snow biome as a magic plant
	name = "Liquid Oxygen"
	desc = "What most lifeforms breathe in.."
	color = "#E6F2F2"
	alpha = 200

	flavor = "oxygen"

	liquid = 0.25

/reagent/nitrogen //Found in the snow biome as a magic plant
	name = "Liquid Nitrogen"
	desc = "What most lifeforms also breathe in but don't really use."
	color = "#D9E2E2"
	alpha = 200

	flavor = "cold"

	liquid = 0.25

/reagent/silicon //Found while mining silicon ore deposits
	name = "Silicon"
	desc = "What most lifeforms do things with."
	color = COLOR_BLACK
	alpha = 225

	flavor = "dildos"

	liquid = -0.25

/reagent/potassium //Found through potash
	name = "Potassium"
	desc = "What most lifeforms do things with."
	color = "#ADADAD"
	alpha = 255

	flavor = "bananas"

	flavor_strength = 6

	liquid = -0.25

	value = 4

/reagent/salt
	name = "ionized table salt"
	desc = "Down here, everything is salt."
	color = "#FFFFF4"
	alpha = 235

	flavor = "salt"
	flavor_strength = 4

	liquid = -0.9

/reagent/salt/on_metabolize_stomach(var/mob/living/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()
	owner.add_hydration(.*-5)

/reagent/salt/sodium_chloride
	name = "sodium chloride"
	desc = "The purest form of salt. Harvested only from the saltiest of Burgerstation players."
	color = "#FFFFFF"
	alpha = 255

	flavor = "disgusting salt"
	flavor_strength = 10

	liquid = -1


/reagent/ash
	name = "Ash"
	desc = "Ash from burning organic things."
	color = "#A0A0A0"
	alpha = 255

	flavor = "ash"
	flavor_strength = 3

	liquid = -0.9

/reagent/ammonia
	name = "Liquid Ammonia"
	desc = "Ammonia from lifeforms."
	alpha = 200

	color = "#EFEFEF"

	flavor = "ammonia"
	flavor_strength = 2

	liquid = 0.9

/reagent/sulfur
	name = "Sulfur"
	desc = "Sulfur from hell."
	alpha = 200

	color = "#FFD800"

	flavor = "sewer"
	flavor_strength = 8

	liquid = -0.75

/reagent/chlorine
	name = "Chlorine"
	desc = "Chlorine from planets."
	alpha = 200

	color = "#C1D689"

	flavor = "chlorine"
	flavor_strength = 8

	liquid = 0



/reagent/space_cleaner
	name = "space cleaner"
	desc = "Cleans 10 times faster that regular water! BLAM! Space Cleaner!"
	color = "#66E1FF"
	alpha = 150

	flavor = "bleach"
	flavor_strength = 5

	liquid = 0.4

/reagent/space_cleaner/on_metabolize_stomach(var/mob/living/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)

	. = ..()

	owner.tox_regen_buffer += .*1

/reagent/space_cleaner/on_metabolize_blood(var/mob/living/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)

	. = ..()

	owner.tox_regen_buffer += .*2

/reagent/space_cleaner/on_splash(var/reagent_container/container,var/mob/caller,var/atom/target,var/volume_to_splash,var/strength_mod=1)

	. = ..()

	if(. && isturf(target))
		var/turf/T = target
		var/cleaning_power = volume_to_splash*10*strength_mod
		for(var/obj/effect/cleanable/C in T.contents)
			if(cleaning_power <= 0)
				break
			qdel(C)
			cleaning_power -= 10

/reagent/phenol
	name = "Phenol"
	desc = "A corrosive flammable solid used as a component in most recipes. Works as a good disinfectant."
	color = "#FFFFFF"
	alpha = 200

	flavor = "acid"
	flavor_strength = 5

	liquid = -0.5

/reagent/saltpetre
	name = "Saltpere"
	desc = ""
	color = "#FFFFFF"
	alpha = 200

	flavor = "acid"
	flavor_strength = 5

	liquid = -0.5

/reagent/lye
	name = "Lye"
	desc = ""
	color = "#FFFFFF"
	alpha = 200

	flavor = "acid"
	flavor_strength = 5

	liquid = -0.5

/reagent/sodium
	name = "Sodium"
	desc = ""
	color = "#FFFFFF"
	alpha = 200

	flavor = "acid"
	flavor_strength = 5

	liquid = -0.5

/reagent/phosphorous
	name = "phosphorous"
	desc = ""
	color = "#FFFFFF"
	alpha = 250

	flavor = "bitterness"
	flavor_strength = 5

	liquid = -0.5

/reagent/tobacco
	name = "Tobacco"
	desc = "Space Tobacco grown on space plantations."
	color = "#63391C"
	alpha = 255

	flavor = "tobacco"
	flavor_strength = 10

	liquid = -0.75

	var/hidden_chance = 0
	var/list/hidden_reagents = list()

	metabolism_blood = 0.5
	metabolism_stomach = 0.5
	metabolism_skin = 10

/reagent/tobacco/on_metabolize_blood(var/mob/living/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)

	. = ..()

	if(container)
		var/reagent/R = /reagent/medicine/nicotine
		if(hidden_chance && prob(hidden_chance))
			R = pickweight(hidden_reagents)
		container.add_reagent(R,.)

/reagent/tobacco/cigarette
	name = "Low-grade Tobacco"
	flavor = "cheap tobacco"
	hidden_chance = 25
	hidden_reagents = list(
		/reagent/fuel/welding = 25,
		/reagent/fuel/acetone = 10,
		/reagent/ammonia = 10,
		/reagent/toxin/spider_toxin = 1,
		/reagent/toxin/xeno_acid = 1
	)

/reagent/hydrogen_peroxide
	name = "hydrogen peroxide"
	color = "#FFFFFF"

	alpha = 100

