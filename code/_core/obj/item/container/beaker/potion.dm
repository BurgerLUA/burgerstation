/obj/item/container/beaker/bottle/large
	name = "large bottle"
	icon = 'icons/obj/item/container/cup/potion_large.dmi'
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


/obj/item/container/beaker/bottle/large/health_potion
	name = "health potion"

/obj/item/container/beaker/bottle/large/health_potion/Generate()
	reagents.add_reagent(/reagent/medicine/health_potion,reagents.volume_max)
	return ..()

/obj/item/container/beaker/bottle/large/stamina_potion
	name = "stamina potion"

/obj/item/container/beaker/bottle/large/stamina_potion/Generate()
	reagents.add_reagent(/reagent/medicine/stamina_potion,reagents.volume_max)
	return ..()


/obj/item/container/beaker/bottle/large/mana_potion
	name = "mana potion"

/obj/item/container/beaker/bottle/large/mana_potion/Generate()
	reagents.add_reagent(/reagent/medicine/mana_potion,reagents.volume_max)
	return ..()