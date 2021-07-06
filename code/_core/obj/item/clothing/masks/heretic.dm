/obj/item/clothing/mask/heretic
	name = "heretic mask"
	icon = 'icons/obj/item/clothing/masks/cursed.dmi'
	desc = "You feel like it's staring into your soul..."
	desc_extended = "An absolutely cursed mask belonging to a heretic."

	flags_clothing = FLAG_CLOTHING_NOBEAST_HEAD

	defense_rating = list(
		BLADE = 50,
		BLUNT = 50,
		PIERCE = 50,
		LASER = 50,
		ARCANE = 50,
		HEAT = 50,
		COLD = 50,
		BOMB = 50,
		BIO = 50,
		RAD = 50,
		HOLY = -200,
		DARK = 200,
		FATIGUE = 100,
		PAIN = 100
	)

	size = SIZE_3

	worn_layer = LAYER_MOB_CLOTHING_ALL

	size = SIZE_2

	value = 500

	item_slot = SLOT_HEAD | SLOT_FACE