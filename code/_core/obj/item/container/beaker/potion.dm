/obj/item/container/beaker/bottle/large
	name = "large potion"
	icon = 'icons/obj/items/container/cup/potion_large.dmi'
	icon_state = "potion"
	icon_count = 16

	reagents = /reagent_container/beaker/potion/large


/obj/item/container/beaker/bottle/large/water
	name = "flask of water"

/obj/item/container/beaker/bottle/large/water/on_spawn()
	reagents.add_reagent("water",reagents.volume_max)