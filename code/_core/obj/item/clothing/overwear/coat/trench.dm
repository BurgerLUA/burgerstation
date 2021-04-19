/obj/item/clothing/overwear/coat/trench
	name = "\improper trench coat"
	desc = "Reeks of blood, of which it was borne."
	desc_extended = "A long black coat. Fashionable, at least it was during the Victorian era."
	icon = 'icons/obj/item/clothing/suit/trench_coat.dmi'
	rarity = RARITY_RARE

	is_container = TRUE
	dynamic_inventory_count = 2
	container_max_size = SIZE_2

	defense_rating = list(
		BLADE = AP_AXE,
		BLUNT = 20,
		PIERCE = AP_AXE,
		LASER = -AP_AXE,
		ARCANE = 20,
		HEAT = -20,
		COLD = 20
	)

	size = SIZE_4

	value = 1000