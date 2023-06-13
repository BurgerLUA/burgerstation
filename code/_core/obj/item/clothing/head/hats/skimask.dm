/obj/item/clothing/head/hat/skimask
	name = "ski mask"
	desc = "LOADSAMONEY"
	desc_extended = "Covers up your face and head. Handy for robbing banks, or for its actual intended purpose."
	icon = 'icons/obj/item/clothing/masks/balaclava.dmi'
	icon_state = "inventory"
	slot_icons = TRUE

	item_slot = SLOT_HEAD | SLOT_FACE

	ignore_other_slots = TRUE

	flags_clothing = FLAG_CLOTHING_NOBEAST_HEAD

	dyeable = TRUE

	worn_layer = LAYER_MOB_CLOTHING_MASK
	item_slot_layer = 1

	armor = /armor/cloth/winter/mask

	hidden_organs = list(
		BODY_HAIR_HEAD = TRUE,
		BODY_HAIR_FACE = TRUE
	)

	value = 30

/obj/item/clothing/head/hat/skimask/pre_equip(var/atom/old_location,var/obj/hud/inventory/new_location)

	if(new_location.item_slot & SLOT_HEAD)
		hidden_organs[BODY_HAIR_HEAD] = TRUE
		hidden_organs[BODY_HAIR_FACE] = FALSE
		worn_layer = LAYER_MOB_CLOTHING_HELMET

	if(new_location.item_slot & SLOT_FACE)
		hidden_organs[BODY_HAIR_HEAD] = TRUE
		hidden_organs[BODY_HAIR_FACE] = TRUE
		worn_layer = LAYER_MOB_CLOTHING_HEADWRAP

	. = ..()


/obj/item/clothing/head/hat/skimask/black
	color = COLOR_BLACK

/obj/item/clothing/head/hat/skimask/medical
	name = "medical full face mask"
	color = COLOR_MEDICAL

/obj/item/clothing/head/hat/skimask/tactical
	icon = 'icons/obj/item/clothing/masks/tacticool.dmi'
	icon_state = "inventory"

/obj/item/clothing/head/hat/skimask/tactical/black
	color = COLOR_BLACK