/obj/item/clothing/feet/socks/
	name = "sock"
	desc = "Don't wear socks with sandals or I'll fucking end you."
	desc_extended = "A sock. This can go on either foot."
	icon_state = "inventory"
	icon_state_worn = "worn"
	flags_clothing = FLAG_CLOTHING_NOBEAST_FEET
	worn_layer = LAYER_MOB_CLOTHING_SOCKS
	item_slot = SLOT_FOOT
	item_slot_mod = SLOT_MOD_RIGHT | SLOT_MOD_LEFT


	ignore_other_slots = TRUE

	slot_icons = TRUE

	protected_limbs = list(BODY_FOOT_RIGHT,BODY_FOOT_LEFT) //TODO: MAKE THIS DYNAMIC

	dyeable = TRUE

	defense_rating = list(
		ARCANE = 20,
		COLD = 10,
		HEAT = -10
	)

	size = SIZE_0

	speed_bonus = 0.05

	item_slot_layer = 1



/obj/item/clothing/feet/socks/ankle
	name = "ankle high socks"
	icon = 'icons/obj/item/clothing/socks/normal.dmi'
	polymorphs = null

	value = 3

/obj/item/clothing/feet/socks/knee
	name = "knee high socks"
	icon = 'icons/obj/item/clothing/socks/knee.dmi'
	polymorphs = list(
		"sock" = COLOR_WHITE
	)

	value = 3

/obj/item/clothing/feet/socks/knee/white
	polymorphs = list(
		"sock" = COLOR_WHITE
	)

/obj/item/clothing/feet/socks/knee/striped
	polymorphs = list(
		"sock" = COLOR_WHITE,
		"stripes" = COLOR_GREY
	)

/obj/item/clothing/feet/socks/knee/striped/scottish
	polymorphs = list(
		"sock" = "#53512A",
		"stripes" = "#32321B"
	)

	value = 3

/obj/item/clothing/feet/socks/thigh/
	name = "thigh high sock"
	icon = 'icons/obj/item/clothing/socks/programmer.dmi'

	value = 10

	polymorphs = list(
		"sock" = COLOR_WHITE
	)

/obj/item/clothing/feet/socks/thigh/striped/
	polymorphs = list(
		"sock" = COLOR_WHITE,
		"stripes" = COLOR_GREY
	)

/obj/item/clothing/feet/socks/thigh/striped/pink
	name = "programmer sock"

	polymorphs = list(
		"sock" = COLOR_WHITE,
		"stripes" = "#FFBFEC"
	)

/obj/item/clothing/feet/socks/thigh/striped/bee
	name = "bee stockings"

	polymorphs = list(
		"sock" = COLOR_BLACK,
		"stripes" = "#F7DD5D"
	)
