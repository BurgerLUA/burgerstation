/obj/item/container/edible/pourable/


/obj/item/container/edible/pourable/flour
	name = "sack of white flour"
	icon = 'icons/obj/item/container/cooking.dmi'
	icon_state = "flour"

/obj/item/container/edible/pourable/flour/Generate()
	reagents.add_reagent(/reagent/nutrition/wheat_grain/flour/processed,reagents.volume_max)
	return ..()

/obj/item/container/edible/pourable/sugar
	name = "sack of white sugar"
	icon = 'icons/obj/item/container/cooking.dmi'
	icon_state = "sugar"

/obj/item/container/edible/pourable/sugar/Generate()
	reagents.add_reagent(/reagent/nutrition/sugar,reagents.volume_max)
	return ..()

/obj/item/container/edible/pourable/milk
	name = "carton of cow's milk"
	icon = 'icons/obj/item/container/cooking.dmi'
	icon_state = "milk"

/obj/item/container/edible/pourable/milk/Generate()
	reagents.add_reagent(/reagent/nutrition/milk,reagents.volume_max)
	return ..()


/obj/item/container/edible/pourable/cream
	name = "carton of cream"
	icon = 'icons/obj/item/container/cooking.dmi'
	icon_state = "cream"

/obj/item/container/edible/pourable/cream/Generate()
	reagents.add_reagent(/reagent/nutrition/cream,reagents.volume_max)
	return ..()

/obj/item/container/edible/pourable/corn_flour
	name = "container of corn flour"
	icon = 'icons/obj/item/container/cooking.dmi'
	icon_state = "corn_flour"
	reagents = /reagent_container/beaker/bottle/

/obj/item/container/edible/pourable/corn_flour/Generate()
	reagents.add_reagent(/reagent/nutrition/corn_flour,reagents.volume_max)
	return ..()