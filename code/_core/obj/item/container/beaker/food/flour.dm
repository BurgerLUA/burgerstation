/obj/item/container/beaker/food/
	overide_icon = TRUE

/obj/item/container/beaker/food/flour
	name = "sack of white flour"
	icon = 'icons/obj/item/container/cooking.dmi'
	icon_state = "flour"

/obj/item/container/beaker/food/flour/Generate()
	reagents.add_reagent(/reagent/nutrition/wheat_grain/flour/processed,reagents.volume_max)
	return ..()

/obj/item/container/beaker/food/sugar
	name = "sack of white sugar"
	icon = 'icons/obj/item/container/cooking.dmi'
	icon_state = "sugar"

/obj/item/container/beaker/food/sugar/Generate()
	reagents.add_reagent(/reagent/nutrition/sugar,reagents.volume_max)
	return ..()

/obj/item/container/beaker/food/milk
	name = "carton of cow's milk"
	icon = 'icons/obj/item/container/cooking.dmi'
	icon_state = "milk"

/obj/item/container/beaker/food/milk/Generate()
	reagents.add_reagent(/reagent/nutrition/milk,reagents.volume_max)
	return ..()


/obj/item/container/beaker/food/cream
	name = "carton of cream"
	icon = 'icons/obj/item/container/cooking.dmi'
	icon_state = "cream"

/obj/item/container/beaker/food/cream/Generate()
	reagents.add_reagent(/reagent/nutrition/cream,reagents.volume_max)
	return ..()

/obj/item/container/beaker/food/corn_flour
	name = "container of corn flour"
	icon = 'icons/obj/item/container/cooking.dmi'
	icon_state = "corn_flour"
	reagents = /reagent_container/beaker/bottle/

/obj/item/container/beaker/food/corn_flour/Generate()
	reagents.add_reagent(/reagent/nutrition/corn_flour,reagents.volume_max)
	return ..()