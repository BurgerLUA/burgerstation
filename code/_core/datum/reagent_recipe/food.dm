/reagent_recipe/dough/

	name = "wheat grain dough"
	id = "dough_wheat_grain"

	required_reagents = list(
		"wheat_grain" = 1,
		"water" = 1,
	)

	results = list(
		"dough_wheat_grain" = 1
	)

	result = /obj/item/container/food/dynamic/bread

/reagent_recipe/dough/flour

	name = "whole wheat flour dough"
	id = "dough_flour"

	required_reagents = list(
		"flour_whole_wheat" = 5,
		"water" = 3,
	)

	results = list(
		"dough_flour" = 15
	)

/reagent_recipe/dough/flour/processed

	name = "white flour dough"
	id = "dough_flour_white"

	required_reagents = list(
		"flour_white" = 5,
		"water" = 3,
	)

	results = list(
		"dough_flour_white" = 5
	)


/reagent_recipe/bread/

	name = "wheat grain bread"
	id = "bread_wheat_grain"

	required_reagents = list(
		"dough_wheat_grain" = 1
	)

	required_temperature_min = list(
		"dough_wheat_grain" = 475
	)

	results = list(
		"bread_wheat_grain" = 1
	)

/reagent_recipe/bread/flour

	name = "whole wheat flour bread"
	id = "bread_flour"

	required_reagents = list(
		"dough_flour" = 1
	)

	required_temperature_min = list(
		"dough_flour" = 475
	)

	results = list(
		"bread_flour" = 1
	)

/reagent_recipe/bread/flour/processed

	name = "white flour bread"
	id = "bread_flour_white"

	required_reagents = list(
		"dough_flour_white" = 1,
	)

	required_temperature_min = list(
		"dough_flour_white" = 475
	)

	results = list(
		"bread_flour_white" = 1
	)
