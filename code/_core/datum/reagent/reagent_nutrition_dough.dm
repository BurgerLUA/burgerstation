//Dough
/reagent/nutrition/dough
	name = "wheat grain dough"
	desc = "Crudely mixed and made wheat dough."
	color = "#AA9970"

	nutrition_amount = 3.5

	flavor = "raw oaty dough"

	liquid = 0.25

	flags_reagent = FLAG_REAGENT_RAW

	heated_reagent = /reagent/nutrition/bread
	heated_reagent_temp = 370
	heated_reagent_amount = 0.5
	heated_reagent_mul = 0.01

	flavor_strength = 4

	flags_flavor = FLAG_FLAVOR_GROSS | FLAG_FLAVOR_GRAIN | FLAG_FLAVOR_RAW

/reagent/nutrition/dough/flour
	name = "whole wheat flour dough"
	desc = "Typical whole wheat water-flour based dough."
	color = "#D8BD6C"

	nutrition_amount = 4
	nutrition_quality_amount = -1

	flavor = "raw oaty dough"

	liquid = 0.25

	heated_reagent = /reagent/nutrition/bread/flour

	flavor_strength = 3

/reagent/nutrition/dough/flour/processed
	name = "white flour dough"
	desc = "Typical whole wheat water-flour based dough."
	color = "#E5D4A2"

	nutrition_amount = 4.5
	nutrition_quality_amount = -2

	flavor = "raw dough"

	liquid = 0.25

	heated_reagent = /reagent/nutrition/bread/flour/processed

	flavor_strength = 2

//Bread
/reagent/nutrition/bread
	name = "wheat grain bread"
	desc = "Crudely mixed and made wheat bread."
	color = "#A09170"

	nutrition_amount = 12
	nutrition_quality_amount = 3

	flavor = "tough bread"

	liquid = -0.25

	flags_reagent = FLAG_REAGENT_COOKED

	heated_reagent_temp = 370
	heated_reagent_mul = 0.003

	flavor_strength = 1

	flags_flavor = FLAG_FLAVOR_GRAIN | FLAG_FLAVOR_LOVE

/reagent/nutrition/bread/flour
	name = "whole grain bread"
	desc = "Typical whole wheat water-flour based bread."
	color = "#A8784D"

	nutrition_amount = 13
	nutrition_quality_amount = 2

	flavor = "whole grain bread"

	liquid = -0.25

	flavor_strength = 0.5

/reagent/nutrition/bread/flour/processed
	name = "white bread"
	desc = "Typical water-flour based bread."
	color = "#E0AC33"

	nutrition_amount = 14
	nutrition_quality_amount = -1

	flavor = "white bread"

	liquid = -0.25

	flavor_strength = 0.25

//Cake
/reagent/nutrition/cake_batter
	name = "cake batter"
	desc = "Typical cake batter."
	color = "#DDBE8F"

	nutrition_amount = 12
	nutrition_quality_amount = -3

	flavor = "raw dough"

	liquid = 0.25

	flags_reagent = FLAG_REAGENT_RAW

	heated_reagent = /reagent/nutrition/cake
	heated_reagent_temp = 370
	heated_reagent_amount = 0.03
	heated_reagent_mul = 0.05

	flags_flavor = FLAG_FLAVOR_GRAIN | FLAG_FLAVOR_RAW

/reagent/nutrition/cake
	name = "cake"
	desc = "Cooked cake."
	color = "#BC9253"

	nutrition_amount = 15
	nutrition_quality_amount = -2

	flavor = "cake"

	flags_flavor = FLAG_FLAVOR_GRAIN | FLAG_FLAVOR_LOVE

	liquid = -0.125

	flags_reagent = FLAG_REAGENT_COOKED

