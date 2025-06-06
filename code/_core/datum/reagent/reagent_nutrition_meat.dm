/reagent/nutrition/flavor //TODO: Give buffs.
	name = "flavor"
	desc = "Pure flavor."
	color = "#EAD5A4"
	alpha = 255

	nutrition_fast_amount = 0
	nutrition_normal_amount = 0
	nutrition_quality_amount = 20

	flavor = "flavor"
	flavor_strength = 10

	liquid = 0.3

	heal_amount = 10

	flags_reagent = FLAG_REAGENT_FAT

	flags_flavor = FLAG_FLAVOR_FAT | FLAG_FLAVOR_LOVE

	value = 2

	particle_size = 0.7

/reagent/nutrition/fat/
	name = "fat"
	desc = "Nutrition and flavor from fat."
	color = "#EAD5A4"
	alpha = 255

	nutrition_fast_amount = 10
	nutrition_normal_amount = 5
	nutrition_quality_amount = 5

	flavor = "fat"

	liquid = 0.1

	flags_reagent = FLAG_REAGENT_FAT

	heated_reagent = /reagent/nutrition/flavor/
	heated_reagent_temp = 328
	heated_reagent_mul = 0.01

	flags_flavor = FLAG_FLAVOR_FAT

	particle_size = 0.8

/reagent/nutrition/fat/cow
	name = "cow fat"
	desc = "Nutrition and flavor from cow's fat."
	color = "#EAD5A4"

	nutrition_fast_amount = 10
	nutrition_normal_amount = 5
	nutrition_quality_amount = 5

	flavor = "fat"

/reagent/nutrition/fat/monkey
	name = "monkey fat"
	desc = "Nutrition and flavor from monkey fat."
	color = "#EAD5A4"

	nutrition_fast_amount = 10
	nutrition_normal_amount = 5
	nutrition_quality_amount = 5

	flavor = "fat"

/reagent/nutrition/fat/bear
	name = "bear fat"
	desc = "Nutrition and flavor from bear fat."
	color = "#EAD5A4"

	nutrition_fast_amount = 10
	nutrition_normal_amount = 5
	nutrition_quality_amount = 10

	flavor = "fat"

/reagent/nutrition/fat/chicken
	name = "chicken fat"
	desc = "Nutrition and flavor from chicken fat."
	color = "#EAD5A4"

	nutrition_fast_amount = 15
	nutrition_normal_amount = 5
	nutrition_quality_amount = 0

	flavor = "fat"

/reagent/nutrition/fat/ancient
	name = "ancient fat"
	desc = "Nutrition and flavor from ancient fat."
	color = "#BAAD8D"

	nutrition_fast_amount = 5
	nutrition_normal_amount = 5
	nutrition_quality_amount = 10

	flavor = "fat"

/reagent/nutrition/fat/penguin
	name = "penguin fat"
	desc = "Nutrition and flavor from penguin fat."
	color = "#EAD5A4"

	nutrition_fast_amount = 10
	nutrition_normal_amount = 10
	nutrition_quality_amount = 0

	flavor = "fat"

/reagent/nutrition/fat/fish
	name = "fish fat"
	desc = "Nutrition and flavor from fish fat."
	color = "#EAD5A4"

	nutrition_fast_amount = 5
	nutrition_normal_amount = 0
	nutrition_quality_amount = 15

	flavor = "fat"

/reagent/nutrition/fat/xeno
	name = "xeno fat"
	desc = "Nutrition and flavor from a xeno fat."
	color = "#EAD5A4"

	nutrition_fast_amount = 15
	nutrition_normal_amount = 0
	nutrition_quality_amount = 5

	flavor = "fat"

/reagent/nutrition/fat/crab
	name = "crab fat"
	desc = "Nutrition and flavor from crab fat."
	color = "#EAD5A4"

	nutrition_fast_amount = 10
	nutrition_normal_amount = 10
	nutrition_quality_amount = 0
	flavor = "fat"

/reagent/nutrition/fat/lobster
	name = "lobster fat"
	desc = "Nutrition and flavor from lobster fat."
	color = "#EAD5A4"

	nutrition_fast_amount = 5
	nutrition_normal_amount = 15
	nutrition_quality_amount = 0

	flavor = "fat"

/reagent/nutrition/fat/arachnid
	name = "arachnid fat"
	desc = "Nutrition and flavor from arachnid fat."
	color = "#B2D5A4"

	nutrition_fast_amount = 10
	nutrition_normal_amount = 10
	nutrition_quality_amount = 0

	flavor = "fat"

/reagent/nutrition/fat/goliath
	name = "goliath fat"
	desc = "Nutrition and flavor from goliath fat."
	color = "#EAD5A4"

	nutrition_fast_amount = 5
	nutrition_normal_amount = 10
	nutrition_quality_amount = 5

	flavor = "fat"



//Meat
/reagent/nutrition/meat/
	name = "raw mystery meat"
	desc = "Nutrition and flavor from raw meat."
	color = "#EA4147"


	nutrition_fast_amount = 10
	nutrition_normal_amount = 10
	nutrition_quality_amount = 0

	heal_amount = 5

	flavor = "raw meat"

	flags_flavor = FLAG_FLAVOR_MEAT | FLAG_FLAVOR_RAW

	liquid = 0.2

	flags_reagent = FLAG_REAGENT_RAW

	heated_reagent_temp = 335
	heated_reagent_mul = 0.01
	heated_reagent_amount = 1

	attribute_experience_per_nutrition = list(
		ATTRIBUTE_STRENGTH = 0.5
	)

/reagent/nutrition/meat/cooked
	name = "cooked mystery meat"
	desc = "Nutrition and flavor from cooked meat."
	color = "#6B3731"

	flags_flavor = FLAG_FLAVOR_MEAT | FLAG_FLAVOR_COOKED

	flavor = "meat"

	flags_reagent = FLAG_REAGENT_COOKED
	heated_reagent = /reagent/carbon
	heated_reagent_mul = 0.01
	heated_reagent_amount = 0

/reagent/nutrition/meat/cow
	name = "raw cow's meat"
	desc = "Nutrition and flavor from raw cow's meat."
	color = "#BF0000"

	nutrition_fast_amount = 5
	nutrition_normal_amount = 15
	nutrition_quality_amount = 0


	heal_amount = 5

	flavor = "raw meat"

	heated_reagent = /reagent/nutrition/meat/cow/cooked

/reagent/nutrition/meat/cow/cooked
	name = "cooked cow's meat"
	desc = "Nutrition and flavor from cooked cow's meat."
	color = "#6B3731"

	flags_flavor = FLAG_FLAVOR_MEAT | FLAG_FLAVOR_COOKED

	flavor = "beef"

	flags_reagent = FLAG_REAGENT_COOKED
	heated_reagent = /reagent/carbon
	heated_reagent_mul = 0.01
	heated_reagent_amount = 0


/reagent/nutrition/meat/monkey
	name = "raw monkey meat"
	desc = "Nutrition and flavor from raw cow's meat."
	color = "#BF0000"

	nutrition_fast_amount = 5
	nutrition_normal_amount = 15
	nutrition_quality_amount = 0
	heal_amount = 5

	flavor = "raw tangy meat"

	heated_reagent = /reagent/nutrition/meat/monkey/cooked

/reagent/nutrition/meat/monkey/cooked
	name = "cooked monkey meat"
	desc = "Nutrition and flavor from cooked cow's meat."
	color = "#6B3731"

	flags_flavor = FLAG_FLAVOR_MEAT | FLAG_FLAVOR_COOKED

	flavor = "tangy beef"

	flags_reagent = FLAG_REAGENT_COOKED
	heated_reagent = /reagent/carbon
	heated_reagent_mul = 0.01
	heated_reagent_amount = 0

/reagent/nutrition/meat/chicken
	name = "raw chicken"
	desc = "Nutrition and flavor from raw chicken."
	color = "#E2A5BB"

	flags_flavor = FLAG_FLAVOR_CHICKEN | FLAG_FLAVOR_RAW

	nutrition_fast_amount = 5
	nutrition_normal_amount = 10
	nutrition_quality_amount = 5
	heal_amount = 2

	flavor = "raw chicken"

	heated_reagent = /reagent/nutrition/meat/chicken/cooked

/reagent/nutrition/meat/chicken/cooked
	name = "cooked chicken"
	desc = "Nutrition and flavor from cooked chicken."
	color = "#F2DCD1"

	flags_flavor = FLAG_FLAVOR_CHICKEN | FLAG_FLAVOR_COOKED

	flavor = "chicken"

	flags_reagent = FLAG_REAGENT_COOKED
	heated_reagent = /reagent/carbon
	heated_reagent_mul = 0.01
	heated_reagent_amount = 0

/reagent/nutrition/meat/xeno
	name = "raw xeno meat"
	desc = "Nutrition and flavor from raw xeno meat."
	color = "#336B42"

	flags_flavor = FLAG_FLAVOR_CHICKEN | FLAG_FLAVOR_RAW | FLAG_FLAVOR_GROSS

	nutrition_fast_amount = 0
	nutrition_normal_amount = 20
	nutrition_quality_amount = 0
	heal_amount = 5

	flavor = "mistakes"

	heated_reagent = /reagent/nutrition/meat/xeno/cooked

/reagent/nutrition/meat/xeno/cooked
	name = "cooked xeno meat"
	desc = "Nutrition and flavor from cooked xeno meat."
	color = "#293D2E"

	flavor = "space aliens"

	flags_flavor = FLAG_FLAVOR_CHICKEN | FLAG_FLAVOR_COOKED

	flags_reagent = FLAG_REAGENT_COOKED
	heated_reagent = /reagent/carbon
	heated_reagent_mul = 0.01
	heated_reagent_amount = 0



/reagent/nutrition/meat/arachnid
	name = "raw arachnid meat"
	desc = "Nutrition and flavor from raw arachnid meat."
	color = "#80BA2B"

	flags_flavor = FLAG_FLAVOR_CHICKEN | FLAG_FLAVOR_RAW | FLAG_FLAVOR_GROSS

	nutrition_fast_amount = 0
	nutrition_normal_amount = 15
	nutrition_quality_amount = 5
	heal_amount = 10

	flavor = "sour dirt"

	heated_reagent = /reagent/nutrition/meat/arachnid/cooked

/reagent/nutrition/meat/arachnid/cooked
	name = "cooked arachnid meat"
	desc = "Nutrition and flavor from cooked arachnid meat."
	color = "#9E782D"

	flags_flavor = FLAG_FLAVOR_CHICKEN | FLAG_FLAVOR_COOKED

	flavor = "chicken"

	flags_reagent = FLAG_REAGENT_COOKED
	heated_reagent = /reagent/carbon
	heated_reagent_mul = 0.01
	heated_reagent_amount = 0

/reagent/nutrition/meat/ash_drake
	name = "raw ash drake meat"
	desc = "Nutrition and flavor from raw ash drake meat."
	color = "#C44E55"

	flags_flavor = FLAG_FLAVOR_CHICKEN | FLAG_FLAVOR_RAW | FLAG_FLAVOR_GROSS | FLAG_FLAVOR_NECRO

	heated_reagent_temp = 750
	heated_reagent_mul = 0.01
	heated_reagent_amount = 1

	nutrition_fast_amount = 5
	nutrition_normal_amount = 0
	nutrition_quality_amount = 15
	heal_amount = 10

	flavor = "sour dirt"

	heated_reagent = /reagent/nutrition/meat/ash_drake/cooked

/reagent/nutrition/meat/ash_drake/cooked
	name = "cooked ash drake meat"
	desc = "Nutrition and flavor from cooked ash drake meat."
	color = "#8E5627"

	flags_flavor = FLAG_FLAVOR_CHICKEN | FLAG_FLAVOR_COOKED | FLAG_FLAVOR_GROSS | FLAG_FLAVOR_NECRO

	flavor = "chicken"

	flags_reagent = FLAG_REAGENT_COOKED
	heated_reagent_temp = 1000
	heated_reagent = /reagent/ash
	heated_reagent_mul = 0.01
	heated_reagent_amount = 0


/reagent/nutrition/meat/bubblegum
	name = "raw bubblegum meat"
	desc = "Nutrition and flavor from raw bubblegum meat."
	color = "#C44E55"

	flags_flavor = FLAG_FLAVOR_CHICKEN | FLAG_FLAVOR_RAW | FLAG_FLAVOR_GROSS

	heated_reagent_temp = 750
	heated_reagent_mul = 0.01
	heated_reagent_amount = 1

	nutrition_fast_amount = 5
	nutrition_normal_amount = 0
	nutrition_quality_amount = 20
	heal_amount = 10

	flavor = "brains"

	heated_reagent = /reagent/nutrition/meat/bubblegum/cooked

/reagent/nutrition/meat/bubblegum/cooked
	name = "cooked bubblegum meat"
	desc = "Nutrition and flavor from cooked bubblegum meat."
	color = "#8E5627"

	flags_flavor = FLAG_FLAVOR_CHICKEN | FLAG_FLAVOR_COOKED | FLAG_FLAVOR_GROSS

	flavor = "cooked brains"

	flags_reagent = FLAG_REAGENT_COOKED
	heated_reagent_temp = 1100
	heated_reagent = /reagent/ash
	heated_reagent_mul = 0.01
	heated_reagent_amount = 0

/reagent/nutrition/meat/colossus
	name = "raw colossus meat"
	desc = "Nutrition and flavor from raw colossus meat."
	color = "#AD0000"

	flags_flavor = FLAG_FLAVOR_CHICKEN | FLAG_FLAVOR_RAW | FLAG_FLAVOR_GROSS

	heated_reagent_temp = 750
	heated_reagent_mul = 0.01
	heated_reagent_amount = 1

	nutrition_fast_amount = 0
	nutrition_normal_amount = 5
	nutrition_quality_amount = 15
	heal_amount = 5

	flavor = "tough raw jerky"

	heated_reagent = /reagent/nutrition/meat/colossus/cooked

/reagent/nutrition/meat/colossus/cooked
	name = "cooked colossus meat"
	desc = "Nutrition and flavor from cooked colossus meat."
	color = "#633700"

	flags_flavor = FLAG_FLAVOR_CHICKEN | FLAG_FLAVOR_COOKED

	flavor = "tough jerky"

	flags_reagent = FLAG_REAGENT_COOKED
	heated_reagent_temp = 1100
	heated_reagent = /reagent/ash
	heated_reagent_mul = 0.01
	heated_reagent_amount = 0



/reagent/nutrition/meat/goliath
	name = "raw goliath meat"
	desc = "Nutrition and flavor from raw goliath meat."
	color = "#A54343"

	flags_flavor = FLAG_FLAVOR_CHICKEN | FLAG_FLAVOR_RAW | FLAG_FLAVOR_GROSS

	heated_reagent_temp = 750
	heated_reagent_mul = 0.01
	heated_reagent_amount = 1

	nutrition_fast_amount = 0
	nutrition_normal_amount = 0
	nutrition_quality_amount = 0
	heal_amount = 0

	flavor = "rocks"

	heated_reagent = /reagent/nutrition/meat/goliath/cooked

/reagent/nutrition/meat/goliath/cooked
	name = "cooked goliath meat"
	desc = "Nutrition and flavor from cooked goliath meat."
	color = "#823613"

	flags_flavor = FLAG_FLAVOR_CHICKEN | FLAG_FLAVOR_COOKED

	nutrition_fast_amount = 5
	nutrition_normal_amount = 15
	nutrition_quality_amount = 0
	heal_amount = 10

	flavor = "filet mignon"

	flags_reagent = FLAG_REAGENT_COOKED
	heated_reagent_temp = 1100
	heated_reagent = /reagent/ash
	heated_reagent_mul = 0.01
	heated_reagent_amount = 0






/reagent/nutrition/meat/spider
	name = "raw spider meat"
	desc = "Nutrition and flavor from raw spider meat."
	color = "#19B03E"

	flags_flavor = FLAG_FLAVOR_CHICKEN | FLAG_FLAVOR_RAW | FLAG_FLAVOR_GROSS

	nutrition_fast_amount = 10
	nutrition_normal_amount = 10
	nutrition_quality_amount = 0

	heal_amount = 5

	flavor = "hair"

	heated_reagent = /reagent/nutrition/meat/spider/cooked

/reagent/nutrition/meat/spider/cooked
	name = "cooked spider meat"
	desc = "Nutrition and flavor from cooked spider meat."
	color = "#A0DBAF"

	flags_flavor = FLAG_FLAVOR_CHICKEN | FLAG_FLAVOR_COOKED | FLAG_FLAVOR_GROSS

	flavor = "web"

	flags_reagent = FLAG_REAGENT_COOKED
	heated_reagent = /reagent/carbon
	heated_reagent_mul = 0.01
	heated_reagent_amount = 0

/reagent/nutrition/meat/bear
	name = "raw bear meat"
	desc = "Nutrition and flavor from raw bear meat."
	color = "#BA0214"

	flags_flavor = FLAG_FLAVOR_MEAT | FLAG_FLAVOR_RAW

	nutrition_fast_amount = 5
	nutrition_normal_amount = 0
	nutrition_quality_amount = 15

	heal_amount = 20

	flavor = "unbearable meat"

	heated_reagent = /reagent/nutrition/meat/bear/cooked

/reagent/nutrition/meat/bear/cooked
	name = "cooked bear meat"
	desc = "Nutrition and flavor from cooked bear meat."
	color = "#57040D"

	flags_flavor = FLAG_FLAVOR_MEAT | FLAG_FLAVOR_COOKED | FLAG_FLAVOR_LOVE

	flavor = "slavic cooking"

	flags_reagent = FLAG_REAGENT_COOKED
	heated_reagent = /reagent/carbon
	heated_reagent_mul = 0.01
	heated_reagent_amount = 0

/reagent/nutrition/meat/penguin
	name = "raw penguin meat"
	desc = "Nutrition and flavor from raw penguin meat."
	color = "#B39497"

	flags_flavor = FLAG_FLAVOR_CHICKEN | FLAG_FLAVOR_FISH | FLAG_FLAVOR_RAW

	nutrition_fast_amount = 5
	nutrition_normal_amount = 10
	nutrition_quality_amount = 5
	heal_amount = 5

	flavor = "ice"

	heated_reagent = /reagent/nutrition/meat/penguin/cooked

/reagent/nutrition/meat/penguin/cooked
	name = "cooked penguin meat"
	desc = "Nutrition and flavor from cooked penguin meat."
	color = "#756A63"

	flags_flavor = FLAG_FLAVOR_CHICKEN | FLAG_FLAVOR_FISH | FLAG_FLAVOR_COOKED

	flavor = "igloos"

	flags_reagent = FLAG_REAGENT_COOKED
	heated_reagent = /reagent/carbon
	heated_reagent_mul = 0.01
	heated_reagent_amount = 0

/reagent/nutrition/meat/fish
	name = "raw fish"
	desc = "Nutrition and flavor from raw fish."
	color = "#F0D8E0"

	flags_flavor = FLAG_FLAVOR_FISH | FLAG_FLAVOR_RAW

	nutrition_fast_amount = 5
	nutrition_normal_amount = 5
	nutrition_quality_amount = 10

	heal_amount = 5

	heated_reagent = /reagent/nutrition/meat/fish/cooked

	flavor = "raw fish"

/reagent/nutrition/meat/fish/cooked
	name = "cooked fish"
	desc = "Nutrition and flavor from cooked fish."
	color = "#CFBE91"

	flags_flavor = FLAG_FLAVOR_FISH | FLAG_FLAVOR_COOKED

	flavor = "cooked fish"

	flags_reagent = FLAG_REAGENT_COOKED
	heated_reagent = /reagent/carbon
	heated_reagent_mul = 0.01
	heated_reagent_amount = 0

/reagent/nutrition/meat/fish/quality
	name = "raw high-grade fish"
	desc = "Nutrition and flavor from high-grade raw fish."
	color = "#F0D8E0"

	nutrition_fast_amount = 0
	nutrition_normal_amount = 5
	nutrition_quality_amount = 15

	heal_amount = 10

	heated_reagent = /reagent/nutrition/meat/fish/quality/cooked

	flavor = "raw high quality fish"

/reagent/nutrition/meat/fish/quality/cooked
	name = "cooked high-grade fish"
	desc = "Nutrition and flavor from cooked high-grade fish."
	color = "#CFBE91"

	flags_flavor = FLAG_FLAVOR_FISH | FLAG_FLAVOR_COOKED

	flavor = "high quality fish"

	flags_reagent = FLAG_REAGENT_COOKED
	heated_reagent = /reagent/carbon
	heated_reagent_mul = 0.01
	heated_reagent_amount = 0

/reagent/nutrition/meat/crab
	name = "raw crab meat"
	desc = "Nutrition and flavor from raw crab meat."
	color = "#EB8046"

	flags_flavor = FLAG_FLAVOR_FISH | FLAG_FLAVOR_RAW

	nutrition_fast_amount = 5
	nutrition_normal_amount = 10
	nutrition_quality_amount = 5

	heal_amount = 5

	flavor = "seashells"

	heated_reagent = /reagent/nutrition/meat/crab/cooked

/reagent/nutrition/meat/crab/cooked
	name = "cooked crab meat"
	desc = "Nutrition and flavor from cooked crab meat."
	color = "#D45B19"

	flags_flavor = FLAG_FLAVOR_FISH | FLAG_FLAVOR_COOKED

	flavor = "the ocean"

	flags_reagent = FLAG_REAGENT_COOKED
	heated_reagent = /reagent/carbon
	heated_reagent_mul = 0.01
	heated_reagent_amount = 0


/reagent/nutrition/meat/lobster
	name = "raw lobster meat"
	desc = "Nutrition and flavor from raw crab meat."
	color = "#EAD8CE"

	flags_flavor = FLAG_FLAVOR_FISH | FLAG_FLAVOR_RAW

	nutrition_fast_amount = 5
	nutrition_normal_amount = 5
	nutrition_quality_amount = 10

	heal_amount = 5

	flavor = "seashells"

	heated_reagent = /reagent/nutrition/meat/lobster/cooked

/reagent/nutrition/meat/lobster/cooked
	name = "cooked lobster meat"
	desc = "Nutrition and flavor from cooked crab meat."
	color = "#E8BAA2"

	flags_flavor = FLAG_FLAVOR_FISH | FLAG_FLAVOR_COOKED

	flavor = "the ocean"

	flags_reagent = FLAG_REAGENT_COOKED
	heated_reagent = /reagent/carbon
	heated_reagent_mul = 0.01
	heated_reagent_amount = 0

/reagent/nutrition/egg_white
	name = "egg whites"
	desc = "Nutrition and flavor from egg whites."
	color = "#FFD865"

	nutrition_fast_amount = 0
	nutrition_normal_amount = 10
	nutrition_quality_amount = 5

	heal_amount = 1

	flavor = "egg white"

/reagent/nutrition/egg_yellow
	name = "egg yolk"
	desc = "Nutrition and flavor from egg yellows."
	color = "#FFFFE4"

	nutrition_fast_amount = 10
	nutrition_normal_amount = 10
	nutrition_quality_amount = 10

	heal_amount = 10

	flavor = "egg yolk"