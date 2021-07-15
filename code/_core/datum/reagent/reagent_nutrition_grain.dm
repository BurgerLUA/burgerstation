/reagent/nutrition/wheat_grain
	name = "wheat grain"
	desc = "Ground up wheat. Process this to get flour."
	color = "#AD9300"
	alpha = 255

	nutrition_amount = 7

	flavor = "gross oats"

	processed_reagent = /reagent/nutrition/wheat_grain/flour

	liquid = -0.75

	flavor_strength = 4

	flags_flavor = FLAG_FLAVOR_GROSS | FLAG_FLAVOR_GRAIN

	particle_size = 0.8

/reagent/nutrition/wheat_grain/flour
	name = "whole wheat flour"
	desc = "Processed wheat grains for use in baking. Process this some more to get white flour."
	color = "#A5771C"

	nutrition_amount = 8

	flavor = "gross dry oat flour"

	processed_reagent = /reagent/nutrition/wheat_grain/flour/processed

	liquid = -0.75

	flavor_strength = 3

	flags_flavor = FLAG_FLAVOR_GRAIN

	particle_size = 0.6

/reagent/nutrition/wheat_grain/flour/processed
	name = "white flour"
	desc = "Finely processed white flour for use in baking."
	color = "#FFF8ED"

	nutrition_amount = 9

	flavor = "gross dry flour"

	liquid = -0.75

	flavor_strength = 2

	flags_flavor = FLAG_FLAVOR_GRAIN

	particle_size = 0.3

/reagent/nutrition/corn
	name = "corn"
	desc = "De-cobbed corn. Process this to get corn flour."
	color = "#FCFC00"
	alpha = 255

	nutrition_amount = 4

	flavor = "tough maize"

	processed_reagent = /reagent/nutrition/corn_flour

	liquid = -0.75

	flavor_strength = 4

	flags_flavor = FLAG_FLAVOR_GROSS | FLAG_FLAVOR_GRAIN

	particle_size = 0.9


/reagent/nutrition/corn_flour
	name = "corn flour"
	desc = "Also called corn starch. One of the by-products of processing corn."
	color = "#E0AC33"

	nutrition_amount = 5

	flavor = "corn starch"

	liquid = -1

	flavor_strength = 4

	flags_flavor = FLAG_FLAVOR_GRAIN

	particle_size = 0.25
