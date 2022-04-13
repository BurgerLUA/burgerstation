/obj/item/container/edible/supermatter_cheese
	name = "supermatter slice"
	desc = "Huh. Kind of looks like a slice of cheese..."
	desc_extended = "A thin crystaline slice of supermatter. NanoTrasen recommended that you do not consume this."

	icon = 'icons/obj/item/consumable/food/cheese.dmi'
	icon_state = "supermatter"

	allow_reagent_transfer_to = FALSE
	allow_reagent_transfer_from = FALSE

	value = 10

/obj/item/container/edible/supermatter_cheese/get_value()
	return get_base_value()

/obj/item/container/edible/supermatter_cheese/Generate()
	. = ..()
	reagents.add_reagent(/reagent/drug/supermatter,10)
	reagents.add_reagent(pick(SSreagent.valid_random_reagents),10)