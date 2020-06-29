/obj/item/container/beaker/vial
	name = "small vial"
	icon = 'icons/obj/item/container/cup/vial.dmi'
	icon_state = "vial"
	icon_count = 10

	reagents = /reagent_container/beaker/vial/

	value = 3


/obj/item/container/beaker/vial/stand


/obj/item/container/beaker/vial/stand
	name = "vial of stand powers"

/obj/item/container/beaker/vial/stand/Generate()
	reagents.add_reagent(/reagent/magic/stand_juice,10)
	return ..()