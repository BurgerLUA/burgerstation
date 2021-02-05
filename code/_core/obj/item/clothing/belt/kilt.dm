/obj/item/clothing/belt/kilt
	name = "kilt belt"
	desc = "THERE CAN ONLY BE ONE."
	desc_extended = "For holding up kilts."
	icon = 'icons/obj/item/clothing/belts/kilt.dmi'

	is_container = TRUE

	dynamic_inventory_count = 4

	size = 8

	container_max_size = SIZE_2

	defense_rating = list(
		BLADE = AP_SWORD,
		BLUNT = AP_DAGGER,
		PIERCE = AP_SWORD,
		ARCANE = AP_SWORD,
		PAIN = AP_SWORD
	)

	rarity = RARITY_UNCOMMON
	value = 30