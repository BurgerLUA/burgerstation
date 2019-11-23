#define NUT_AMOUNT 0.1
#define NUT_FACTOR / NUT_AMOUNT

/reagent/core/nutrition/
	name = "nutrients"
	id = "nutrition"
	desc = "A source of nutrition."
	color = "#FFFFFF"

	metabolism_stomach = NUT_AMOUNT

	var/nutrition_amount = 1 NUT_FACTOR //How much health, stamina, and mana to restore per tick.
	//1 NUT FACTOR means it restores 1 per second.

	var/keywords = "none"

/reagent/core/nutrition/on_metabolize_stomach(var/atom/owner,var/reagent_container/container,var/starting_volume=0)

	. = ..()

	if(owner && owner.health)
		owner.health.adjust_stamina(nutrition_amount)
		if(is_advanced(owner))
			var/mob/living/advanced/A = owner
			A.heal_all_organs(nutrition_amount,nutrition_amount,nutrition_amount,nutrition_amount)


	return .

//Flour
/reagent/core/nutrition/wheat_grain
	name = "wheat grain"
	id = "wheat_grain"
	desc = "Ground up wheat. Process this to get flour."
	color = "#AD9300"

	nutrition_amount = 0.1 NUT_FACTOR

	flavor = "gross oats"

/reagent/core/nutrition/wheat_grain/flour
	name = "whole wheat flour"
	id = "flour_whole_wheat"
	desc = "Processed wheat grains for use in baking. Process this some more to get white flour."
	color = "#A5771C"

	nutrition_amount = 0.2 NUT_FACTOR

	flavor = "gross dry oat flour"

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