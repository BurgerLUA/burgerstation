//Stats gathered here: https://www.healthline.com/health/rarest-blood-type#rarest-type

/reagent/blood //Found through organic things
	name = "Rh Null Human Blood"
	desc = "What most lifeforms do things with."
	color = "#880000"
	alpha = 255

	flavor = "blood"
	flags_flavor = FLAG_FLAVOR_MEAT | FLAG_FLAVOR_RAW

	metabolism_blood = 10
	metabolism_stomach = 2

	overdose_threshold = 0

	liquid = 0.4

	particle_size = 0.25

	var/list/compatible_blood = list(/reagent/blood) //If a mob has this blood type, what can it receive without poison?

	value = 0.5

	blood_toxicity_multiplier = 0

	flags_metabolism = REAGENT_METABOLISM_STOMACH | REAGENT_METABOLISM_BLOOD

/reagent/blood/on_metabolize_stomach(var/mob/living/owner,var/reagent_container/container,var/amount_to_metabolize=0,var/starting_volume=0,var/multiplier=1)
	. = ..()
	owner.add_nutrition(2*.) //Blood is actually nutritious.

/reagent/blood/on_metabolize_blood(var/mob/living/owner,var/reagent_container/container,var/amount_to_metabolize=0,var/starting_volume=0,var/multiplier=1)

	. = ..()

	if(owner.blood_type)
		var/reagent/blood/R = REAGENT(owner.blood_type)
		if(R.compatible_blood[src.type])
			owner.blood_volume += .*multiplier
		else
			owner.blood_volume += . *0.5*multiplier
			owner.tox_regen_buffer += .*0.5*multiplier
			owner.blood_toxicity += .
		QUEUE_HEALTH_UPDATE(owner)

/reagent/blood/human/ab_negative
	name = "AB Negative Human Blood"

	compatible_blood = list(
		/reagent/blood/human/o_negative = TRUE,
		/reagent/blood/human/b_negative = TRUE,
		/reagent/blood/human/a_negative = TRUE,
		/reagent/blood/human/ab_negative = TRUE,
		/reagent/blood/ancient = TRUE
	)

/reagent/blood/human/b_negative
	name = "B Negative Human Blood"

	compatible_blood = list(
		/reagent/blood/human/b_negative = TRUE,
		/reagent/blood/human/o_negative = TRUE,
		/reagent/blood/ancient = TRUE
	)

/reagent/blood/human/ab_positive
	name = "AB Positive Human Blood"

	compatible_blood = list(
		/reagent/blood/human/ab_negative = TRUE,
		/reagent/blood/human/b_negative = TRUE,
		/reagent/blood/human/ab_positive = TRUE,
		/reagent/blood/human/a_negative = TRUE,
		/reagent/blood/human/o_negative = TRUE,
		/reagent/blood/human/b_positive = TRUE,
		/reagent/blood/human/a_positive = TRUE,
		/reagent/blood/human/o_positive = TRUE,
		/reagent/blood/ancient = TRUE
	)

/reagent/blood/human/a_negative
	name = "A Negative Human Blood"

	compatible_blood = list(
		/reagent/blood/human/a_negative = TRUE,
		/reagent/blood/human/o_negative = TRUE,
		/reagent/blood/ancient = TRUE
	)

/reagent/blood/human/o_negative
	name = "O Negative Human Blood"

	compatible_blood = list(
		/reagent/blood/human/o_negative = TRUE,
		/reagent/blood/ancient = TRUE
	)

/reagent/blood/human/b_positive
	name = "B Positive Human Blood"

	compatible_blood = list(
		/reagent/blood/human/b_positive = TRUE,
		/reagent/blood/human/b_negative = TRUE,
		/reagent/blood/human/o_negative = TRUE,
		/reagent/blood/human/o_positive = TRUE,
		/reagent/blood/ancient = TRUE
	)

/reagent/blood/human/a_positive
	name = "A Positive Human Blood"

	compatible_blood = list(
		/reagent/blood/human/a_negative = TRUE,
		/reagent/blood/human/a_positive = TRUE,
		/reagent/blood/human/o_negative = TRUE,
		/reagent/blood/human/o_positive = TRUE,
		/reagent/blood/ancient = TRUE
	)

/reagent/blood/human/o_positive
	name = "O Positive Human Blood"

	compatible_blood = list(
		/reagent/blood/human/o_negative = TRUE,
		/reagent/blood/human/o_positive = TRUE,
		/reagent/blood/ancient = TRUE
	)

/reagent/blood/robot
	name = "Robot Oil"

	compatible_blood = list(
		/reagent/blood/robot = TRUE,
		/reagent/blood/ancient = TRUE
	)

	color = COLOR_BLACK

/reagent/blood/xeno
	name = "Xeno Blood"

	compatible_blood = list(
		/reagent/blood/xeno = TRUE
	)

	color = "#B6FF00"

/reagent/blood/reptile
	name = "Reptile Blood"

	compatible_blood = list(
		/reagent/blood/reptile = TRUE,
		/reagent/blood/ancient = TRUE
	)

	color = "#88002B"

/reagent/blood/goliath
	name = "Goliath Blood"

	compatible_blood = list(
		/reagent/blood/ancient = TRUE
	)

	color = "#AE0000"


/reagent/blood/ancient
	name = "Ancient Blood"

	compatible_blood = list(
		/reagent/blood/ancient = TRUE
	)

	color = "#AE0000"

/reagent/blood/ancient/on_metabolize_blood(var/mob/living/owner,var/reagent_container/container,var/amount_to_metabolize=0,var/starting_volume=0,var/multiplier=1)
	.=..()
	owner.add_status_effect(DRUGGY)
	owner.add_status_effect(CONFUSED)
	owner.brute_regen_buffer += .*3*multiplier
	owner.burn_regen_buffer += .*2*multiplier
	owner.pain_regen_buffer += .*5*multiplier
	owner.add_hydration(.*-5*multiplier)
	owner.intoxication += 12*.*multiplier
	owner.sanity_regen_buffer -= 12*.*multiplier

/reagent/blood/alien/red
	name = "Red Alien Blood"

	compatible_blood = list(
		/reagent/blood/alien = TRUE
	)

	color = "#C12E3E"

/reagent/blood/alien/green
	name = "Green Alien Blood"

	compatible_blood = list(
		/reagent/blood/alien = TRUE
	)

	color = "#47A228"


/reagent/blood/bat
	name = "Bat Blood"

	compatible_blood = list(
		/reagent/blood/bat = TRUE
	)

	color = "#AE0000"

/reagent/blood/bear
	name = "Bear Blood"

	compatible_blood = list(
		/reagent/blood/bear = TRUE
	)

	color = "#AE0000"

/reagent/blood/cow
	name = "Cow Blood"

	compatible_blood = list(
		/reagent/blood/cow = TRUE
	)

	color = "#AE0000"

/reagent/blood/blob
	name = "Blob Blood"

	compatible_blood = list(
		/reagent/blood/blob = TRUE
	)

	color = "#DDB233"

/reagent/blood/carp
	name = "Carp Blood"

	compatible_blood = list(
		/reagent/blood/carp = TRUE
	)

	color = "#AF2A42"

/reagent/blood/cat
	name = "Cat Blood"

	compatible_blood = list(
		/reagent/blood/cat = TRUE
	)

	color = "#AE0000"


/reagent/blood/clown
	name = "Clown Blood"

	compatible_blood = list(
		/reagent/blood/clown = TRUE
	)

	color = "#AE0000"

/reagent/blood/crab
	name = "Crab Blood"

	compatible_blood = list(
		/reagent/blood/crab = TRUE
	)

	color = "#AE0000"

/reagent/blood/unholy
	name = "Unholy Blood"

	compatible_blood = list(
		/reagent/blood/unholy = TRUE
	)

	color = "#520000"

/reagent/blood/insect
	name = "Insect Blood"

	compatible_blood = list(
		/reagent/blood/insect = TRUE
	)

	color = "#B6FF00"

/reagent/blood/bird
	name = "Bird Blood"

	compatible_blood = list(
		/reagent/blood/bird = TRUE
	)

	color = "#AE0000"

/reagent/blood/spider
	name = "Spider Blood"

	compatible_blood = list(
		/reagent/blood/spider = TRUE
	)

	color = "#D9D500"

/reagent/blood/plant
	name = "Plant Blood"

	compatible_blood = list(
		/reagent/blood/plant = TRUE
	)

	heated_reagent = /reagent/medicine/mitogen
	heated_reagent_temp = 300
	heated_reagent_amount = 0
	heated_reagent_mul = 0.01

	color = "#A5FF7F"

/reagent/blood/chicken
	name = "Chicken Blood"

	compatible_blood = list(
		/reagent/blood/chicken = TRUE
	)

	color = "#AE0000"

/reagent/blood/mouse
	name = "Mouse Blood"

	compatible_blood = list(
		/reagent/blood/mouse = TRUE
	)

	color = "#AE0000"

/reagent/blood/goblin
	name = "Goblin Blood"

	compatible_blood = list(
		/reagent/blood/goblin = TRUE
	)

	color = "#AE3700"

/reagent/blood/gutlunch
	name = "Gutlunch Blood"

	compatible_blood = list(
		/reagent/blood/gutlunch = TRUE
	)

	color = "#52001C"

/reagent/blood/rat
	name = "Rat Blood"

	compatible_blood = list(
		/reagent/blood/rat = TRUE
	)

	color = "#932B1C"