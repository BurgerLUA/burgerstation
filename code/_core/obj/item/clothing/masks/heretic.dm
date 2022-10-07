/obj/item/clothing/mask/heretic
	name = "heretic mask"
	icon = 'icons/obj/item/clothing/masks/cursed.dmi'
	desc = "You feel like it's staring into your soul..."
	desc_extended = "An absolutely cursed mask belonging to a heretic."

	flags_clothing = FLAG_CLOTHING_NOBEAST_HEAD
	item_slot = SLOT_HEAD | SLOT_FACE
	worn_layer = LAYER_MOB_CLOTHING_ALL

	armor = /armor/dark/arcane/sanity

	size = SIZE_2

	mob_values_add = list(
		ATTRIBUTE_SOUL = 5,
		SKILL_PRAYER = 5
	)

