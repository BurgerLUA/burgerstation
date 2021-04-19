/obj/item/clothing/mask/mummy
	name = "bandage mask"
	desc = "Can't actually be used to stop bleeding."
	desc_extended = "A mask made from wrapped cloth. The signature look of mysterious characters, mummies and deeply unfortunate people alike."
	icon = 'icons/obj/item/clothing/masks/mummy.dmi'
	flags_clothing = FLAG_CLOTHING_NOBEAST_HEAD
	rarity = RARITY_UNCOMMON

	defense_rating = list(
		BLADE = 10,
		PIERCE = 10,
		LASER = -10,
		ARCANE = 40,
		HOLY = -40,
		DARK = 40
	)

	value = 20

	worn_layer = LAYER_MOB_CLOTHING_MASK

	worn_layer = LAYER_MOB_CLOTHING_MASK

	item_slot = SLOT_FACE


	hidden_organs = list(
		BODY_HAIR_HEAD = TRUE,
		BODY_HAIR_FACE = TRUE
	)
