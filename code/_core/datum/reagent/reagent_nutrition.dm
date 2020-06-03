/reagent/nutrition/
	name = "nutrients"
	desc = "A source of nutrition."
	color = "#FFFFFF"

	metabolism_stomach = 8

	var/nutrition_amount = 0 //Per unit
	var/hydration_amount = 0 //Per unit


	value = 1

	liquid = -0.25

/reagent/nutrition/on_add(var/reagent_container/container,var/amount_added=0,var/current_volume=0)

	. = ..()

	if(amount_added && (container.flags_metabolism & REAGENT_METABOLISM_INGEST) && is_living(container.owner.loc))
		var/mob/living/L = container.owner.loc
		. *= 0.5
		if(nutrition_amount)
			L.add_nutrition(nutrition_amount*.,FALSE)
		if(hydration_amount)
			L.add_hydration(hydration_amount*.,FALSE)


	return .

/reagent/nutrition/on_metabolize_stomach(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)

	. = ..()

	var/mob/living/L = owner
	if(nutrition_amount)
		L.add_nutrition(nutrition_amount*.,FALSE)
	if(hydration_amount)
		L.add_hydration(hydration_amount*.,FALSE)

	if(owner && owner.health)
		owner.health.adjust_loss_smart(brute=-.*nutrition_amount,burn=-.*nutrition_amount,tox=-.*nutrition_amount,oxy=-.*nutrition_amount)

	return .

//Flour
/reagent/nutrition/wheat_grain
	name = "wheat grain"
	desc = "Ground up wheat. Process this to get flour."
	color = "#AD9300"

	nutrition_amount = 1.5

	flavor = "gross oats"

	processed_reagent = "flour_whole_wheat"

	liquid = -0.75

/reagent/nutrition/wheat_grain/flour
	name = "whole wheat flour"
	desc = "Processed wheat grains for use in baking. Process this some more to get white flour."
	color = "#A5771C"

	nutrition_amount = 1.75

	flavor = "gross dry oat flour"

	processed_reagent = "flour_white"

	liquid = -0.75

/reagent/nutrition/wheat_grain/flour/processed
	name = "white flour"
	desc = "Finely processed white flour for use in baking."
	color = "#FFF8ED"

	nutrition_amount = 1.5

	flavor = "gross dry flour"

	liquid = -0.75

//Dough
/reagent/nutrition/dough
	name = "wheat grain dough"
	desc = "Crudely mixed and made wheat dough."
	color = "#AA9970"

	nutrition_amount = 1.5

	flavor = "raw oaty dough"

	liquid = 0.25

/reagent/nutrition/dough/flour
	name = "whole wheat flour dough"
	desc = "Typical whole wheat water-flour based dough."
	color = "#D8BD6C"

	nutrition_amount = 1.75

	flavor = "raw oaty dough"

	liquid = 0.25

/reagent/nutrition/dough/flour/processed
	name = "white flour dough"
	desc = "Typical whole wheat water-flour based dough."
	color = "#E5D4A2"

	nutrition_amount = 1.5

	flavor = "raw dough"

	liquid = 0.25

//Bread
/reagent/nutrition/bread
	name = "wheat grain bread"
	desc = "Crudely mixed and made wheat dough."
	color = "#A09170"

	nutrition_amount = 1.5

	flavor = "tough bread"

	liquid = -0.25

/reagent/nutrition/bread/flour
	name = "whole grain bread"
	desc = "Typical whole wheat water-flour based dough."
	color = "#A8784D"

	nutrition_amount = 1.75

	flavor = "whole grain bread"

	liquid = -0.25

/reagent/nutrition/bread/flour/processed
	name = "white bread"
	desc = "Typical whole wheat water-flour based dough."
	color = "#E0AC33"

	nutrition_amount = 1.5

	flavor = "white bread"

	liquid = -0.25


/reagent/nutrition/sugar
	name = "white sugar"
	desc = "Processed sugar."
	color = "#F4FFF8"

	nutrition_amount = 3

	flavor = "sweetness"

	liquid = -0.4

/reagent/nutrition/sugar/cane
	name = "sugarcane"
	desc = "Unprocessed sugarcane sugar."
	color = "#CEA171"

	nutrition_amount = 2

	flavor = "sweetness"


/reagent/nutrition/chanterelle
	name = "chanterelle"
	desc = "Nutrition and flavor from a chanterelle mushroom."
	color = "#FFDD8F"

	nutrition_amount = 1

	flavor = "mushroom"

	liquid = -0.1

//Milk
/reagent/nutrition/milk/
	name = "cow's milk"
	desc = "Nutrition and flavor from cow's milk."
	color = "#FFFFFF"

	nutrition_amount = 1
	hydration_amount = 1

	flavor = "milk"

	liquid = 0.5

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
/reagent/nutrition/fat/
	name = "fat"
	desc = "Nutrition and flavor from fat."
	color = "#EAD5A4"

	nutrition_amount = 2

	flavor = "fat"

	liquid = 0.1

	flags_reagent = FLAG_REAGENT_FAT

/reagent/nutrition/fat/cow
	name = "cow's fat"
	desc = "Nutrition and flavor from cow's fat."
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

/reagent/nutrition/meat/cow
	name = "raw cow's meat"
	desc = "Nutrition and flavor from raw cow's meat."
	color = "#EA4147"

	nutrition_amount = 4

	flavor = "raw meat"

/reagent/nutrition/meat/cow/cooked
	name = "cooked cow's meat"
	desc = "Nutrition and flavor from cooked cow's meat."
	color = "#96463C"

	nutrition_amount = 3

	flavor = "beef"

	flags_reagent = FLAG_REAGENT_COOKED

/reagent/nutrition/meat/chicken
	name = "raw chicken"
	desc = "Nutrition and flavor from raw chicken."
	color = "#E2A5BB"

	nutrition_amount = 3

	flavor = "raw chicken"

/reagent/nutrition/meat/chicken/cooked
	name = "cooked chicken"
	desc = "Nutrition and flavor from cooked chicken."
	color = "#F2DCD1"

	nutrition_amount = 2

	flavor = "chicken"

	flags_reagent = FLAG_REAGENT_COOKED


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