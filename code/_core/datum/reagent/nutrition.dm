#define NUT_AMOUNT 0.1
#define NUT_FACTOR / NUT_AMOUNT

/reagent/core/nutrition/
	name = "nutrients"
	id = "nutrition"
	desc = "A source of nutrition."
	color = "#FFFFFF"

	metabolism_stomach = NUT_AMOUNT

	var/nutrition_amount = 1 NUT_FACTOR //How much stamina to restore per unit.
	//1 NUT FACTOR means it restores 1 per second.

/reagent/core/nutrition/on_metabolize_stomach(var/atom/owner,var/reagent_container/container,var/starting_volume=0)

	. = ..()

	if(owner && owner.health)
		owner.health.adjust_stamina(nutrition_amount)

	return .

/reagent/core/nutrition/wheat_grain //Found in the snow biome as a magic plant
	name = "wheat grain"
	id = "wheat_grain"
	desc = "Ground up wheat. Process this to get flour."
	color = "#EAE89F"

	nutrition_amount = 0.1 NUT_FACTOR

/reagent/core/nutrition/wheat_grain/flour/ //Found in the snow biome as a magic plant
	name = "whole wheat flour"
	id = "flour_whole_wheat"
	desc = "Processed wheat grains for use in baking. Process this some more to get white flour."
	color = "#E8E7D0"

	nutrition_amount = 0.2 NUT_FACTOR

/reagent/core/nutrition/wheat_grain/flour/processed //Found in the snow biome as a magic plant
	name = "white flour"
	id = "flour_white"
	desc = "Finely processed white flour for use in baking."
	color = "#E5E5E3"

	nutrition_amount = 0.2 NUT_FACTOR


/reagent/core/nutrition/dough //Found in the snow biome as a magic plant
	name = "wheat grain dough"
	id = "dough_wheat_grain"
	desc = "Crudely mixed and made wheat dough."
	color = "#AF6E1C"

	nutrition_amount = 0.1 NUT_FACTOR

/reagent/core/nutrition/dough/flour //Found in the snow biome as a magic plant
	name = "whole wheat flour dough"
	id = "dough_flour"
	desc = "Typical whole wheat water-flour based dough."
	color = "#D6C08F"

	nutrition_amount = 0.2 NUT_FACTOR

/reagent/core/nutrition/dough/flour/processed //Found in the snow biome as a magic plant
	name = "white flour dough"
	id = "dough_flour_white"
	desc = "Typical whole wheat water-flour based dough."
	color = "#D3C4A5"

	nutrition_amount = 0.2 NUT_FACTOR

/reagent/core/nutrition/sugar
	name = "white sugar"
	id = "sugar"
	desc = "Processed sugar."
	color = "#F4FFF8"

	nutrition_amount = 0.4 NUT_FACTOR

/reagent/core/nutrition/sugar/cane
	name = "sugarcane"
	id = "sugarcane"
	desc = "Unprocessed sugarcane sugar."
	color = "#CEA171"

	nutrition_amount = 0.3 NUT_FACTOR


/reagent/core/nutrition/chanterelle
	name = "chanterelle"
	id = "chanterelle"
	desc = "Nutrition and flavor from a chanterelle mushroom."
	color = "#FFDD8F"

	nutrition_amount = 0.3 NUT_FACTOR

