//Milk
/reagent/nutrition/milk/
	name = "cow's milk"
	desc = "Nutrition and flavor from cow's milk."
	color = "#FFFFFF"
	alpha = 255

	nutrition_fast_amount = 2
	nutrition_normal_amount = 4
	nutrition_quality_amount = 2
	hydration_amount = 4


	flavor = "milk"

	liquid = 0.5

	flags_flavor = FLAG_FLAVOR_DAIRY

	particle_size = 0.2

/reagent/nutrition/cream
	name = "milk cream"
	desc = "Nutrition and flavor from milk cream."
	color = "#EEEED9"

	nutrition_fast_amount = 10
	nutrition_normal_amount = 5
	nutrition_quality_amount = 0

	hydration_amount = 3

	flavor = "cream"

	liquid = 0.5

	processed_reagent = /reagent/nutrition/butter

	particle_size = 0.3

//Cheese
/reagent/nutrition/cheese/
	name = "processed cheese"
	desc = "Nutrition and flavor from processed cheese."
	color = "#FFC237"

	nutrition_fast_amount = 20
	nutrition_normal_amount = 0
	nutrition_quality_amount = 0

	flavor = "processed cheese"

	liquid = 0.2

	flavor_strength = 3

	flags_flavor = FLAG_FLAVOR_DAIRY | FLAG_FLAVOR_FAT

	particle_size = 0.8

/reagent/nutrition/cheese/kadchgall
	name = "Kadchgall Desert cheese"
	desc = "Nutrition and flavor from Kadchgall cheese."
	color = "#FFE8AA"

	nutrition_fast_amount = 5
	nutrition_normal_amount = 10
	nutrition_quality_amount = 10

	flavor = "processed cheese"

	liquid = 0.2

	flags_flavor = FLAG_FLAVOR_DAIRY | FLAG_FLAVOR_LOVE | FLAG_FLAVOR_FAT

/reagent/nutrition/cheese/cheddar
	name = "cheddar cheese"
	desc = "Nutrition and flavor from cheddar cheese."
	color = "#FF9F00"

	nutrition_fast_amount = 10
	nutrition_normal_amount = 5
	nutrition_quality_amount = 10

	flavor = "sharp cheddar cheese"

	liquid = 0.2

	flags_flavor = FLAG_FLAVOR_DAIRY | FLAG_FLAVOR_LOVE | FLAG_FLAVOR_FAT


/reagent/nutrition/cheese/brabander
	name = "Old Brabander Jungle cheese"
	desc = "Nutrition and flavor from Old Brabander Jungle cheese."
	color = "#FFFCE8"

	nutrition_fast_amount = 5
	nutrition_normal_amount = 5
	nutrition_quality_amount = 15


	flavor = "sweet and creamy caramel cheese"

	liquid = 0.2

	flags_flavor = FLAG_FLAVOR_DAIRY | FLAG_FLAVOR_LOVE | FLAG_FLAVOR_FAT



/reagent/nutrition/cheese/raclette
	name = "Raclette Alpine cheese"
	desc = "Nutrition and flavor from Raclette Alpine cheese."
	color = "#FFF09F"

	nutrition_fast_amount = 5
	nutrition_normal_amount = 0
	nutrition_quality_amount = 20

	flavor = "sweet nutty cheese"

	liquid = 0.2

	flags_flavor = FLAG_FLAVOR_DAIRY | FLAG_FLAVOR_LOVE | FLAG_FLAVOR_FAT


/reagent/nutrition/cheese/gruyere
	name = "Gruy�re cave cheese"
	desc = "Nutrition and flavor from Gruy�re cave cheese."
	color = "#E4A300"

	nutrition_fast_amount = 5
	nutrition_normal_amount = 10
	nutrition_quality_amount = 10

	flavor = "sweet and salty nutty cream cheese"

	liquid = 0.2

	flags_flavor = FLAG_FLAVOR_DAIRY | FLAG_FLAVOR_LOVE | FLAG_FLAVOR_FAT


/reagent/nutrition/cheese/guava
	name = "Smoked Guava cheese"
	desc = "Nutrition and flavor from Smoked Guava cheese."
	color = "#704226"

	nutrition_fast_amount = 5
	nutrition_normal_amount = 5
	nutrition_quality_amount = 15

	flavor = "sweet fudge cheese"

	liquid = 0.2

	flags_flavor = FLAG_FLAVOR_DAIRY | FLAG_FLAVOR_LOVE | FLAG_FLAVOR_FAT


/reagent/nutrition/cheese/bluespace
	name = "bluespace cheese"
	desc = "Nutrition and flavor from bluespace cheese."
	color = "#78A093"

	nutrition_fast_amount = 20
	nutrition_normal_amount = 0
	nutrition_quality_amount = 5

	flavor = "bluespace cheese"

	liquid = 0.2

	flags_flavor = FLAG_FLAVOR_DAIRY | FLAG_FLAVOR_LOVE | FLAG_FLAVOR_FAT


/reagent/nutrition/cheese/oasis
	name = "Glardin Oasis cheese"
	desc = "Nutrition and flavor from Glardin Oasis cheese."
	color = "#3D62C3"

	nutrition_fast_amount = 10
	nutrition_normal_amount = 10
	nutrition_quality_amount = 5

	hydration_amount = 5

	flavor = "salty waterlogged cheese"

	liquid = 0.2

	flags_flavor = FLAG_FLAVOR_DAIRY | FLAG_FLAVOR_LOVE | FLAG_FLAVOR_FAT

/reagent/nutrition/cheese/blackash
	name = "Black Ash cheese"
	desc = "Nutrition and flavor from Black Ash cheese."
	color = "#3f3f3f"

	nutrition_fast_amount = 0
	nutrition_normal_amount = 25
	nutrition_quality_amount = 0

	flavor = "scorched rocks and smokey ash cheese"

	liquid = 0.2

	flags_flavor = FLAG_FLAVOR_DAIRY | FLAG_FLAVOR_LOVE | FLAG_FLAVOR_FAT


/reagent/nutrition/butter
	name = "butter"
	desc = "Nutrition and flavor from butter."
	color = "#FFD865"

	nutrition_fast_amount = 15
	nutrition_normal_amount = 10
	nutrition_quality_amount = 5

	flavor = "butter"

	value = 2

	flags_flavor = FLAG_FLAVOR_LOVE | FLAG_FLAVOR_FAT
