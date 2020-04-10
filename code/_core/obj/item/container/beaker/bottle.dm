/obj/item/container/beaker/bottle
	name = "small bottle"
	icon = 'icons/obj/items/container/cup/bottle.dmi'
	icon_state = "bottle"
	icon_count = 7

	reagents = /reagent_container/beaker/bottle/

	value = 3


/obj/item/container/beaker/bottle/bicaridine
	name = "bottle of bicaridine"

/obj/item/container/beaker/bottle/bicaridine/on_spawn()
	reagents.add_reagent("bicaridine",reagents.volume_max)
	return ..()

/obj/item/container/beaker/bottle/dylovene
	name = "bottle of dylovene"

/obj/item/container/beaker/bottle/dylovene/on_spawn()
	reagents.add_reagent("dylovene",reagents.volume_max)
	return ..()

/obj/item/container/beaker/bottle/kelotane
	name = "bottle of kelotane"

/obj/item/container/beaker/bottle/kelotane/on_spawn()
	reagents.add_reagent("kelotane",reagents.volume_max)
	return ..()


/obj/item/container/beaker/bottle/epinephrine
	name = "bottle of epinephrine"

/obj/item/container/beaker/bottle/epinephrine/on_spawn()
	reagents.add_reagent("epinephrine",reagents.volume_max)
	return ..()



/obj/item/container/beaker/glass
	name = "drinking glass"
	icon = 'icons/obj/items/container/cup/glass.dmi'
	icon_state = "cup"
	icon_count = 15

	reagents = /reagent_container/beaker/bottle/

	value = 1