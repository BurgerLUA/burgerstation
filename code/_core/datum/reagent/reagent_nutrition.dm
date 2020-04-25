/reagent/core/nutrition/
	name = "nutrients"
	id = "nutrition"
	desc = "A source of nutrition."
	color = "#FFFFFF"

	metabolism_stomach = NUT_AMOUNT

	var/nutrition_amount = 0 NUT_FACTOR
	var/hydration_amount = 0 NUT_FACTOR
	//1 NUT FACTOR means it restores 1 per second.

	var/keywords = "none"

	value = 1

/reagent/core/nutrition/on_metabolize_stomach(var/atom/owner,var/reagent_container/container,var/starting_volume=0)

	. = ..()

	if(owner && owner.health)
		owner.health.adjust_loss_smart(brute=-.*nutrition_amount,burn=-.*nutrition_amount,tox=-.*nutrition_amount,oxy=-.*nutrition_amount)

	if(is_living(owner))
		var/mob/living/L = owner
		L.add_nutrition(nutrition_amount)
		L.add_hydration(hydration_amount)

	return .

//Flour
/reagent/core/nutrition/wheat_grain
	name = "wheat grain"
	id = "wheat_grain"
	desc = "Ground up wheat. Process this to get flour."
	color = "#AD9300"

	nutrition_amount = 0.1 NUT_FACTOR

	flavor = "gross oats"

	processed_reagent = "flour_whole_wheat"

/reagent/core/nutrition/wheat_grain/flour
	name = "whole wheat flour"
	id = "flour_whole_wheat"
	desc = "Processed wheat grains for use in baking. Process this some more to get white flour."
	color = "#A5771C"

	nutrition_amount = 0.2 NUT_FACTOR

	flavor = "gross dry oat flour"

	processed_reagent = "flour_white"

/reagent/core/nutrition/wheat_grain/flour/processed
	name = "white flour"
	id = "flour_white"
	desc = "Finely processed white flour for use in baking."
	color = "#FFF8ED"

	nutrition_amount = 0.2 NUT_FACTOR

	flavor = "gross dry flour"

//Dough
/reagent/core/nutrition/dough
	name = "wheat grain dough"
	id = "dough_wheat_grain"
	desc = "Crudely mixed and made wheat dough."
	color = "#AA9970"

	nutrition_amount = 0.1 NUT_FACTOR

	flavor = "raw oaty dough"

/reagent/core/nutrition/dough/flour
	name = "whole wheat flour dough"
	id = "dough_flour"
	desc = "Typical whole wheat water-flour based dough."
	color = "#D8BD6C"

	nutrition_amount = 0.2 NUT_FACTOR

	flavor = "raw oaty dough"

/reagent/core/nutrition/dough/flour/processed
	name = "white flour dough"
	id = "dough_flour_white"
	desc = "Typical whole wheat water-flour based dough."
	color = "#E5D4A2"

	nutrition_amount = 0.2 NUT_FACTOR

	flavor = "raw dough"

//Bread
/reagent/core/nutrition/bread
	name = "wheat grain bread"
	id = "bread_wheat_grain"
	desc = "Crudely mixed and made wheat dough."
	color = "#A09170"

	nutrition_amount = 0.6 NUT_FACTOR

	flavor = "tough bread"

/reagent/core/nutrition/bread/flour
	name = "whole grain bread"
	id = "bread_flour"
	desc = "Typical whole wheat water-flour based dough."
	color = "#A8784D"

	nutrition_amount = 0.8 NUT_FACTOR

	flavor = "whole grain bread"

/reagent/core/nutrition/bread/flour/processed
	name = "white bread"
	id = "bread_flour_white"
	desc = "Typical whole wheat water-flour based dough."
	color = "#E0AC33"

	nutrition_amount = 1 NUT_FACTOR

	flavor = "white bread"


/reagent/core/nutrition/sugar
	name = "white sugar"
	id = "sugar"
	desc = "Processed sugar."
	color = "#F4FFF8"

	nutrition_amount = 0.4 NUT_FACTOR

	flavor = "sweetness"

/reagent/core/nutrition/sugar/cane
	name = "sugarcane"
	id = "sugarcane"
	desc = "Unprocessed sugarcane sugar."
	color = "#CEA171"

	nutrition_amount = 0.3 NUT_FACTOR

	flavor = "sweetness"


/reagent/core/nutrition/chanterelle
	name = "chanterelle"
	id = "chanterelle"
	desc = "Nutrition and flavor from a chanterelle mushroom."
	color = "#FFDD8F"

	nutrition_amount = 0.3 NUT_FACTOR

	flavor = "mushroom"

//Milk
/reagent/core/nutrition/milk/
	name = "cow's milk"
	id = "milk_cow"
	desc = "Nutrition and flavor from cow's milk."
	color = "#FFFFFF"

	nutrition_amount = 0.8 NUT_FACTOR

	flavor = "milk"

//Cheese
/reagent/core/nutrition/cheese/
	name = "processed cheese"
	id = "processed_cheese"
	desc = "Nutrition and flavor from processed cheese."
	color = "#FFC237"

	nutrition_amount = 0.8 NUT_FACTOR

	flavor = "processed cheese"

//Fat
/reagent/core/nutrition/fat/
	name = "fat"
	id = "fat"
	desc = "Nutrition and flavor from fat."
	color = "#EAD5A4"

	nutrition_amount = 0.8 NUT_FACTOR

	flavor = "fat"

/reagent/core/nutrition/fat/cow
	name = "cow's fat"
	id = "fat_cow"
	desc = "Nutrition and flavor from cow's fat."
	color = "#EAD5A4"

	nutrition_amount = 0.8 NUT_FACTOR

	flavor = "fat"

//Meat
/reagent/core/nutrition/meat/
	name = "raw meat"
	id = "raw_meat"
	desc = "Nutrition and flavor from raw meat."
	color = "#EA4147"

	nutrition_amount = 0.4 NUT_FACTOR

	flavor = "raw meat"

/reagent/core/nutrition/meat/cow
	name = "raw cow's meat"
	id = "raw_meat_cow"
	desc = "Nutrition and flavor from raw cow's meat."
	color = "#EA4147"

	nutrition_amount = 0.5 NUT_FACTOR

	flavor = "raw meat"

/reagent/core/nutrition/meat/cow/cooked
	name = "cooked cow's meat"
	id = "cooked_meat_cow"
	desc = "Nutrition and flavor from cooked cow's meat."
	color = "#96463C"

	nutrition_amount = 0.7 NUT_FACTOR

	flavor = "beef"

/reagent/core/nutrition/meat/chicken
	name = "raw chicken"
	id = "raw_chicken"
	desc = "Nutrition and flavor from raw chicken."
	color = "#E2A5BB"

	nutrition_amount = 0.6 NUT_FACTOR

	flavor = "raw meat"

/reagent/core/nutrition/meat/chicken/cooked
	name = "cooked chicken"
	id = "cooked_chicken"
	desc = "Nutrition and flavor from cooked chicken."
	color = "#F2DCD1"

	nutrition_amount = 0.8 NUT_FACTOR

	flavor = "beef"


/reagent/core/nutrition/junk/
	name = "junk food"
	id = null
	desc = "Nutrition and flavor from junk food."
	color = "#AAAAAA"

	nutrition_amount = 0.2 NUT_FACTOR

	flavor = "grease"

	value = 0.2


/reagent/core/nutrition/junk/chips
	name = "chips"
	id = "chips"
	desc = "Nutrition and flavor from chips."
	color = "#FFDE7C"

	nutrition_amount = 0.2 NUT_FACTOR

	flavor = "chips"

/reagent/core/nutrition/junk/chocolate
	name = "low quality milk chocolate"
	id = "low_chocolate"
	desc = "Nutrition and flavor from low quality chocolate."
	color = "#68452A"

	nutrition_amount = 0.2 NUT_FACTOR

	flavor = "bland chocolate"

/reagent/core/nutrition/junk/jerky
	name = "soy jerky"
	id = "soy_jerky"
	desc = "Nutrition and flavor from soy jerky."
	color = "#683013"

	nutrition_amount = 0.2 NUT_FACTOR

	flavor = "soy meat"

/reagent/core/nutrition/junk/raisins
	name = "dried sweet raisins"
	id = "junk_raisins"
	desc = "Nutrition and flavor from dried sweet raisins."
	color = "#470068"

	nutrition_amount = 0.2 NUT_FACTOR

	flavor = "sour raisins"

/reagent/core/nutrition/junk/cake
	name = "yellow cake"
	id = "yellow_cake"
	desc = "Nutrition and flavor from yellow cake."
	color = "#FFE97C"

	nutrition_amount = 0.2 NUT_FACTOR

	flavor = "bland overmoist cake"


/reagent/core/nutrition/junk/cream_filling
	name = "sugar cream filling"
	id = "cream_filling"
	desc = "Nutrition and flavor from cream filling cake."
	color = "#E1FFFF"

	nutrition_amount = 0.2 NUT_FACTOR

	flavor = "sugary cream filling"

/reagent/core/nutrition/junk/cheese_powder
	name = "cheese powder"
	id = "cheese_powder"
	desc = "Nutrition and flavor from cheese powder."
	color = "#FF6A00"

	nutrition_amount = 0.2 NUT_FACTOR

	flavor = "cheese powder"