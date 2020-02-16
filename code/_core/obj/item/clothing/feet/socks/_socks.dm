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

	size = SIZE_0
	weight = WEIGHT_0

	value = 3


/obj/item/clothing/feet/socks/white
	icon = 'icons/obj/items/clothing/socks/normal.dmi'

/obj/item/clothing/feet/socks/knee
	name = "knee socks"
	icon = 'icons/obj/items/clothing/socks/knee.dmi'
	polymorphic = TRUE

	value = 5

/obj/item/clothing/feet/socks/knee/white
	color_primary = "#FFFFFF"
	color_secondary = "#FFFFFF"
	color_tertiary = "#FFFFFF"

/obj/item/clothing/feet/socks/knee/scottish
	color_primary = "#53512A"
	color_secondary = "#32321B"
	color_tertiary = "#53512A"

/obj/item/clothing/feet/socks/stockings/
	name = "thigh high sock"
	icon = 'icons/obj/items/clothing/socks/programmer.dmi'
	polymorphic = TRUE
	value = 10

/obj/item/clothing/feet/socks/stockings/pink
	name = "programmer sock"

	color_primary = "#FFFFFF"
	color_secondary = "#EE9AA8"
	color_tertiary = "#FFFFFF"

/obj/item/clothing/feet/socks/stockings/bee
	name = "bee stockings"

	color_primary = "#1E1E1E"
	color_secondary = "#FFD819"
	color_tertiary = "#1E1E1E"
