/obj/item/container/simple/beaker/vial
	name = "small vial"
	desc = "Careful to not drop this."
	desc_extended = "A vial. Often used by virologists to store viruses and blood samples."
	icon = 'icons/obj/item/container/cup/vial.dmi'
	icon_state = "vial"
	icon_count = 10

	reagents = /reagent_container/beaker/vial/

	value = 3

	drop_sound = 'sound/items/drop/glass.ogg'

	size = SIZE_1

/obj/item/container/simple/beaker/vial/enzymes
	name = "vial of enzymes"

/obj/item/container/simple/beaker/vial/enzymes/Generate()
	reagents.add_reagent(/reagent/enzymes,reagents.volume_max)
	return ..()

/*
/obj/item/container/simple/beaker/vial/stand
	name = "vial of stand powers"
	desc = "Hmm, tastes like a blended arrow."
	desc_extended = "A vial containing a bullshit virus that makes a funky half-naked person appear near you and punch people."

/obj/item/container/simple/beaker/vial/stand/Generate()
	reagents.add_reagent(/reagent/magic/stand_juice,10)
	return ..()
*/

/obj/item/container/simple/beaker/vial/health_potion
	name = "vial of health"

/obj/item/container/simple/beaker/vial/health_potion/Generate()
	reagents.add_reagent(/reagent/medicine/health_potion,reagents.volume_max)
	return ..()

/obj/item/container/simple/beaker/vial/stamina_potion
	name = "vial of stamina"

/obj/item/container/simple/beaker/vial/stamina_potion/Generate()
	reagents.add_reagent(/reagent/medicine/stamina_potion,reagents.volume_max)
	return ..()

/obj/item/container/simple/beaker/vial/mana_potion
	name = "vial of mana"

/obj/item/container/simple/beaker/vial/mana_potion/Generate()
	reagents.add_reagent(/reagent/medicine/mana_potion,reagents.volume_max)
	return ..()






