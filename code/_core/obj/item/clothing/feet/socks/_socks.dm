/obj/item/clothing/feet/socks/
	name = "sock"
	desc = "Don't wear socks with this or I'll fucking end you."
	desc_extended = "A sock. This can go on either foot."
	icon_state = "inventory"
	icon_state_worn = "worn"
	flags_clothing = FLAG_CLOTHING_NOBEAST_FEET
	worn_layer = LAYER_MOB_CLOTHING_SOCKS
	item_slot = SLOT_FOOT_LEFT_U | SLOT_FOOT_RIGHT_U

	ignore_other_slots = TRUE

	slot_icons = TRUE

	protected_limbs = list(BODY_FOOT_RIGHT,BODY_FOOT_LEFT) //TODO: MAKE THIS DYNAMIC

	defense_rating = list(
		MAGIC = ARMOR_D,
		COLD = ARMOR_D
	)

/obj/item/clothing/feet/socks/white
	icon = 'icons/obj/items/clothing/socks/normal.dmi'



