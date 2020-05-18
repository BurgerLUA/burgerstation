/obj/item/container/beaker/food/
	overide_icon = TRUE

/obj/item/container/beaker/food/flour
	name = "sack of white flour"
	icon = 'icons/obj/items/container/cooking.dmi'
	icon_state = "flour"

/obj/item/container/beaker/food/flour/Generate()
	reagents.add_reagent("flour_white",reagents.volume_max)
	return ..()

/obj/item/container/beaker/food/milk
	name = "carton of cow's milk"
	icon = 'icons/obj/items/container/cooking.dmi'
	icon_state = "milk"

/obj/item/container/beaker/food/milk/Generate()
	reagents.add_reagent("milk_cow",reagents.volume_max)
	return ..()
