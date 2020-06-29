/obj/item/container/beaker/bottle
	name = "small bottle"
	icon = 'icons/obj/item/container/cup/bottle.dmi'
	icon_state = "bottle"
	icon_count = 7

	reagents = /reagent_container/beaker/bottle/

	value = 3


/obj/item/container/beaker/bottle/bicaridine
	name = "bottle of bicaridine"

/obj/item/container/beaker/bottle/bicaridine/Generate()
	reagents.add_reagent(/reagent/medicine/bicaridine,reagents.volume_max)
	return ..()

/obj/item/container/beaker/bottle/dylovene
	name = "bottle of dylovene"

/obj/item/container/beaker/bottle/dylovene/Generate()
	reagents.add_reagent(/reagent/medicine/dylovene,reagents.volume_max)
	return ..()

/obj/item/container/beaker/bottle/kelotane
	name = "bottle of kelotane"

/obj/item/container/beaker/bottle/kelotane/Generate()
	reagents.add_reagent(/reagent/medicine/kelotane,reagents.volume_max)
	return ..()


/obj/item/container/beaker/bottle/epinephrine
	name = "bottle of epinephrine"

/obj/item/container/beaker/bottle/epinephrine/Generate()
	reagents.add_reagent(/reagent/medicine/adrenaline/epinephrine,reagents.volume_max)
	return ..()



/obj/item/container/beaker/glass
	name = "drinking glass"
	icon = 'icons/obj/item/container/cup/glass.dmi'
	icon_state = "cup"
	icon_count = 15

	reagents = /reagent_container/beaker/bottle/

	value = 10

/obj/item/container/beaker/bowl
	name = "glass mixing bowl"
	icon = 'icons/obj/item/container/cup/bowl.dmi'
	icon_state = "bowl"
	icon_count = 23

	reagents = /reagent_container/beaker/large/

	value = 25