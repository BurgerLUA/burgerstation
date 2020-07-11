/obj/item/clothing/mask/daddy
	name = "true mask"
	icon = 'obj/item/clothing/masks/daddy.dmi'
	rarity = RARITY_MYTHICAL
	flags_clothing = FLAG_CLOTHING_NOBEAST_HEAD
	desc = "Well, what is it?"
	desc_extended = "A giant mask depicting some sort of father figure. Speeds you up when worn."

	defense_rating = list(
		BLADE = 25,
		BLUNT = 25,
		PIERCE = 25
	)

	size = SIZE_3

	worn_layer = LAYER_MOB_CLOTHING_NECK_OVER

	value = 500

	hidden_organs = list(
		BODY_HEAD = TRUE,
		BODY_HAIR_HEAD = TRUE,
		BODY_HAIR_FACE = TRUE,
		BODY_EYES = TRUE
	)

	item_slot = SLOT_HEAD | SLOT_FACE

	blocks_clothing = SLOT_HEAD | SLOT_FACE

	slowdown_mul_worn = 0.95