/reagent_recipe/dough/

	name = "wheat grain dough"

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

	required_reagents = list(
		/reagent/nutrition/meat/chicken = 1
	)

	required_temperature_min = list(
		/reagent/nutrition/meat/chicken = 400
	)

	results = list(
		/reagent/nutrition/meat/chicken/cooked = 1
	)


/reagent_recipe/cake_batter/

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


/reagent_recipe/cake/

	name = "cake"

	required_reagents = list(
		/reagent/nutrition/cake_batter = 1
	)

	required_temperature_min = list(
		/reagent/nutrition/cake_batter = 475
	)

	results = list(
		/reagent/nutrition/cake = 1
	)