/obj/item/container/simple/baking
	icon = 'icons/obj/item/container/cooking.dmi'
	reagents = /reagent_container/beaker/large


/obj/item/container/simple/baking/flour
	name = "sack of white flour"
	icon_state = "flour"


/obj/item/container/simple/baking/flour/Generate()
	reagents.add_reagent(/reagent/nutrition/wheat_grain/flour/processed,reagents.volume_max)
	return ..()

/obj/item/container/simple/baking/sugar
	name = "sack of white sugar"
	icon_state = "sugar"

/obj/item/container/simple/baking/sugar/Generate()
	reagents.add_reagent(/reagent/nutrition/sugar,reagents.volume_max)
	return ..()

/obj/item/container/simple/baking/milk
	name = "carton of cow's milk"
	icon_state = "milk"

/obj/item/container/simple/baking/milk/Generate()
	reagents.add_reagent(/reagent/nutrition/milk,reagents.volume_max)
	return ..()


/obj/item/container/simple/baking/cream
	name = "carton of cream"
	icon_state = "cream"

/obj/item/container/simple/baking/cream/Generate()
	reagents.add_reagent(/reagent/nutrition/cream,reagents.volume_max)
	return ..()

/obj/item/container/simple/baking/corn_flour
	name = "container of corn flour"
	icon_state = "corn_flour"
	reagents = /reagent_container/beaker/bottle/ //smaller

/obj/item/container/simple/baking/corn_flour/Generate()
	reagents.add_reagent(/reagent/nutrition/corn_flour,reagents.volume_max)
	return ..()