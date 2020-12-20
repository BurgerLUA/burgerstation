/obj/item/clothing/overwear/coat/blazer_blue
	name = "blue blazer"
	icon = 'icons/obj/item/clothing/suit/blazer_blue.dmi'

	rarity = RARITY_UNCOMMON

	desc = "I NEED just one pocket actually."
	desc_extended = "A snazzy blue blazer with a pocket inside. Of course, it won't do much against the horrors of the void."

	is_container = TRUE
	dynamic_inventory_count = 1
	container_max_size = SIZE_2

	size = SIZE_3


	defense_rating = list(
		BLADE = AP_DAGGER,
		PIERCE = AP_DAGGER,
		ARCANE = AP_SWORD,
		HEAT = -AP_SWORD,
		COLD = AP_SWORD
	)

	value = 30