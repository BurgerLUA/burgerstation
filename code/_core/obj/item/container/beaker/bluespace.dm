/obj/item/container/simple/beaker/bluespace
	name = "bluespace beaker"
	desc = "A chemist's best friend."
	desc_extended = "An incredibly useful and spacious bluespace beaker designed to hold as much reagents as possible in as little space as possible."
	icon = 'icons/obj/item/container/cup/beaker_bluespace.dmi'
	icon_state = "beaker"
	icon_count = 1

	reagents = /reagent_container/beaker/bucket

	size = SIZE_2

	color = COLOR_GREY

	rarity = RARITY_RARE

/obj/item/container/simple/beaker/bluespace/oxygen
	value_burgerbux = 1

/obj/item/container/simple/beaker/bluespace/oxygen/Generate()
	reagents.add_reagent(/reagent/fuel/oxygen,reagents.volume_max)
	return ..()

/obj/item/container/simple/beaker/bluespace/phoron
	value_burgerbux = 1

/obj/item/container/simple/beaker/bluespace/phoron/Generate()
	reagents.add_reagent(/reagent/fuel/phoron,reagents.volume_max)
	return ..()