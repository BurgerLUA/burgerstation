/obj/item/clothing/feet/shoes/colored
	name = "right shoe"
	desc = "Good for running!"
	desc_extended = "A basic running shoe. Doesn't protect much, but it makes you go faster. Can also be colored with dye."
	icon_state = "inventory_right"
	icon_state_worn = "worn_right"

	icon = 'icons/obj/item/clothing/shoes/colored.dmi'

	item_slot = SLOT_FOOT
	item_slot_mod = SLOT_MOD_RIGHT
	protected_limbs = list(BODY_FOOT_RIGHT)

	no_initial_blend = TRUE

	defense_rating = list(
		BLADE = 10,
		BLUNT = 10,
		PIERCE = 10,
		ARCANE = 40,
		COLD = 20,
		PAIN = 10
	)

	size = SIZE_1


	dyeable = TRUE

	polymorphs = list(
		"base" = COLOR_WHITE,
		"ankle" = COLOR_WHITE,
		"sole" = COLOR_GREY_LIGHT
	)

	value = 30



	drop_sound = 'sound/items/drop/shoes.ogg'

/obj/item/clothing/feet/shoes/colored/left
	name = "left shoe"
	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_FOOT
	item_slot_mod = SLOT_MOD_LEFT
	protected_limbs = list(BODY_FOOT_LEFT)


/obj/item/clothing/feet/shoes/colored/black
	polymorphs = list(
		"base" = COLOR_WHITE,
		"ankle" = COLOR_BLACK,
		"sole" = COLOR_GREY_LIGHT
	)


/obj/item/clothing/feet/shoes/colored/black/left
	name = "left shoe"
	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_FOOT
	item_slot_mod = SLOT_MOD_LEFT
	protected_limbs = list(BODY_FOOT_LEFT)

/obj/item/clothing/feet/shoes/colored/blacker
	polymorphs = list(
		"base" = COLOR_BLACK,
		"ankle" = COLOR_BLACK,
		"sole" = COLOR_GREY_LIGHT
	)

/obj/item/clothing/feet/shoes/colored/blacker/left
	name = "left shoe"
	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_FOOT
	item_slot_mod = SLOT_MOD_LEFT
	protected_limbs = list(BODY_FOOT_LEFT)


/obj/item/clothing/feet/shoes/colored/brown
	polymorphs = list(
		"base" = COLOR_BROWN_LIGHT,
		"ankle" = COLOR_BROWN_LIGHT,
		"sole" = COLOR_BROWN
	)

/obj/item/clothing/feet/shoes/colored/brown/left
	name = "left shoe"
	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_FOOT
	item_slot_mod = SLOT_MOD_LEFT
	protected_limbs = list(BODY_FOOT_LEFT)

/obj/item/clothing/feet/shoes/colored/merc
	polymorphs = list(
		"base" = "#3E5254",
		"ankle" = "#475A61",
		"sole" = "#687E8E"
	)

/obj/item/clothing/feet/shoes/colored/merc/left
	name = "left shoe"
	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_FOOT
	item_slot_mod = SLOT_MOD_LEFT
	protected_limbs = list(BODY_FOOT_LEFT)
