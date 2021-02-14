/reagent/nutrition/chanterelle
	name = "chanterelle"
	desc = "Nutrition and flavor from a chanterelle mushroom."
	color = "#FFDD8F"

	nutrition_amount = 7
	nutrition_quality_amount = 2

	flavor = "mushroom"

	liquid = -0.2

/reagent/nutrition/tomato
	name = "tomato paste"
	desc = "Nutrition and flavor from a tomato."
	color = "#C90000"

	nutrition_amount = 6
	nutrition_quality_amount = 2

	flavor = "tomato"

	liquid = 0.3

/reagent/nutrition/pineapple
	name = "pineapple"
	desc = "Nutrition and flavor from a pineapple."
	color = "#C90000"

	nutrition_amount = 8
	nutrition_quality_amount = 1

	flavor = "pineapple"

	liquid = 0.5

/reagent/nutrition/cabbage
	name = "cabbage"
	desc = "Nutrition and flavor from a cabbage."
	color = "#658268"

	nutrition_amount = 8
	nutrition_quality_amount = 8

	flavor = "cabbage"

	liquid = 0

/reagent/nutrition/lettuce
	name = "lettuce"
	desc = "Nutrition and flavor from lettuce."
	color = "#5AAF36"

	nutrition_amount = 6
	nutrition_quality_amount = 5

	flavor = "lettuce"

	liquid = 0

/reagent/nutrition/coconut
	name = "coconut"
	desc = "Nutrition and flavor from a coconut."
	color = "#658268"

	nutrition_amount = 15
	nutrition_quality_amount = 2

	flavor = "coconut"

	liquid = -0.25


/reagent/nutrition/nut
	name = "nut"
	desc = "Nutrition and flavor from a nut."
	color = "#658268"

	nutrition_amount = 12
	nutrition_quality_amount = 2

	flavor = "nut"

	liquid = -0.5

/reagent/nutrition/nut/butter
	name = "nut butter"
	desc = "Nutrition and flavor from nut butter."
	color = "#658268"

	nutrition_amount = 20
	nutrition_quality_amount = 0

	flavor = "nut butter"

	liquid = 0.25


/reagent/nutrition/flower_petal
	name = "flower petal"
	desc = "Nutrition and flavor from a flower petal."
	color = "#965A33"

	nutrition_amount = 4
	nutrition_quality_amount = 4

	flavor = "flower petal"

	liquid = 0

/reagent/nutrition/poppy_seed
	name = "poppy seed"
	desc = "Opium-free washed poppy seeds."
	color = "#511500"

	nutrition_amount = 8
	nutrition_quality_amount = 8

	flavor = "poppy seeds"

	liquid = 0

/reagent/nutrition/poppy_seed/raw
	name = "raw poppy seed"
	desc = "Pure unrefined poppy seeds. It's unwashed and contains traces of opium."

	processed_reagent = /reagent/medicine/painkiller/opium


/reagent/nutrition/poppy_seed/raw/on_metabolize_stomach(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)

	. = ..()

	if(prob(10))
		. *= 0.5
		container.add_reagent(processed_reagent,.)

	return .


/reagent/nutrition/poppy_seed/raw/on_metabolize_blood(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)

	. = ..()

	if(prob(10))
		. *= 0.5
		container.add_reagent(processed_reagent,.)

	return .


/reagent/nutrition/lipolicide
	name = "lipolicide"
	desc = "Plant-based nutrition-eating germs."
	color = "#511500"

	nutrition_amount = -5
	nutrition_quality_amount = 0

	flavor = "hunger"

	liquid = -0.1

