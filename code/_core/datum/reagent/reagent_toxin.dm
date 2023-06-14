/reagent/toxin/
	name = "toxin"
	desc = "A common toxin found nearly everywhere."
	color = "#FF8411"
	alpha = 200

	var/damage_per_unit = 1

	lethal = TRUE

	liquid = 0.5

	particle_size = 0.6

	flags_metabolism = REAGENT_METABOLISM_STOMACH | REAGENT_METABOLISM_BLOOD | REAGENT_METABOLISM_PLANT

/reagent/toxin/New(var/desired_loc)
	blood_toxicity_multiplier = damage_per_unit*5
	value *= 1+(damage_per_unit*3)
	return ..()

/reagent/toxin/on_metabolize_plant(var/obj/structure/interactive/plant/plant,var/reagent_container/container,var/amount_to_metabolize=0,var/starting_volume=0,var/multiplier=1)
	. = ..()
	plant?.health?.adjust_loss_smart(tox=-.*damage_per_unit*2*multiplier)

/reagent/toxin/on_metabolize_stomach(var/mob/living/owner,var/reagent_container/container,var/amount_to_metabolize=0,var/starting_volume=0,var/multiplier=1)
	. = ..()
	owner.tox_regen_buffer -= .*damage_per_unit*0.75*multiplier

/reagent/toxin/on_metabolize_blood(var/mob/living/owner,var/reagent_container/container,var/amount_to_metabolize=0,var/starting_volume=0,var/multiplier=1)
	. = ..()
	owner.tox_regen_buffer -= .*damage_per_unit*multiplier

/reagent/toxin/angel_toxin
	name = "angel toxin"
	desc = "An incredibly lethal toxin. Injecting this will make you see angels."

	damage_per_unit = 15

	flavor = "mushroom"

	particle_size = 0.4


/reagent/toxin/fly_amanita_toxin
	name = "fly amanita toxin"
	desc = "An moderately lethal toxin."

	damage_per_unit = 4

	flavor = "mushroom"

	particle_size = 0.5

/reagent/toxin/polypnium_toxin
	name = "polypnium toxin"
	desc = "An very lethal toxin."

	damage_per_unit = 10

	flavor = "mushroom"

	particle_size = 0.3

/reagent/toxin/xeno_acid
	name = "xeno acid"
	desc = "Literal fucking acid."

	damage_per_unit = 2

	flavor = "pain"

	particle_size = 0.3

/reagent/toxin/spider_toxin
	name = "spider toxin"
	desc = "Toxins bad."

	damage_per_unit = 3

	flavor = "arachnophobia"

	particle_size = 0.2

/reagent/toxin/sulfur_dioxide
	name = "Sulfur Dioxide"
	desc = "Toxic fumes from burning sulfur with coal."

	damage_per_unit = 1

	heated_reagent = /reagent/acid/sulphuric
	heated_reagent_temp = 600
	heated_reagent_amount = 1
	heated_reagent_mul = 0.01

	particle_size = 0.7

/reagent/toxin/mercury
	name = "mercury"
	desc = "Toxins bad."

	color = "#808080"
	alpha = 255

	damage_per_unit = 5

	flavor = "venus"

	particle_size = 1


/reagent/toxin/blob_spore
	name = "blob spores"
	desc = "Don't breathe this in."

	damage_per_unit = 2

	particle_size = 0.8

	color = "#A06300"