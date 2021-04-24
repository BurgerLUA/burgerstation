/obj/item/clothing/overwear/coat/drip
	name = "drip"
	icon = 'icons/obj/item/clothing/suit/drip.dmi'

	rarity = RARITY_LEGENDARY

	desc = "By any means necessary."
	desc_extended = "Probably the most expensive clothing you can find. Does it do anything? Probably not."

	is_container = TRUE
	dynamic_inventory_count = 2
	container_max_size = SIZE_2

	size = SIZE_3

	defense_rating = list(
		BLADE = 10,
		PIERCE = 10,
		ARCANE = 20,
		HEAT = -20,
		COLD = 20
	)

/obj/item/clothing/overwear/coat/drip/get_base_value()
	. = ..()
	. += 20000