/reagent/nutrition/junk/
	name = "junk food"
	desc = "Nutrition and flavor from junk food."
	color = "#AAAAAA"

	nutrition_amount = 4

	flavor = "grease"

	flags_flavor = FLAG_FLAVOR_JUNK

	liquid = -0.75

/reagent/nutrition/junk/New(var/desired_loc)
	nutrition_quality_amount = -nutrition_amount*0.4 //Automation!
	return ..()

/reagent/nutrition/junk/chips
	name = "chips"
	desc = "Nutrition and flavor from chips."
	color = "#FFDE7C"

	nutrition_amount = 8

	flavor = "chips"

	flags_flavor = FLAG_FLAVOR_JUNK | FLAG_FLAVOR_GRAIN

/reagent/nutrition/junk/chocolate
	name = "low quality milk chocolate"
	desc = "Nutrition and flavor from low quality chocolate."
	color = "#68452A"

	nutrition_amount = 12

	flavor = "bland chocolate"

/reagent/nutrition/junk/nougat
	name = "low quality nougat"
	desc = "Nutrition and flavor from low quality nougat."
	color = "#C4A06D"

	nutrition_amount = 8

	flavor = "bitter nougat"

/reagent/nutrition/junk/crisp_rice
	name = "crispy rice"
	desc = "Nutrition and flavor from crispy rice."
	color = "#EAEAC7"

	nutrition_amount = 4

	flavor = "stale crispy rice"

/reagent/nutrition/junk/wafer
	name = "wafer"
	desc = "Nutrition and flavor from wafers."
	color = "#FFD897"

	nutrition_amount = 6

	flavor = "stale wafer"

/reagent/nutrition/junk/cookie
	name = "cookie"
	desc = "Nutrition and flavor from cookies."
	color = "#B77100"

	nutrition_amount = 10

	flavor = "cookie"

/reagent/nutrition/junk/jerky
	name = "soy jerky"
	desc = "Nutrition and flavor from soy jerky."
	color = "#683013"

	nutrition_amount = 14

	flavor = "soy meat"

	flags_flavor = FLAG_FLAVOR_JUNK | FLAG_FLAVOR_MEAT

/reagent/nutrition/junk/raisins
	name = "dried sweet raisins"
	desc = "Nutrition and flavor from dried sweet raisins."
	color = "#470068"

	nutrition_amount = 10

	flavor = "sour raisins"

/reagent/nutrition/junk/cake
	name = "yellow cake"
	desc = "Nutrition and flavor from yellow cake."
	color = "#FFE97C"

	nutrition_amount = 10

	flavor = "bland overmoist cake"

	flags_flavor = FLAG_FLAVOR_JUNK | FLAG_FLAVOR_GRAIN


/reagent/nutrition/junk/cream_filling
	name = "sugar cream filling"
	desc = "Nutrition and flavor from cream filling cake."
	color = "#E1FFFF"

	nutrition_amount = 12

	flavor = "sugary cream filling"

/reagent/nutrition/junk/cheese_powder
	name = "cheese powder"
	desc = "Nutrition and flavor from cheese powder."
	color = "#FF6A00"

	nutrition_amount = 12

	flavor = "cheese powder"

