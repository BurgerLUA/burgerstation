/reagent/nutrition/chanterelle
	name = "chanterelle"
	desc = "Nutrition and flavor from a chanterelle mushroom."
	color = "#FFDD8F"

	nutrition_amount = 7
	nutrition_quality_amount = 2

	flavor = "mushroom"

	liquid = -0.2

	particle_size = 0.6

/reagent/nutrition/porcini
	name = "porcini"
	desc = "Nutrition and flavor from a porcini mushroom."
	color = "#444444"

	nutrition_amount = 7
	nutrition_quality_amount = 6

	flavor = "roasted mushroom"

	liquid = -0.4

	particle_size = 0.4

/reagent/nutrition/tomato
	name = "tomato paste"
	desc = "Nutrition and flavor from a tomato."
	color = "#C90000"

	nutrition_amount = 6
	nutrition_quality_amount = 2

	flavor = "tomato"

	liquid = 0.3

	particle_size = 0.4

/reagent/nutrition/mustard
	name = "mustard paste"
	desc = "Nutrition and flavor from mustard seeds."
	color = "#EAC300"

	nutrition_amount = 6
	nutrition_quality_amount = 2

	flavor = "mustard"

	liquid = 0.1

	particle_size = 0.4

/reagent/nutrition/pineapple
	name = "pineapple"
	desc = "Nutrition and flavor from a pineapple."
	color = "#C90000"

	nutrition_amount = 8
	nutrition_quality_amount = 1

	flavor = "pineapple"

	liquid = 0.5

	particle_size = 0.6

/reagent/nutrition/cabbage
	name = "cabbage"
	desc = "Nutrition and flavor from a cabbage."
	color = "#658268"

	nutrition_amount = 8
	nutrition_quality_amount = 8

	flavor = "cabbage"

	liquid = 0

	particle_size = 0.7

/reagent/nutrition/lettuce
	name = "lettuce"
	desc = "Nutrition and flavor from lettuce."
	color = "#5AAF36"

	nutrition_amount = 6
	nutrition_quality_amount = 5

	flavor = "lettuce"

	liquid = 0

	particle_size = 0.7

/reagent/nutrition/coconut
	name = "coconut"
	desc = "Nutrition and flavor from a coconut."
	color = "#658268"

	nutrition_amount = 15
	nutrition_quality_amount = 2

	flavor = "coconut"

	liquid = -0.25

	particle_size = 0.6


/reagent/nutrition/nut
	name = "nut"
	desc = "Nutrition and flavor from a nut."
	color = "#658268"

	nutrition_amount = 12
	nutrition_quality_amount = 2

	flavor = "nut"

	liquid = -0.5

	particle_size = 0.8

/reagent/nutrition/nut/butter
	name = "nut butter"
	desc = "Nutrition and flavor from nut butter."
	color = "#658268"

	nutrition_amount = 20
	nutrition_quality_amount = 0

	flavor = "nut butter"

	liquid = 0.25

	particle_size = 0.4


/reagent/nutrition/flower_petal
	name = "flower petal"
	desc = "Nutrition and flavor from a flower petal."
	color = "#965A33"

	nutrition_amount = 4
	nutrition_quality_amount = 4

	flavor = "flower petal"

	liquid = 0

	particle_size = 0.7

/reagent/nutrition/poppy_seed
	name = "poppy seed"
	desc = "Opium-free washed poppy seeds."
	color = "#511500"

	nutrition_amount = 8
	nutrition_quality_amount = 8

	flavor = "poppy seeds"

	liquid = 0

	particle_size = 0.3

/reagent/nutrition/poppy_seed/raw
	name = "raw poppy seed"
	desc = "Pure unrefined poppy seeds. It's unwashed and contains traces of opium."

	processed_reagent = /reagent/medicine/painkiller/opium

	particle_size = 0.4

	lethal = TRUE


/reagent/nutrition/poppy_seed/raw/on_metabolize_stomach(var/mob/living/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)

	. = ..()

	if(prob(10))
		. *= 0.5
		container.add_reagent(processed_reagent,.)

/reagent/nutrition/poppy_seed/raw/on_metabolize_blood(var/mob/living/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)

	. = ..()

	if(prob(10))
		. *= 0.5
		container.add_reagent(processed_reagent,.)

/reagent/nutrition/lipolicide
	name = "lipolicide"
	desc = "Plant-based nutrition-eating germs."
	color = "#511500"

	nutrition_amount = -5
	nutrition_quality_amount = 0

	flavor = "hunger"

	liquid = -0.1

	particle_size = 0.1

/reagent/nutrition/potato
	name = "potato"
	desc = "Nutrition and flavor from potatoes."
	color = "#FFFFEA"

	nutrition_amount = 6
	nutrition_quality_amount = 3

	flavor = "ground apples"

	liquid = 0

	particle_size = 0.8


/reagent/nutrition/cactus
	name = "cactus"
	desc = "Nutrition and flavor from cacti."
	color = "#5AFF36"

	nutrition_amount = 2
	nutrition_quality_amount = 5
	hydration_amount = 10

	flavor = "crunchy water"

	liquid = 0

	particle_size = 0.1


/reagent/nutrition/capsaicin
	name = "capsaicin"
	desc = "The pain juice."
	color = "#EF3232"

	nutrition_amount = 1
	nutrition_quality_amount = 1
	hydration_amount = -4

	flavor = "hurting"

	liquid = 0

	particle_size = 0.2

	lethal = TRUE

/reagent/nutrition/capsaicin/on_metabolize_stomach(var/mob/living/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)

	. = ..()
	owner.pain_regen_buffer += -starting_volume
	owner.send_pain(starting_volume)


/reagent/nutrition/capsaicin/on_metabolize_blood(var/mob/living/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)

	. = ..()
	owner.pain_regen_buffer += -starting_volume * 0.5
	owner.send_pain(starting_volume * 0.5)

/reagent/nutrition/capsaicin/on_metabolize_skin(var/mob/living/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)

	. = ..()
	owner.pain_regen_buffer += -starting_volume
	owner.send_pain(starting_volume)
