/reagent_recipe/dough/

	name = "wheat grain dough"
	id = "dough_wheat_grain"

	required_reagents = list(
		/reagent/nutrition/wheat_grain = 3,
		/reagent/nutrition/water = 2,
	)

	results = list(
		/reagent/nutrition/dough = 5
	)

	result = /obj/item/container/food/dynamic/bread

/reagent_recipe/dough/flour

	name = "whole wheat flour dough"
	id = "dough_flour"

	required_reagents = list(
		/reagent/nutrition/wheat_grain/flour = 3,
		/reagent/nutrition/water = 2,
	)

	results = list(
		/reagent/nutrition/dough/flour = 5
	)

	result = /obj/item/container/food/dynamic/bread

/reagent_recipe/dough/flour/processed

	name = "white flour dough"
	id = "dough_flour_white"

	required_reagents = list(
		/reagent/nutrition/wheat_grain/flour/processed = 3,
		/reagent/nutrition/water = 2,
	)

	results = list(
		/reagent/nutrition/dough/flour/processed = 5
	)

	result = /obj/item/container/food/dynamic/bread


/reagent_recipe/bread/

	name = "wheat grain bread"
	id = "bread_wheat_grain"

	required_reagents = list(
		/reagent/nutrition/dough = 1
	)

	required_temperature_min = list(
		/reagent/nutrition/dough = 475
	)

	results = list(
		/reagent/nutrition/bread = 1
	)

/reagent_recipe/bread/flour

	name = "whole wheat flour bread"
	id = "bread_flour"

	required_reagents = list(
		/reagent/nutrition/dough/flour = 1
	)

	required_temperature_min = list(
		/reagent/nutrition/dough/flour = 475
	)

	results = list(
		/reagent/nutrition/bread/flour = 1
	)

/reagent_recipe/bread/flour/processed

	name = "white flour bread"
	id = "bread_flour_white"

	required_reagents = list(
		/reagent/nutrition/dough/flour/processed = 1,
	)

	required_temperature_min = list(
		/reagent/nutrition/dough/flour/processed = 475
	)

	results = list(
		/reagent/nutrition/bread/flour/processed = 1
	)

//Meat
/reagent_recipe/meat/cow

	name = "cooked cow's meat"
	id = "cooked_meat_cow"

	required_reagents = list(
		/reagent/nutrition/meat/cow = 1
	)

	required_temperature_min = list(
		/reagent/nutrition/meat/cow = 400
	)

	results = list(
		/reagent/nutrition/meat/cow/cooked = 1
	)

/reagent_recipe/meat/chicken

	name = "cooked chicken's meat"
	id = "cooked_chicken"

	required_reagents = list(
		/reagent/nutrition/meat/chicken = 1
	)

	required_temperature_min = list(
		/reagent/nutrition/meat/chicken = 400
	)

	results = list(
		/reagent/nutrition/meat/chicken/cooked = 1
	)