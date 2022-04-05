/obj/item/container/syringe/medipen
	name = "medipen"
	desc = "For when you want to poke holes in people and overdose them even faster than with the syringe."
	desc_extended = "Holds reagents. Can't draw and is used for quick injections. Type of contents could be seen by looking at the medipen's marker's color and guessing what does it mean."
	crafting_id = "medipen"
	icon = 'icons/obj/item/container/medipen.dmi'
	icon_state = "medipen"

	reagents = /reagent_container/syringe/medipen

	injection_sound = 'sound/effects/epi.ogg'

	can_draw = FALSE
	adjustable = FALSE

	injection_time = 0
	quality_reduction_on_use = 100

	value = 1


/obj/item/container/syringe/medipen/adminomnizine
	name = "god's medipen"
	value_burgerbux = 1000

/obj/item/container/syringe/medipen/adminomnizine/Generate()
	reagents.add_reagent(/reagent/medicine/adminomnizine,reagents.volume_max)
	return ..()

/obj/item/container/syringe/medipen/bicaridine
	name = "anti-brute medipen"

/obj/item/container/syringe/medipen/bicaridine/Generate()
	reagents.add_reagent(/reagent/medicine/bicaridine_plus,reagents.volume_max)
	return ..()

/obj/item/container/syringe/medipen/kelotane
	name = "anti-burn medipen"

/obj/item/container/syringe/medipen/kelotane/Generate()
	reagents.add_reagent(/reagent/medicine/kelotane,reagents.volume_max)
	return ..()

/obj/item/container/syringe/medipen/dylovene
	name = "anti-toxin medipen"

/obj/item/container/syringe/medipen/dylovene/Generate()
	reagents.add_reagent(/reagent/medicine/dylovene,reagents.volume_max)
	return ..()

/obj/item/container/syringe/medipen/dexaline
	name = "anti-suffocation medipen"

/obj/item/container/syringe/medipen/dexaline/Generate()
	reagents.add_reagent(/reagent/medicine/dexalin,reagents.volume_max)
	return ..()

/obj/item/container/syringe/medipen/epinephrine
	name = "epipen"

/obj/item/container/syringe/medipen/epinephrine/Generate()
	reagents.add_reagent(/reagent/medicine/adrenaline/epinephrine,reagents.volume_max)
	return ..()

/obj/item/container/syringe/medipen/iron
	name = "iron medipen"

/obj/item/container/syringe/medipen/iron/Generate()
	reagents.add_reagent(/reagent/iron,reagents.volume_max)
	return ..()