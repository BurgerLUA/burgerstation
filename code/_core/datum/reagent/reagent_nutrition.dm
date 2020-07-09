#define NUTRITION_MULTIPLIER 2

/reagent/nutrition/
	name = "nutrients"
	desc = "A source of nutrition."
	color = "#FFFFFF"

	metabolism_stomach = 4

	var/nutrition_amount = 0 //Per unit
	var/hydration_amount = 0 //Per unit
	var/heal_factor = 0.1

	value = 1

	liquid = -0.25

	heated_reagent = /reagent/carbon
	heated_reagent_temp = 300
	heated_reagent_amount = 0
	heated_reagent_mul = 0.01

/reagent/nutrition/on_add(var/reagent_container/container,var/amount_added=0,var/current_volume=0)

	. = ..()

	if(amount_added && (container.flags_metabolism & REAGENT_METABOLISM_INGEST) && is_living(container.owner.loc))
		var/mob/living/L = container.owner.loc
		. *= 0.5
		if(nutrition_amount)
			L.add_nutrition(nutrition_amount*.*NUTRITION_MULTIPLIER,FALSE)
		if(hydration_amount)
			L.add_hydration(hydration_amount*.*NUTRITION_MULTIPLIER,FALSE)

	return .

/reagent/nutrition/on_metabolize_stomach(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)

	. = ..()

	var/mob/living/L = owner
	if(nutrition_amount)
		L.add_nutrition(nutrition_amount*.*NUTRITION_MULTIPLIER,FALSE)
	if(hydration_amount)
		L.add_hydration(hydration_amount*.*NUTRITION_MULTIPLIER,FALSE)

	if(owner && owner.health)
		var/amount_to_heal = (nutrition_amount + hydration_amount)*heal_factor*.
		owner.health.adjust_loss_smart(brute=-amount_to_heal,burn=-amount_to_heal)

	return .

//Flour
/reagent/nutrition/wheat_grain
	name = "wheat grain"
	desc = "Ground up wheat. Process this to get flour."
	color = "#AD9300"

	nutrition_amount = 1.5

	flavor = "gross oats"

	processed_reagent = /reagent/nutrition/wheat_grain/flour

	liquid = -0.75

/reagent/nutrition/wheat_grain/flour
	name = "whole wheat flour"
	desc = "Processed wheat grains for use in baking. Process this some more to get white flour."
	color = "#A5771C"

	nutrition_amount = 1.75

	flavor = "gross dry oat flour"

	processed_reagent = /reagent/nutrition/wheat_grain/flour/processed

	liquid = -0.75

/reagent/nutrition/wheat_grain/flour/processed
	name = "white flour"
	desc = "Finely processed white flour for use in baking."
	color = "#FFF8ED"

	nutrition_amount = 1.5

	flavor = "gross dry flour"

	liquid = -0.75

/reagent/nutrition/corn_flour
	name = "corn flour"
	desc = "Also called corn starch. One of the biproducts of processing corn."
	color = "#E0AC33"

	nutrition_amount = 0.75

	flavor = "corn starch"

	liquid = -1

//Dough
/reagent/nutrition/dough
	name = "wheat grain dough"
	desc = "Crudely mixed and made wheat dough."
	color = "#AA9970"

	nutrition_amount = 1.5

	flavor = "raw oaty dough"

	liquid = 0.25

	flags_reagent = FLAG_REAGENT_RAW

	heated_reagent = /reagent/nutrition/bread
	heated_reagent_temp = 370
	heated_reagent_amount = 0.3
	heated_reagent_mul = 0.01

/reagent/nutrition/dough/flour
	name = "whole wheat flour dough"
	desc = "Typical whole wheat water-flour based dough."
	color = "#D8BD6C"

	nutrition_amount = 1.75

	flavor = "raw oaty dough"

	liquid = 0.25

	heated_reagent = /reagent/nutrition/bread/flour

/reagent/nutrition/dough/flour/processed
	name = "white flour dough"
	desc = "Typical whole wheat water-flour based dough."
	color = "#E5D4A2"

	nutrition_amount = 1.5

	flavor = "raw dough"

	liquid = 0.25

	heated_reagent = /reagent/nutrition/bread/flour/processed

//Bread
/reagent/nutrition/bread
	name = "wheat grain bread"
	desc = "Crudely mixed and made wheat bread."
	color = "#A09170"

	nutrition_amount = 1.5

	flavor = "tough bread"

	liquid = -0.25

	flags_reagent = FLAG_REAGENT_COOKED

	heated_reagent_temp = 370
	heated_reagent_mul = 0.003

/reagent/nutrition/bread/flour
	name = "whole grain bread"
	desc = "Typical whole wheat water-flour based bread."
	color = "#A8784D"

	nutrition_amount = 1.75

	flavor = "whole grain bread"

	liquid = -0.25

/reagent/nutrition/bread/flour/processed
	name = "white bread"
	desc = "Typical water-flour based bread."
	color = "#E0AC33"

	nutrition_amount = 1.5

	flavor = "white bread"

	liquid = -0.25

//Cake
/reagent/nutrition/cake_batter
	name = "cake batter"
	desc = "Typical cake batter."
	color = "#DDBE8F"

	nutrition_amount = 1.5

	flavor = "raw dough"

	liquid = 0.25

	flags_reagent = FLAG_REAGENT_RAW

	heated_reagent = /reagent/nutrition/cake
	heated_reagent_temp = 370
	heated_reagent_amount = 0.03
	heated_reagent_mul = 0.05

/reagent/nutrition/cake
	name = "cake"
	desc = "Cooked cake."
	color = "#BC9253"

	nutrition_amount = 4

	flavor = "cake"

	liquid = -0.125

	flags_reagent = FLAG_REAGENT_COOKED

/reagent/nutrition/sugar
	name = "white sugar"
	desc = "Processed sugar."
	color = "#F4FFF8"

	nutrition_amount = 3

	flavor = "sweetness"

	liquid = -0.4

/reagent/nutrition/sugar/cane
	name = "cane sugar"
	desc = "Unprocessed sugarcane sugar."
	color = "#CEA171"

	nutrition_amount = 2

	flavor = "sweetness"

/reagent/nutrition/sugar/icing
	name = "icing sugar"
	desc = "White and fluffy icing sugar."
	color = "#F4FFF8"

	nutrition_amount = 2.5

	flavor = "icing sugar"

/reagent/nutrition/icing
	name = "white icing"
	desc = "White icing."
	color = "#FFFFFF"

	nutrition_amount = 2

	flavor = "icing"


/reagent/nutrition/chanterelle
	name = "chanterelle"
	desc = "Nutrition and flavor from a chanterelle mushroom."
	color = "#FFDD8F"

	nutrition_amount = 1

	flavor = "mushroom"

	liquid = -0.2

/reagent/nutrition/tomato
	name = "tomato paste"
	desc = "Nutrition and flavor from a tomato."
	color = "#C90000"

	nutrition_amount = 1

	flavor = "tomato"

	liquid = 0.3

/reagent/nutrition/cabbage
	name = "cabbage"
	desc = "Nutrition and flavor from a cabbage."
	color = "#658268"

	nutrition_amount = 1

	flavor = "cabbage"

	liquid = 0

//Milk
/reagent/nutrition/milk/
	name = "cow's milk"
	desc = "Nutrition and flavor from cow's milk."
	color = "#FFFFFF"

	nutrition_amount = 1
	hydration_amount = 1

	flavor = "milk"

	liquid = 0.5

/reagent/nutrition/cream
	name = "milk cream"
	desc = "Nutrition and flavor from milk cream."
	color = "#EEEED9"

	nutrition_amount = 3
	hydration_amount = 0.5

	flavor = "milk"

	liquid = 0.5

	processed_reagent = /reagent/nutrition/butter

//Cheese
/reagent/nutrition/cheese/
	name = "processed cheese"
	desc = "Nutrition and flavor from processed cheese."
	color = "#FFC237"

	nutrition_amount = 1.5

	flavor = "processed cheese"

	liquid = 0.2

/reagent/nutrition/cheese/kadchgall
	name = "Kadchgall Desert cheese"
	desc = "Nutrition and flavor from Kadchgall cheese."
	color = "#FFE8AA"

	nutrition_amount = 4

	flavor = "processed cheese"

	liquid = 0.2

/reagent/nutrition/cheese/cheddar
	name = "cheddar cheese"
	desc = "Nutrition and flavor from cheddar cheese."
	color = "#FF9F00"

	nutrition_amount = 4

	flavor = "sharp cheddar cheese"

	liquid = 0.2

/reagent/nutrition/cheese/brabander
	name = "Old Brabander Jungle cheese"
	desc = "Nutrition and flavor from Old Brabander Jungle cheese."
	color = "#FFFCE8"

	nutrition_amount = 4

	flavor = "sweet and creamy caramel cheese"

	liquid = 0.2


/reagent/nutrition/cheese/raclette
	name = "Raclette Alpine cheese"
	desc = "Nutrition and flavor from Raclette Alpine cheese."
	color = "#FFF09F"

	nutrition_amount = 4

	flavor = "sweet nutty cheese"

	liquid = 0.2

/reagent/nutrition/cheese/gruyere
	name = "Gruyère cave cheese"
	desc = "Nutrition and flavor from Gruyère cave cheese."
	color = "#E4A300"

	nutrition_amount = 4

	flavor = "sweet and salty nutty cream cheese"

	liquid = 0.2

/reagent/nutrition/cheese/guava
	name = "Smoked Guava cheese"
	desc = "Nutrition and flavor from Smoked Guava cheese."
	color = "#704226"

	nutrition_amount = 4

	flavor = "sweet fudge cheese"

	liquid = 0.2

/reagent/nutrition/cheese/bluespace
	name = "bluespace cheese"
	desc = "Nutrition and flavor from bluespace cheese."
	color = "#78A093"

	nutrition_amount = 4

	flavor = "bluespace cheese"

	liquid = 0.2


//Fat


/reagent/nutrition/flavor/ //TODO: Give buffs.
	name = "flavor"
	desc = "Pure flavor."
	color = "#EAD5A4"

	nutrition_amount = 3

	flavor = "flavor"

	liquid = 0.3

	flags_reagent = FLAG_REAGENT_FAT

/reagent/nutrition/fat/
	name = "fat"
	desc = "Nutrition and flavor from fat."
	color = "#EAD5A4"

	nutrition_amount = 2

	flavor = "fat"

	liquid = 0.1

	flags_reagent = FLAG_REAGENT_FAT

	heated_reagent = /reagent/nutrition/flavor/
	heated_reagent_temp = 328
	heated_reagent_mul = 0.01

/reagent/nutrition/fat/cow
	name = "cow's fat"
	desc = "Nutrition and flavor from cow's fat."
	color = "#EAD5A4"

	nutrition_amount = 2

	flavor = "fat"

/reagent/nutrition/fat/bear
	name = "bear's fat"
	desc = "Nutrition and flavor from bear's fat."
	color = "#EAD5A4"

	nutrition_amount = 2

	flavor = "fat"

/reagent/nutrition/fat/penguin
	name = "penguin's fat"
	desc = "Nutrition and flavor from penguin's fat."
	color = "#EAD5A4"

	nutrition_amount = 2

	flavor = "fat"

/reagent/nutrition/fat/fish
	name = "fish's fat"
	desc = "Nutrition and flavor from fish's fat."
	color = "#EAD5A4"

	nutrition_amount = 2

	flavor = "fat"

/reagent/nutrition/fat/crab
	name = "crab's fat"
	desc = "Nutrition and flavor from crab's fat."
	color = "#EAD5A4"

	nutrition_amount = 2

	flavor = "fat"


//Meat
/reagent/nutrition/meat/
	name = "raw mystery meat"
	desc = "Nutrition and flavor from raw meat."
	color = "#EA4147"

	nutrition_amount = 4

	flavor = "raw meat"

	liquid = 0.2

	flags_reagent = FLAG_REAGENT_RAW

	heated_reagent_temp = 335
	heated_reagent_mul = 0.01
	heated_reagent_amount = 1

/reagent/nutrition/meat/cow
	name = "raw cow's meat"
	desc = "Nutrition and flavor from raw cow's meat."
	color = "#BF0000"

	nutrition_amount = 4

	flavor = "raw meat"

	heated_reagent = /reagent/nutrition/meat/cow/cooked

/reagent/nutrition/meat/cow/cooked
	name = "cooked cow's meat"
	desc = "Nutrition and flavor from cooked cow's meat."
	color = "#6B3731"

	nutrition_amount = 3

	flavor = "beef"

	flags_reagent = FLAG_REAGENT_COOKED
	heated_reagent = /reagent/carbon
	heated_reagent_mul = 0.01
	heated_reagent_amount = 0

/reagent/nutrition/meat/chicken
	name = "raw chicken"
	desc = "Nutrition and flavor from raw chicken."
	color = "#E2A5BB"

	nutrition_amount = 3

	flavor = "raw chicken"

	heated_reagent = /reagent/nutrition/meat/chicken/cooked

/reagent/nutrition/meat/chicken/cooked
	name = "cooked chicken"
	desc = "Nutrition and flavor from cooked chicken."
	color = "#F2DCD1"

	nutrition_amount = 2

	flavor = "chicken"

	flags_reagent = FLAG_REAGENT_COOKED
	heated_reagent = /reagent/carbon
	heated_reagent_mul = 0.01
	heated_reagent_amount = 0

/reagent/nutrition/meat/xeno
	name = "raw xeno meat"
	desc = "Nutrition and flavor from raw xeno meat."
	color = "#336B42"

	nutrition_amount = 4

	flavor = "mistakes"

	heated_reagent = /reagent/nutrition/meat/xeno/cooked

/reagent/nutrition/meat/xeno/cooked
	name = "cooked xeno meat"
	desc = "Nutrition and flavor from cooked xeno meat."
	color = "#293D2E"

	nutrition_amount = 3

	flavor = "space aliens"

	flags_reagent = FLAG_REAGENT_COOKED
	heated_reagent = /reagent/carbon
	heated_reagent_mul = 0.01
	heated_reagent_amount = 0

/reagent/nutrition/meat/spider
	name = "raw spider meat"
	desc = "Nutrition and flavor from raw spider meat."
	color = "#19B03E"

	nutrition_amount = 3

	flavor = "hair"

	heated_reagent = /reagent/nutrition/meat/spider/cooked

/reagent/nutrition/meat/spider/cooked
	name = "cooked spider meat"
	desc = "Nutrition and flavor from cooked spider meat."
	color = "#A0DBAF"

	nutrition_amount = 2

	flavor = "web"

	flags_reagent = FLAG_REAGENT_COOKED
	heated_reagent = /reagent/carbon
	heated_reagent_mul = 0.01
	heated_reagent_amount = 0

/reagent/nutrition/meat/bear
	name = "raw bear meat"
	desc = "Nutrition and flavor from raw bear meat."
	color = "#BA0214"

	nutrition_amount = 5

	flavor = "bearable"

	heated_reagent = /reagent/nutrition/meat/bear/cooked

/reagent/nutrition/meat/bear/cooked
	name = "cooked bear meat"
	desc = "Nutrition and flavor from cooked bear meat."
	color = "#57040D"

	nutrition_amount = 4

	flavor = "russia"

	flags_reagent = FLAG_REAGENT_COOKED
	heated_reagent = /reagent/carbon
	heated_reagent_mul = 0.01
	heated_reagent_amount = 0

/reagent/nutrition/meat/penguin
	name = "raw penguin meat"
	desc = "Nutrition and flavor from raw penguin meat."
	color = "#B39497"

	nutrition_amount = 3

	flavor = "ice"

	heated_reagent = /reagent/nutrition/meat/penguin/cooked

/reagent/nutrition/meat/penguin/cooked
	name = "cooked penguin meat"
	desc = "Nutrition and flavor from cooked penguin meat."
	color = "#756A63"

	nutrition_amount = 2

	flavor = "igloos"

	flags_reagent = FLAG_REAGENT_COOKED
	heated_reagent = /reagent/carbon
	heated_reagent_mul = 0.01
	heated_reagent_amount = 0

/reagent/nutrition/meat/fish
	name = "raw fish"
	desc = "Nutrition and flavor from raw fish."
	color = "#F0D8E0"

	flags_reagent = FLAG_REAGENT_COOKED
	heated_reagent = /reagent/carbon
	heated_reagent_mul = 0.01
	heated_reagent_amount = 0

	flavor = "fish"

	heated_reagent = /reagent/nutrition/meat/fish/cooked

/reagent/nutrition/meat/fish/cooked
	name = "cooked fish"
	desc = "Nutrition and flavor from cooked fish."
	color = "#CFBE91"

	nutrition_amount = 2

	flavor = "FISH"

	flags_reagent = FLAG_REAGENT_COOKED
	heated_reagent = /reagent/carbon
	heated_reagent_mul = 0.01
	heated_reagent_amount = 0

/reagent/nutrition/meat/crab
	name = "raw crab meat"
	desc = "Nutrition and flavor from raw crab meat."
	color = "#EB8046"

	nutrition_amount = 4

	flavor = "seashells"

	heated_reagent = /reagent/nutrition/meat/crab/cooked

/reagent/nutrition/meat/crab/cooked
	name = "cooked crab meat"
	desc = "Nutrition and flavor from cooked crab meat."
	color = "#D45B19"

	nutrition_amount = 4

	flavor = "the ocean"

	flags_reagent = FLAG_REAGENT_COOKED
	heated_reagent = /reagent/carbon
	heated_reagent_mul = 0.01
	heated_reagent_amount = 0

/reagent/nutrition/junk/
	name = "junk food"
	desc = "Nutrition and flavor from junk food."
	color = "#AAAAAA"

	nutrition_amount = 1

	flavor = "grease"

	value = 0.2

	liquid = -0.75

/reagent/nutrition/junk/chips
	name = "chips"
	desc = "Nutrition and flavor from chips."
	color = "#FFDE7C"

	nutrition_amount = 1.25

	flavor = "chips"

/reagent/nutrition/junk/chocolate
	name = "low quality milk chocolate"
	desc = "Nutrition and flavor from low quality chocolate."
	color = "#68452A"

	nutrition_amount = 1.25

	flavor = "bland chocolate"

/reagent/nutrition/junk/jerky
	name = "soy jerky"
	desc = "Nutrition and flavor from soy jerky."
	color = "#683013"

	nutrition_amount = 1.25

	flavor = "soy meat"

/reagent/nutrition/junk/raisins
	name = "dried sweet raisins"
	desc = "Nutrition and flavor from dried sweet raisins."
	color = "#470068"

	nutrition_amount = 1.25

	flavor = "sour raisins"

/reagent/nutrition/junk/cake
	name = "yellow cake"
	desc = "Nutrition and flavor from yellow cake."
	color = "#FFE97C"

	nutrition_amount = 1.5

	flavor = "bland overmoist cake"


/reagent/nutrition/junk/cream_filling
	name = "sugar cream filling"
	desc = "Nutrition and flavor from cream filling cake."
	color = "#E1FFFF"

	nutrition_amount = 1.5

	flavor = "sugary cream filling"

/reagent/nutrition/junk/cheese_powder
	name = "cheese powder"
	desc = "Nutrition and flavor from cheese powder."
	color = "#FF6A00"

	nutrition_amount = 1

	flavor = "cheese powder"


/reagent/nutrition/butter
	name = "butter"
	desc = "Nutrition and flavor from butter."
	color = "#FFD865"

	nutrition_amount = 3

	flavor = "butter"

	value = 2

/reagent/nutrition/egg_white
	name = "egg whites"
	desc = "Nutrition and flavor from egg whites."
	color = "#FFD865"

	nutrition_amount = 2

	flavor = "egg white"

	value = 2

/reagent/nutrition/egg_yellow
	name = "egg yolk"
	desc = "Nutrition and flavor from egg yellows."
	color = "#FFFFE4"

	nutrition_amount = 6

	flavor = "egg yolk"

	value = 4

