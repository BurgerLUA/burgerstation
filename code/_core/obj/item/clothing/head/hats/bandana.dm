/obj/item/clothing/head/hat/bandana
	name = "bandana"
	desc = "Damn, it feels good to be a gangsta."
	desc_extended = "Can be worn both as a mask to cover up your face, or as a hat."
	icon = 'icons/obj/item/clothing/masks/bandana.dmi'
	icon_state = "inventory"
	slot_icons = TRUE

	item_slot = SLOT_HEAD | SLOT_FACE
	ignore_other_slots = TRUE

	dyeable = TRUE

	worn_layer = LAYER_MOB_CLOTHING_MASK

	defense_rating = list(
		ARCANE = AP_SWORD,
		COLD = AP_SWORD,
		HEAT = AP_SWORD,
		BIO = AP_SWORD
	)

	value = 40

/obj/item/clothing/head/hat/bandana/pre_pickup(var/atom/old_location,var/obj/hud/inventory/new_location)

	. = ..()

	if(new_location.item_slot & SLOT_HEAD)
		hidden_organs = list(BODY_HAIR_HEAD = TRUE, BODY_HAIR_FACE = FALSE)
		worn_layer = LAYER_MOB_CLOTHING_HELMET

	if(new_location.item_slot & SLOT_FACE)
		hidden_organs = list(BODY_HAIR_HEAD = TRUE, BODY_HAIR_FACE = TRUE)
		worn_layer = LAYER_MOB_CLOTHING_MASK

	return .


/obj/item/clothing/head/hat/bandana/red
	color = "#880000"