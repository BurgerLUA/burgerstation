/obj/item/container/beaker/large
	name = "large beaker"
	icon = 'icons/obj/items/container/cup/beaker_large.dmi'
	icon_state = "beaker"
	icon_count = 9

	reagents = /reagent_container/beaker/large

/obj/item/container/beaker/large/bicaridine/on_spawn()
	reagents.add_reagent("bicaridine",reagents.volume_max)
	return ..()

/obj/item/container/beaker/large/kelotane/on_spawn()
	reagents.add_reagent("kelotane",reagents.volume_max)
	return ..()

/obj/item/container/beaker/large/dylovene/on_spawn()
	reagents.add_reagent("dylovene",reagents.volume_max)
	return ..()

/obj/item/container/beaker/large/water/on_spawn()
	reagents.add_reagent("water",reagents.volume_max)
	return ..()

/obj/item/container/beaker/large/potassium/on_spawn()
	reagents.add_reagent("potassium",reagents.volume_max)
	return ..()
