/reagent_recipe/food/
	category = "Food"

/reagent_recipe/food/dough/

	name = "wheat grain dough"

	required_reagents = list(
		/reagent/nutrition/wheat_grain = 3,
		/reagent/nutrition/water = 2,
	)

	results = list(
		/reagent/nutrition/dough = 5
	)

	result = /obj/item/container/food/dynamic/bread

/reagent_recipe/food/dough/flour

	name = "whole wheat flour dough"

	required_reagents = list(
		/reagent/nutrition/wheat_grain/flour = 3,
		/reagent/nutrition/water = 2,
	)

	results = list(
		/reagent/nutrition/dough/flour = 5
	)

	result = /obj/item/container/food/dynamic/bread

/reagent_recipe/food/dough/flour/processed

	name = "white flour dough"

	required_reagents = list(
		/reagent/nutrition/wheat_grain/flour/processed = 3,
		/reagent/nutrition/water = 2,
	)

	results = list(
		/reagent/nutrition/dough/flour/processed = 5
	)

	result = /obj/item/container/food/dynamic/bread


/reagent_recipe/food/bread/

	name = "wheat grain bread"

	required_reagents = list(
		/reagent/nutrition/dough = 1
	)

	required_temperature_min = list(
		/reagent/nutrition/dough = 475
	)

	results = list(
		/reagent/nutrition/bread = 1
	)

/reagent_recipe/food/bread/flour

	name = "whole wheat flour bread"

	required_reagents = list(
		/reagent/nutrition/dough/flour = 1
	)

	required_temperature_min = list(
		/reagent/nutrition/dough/flour = 475
	)

	results = list(
		/reagent/nutrition/bread/flour = 1
	)

/reagent_recipe/food/bread/flour/processed

	name = "white flour bread"

	required_reagents = list(
		/reagent/nutrition/dough/flour/processed = 1,
	)

	required_temperature_min = list(
		/reagent/nutrition/dough/flour/processed = 475
	)

	results = list(
		/reagent/nutrition/bread/flour/processed = 1
	)

/reagent_recipe/food/cake_batter/

	name = "cake batter"

	required_reagents = list(
		/reagent/nutrition/wheat_grain/flour/processed = 15,
		/reagent/nutrition/sugar = 5,
		/reagent/nutrition/egg_white = 5,
		/reagent/nutrition/egg_yellow = 5,
	)

	results = list(
		/reagent/nutrition/cake_batter = 30
	)

	result = /obj/item/container/food/dynamic/cake

/reagent_recipe/food/icing_sugar
	name = "icing sugar"

	required_reagents = list(
		/reagent/nutrition/corn_flour = 1,
		/reagent/nutrition/sugar = 1
	)

	results = list(
		/reagent/nutrition/sugar/icing = 1
	)

/reagent_recipe/food/icing
	name = "icing"

	required_reagents = list(
		/reagent/nutrition/sugar/icing = 1,
		/reagent/nutrition/water = 1
	)

	results = list(
		/reagent/nutrition/icing = 1
	)