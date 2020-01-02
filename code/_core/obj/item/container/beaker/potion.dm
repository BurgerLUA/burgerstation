/obj/item/container/beaker/bottle/large
	name = "large bottle"
	icon = 'icons/obj/items/container/cup/potion_large.dmi'
	icon_state = "potion"
	icon_count = 16

	reagents = /reagent_container/beaker/potion/large


/obj/item/container/beaker/bottle/large/water
	name = "flask of water"

/obj/item/container/beaker/bottle/large/water/on_spawn()
	reagents.add_reagent("water",reagents.volume_max)
	return ..()

/obj/item/container/beaker/bottle/large/milk
	name = "flask of cow's milk"

/obj/item/container/beaker/bottle/large/milk/on_spawn()
	reagents.add_reagent("milk_cow",reagents.volume_max)
	return ..()

/obj/item/container/beaker/bottle/large/enzymes
	name = "flask of enzymes"

/obj/item/container/beaker/bottle/large/enzymes/on_spawn()
	reagents.add_reagent("enzymes",reagents.volume_max)
	return ..()