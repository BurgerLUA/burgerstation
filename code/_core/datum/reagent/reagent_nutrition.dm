/reagent/nutrition/
	name = "nutrients"
	desc = "A source of nutrition."
	color = "#FFFFFF"

	metabolism_stomach = NUT_AMOUNT

	var/nutrition_amount = 0 NUT_FACTOR
	var/hydration_amount = 0 NUT_FACTOR
	//1 NUT FACTOR means it restores 1 per second.

	value = 1

	liquid = -0.25

/reagent/nutrition/on_metabolize_stomach(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)

	. = ..()

	if(owner && owner.health)
		owner.health.adjust_loss_smart(brute=-.*nutrition_amount,burn=-.*nutrition_amount,tox=-.*nutrition_amount,oxy=-.*nutrition_amount)

	if(is_living(owner))
		var/mob/living/L = owner
		L.add_nutrition(nutrition_amount)
		L.add_hydration(hydration_amount)

	return .

//Flour
/reagent/nutrition/wheat_grain
	name = "wheat grain"
	desc = "Ground up wheat. Process this to get flour."
	color = "#AD9300"

	nutrition_amount = 1.5 NUT_FACTOR

	flavor = "gross oats"

	processed_reagent = "flour_whole_wheat"

	liquid = -0.75

/reagent/nutrition/wheat_grain/flour
	name = "whole wheat flour"
	desc = "Processed wheat grains for use in baking. Process this some more to get white flour."
	color = "#A5771C"

	nutrition_amount = 1.75 NUT_FACTOR

	flavor = "gross dry oat flour"

	processed_reagent = "flour_white"

	liquid = -0.75

/reagent/nutrition/wheat_grain/flour/processed
	name = "white flour"
	desc = "Finely processed white flour for use in baking."
	color = "#FFF8ED"

	nutrition_amount = 1.5 NUT_FACTOR

	flavor = "gross dry flour"

	liquid = -0.75

//Dough
/reagent/nutrition/dough
	name = "wheat grain dough"
	desc = "Crudely mixed and made wheat dough."
	color = "#AA9970"

	nutrition_amount = 1.5 NUT_FACTOR

	flavor = "raw oaty dough"

	liquid = 0.25

/reagent/nutrition/dough/flour
	name = "whole wheat flour dough"
	desc = "Typical whole wheat water-flour based dough."
	color = "#D8BD6C"

	nutrition_amount = 1.75 NUT_FACTOR

	flavor = "raw oaty dough"

	liquid = 0.25

/reagent/nutrition/dough/flour/processed
	name = "white flour dough"
	desc = "Typical whole wheat water-flour based dough."
	color = "#E5D4A2"

	nutrition_amount = 1.5 NUT_FACTOR

	flavor = "raw dough"

	liquid = 0.25

//Bread
/reagent/nutrition/bread
	name = "wheat grain bread"
	desc = "Crudely mixed and made wheat dough."
	color = "#A09170"

	nutrition_amount = 1.5 NUT_FACTOR

	flavor = "tough bread"

	liquid = -0.25

/reagent/nutrition/bread/flour
	name = "whole grain bread"
	desc = "Typical whole wheat water-flour based dough."
	color = "#A8784D"

	nutrition_amount = 1.75 NUT_FACTOR

	flavor = "whole grain bread"

	liquid = -0.25

/reagent/nutrition/bread/flour/processed
	name = "white bread"
	desc = "Typical whole wheat water-flour based dough."
	color = "#E0AC33"

	nutrition_amount = 1.5 NUT_FACTOR

	flavor = "white bread"

	liquid = -0.25


/reagent/nutrition/sugar
	name = "white sugar"
	desc = "Processed sugar."
	color = "#F4FFF8"

	nutrition_amount = 3 NUT_FACTOR

	flavor = "sweetness"

	liquid = -0.4

/reagent/nutrition/sugar/cane
	name = "sugarcane"
	desc = "Unprocessed sugarcane sugar."
	color = "#CEA171"

	nutrition_amount = 2 NUT_FACTOR

	flavor = "sweetness"


/reagent/nutrition/chanterelle
	name = "chanterelle"
	desc = "Nutrition and flavor from a chanterelle mushroom."
	color = "#FFDD8F"

	nutrition_amount = 1 NUT_FACTOR

	flavor = "mushroom"

	liquid = -0.1

//Milk
/reagent/nutrition/milk/
	name = "cow's milk"
	desc = "Nutrition and flavor from cow's milk."
	color = "#FFFFFF"

	nutrition_amount = 1 NUT_FACTOR
	hydration_amount = 1 NUT_FACTOR

	flavor = "milk"

	liquid = 0.5

//Cheese
/reagent/nutrition/cheese/
	name = "processed cheese"
	desc = "Nutrition and flavor from processed cheese."
	color = "#FFC237"

	nutrition_amount = 2 NUT_FACTOR

	flavor = "processed cheese"

	liquid = 0.2

//Fat
/reagent/nutrition/fat/
	name = "fat"
	desc = "Nutrition and flavor from fat."
	color = "#EAD5A4"

	nutrition_amount = 2 NUT_FACTOR

	flavor = "fat"

	liquid = 0.1

/reagent/nutrition/fat/cow
	name = "cow's fat"
	desc = "Nutrition and flavor from cow's fat."
	color = "#EAD5A4"

	nutrition_amount = 2 NUT_FACTOR

	flavor = "fat"

//Meat
/reagent/nutrition/meat/
	name = "raw meat"
	desc = "Nutrition and flavor from raw meat."
	color = "#EA4147"

	nutrition_amount = 4 NUT_FACTOR

	flavor = "raw meat"

	liquid = 0.2

/reagent/nutrition/meat/cow
	name = "raw cow's meat"
	desc = "Nutrition and flavor from raw cow's meat."
	color = "#EA4147"

	nutrition_amount = 4 NUT_FACTOR

	flavor = "raw meat"

/reagent/nutrition/meat/cow/cooked
	name = "cooked cow's meat"
	desc = "Nutrition and flavor from cooked cow's meat."
	color = "#96463C"

	nutrition_amount = 3 NUT_FACTOR

	flavor = "beef"

/reagent/nutrition/meat/chicken
	name = "raw chicken"
	desc = "Nutrition and flavor from raw chicken."
	color = "#E2A5BB"

	nutrition_amount = 3 NUT_FACTOR

	flavor = "raw meat"

/reagent/nutrition/meat/chicken/cooked
	name = "cooked chicken"
	desc = "Nutrition and flavor from cooked chicken."
	color = "#F2DCD1"

	nutrition_amount = 2 NUT_FACTOR

	flavor = "beef"


/reagent/nutrition/junk/
	name = "junk food"
	desc = "Nutrition and flavor from junk food."
	color = "#AAAAAA"

	nutrition_amount = 1 NUT_FACTOR

	flavor = "grease"

	value = 0.2

	liquid = -0.75


/reagent/nutrition/junk/chips
	name = "chips"
	desc = "Nutrition and flavor from chips."
	color = "#FFDE7C"

	nutrition_amount = 1.25 NUT_FACTOR

	flavor = "chips"

/reagent/nutrition/junk/chocolate
	name = "low quality milk chocolate"
	desc = "Nutrition and flavor from low quality chocolate."
	color = "#68452A"

	nutrition_amount = 1.25 NUT_FACTOR

	flavor = "bland chocolate"

/reagent/nutrition/junk/jerky
	name = "soy jerky"
	desc = "Nutrition and flavor from soy jerky."
	color = "#683013"

	nutrition_amount = 1.25 NUT_FACTOR

	flavor = "soy meat"

/reagent/nutrition/junk/raisins
	name = "dried sweet raisins"
	desc = "Nutrition and flavor from dried sweet raisins."
	color = "#470068"

	nutrition_amount = 1.25 NUT_FACTOR

	flavor = "sour raisins"

/reagent/nutrition/junk/cake
	name = "yellow cake"
	desc = "Nutrition and flavor from yellow cake."
	color = "#FFE97C"

	nutrition_amount = 1.5 NUT_FACTOR

	flavor = "bland overmoist cake"


/reagent/nutrition/junk/cream_filling
	name = "sugar cream filling"
	desc = "Nutrition and flavor from cream filling cake."
	color = "#E1FFFF"

	nutrition_amount = 1.5 NUT_FACTOR

	flavor = "sugary cream filling"

/reagent/nutrition/junk/cheese_powder
	name = "cheese powder"
	desc = "Nutrition and flavor from cheese powder."
	color = "#FF6A00"

	nutrition_amount = 1 NUT_FACTOR

	flavor = "cheese powder"