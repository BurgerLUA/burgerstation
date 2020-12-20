/obj/item/clothing/mask/mummy
	name = "bandage mask"
	desc = "Can't actually be used to stop bleeding."
	desc_extended = "A mask made from wrapped cloth. The signature look of mysterious characters, mummies and deeply unfortunate people alike."
	icon = 'icons/obj/item/clothing/masks/mummy.dmi'
	flags_clothing = FLAG_CLOTHING_NOBEAST_HEAD
	rarity = RARITY_UNCOMMON

	defense_rating = list(
		BLADE = AP_DAGGER,
		PIERCE = AP_DAGGER,
		LASER = -AP_DAGGER,
		ARCANE = AP_AXE,
		HOLY = -AP_AXE,
		DARK = AP_AXE
	)

	value = 20

	worn_layer = LAYER_MOB_CLOTHING_MASK

	worn_layer = LAYER_MOB_CLOTHING_MASK

	item_slot = SLOT_FACE_WRAP

	hidden_organs = list(
		BODY_HAIR_HEAD = TRUE,
		BODY_HAIR_FACE = TRUE
	)

	blocks_clothing = SLOT_FACE_WRAP
