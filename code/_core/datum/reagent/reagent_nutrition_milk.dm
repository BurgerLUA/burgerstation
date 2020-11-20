//Milk
/reagent/nutrition/milk/
	name = "cow's milk"
	desc = "Nutrition and flavor from cow's milk."
	color = "#FFFFFF"
	alpha = 255

	nutrition_amount = 8
	hydration_amount = 4
	nutrition_quality_amount = 0

	flavor = "milk"

	liquid = 0.5

	flags_flavor = FLAG_FLAVOR_DAIRY

/reagent/nutrition/cream
	name = "milk cream"
	desc = "Nutrition and flavor from milk cream."
	color = "#EEEED9"

	nutrition_amount = 15
	hydration_amount = 5
	nutrition_quality_amount = -3

	flavor = "milk"

	liquid = 0.5

	processed_reagent = /reagent/nutrition/butter

//Cheese
/reagent/nutrition/cheese/
	name = "processed cheese"
	desc = "Nutrition and flavor from processed cheese."
	color = "#FFC237"

	nutrition_amount = 20
	nutrition_quality_amount = -6

	flavor = "processed cheese"

	liquid = 0.2

	flavor_strength = 3

	flags_flavor = FLAG_FLAVOR_DAIRY | FLAG_FLAVOR_FAT

/reagent/nutrition/cheese/kadchgall
	name = "Kadchgall Desert cheese"
	desc = "Nutrition and flavor from Kadchgall cheese."
	color = "#FFE8AA"

	nutrition_amount = 30
	nutrition_quality_amount = -3

	flavor = "processed cheese"

	liquid = 0.2

	flags_flavor = FLAG_FLAVOR_DAIRY | FLAG_FLAVOR_LOVE | FLAG_FLAVOR_FAT

/reagent/nutrition/cheese/cheddar
	name = "cheddar cheese"
	desc = "Nutrition and flavor from cheddar cheese."
	color = "#FF9F00"

	nutrition_amount = 30
	nutrition_quality_amount = -6

	flavor = "sharp cheddar cheese"

	liquid = 0.2

	flags_flavor = FLAG_FLAVOR_DAIRY | FLAG_FLAVOR_LOVE | FLAG_FLAVOR_FAT


/reagent/nutrition/cheese/brabander
	name = "Old Brabander Jungle cheese"
	desc = "Nutrition and flavor from Old Brabander Jungle cheese."
	color = "#FFFCE8"

	nutrition_amount = 30
	nutrition_quality_amount = -3

	flavor = "sweet and creamy caramel cheese"

	liquid = 0.2

	flags_flavor = FLAG_FLAVOR_DAIRY | FLAG_FLAVOR_LOVE | FLAG_FLAVOR_FAT



/reagent/nutrition/cheese/raclette
	name = "Raclette Alpine cheese"
	desc = "Nutrition and flavor from Raclette Alpine cheese."
	color = "#FFF09F"

	nutrition_amount = 30
	nutrition_quality_amount = -3

	flavor = "sweet nutty cheese"

	liquid = 0.2

	flags_flavor = FLAG_FLAVOR_DAIRY | FLAG_FLAVOR_LOVE | FLAG_FLAVOR_FAT


/reagent/nutrition/cheese/gruyere
	name = "Gruyère cave cheese"
	desc = "Nutrition and flavor from Gruyère cave cheese."
	color = "#E4A300"

	nutrition_amount = 30
	nutrition_quality_amount = -3

	flavor = "sweet and salty nutty cream cheese"

	liquid = 0.2

	flags_flavor = FLAG_FLAVOR_DAIRY | FLAG_FLAVOR_LOVE | FLAG_FLAVOR_FAT


/reagent/nutrition/cheese/guava
	name = "Smoked Guava cheese"
	desc = "Nutrition and flavor from Smoked Guava cheese."
	color = "#704226"

	nutrition_amount = 30
	nutrition_quality_amount = -3

	flavor = "sweet fudge cheese"

	liquid = 0.2

	flags_flavor = FLAG_FLAVOR_DAIRY | FLAG_FLAVOR_LOVE | FLAG_FLAVOR_FAT


/reagent/nutrition/cheese/bluespace
	name = "bluespace cheese"
	desc = "Nutrition and flavor from bluespace cheese."
	color = "#78A093"

	nutrition_amount = 30
	nutrition_quality_amount = 0

	flavor = "bluespace cheese"

	liquid = 0.2

	flags_flavor = FLAG_FLAVOR_DAIRY | FLAG_FLAVOR_LOVE | FLAG_FLAVOR_FAT


/reagent/nutrition/butter
	name = "butter"
	desc = "Nutrition and flavor from butter."
	color = "#FFD865"

	nutrition_amount = 20
	nutrition_quality_amount = -5

	flavor = "butter"

	value = 2

	flags_flavor = FLAG_FLAVOR_LOVE | FLAG_FLAVOR_FAT

