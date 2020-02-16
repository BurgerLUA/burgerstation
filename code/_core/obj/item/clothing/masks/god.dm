/obj/item/clothing/mask/god
	name = "god mask"
	icon = 'obj/items/clothing/masks/god.dmi'
	rarity = RARITY_MYTHICAL
	flags_clothing = FLAG_CLOTHING_NOBEAST_HEAD
	desc = "Well, what is it?"
	desc_extended = "A giant mask depicting some sort of father figure. Has a negative weight value, and decreases equip load when worn."
	rarity = RARITY_UNCOMMON

	defense_rating = list(
		BLADE = ARMOR_C,
		BLUNT = ARMOR_E,
		PIERCE = ARMOR_C
	)

	size = SIZE_7
	weight = WEIGHT_5

	pixel_x = -16
	pixel_y = -16

	worn_pixel_x = -16
	worn_pixel_y = -8

	worn_layer = LAYER_MOB_CLOTHING_NECK_OVER

	value = 1000