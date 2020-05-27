/obj/item/container/beaker/bottle/large
	name = "large bottle"
	icon = 'icons/obj/items/container/cup/potion_large.dmi'
	icon_state = "potion"
	icon_count = 16

	reagents = /reagent_container/beaker/bottle/large


/obj/item/container/beaker/bottle/large/water
	name = "flask of water"

/obj/item/container/beaker/bottle/large/water/Generate()
	reagents.add_reagent(/reagent/nutrition/water,reagents.volume_max)
	return ..()

/obj/item/container/beaker/bottle/large/milk
	name = "flask of cow's milk"

/obj/item/container/beaker/bottle/large/milk/Generate()
	reagents.add_reagent(/reagent/nutrition/milk,reagents.volume_max)
	return ..()

/obj/item/container/beaker/bottle/large/enzymes
	name = "flask of enzymes"

/obj/item/container/beaker/bottle/large/enzymes/Generate()
	reagents.add_reagent(/reagent/enzymes,reagents.volume_max)
	return ..()