/obj/item/clothing/mask/godlike
	name = "god mask"
	icon = 'icons/obj/item/clothing/masks/god.dmi'
	rarity = RARITY_LEGENDARY
	flags_clothing = FLAG_CLOTHING_NOBEAST_HEAD
	desc = "How can you kill a god?"
	desc_extended = "Wearing this mask will make them hard to kill... if you only target their head."
	rarity = RARITY_UNCOMMON

	defense_rating = list(
		BLADE = 100,
		BLUNT = 100,
		PIERCE = 100,
		LASER = 100,
		ARCANE = 100,
		HEAT = 100,
		COLD = 100,
		BOMB = 100,
		BIO = 100,
		RAD = 100,
		HOLY = 100,
		DARK = 100,
		FATIGUE = 100,
		PAIN = 100
	)

	size = SIZE_7


	pixel_x = -16
	pixel_y = -16

	worn_pixel_x = -16
	worn_pixel_y = -8

	worn_layer = LAYER_MOB_CLOTHING_ALL

	value = 20000
	value_burgerbux = 20000

	item_slot = SLOT_HEAD | SLOT_FACE

	blocks_clothing = SLOT_HEAD | SLOT_FACE