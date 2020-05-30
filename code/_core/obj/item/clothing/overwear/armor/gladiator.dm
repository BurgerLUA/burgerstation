/obj/item/clothing/overwear/armor/gladiator
	name = "gladiator armor"
	icon = 'icons/obj/items/clothing/suit/gladiator.dmi'
	rarity = RARITY_UNCOMMON

	value = 40

	dyeable = TRUE

/obj/item/clothing/overwear/armor/gladiator/brass
	name = "bronze gladiator armor"
	color = "#B7A33E"
	item_slot = SLOT_TORSO_A
	worn_layer = LAYER_MOB_CLOTHING_ARMOR

	defense_rating = list(
		BLADE = 50,
		BLUNT = 25,
		PIERCE = 25,
		LASER = 25,
		MAGIC = -75
	)

	size = SIZE_5
	weight = WEIGHT_5

