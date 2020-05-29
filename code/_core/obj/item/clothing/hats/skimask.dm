/obj/item/clothing/head/hood/skimask
	name = "ski mask"
	icon = 'icons/obj/items/clothing/masks/balaclava.dmi'
	icon_state = "inventory"
	slot_icons = TRUE

	item_slot = SLOT_HEAD | SLOT_FACE
	ignore_other_slots = TRUE

	dyeable = TRUE

	worn_layer = LAYER_MOB_CLOTHING_NECK_UNDER

	hide_hair = TRUE

	value = 10

	hidden_organs = list(
		BODY_HAIR_HEAD = TRUE
	)

/obj/item/clothing/head/hood/skimask/black
	color = COLOR_BLACK

/obj/item/clothing/head/hood/skimask/medical
	name = "medical full face mask"
	color = COLOR_MEDICAL