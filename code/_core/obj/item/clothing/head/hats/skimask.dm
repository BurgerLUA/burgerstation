/obj/item/clothing/head/hat/skimask
	name = "ski mask"
	desc = "LOADSAMONEY"
	desc_extended = "Covers up your face and head. Handy for robbing banks, or for its actual intended purpose."
	icon = 'icons/obj/item/clothing/masks/balaclava.dmi'
	icon_state = "inventory"
	slot_icons = TRUE

	item_slot = SLOT_HEAD | SLOT_FACE_WRAP
	ignore_other_slots = TRUE

	flags_clothing = FLAG_CLOTHING_NOBEAST_HEAD

	dyeable = TRUE

	worn_layer = LAYER_MOB_CLOTHING_MASK

	defense_rating = list(
		ARCANE = AP_SWORD,
		COLD = AP_AXE,
		BIO = AP_SWORD
	)

	hidden_organs = list(
		BODY_HAIR_HEAD = TRUE,
		BODY_HAIR_FACE = TRUE
	)

	blocks_clothing = SLOT_FACE_WRAP

	value = 30

/obj/item/clothing/head/hat/skimask/pre_pickup(var/atom/old_location,var/obj/hud/inventory/new_location)

	. = ..()

	if(new_location.item_slot & SLOT_HEAD)
		hidden_organs = list(BODY_HAIR_HEAD = TRUE, BODY_HAIR_FACE = FALSE)
		worn_layer = LAYER_MOB_CLOTHING_HELMET

	if(new_location.item_slot & SLOT_FACE_WRAP)
		hidden_organs = list(BODY_HAIR_HEAD = TRUE, BODY_HAIR_FACE = TRUE)
		worn_layer = LAYER_MOB_CLOTHING_HEADWRAP

	return .


/obj/item/clothing/head/hat/skimask/black
	color = COLOR_BLACK

/obj/item/clothing/head/hat/skimask/medical
	name = "medical full face mask"
	color = COLOR_MEDICAL