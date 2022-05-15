/obj/item/container/simple/beaker/bottle/medium
	name = "medium bottle"
	desc = "Remember to read the label before drinking."
	desc_extended = "A bottle used by chemists to contain medicines and other reagents."
	icon = 'icons/obj/item/container/cup/bottle_medium.dmi'
	icon_state = "bottle"
	icon_count = 11

	reagents = /reagent_container/beaker/bottle/medium

	value = 5


/obj/item/container/simple/beaker/bottle/medium/bicaridine
	name = "bottle of bicaridine"

/obj/item/container/simple/beaker/bottle/medium/bicaridine/Generate()
	reagents.add_reagent(/reagent/medicine/bicaridine,reagents.volume_max)
	return ..()


/obj/item/container/simple/beaker/bottle/medium/kelotane
	name = "bottle of kelotane"

/obj/item/container/simple/beaker/bottle/medium/kelotane/Generate()
	reagents.add_reagent(/reagent/medicine/kelotane,reagents.volume_max)
	return ..()


/obj/item/container/simple/beaker/bottle/medium/dylovene
	name = "bottle of dylovene"

/obj/item/container/simple/beaker/bottle/medium/dylovene/Generate()
	reagents.add_reagent(/reagent/medicine/dylovene,reagents.volume_max)
	return ..()

/obj/item/container/simple/beaker/bottle/medium/epinephrine
	name = "bottle of epinephrine"

/obj/item/container/simple/beaker/bottle/medium/epinephrine/Generate()
	reagents.add_reagent(/reagent/medicine/adrenaline/epinephrine,reagents.volume_max)
	return ..()


/obj/item/container/simple/beaker/bottle/medium/morphine
	name = "bottle of morphine"

/obj/item/container/simple/beaker/bottle/medium/morphine/Generate()
	reagents.add_reagent(/reagent/medicine/painkiller/morphine,reagents.volume_max)
	return ..()


/obj/item/container/simple/beaker/bottle/medium/calomel
	name = "bottle of calomel"

/obj/item/container/simple/beaker/bottle/medium/calomel/Generate()
	reagents.add_reagent(/reagent/medicine/purge,reagents.volume_max)
	return ..()


/obj/item/container/simple/beaker/bottle/medium/inaprovaline
	name = "bottle of inaprovaline"

/obj/item/container/simple/beaker/bottle/medium/inaprovaline/Generate()
	reagents.add_reagent(/reagent/medicine/inaprovaline,reagents.volume_max)
	return ..()