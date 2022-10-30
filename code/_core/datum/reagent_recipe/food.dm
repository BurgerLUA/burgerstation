/reagent_recipe/food/
	category = "Food"
	results = list()

/reagent_recipe/food/dough/

	name = "wheat grain dough"
	desc = "wheat dough! add reagents to it!"

	required_reagents = list(
		/reagent/nutrition/wheat_grain = 3,
		/reagent/nutrition/water = 2,
	)

	results = list(
		/reagent/nutrition/dough = 5
	)

	result = /obj/item/container/edible/dynamic/bread

/reagent_recipe/food/dough/flour

	name = "whole wheat flour dough"
	desc = "healthier than normal dough."

	required_reagents = list(
		/reagent/nutrition/wheat_grain/flour = 3,
		/reagent/nutrition/water = 2,
	)

	results = list(
		/reagent/nutrition/dough/flour = 5
	)

	result = /obj/item/container/edible/dynamic/bread

/reagent_recipe/food/dough/flour/processed

	name = "white flour dough"
	desc = "dough"

	required_reagents = list(
		/reagent/nutrition/wheat_grain/flour/processed = 3,
		/reagent/nutrition/water = 2,
	)

	results = list(
		/reagent/nutrition/dough/flour/processed = 5
	)

	result = /obj/item/container/edible/dynamic/bread

/reagent_recipe/food/dough/corn
	name = "corn flour dough"
	desc = "dough made with corn flour"

	required_reagents = list(

		/reagent/nutrition/corn_flour = 3,
		/reagent/nutrition/water = 2,
	)

	results = list(
		/reagent/nutrition/dough/corn = 5
	)

	result = /obj/item/container/edible/dynamic/bread



/reagent_recipe/food/bread/

	name = "wheat grain bread"
	desc = "bread made from wheat grain, cook dough."

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
	desc = "bread made from whole wheat grain, cook dough."

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
	desc = "bread made from processed wheat grain, cook dough."

	required_reagents = list(
		/reagent/nutrition/dough/flour/processed = 1,
	)

	required_temperature_min = list(
		/reagent/nutrition/dough/flour/processed = 475
	)

	results = list(
		/reagent/nutrition/bread/flour/processed = 1
	)


/reagent_recipe/food/bread/corn

	name = "whole wheat flour bread"
	desc = "bread made from whole wheat grain, cook dough."

	required_reagents = list(
		/reagent/nutrition/dough/corn = 1
	)

	required_temperature_min = list(
		/reagent/nutrition/dough/corn = 475
	)

	results = list(
		/reagent/nutrition/bread/corn = 1
	)

/reagent_recipe/food/cake_batter/

	name = "cake batter"
	desc = "the cake is a lie."

	required_reagents = list(
		/reagent/nutrition/wheat_grain/flour/processed = 15,
		/reagent/nutrition/sugar = 5,
		/reagent/nutrition/egg_white = 5,
		/reagent/nutrition/egg_yellow = 5,
	)

	results = list(
		/reagent/nutrition/cake_batter = 30
	)

	result = /obj/item/container/edible/dynamic/cake

/reagent_recipe/food/icing_sugar
	name = "icing sugar"
	desc = "sugar icing, (better than buttercream)."

	required_reagents = list(
		/reagent/nutrition/corn_flour = 1,
		/reagent/nutrition/sugar = 1
	)

	results = list(
		/reagent/nutrition/sugar/icing = 1
	)

/reagent_recipe/food/icing
	name = "icing"
	desc = "icing, uses sugar icing which is a bit weird, this is probably buttercream (inferior)."

	required_reagents = list(
		/reagent/nutrition/sugar/icing = 1,
		/reagent/nutrition/water = 1
	)

	results = list(
		/reagent/nutrition/icing = 1
	)
