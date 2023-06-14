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
	heated_reagent_temp = 700
	heated_reagent_amount = 0
	heated_reagent_mul = 0.01

/reagent/wood
	name = "Wood"
	desc = "What most wooden things are made out of."
	color = "#6B5546"
	alpha = 255

	flavor = "sawdust"

	liquid = -0.25

	heated_reagent = /reagent/carbon
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

	flags_metabolism = REAGENT_METABOLISM_STOMACH | REAGENT_METABOLISM_BLOOD

/reagent/iron/act_explode(var/reagent_container/container,var/atom/owner,var/atom/source,var/atom/epicenter,var/magnitude,var/desired_loyalty_tag) //What happens when this reagent is hit by an explosive.
	var/volume_amount = -container.add_reagent(src.type,-container.volume_current,caller = owner) //Can't be bothered to get the exact amount needed to be removed as it is handled in the proc anyways.
	var/shrapnel_amount = min(20,CEILING(volume_amount/3,1))
	container.owner.shoot_projectile(
		owner,
		epicenter,
		null,
		null,
		/obj/projectile/bullet/firearm/shotgun_pellet,
		/damagetype/ranged/shrapnel,
		16,
		16,
		4,
		TILE_SIZE*0.5,
		shrapnel_amount,
		"#FFFFFF",
		0,
		1,
		null,
		desired_loyalty_tag,
		0,
		1
	)


/reagent/iron/on_metabolize_blood(var/mob/living/owner,var/reagent_container/container,var/amount_to_metabolize=0,var/starting_volume=0,var/multiplier=1)

	. = ..()

	if(owner.blood_type)
		owner.blood_volume += .*4*multiplier
		owner.tox_regen_buffer -= . * 0.5
		QUEUE_HEALTH_UPDATE(owner)

/reagent/iron/on_metabolize_stomach(var/mob/living/owner,var/reagent_container/container,var/amount_to_metabolize=0,var/starting_volume=0,var/multiplier=1)

	. = ..()

	if(owner.blood_type)
		owner.blood_volume += .*2*multiplier
		QUEUE_HEALTH_UPDATE(owner)

/reagent/steel
	name = "Steel"
	desc = "What most lifeforms build weapons out of."
	color = COLOR_STEEL
	alpha = 255

	flavor = "metal"

	liquid = -0.25

/reagent/plasteel
	name = "Plasteel"
	desc = "What most lifeforms build advanced weapons out of."
	color = COLOR_PLASTEEL
	alpha = 255

	flavor = "plastic"

	liquid = -0.25

/reagent/copper
	name = "Copper"
	desc = "What most lifeforms build low-level currency out of."
	color = "#DD842F"
	alpha = 255

	flavor = "copper"

	liquid = -0.25

/reagent/diamond
	name = "Diamond"
	desc = "What most lifeforms build high-level currency out of."
	color = "#D9FFFF"
	alpha = 255

	flavor = "expenses"

	liquid = -0.25

/reagent/silver
	name = "Silver"
	desc = "What most lifeforms build weapons out of."
	color = COLOR_SILVER
	alpha = 255

	flavor = "metal"

	liquid = -0.25

/reagent/platinum
	name = "Platinum"
	desc = "What most lifeforms build high-level currency out of."
	color = COLOR_PLATINUM
	alpha = 255

	flavor = "metal"

	liquid = -0.25

/reagent/gold
	name = "Gold"
	desc = "What most lifeforms build high-level currency out of."
	color = COLOR_GOLD
	alpha = 255

	flavor = "metal"

	liquid = -0.25

/reagent/brass
	name = "Brass"
	desc = "What most lifeforms build pipes out of."
	color = "#e7a831"
	alpha = 255

	flavor = "metal"

	liquid = -0.25

/reagent/titanium
	name = "Titanium"
	desc = "What most lifeforms build weapons out of."
	color = COLOR_TITANIUM
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

/reagent/nitrogen //Found in the snow biome as a magic plant
	name = "Liquid Nitrogen"
	desc = "What most lifeforms also breathe in but don't really use."
	color = "#D9E2E2"
	alpha = 200
	value = 3
	flavor = "cold"

	liquid = 0.25

/reagent/silicon //Found while mining silicon ore deposits
	name = "Silicon"
	desc = "What most lifeforms do things with."
	color = COLOR_BLACK
	alpha = 225
	value = 2
	flavor = "dildos"

	liquid = -0.25

/reagent/potassium //Found through potash
	name = "Potassium"
	desc = "What most lifeforms do things with."
	color = "#ADADAD"
	alpha = 255
	value = 2
	flavor = "bananas"

	flavor_strength = 6

	liquid = -0.25

	value = 2

/reagent/salt
	name = "ionized table salt"
	desc = "Down here, everything is salt."
	color = "#FFFFF4"
	alpha = 235
	value = 1.5
	flavor = "salt"
	flavor_strength = 4

	liquid = -0.9

	flags_metabolism = REAGENT_METABOLISM_STOMACH

/reagent/salt/on_metabolize_stomach(var/mob/living/owner,var/reagent_container/container,var/amount_to_metabolize=0,var/starting_volume=0,var/multiplier=1)
	. = ..()
	owner.add_hydration(.*-5*multiplier)

/reagent/salt/sodium_chloride
	name = "sodium chloride"
	desc = "The purest form of salt. Harvested only from the saltiest of Burgerstation players."
	color = "#FFFFFF"
	alpha = 255
	value = 2
	flavor = "disgusting salt"
	flavor_strength = 10

	liquid = -1


/reagent/ash
	name = "Ash"
	desc = "Ash from burning organic things."
	color = "#A0A0A0"
	alpha = 255
	value = 2
	flavor = "ash"
	flavor_strength = 3

	liquid = -0.9

/reagent/ammonia
	name = "Liquid Ammonia"
	desc = "Ammonia from lifeforms."
	alpha = 200
	value = 2
	color = "#EFEFEF"

	flavor = "ammonia"
	flavor_strength = 2

	liquid = 0.9

/reagent/sulfur
	name = "Sulfur"
	desc = "Sulfur from hell."
	alpha = 200
	value = 2
	color = "#FFD800"

	flavor = "sewer"
	flavor_strength = 8

	liquid = -0.75

/reagent/chlorine
	name = "Chlorine"
	desc = "Chlorine from planets."
	alpha = 200

	color = "#C1D689"
	value = 2.5

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

	blood_toxicity_multiplier = -0.5 //A meme, but whatever.

	lethal = TRUE

	flags_metabolism = REAGENT_METABOLISM_STOMACH | REAGENT_METABOLISM_BLOOD | REAGENT_METABOLISM_SKIN

/reagent/space_cleaner/on_metabolize_stomach(var/mob/living/owner,var/reagent_container/container,var/amount_to_metabolize=0,var/starting_volume=0,var/multiplier=1)

	. = ..()

	owner.tox_regen_buffer -= .*2*multiplier

/reagent/space_cleaner/on_metabolize_blood(var/mob/living/owner,var/reagent_container/container,var/amount_to_metabolize=0,var/starting_volume=0,var/multiplier=1)

	. = ..()

	owner.tox_regen_buffer -= .*4*multiplier

/reagent/space_cleaner/on_splash(var/reagent_container/container,var/mob/caller,var/atom/target,var/volume_to_splash,var/strength_mod=1)

	. = ..()

	if(.)
		if(is_turf(target))
			var/turf/T = target
			var/cleaning_power = volume_to_splash*10*strength_mod
			for(var/obj/effect/cleanable/C in T.contents)
				if(cleaning_power <= 0)
					break
				qdel(C)
				cleaning_power -= 10
		else if(is_advanced(target))
			var/cleaning_power = volume_to_splash*strength_mod
			var/mob/living/advanced/A = target
			A.make_clean(clean_strength=cleaning_power)

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
	value = 2.5
	flavor = "bitterness"
	flavor_strength = 5

	liquid = -0.5

