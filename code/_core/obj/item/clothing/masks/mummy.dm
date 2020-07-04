/obj/item/clothing/mask/mummy
	name = "bandage mask"
	desc = "Can't actually be used to stop bleeding."
	desc_extended = "A mask made from wrapped cloth. The signature look of mysterious characters, mummies and deeply unfortunate people alike."
	icon = 'obj/item/clothing/masks/mummy.dmi'
	flags_clothing = FLAG_CLOTHING_NOBEAST_HEAD
	rarity = RARITY_UNCOMMON

	defense_rating = list(
		BLADE = 10,
		PIERCE = 10,
		LASER = -10,
		MAGIC = 50,
		HOLY = 25,
		DARK = 25
	)

	value = 5

	worn_layer = LAYER_MOB_CLOTHING_MASK

	hidden_organs = list(
		BODY_HAIR_HEAD = TRUE,
		BODY_HAIR_FACE = TRUE
	)