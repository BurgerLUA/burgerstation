/reagent/nutrition/chanterelle
	name = "chanterelle"
	desc = "Nutrition and flavor from a chanterelle mushroom."
	color = "#FFDD8F"

	nutrition_fast_amount = 1
	nutrition_normal_amount = 4
	nutrition_quality_amount = 5

	flavor = "mushroom"

	liquid = -0.2

	particle_size = 0.6

/reagent/nutrition/porcini
	name = "porcini"
	desc = "Nutrition and flavor from a porcini mushroom."
	color = "#68593E"

	nutrition_fast_amount = 1
	nutrition_normal_amount = 3
	nutrition_quality_amount = 6

	flavor = "roasted mushroom"

	liquid = -0.4

	particle_size = 0.4

/reagent/nutrition/tomato
	name = "tomato paste"
	desc = "Nutrition and flavor from a tomato."
	color = "#C90000"

	nutrition_fast_amount = 0
	nutrition_normal_amount = 5
	nutrition_quality_amount = 5

	flavor = "tomato"

	liquid = 0.3

	particle_size = 0.4

/reagent/nutrition/mustard
	name = "mustard paste"
	desc = "Nutrition and flavor from mustard seeds."
	color = "#EAC300"

	nutrition_fast_amount = 1
	nutrition_normal_amount = 3
	nutrition_quality_amount = 6

	flavor = "mustard"

	liquid = 0.1

	particle_size = 0.4

/reagent/nutrition/pineapple
	name = "pineapple"
	desc = "Nutrition and flavor from a pineapple."
	color = "#C90000"

	nutrition_fast_amount = 2
	nutrition_normal_amount = 5
	nutrition_quality_amount = 3

	flavor = "pineapple"

	liquid = 0.5

	particle_size = 0.6

/reagent/nutrition/cabbage
	name = "cabbage"
	desc = "Nutrition and flavor from a cabbage."
	color = "#658268"

	nutrition_fast_amount = 0
	nutrition_normal_amount = 3
	nutrition_quality_amount = 7

	flavor = "cabbage"

	liquid = 0

	particle_size = 0.7

/reagent/nutrition/lettuce
	name = "lettuce"
	desc = "Nutrition and flavor from lettuce."
	color = "#5AAF36"

	nutrition_fast_amount = 0
	nutrition_normal_amount = 4
	nutrition_quality_amount = 6

	flavor = "lettuce"

	liquid = 0

	particle_size = 0.7

/reagent/nutrition/coconut
	name = "coconut"
	desc = "Nutrition and flavor from a coconut."
	color = "#658268"

	nutrition_fast_amount = 3
	nutrition_normal_amount = 4
	nutrition_quality_amount = 3

	flavor = "coconut"

	liquid = -0.25

	particle_size = 0.6


/reagent/nutrition/nut
	name = "treenut"
	desc = "Nutrition and flavor from a treenut."
	color = "#658268"

	nutrition_fast_amount = 4
	nutrition_normal_amount = 3
	nutrition_quality_amount = 3

	flavor = "nut"

	liquid = -0.5

	particle_size = 0.8

/reagent/nutrition/nut/butter
	name = "nut butter"
	desc = "Nutrition and flavor from nut butter."
	color = "#658268"

	nutrition_fast_amount = 7
	nutrition_normal_amount = 0
	nutrition_quality_amount = 3

	flavor = "nut butter"

	liquid = 0.25

	particle_size = 0.4


/reagent/nutrition/flower_petal
	name = "flower petal"
	desc = "Nutrition and flavor from a flower petal."
	color = "#965A33"

	nutrition_fast_amount = 1
	nutrition_normal_amount = 1
	nutrition_quality_amount = 1

	flags_flavor = FLAG_FLAVOR_GROSS

	flavor = "dirt"

	liquid = 0

	particle_size = 0.7

/reagent/nutrition/poppy_seed
	name = "poppy seed"
	desc = "Opium-free washed poppy seeds."
	color = "#511500"

	nutrition_fast_amount = 2
	nutrition_normal_amount = 2
	nutrition_quality_amount = 5

	flavor = "poppy seeds"

	liquid = 0

	particle_size = 0.3

/reagent/nutrition/poppy_seed/raw
	name = "raw poppy seed"
	desc = "Pure unrefined poppy seeds. It's unwashed and contains traces of opium."

	processed_reagent = /reagent/medicine/painkiller/opium

	particle_size = 0.4

	lethal = TRUE


/reagent/nutrition/poppy_seed/raw/on_metabolize_stomach(var/mob/living/owner,var/reagent_container/container,var/amount_to_metabolize=0,var/starting_volume=0,var/multiplier=1)

	. = ..()

	if(prob(10))
		. *= 0.5
		container.add_reagent(processed_reagent,.)

/reagent/nutrition/poppy_seed/raw/on_metabolize_blood(var/mob/living/owner,var/reagent_container/container,var/amount_to_metabolize=0,var/starting_volume=0,var/multiplier=1)

	. = ..()

	if(prob(10))
		. *= 0.5
		container.add_reagent(processed_reagent,.)

/reagent/nutrition/lipolicide
	name = "lipolicide"
	desc = "Plant-based nutrition-eating germs."
	color = "#511500"

	nutrition_fast_amount = -5
	nutrition_normal_amount = -10
	nutrition_quality_amount = -15

	flavor = "hunger"

	liquid = -0.1

	particle_size = 0.1

/reagent/nutrition/potato
	name = "potato"
	desc = "Nutrition and flavor from potatoes."
	color = "#FFFFEA"

	nutrition_fast_amount = 3
	nutrition_normal_amount = 6
	nutrition_quality_amount = 1

	flavor = "ground apples"

	liquid = 0

	particle_size = 0.8


/reagent/nutrition/cactus
	name = "cactus"
	desc = "Nutrition and flavor from cacti."
	color = "#5AFF36"

	nutrition_fast_amount = 0
	nutrition_normal_amount = 4
	nutrition_quality_amount = 1
	hydration_amount = 10

	flavor = "crunchy water"

	liquid = 0

	particle_size = 0.1


/reagent/nutrition/capsaicin
	name = "capsaicin"
	desc = "The pain juice."
	color = "#EF3232"

	nutrition_fast_amount = 1
	nutrition_normal_amount = 6
	nutrition_quality_amount = 3
	hydration_amount = -5

	flavor = "hurting"

	liquid = 0

	particle_size = 0.2

	lethal = TRUE

	metabolism_skin = 10

/reagent/nutrition/capsaicin/on_metabolize_stomach(var/mob/living/owner,var/reagent_container/container,var/amount_to_metabolize=0,var/starting_volume=0,var/multiplier=1)
	. = ..()
	owner.pain_regen_buffer += -.*multiplier
	owner.send_pain_response(.*multiplier)


/reagent/nutrition/capsaicin/on_metabolize_blood(var/mob/living/owner,var/reagent_container/container,var/amount_to_metabolize=0,var/starting_volume=0,var/multiplier=1)

	. = ..()
	owner.pain_regen_buffer += -. * 0.5*multiplier
	owner.send_pain_response(. * 0.5*multiplier)

/reagent/nutrition/capsaicin/on_metabolize_skin(var/mob/living/owner,var/reagent_container/container,var/amount_to_metabolize=0,var/starting_volume=0,var/multiplier=1)

	. = ..()
	owner.pain_regen_buffer += -.*multiplier
	owner.send_pain_response(.*multiplier)
