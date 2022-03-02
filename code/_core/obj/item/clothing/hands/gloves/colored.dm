/obj/item/clothing/hands/gloves/colored
	name = "right glove"
	icon_state = "inventory_right"
	icon_state_worn = "worn_right"
	desc = "Slap people with these."
	desc_extended = "A generic glove. Hope that you have a matching pair."
	icon = 'icons/obj/item/clothing/gloves/regular.dmi'
	color = "#FFFFFF"

	armor = /armor/cloth/

	size = SIZE_1


	value = 20

	dyeable = TRUE

/obj/item/clothing/hands/gloves/colored/left
	name = "left glove"
	desc = "Slap people with these."
	desc_extended = "A generic glove. Hope that you have a matching pair."
	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_HAND
	item_slot_mod = SLOT_MOD_LEFT
	protected_limbs = list(BODY_HAND_LEFT)

/obj/item/clothing/hands/gloves/colored/combat
	name = "right combat glove"
	desc = "Shoot guns with theese."
	desc_extended = "A combat glove. Sadly cannot be used for catching bullets to fuel your slavic bias."
	color = "#404040"

	armor = /armor/cloth/hard

	protection_cold = list(
		BODY_HAND_RIGHT = 1
	)

	size = SIZE_1


/obj/item/clothing/hands/gloves/colored/combat/left
	name = "left combat glove"
	desc = "Shoot guns with theese."
	desc_extended = "A combat glove. Sadly cannot be used for catching bullets to fuel your slavic bias."
	color = "#404040"
	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_HAND
	item_slot_mod = SLOT_MOD_LEFT
	protected_limbs = list(BODY_HAND_LEFT)

	protection_cold = list(
		BODY_HAND_LEFT = 1
	)


/obj/item/clothing/hands/gloves/colored/insulated
	name = "right insulated glove"
	desc = "Hack airlocks with these."
	desc_extended = "Someday, someone declared that the insulated gloves looked like shit. They turned into insulted gloves, but they got over it now. Also has infinite fatigue resist, hell if i know why."
	color = "#FFFF00"

	armor = /armor/glasses/sunglasses/insulated

	protection_cold = list(
		BODY_HAND_LEFT = 2
	)

	size = SIZE_1


	value = 150

/obj/item/clothing/hands/gloves/colored/insulated/left
	name = "left insulated glove"
	desc = "Hack airlocks with theese."
	desc_extended = "Someday, someone declared that the insulated gloves looked like shit. They turned into insulted gloves, but they got over it now. Also has infinite fatigue resist, hell if i know why."
	color = "#FFFF00"

	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_HAND
	item_slot_mod = SLOT_MOD_LEFT
	protected_limbs = list(BODY_HAND_LEFT)

	protection_cold = list(
		BODY_HAND_RIGHT = 2
	)

/obj/item/clothing/hands/gloves/colored/padded
	name = "right padded tactical glove"
	desc = "Be tactical with theese."
	desc_extended = "A padded glove. Equipped with a fancier icon for extra tactical-ness."
	icon = 'icons/obj/item/clothing/gloves/padded.dmi'

	armor = /armor/military/light

	protection_cold = list(
		BODY_HAND_RIGHT = 3
	)

	size = SIZE_1

	value = 120


/obj/item/clothing/hands/gloves/colored/padded/left
	name = "left padded tactical glove"
	desc = "Be tactical with theese."
	desc_extended = "A padded glove. Equipped with a fancier texture for extra tactical-ness."
	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_HAND
	item_slot_mod = SLOT_MOD_LEFT
	protected_limbs = list(BODY_HAND_LEFT)

	protection_cold = list(
		BODY_HAND_LEFT = 3
	)

/obj/item/clothing/hands/gloves/colored/padded/black
	color = COLOR_BLACK

/obj/item/clothing/hands/gloves/colored/padded/black/left
	name = "left padded glove"
	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_HAND
	item_slot_mod = SLOT_MOD_LEFT
	protected_limbs = list(BODY_HAND_LEFT)

	protection_cold = list(
		BODY_HAND_LEFT = 3
	)



/obj/item/clothing/hands/gloves/colored/padded/brown
	name = "left padded workman's glove"
	color = COLOR_BROWN

	armor = /armor/leather/mining

/obj/item/clothing/hands/gloves/colored/padded/brown/left
	name = "left padded workman's glove"
	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_HAND
	item_slot_mod = SLOT_MOD_LEFT
	protected_limbs = list(BODY_HAND_LEFT)

	protection_cold = list(
		BODY_HAND_LEFT = 3
	)


/obj/item/clothing/hands/gloves/colored/padded/merc
	color = "#6C8A97"

/obj/item/clothing/hands/gloves/colored/padded/merc/left
	name = "left padded tactical glove"
	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_HAND
	item_slot_mod = SLOT_MOD_LEFT
	protected_limbs = list(BODY_HAND_LEFT)

	protection_cold = list(
		BODY_HAND_LEFT = 3
	)

/obj/item/clothing/hands/gloves/colored/padded/merc_alt
	color = "#48482D"

/obj/item/clothing/hands/gloves/colored/padded/merc_alt/left
	name = "left padded tactical glove"
	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_HAND
	item_slot_mod = SLOT_MOD_LEFT
	protected_limbs = list(BODY_HAND_LEFT)

	protection_cold = list(
		BODY_HAND_LEFT = 3
	)