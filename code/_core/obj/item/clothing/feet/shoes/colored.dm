/obj/item/clothing/feet/shoes/colored
	name = "right shoe"
	desc = "Good for running!"
	desc_extended = "A basic running shoe. Doesn't protect much, but it makes you go faster. Can also be colored with dye."
	icon_state = "inventory_right"
	icon_state_worn = "worn_right"

	icon = 'icons/obj/item/clothing/shoes/colored.dmi'

	item_slot = SLOT_FOOT_RIGHT
	protected_limbs = list(BODY_FOOT_RIGHT)
	blocks_clothing = SLOT_FOOT_RIGHT_U | SLOT_FOOT_RIGHT

	no_initial_blend = TRUE

	defense_rating = list(
		BLADE = AP_DAGGER,
		BLUNT = AP_DAGGER,
		PIERCE = AP_DAGGER,
		ARCANE = AP_AXE,
		COLD = AP_SWORD,
		PAIN = AP_DAGGER
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

	item_slot = SLOT_FOOT_LEFT
	protected_limbs = list(BODY_FOOT_LEFT)
	blocks_clothing = SLOT_FOOT_LEFT | SLOT_FOOT_LEFT_U


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

	item_slot = SLOT_FOOT_LEFT
	protected_limbs = list(BODY_FOOT_LEFT)
	blocks_clothing = SLOT_FOOT_LEFT | SLOT_FOOT_LEFT_U

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

	item_slot = SLOT_FOOT_LEFT
	protected_limbs = list(BODY_FOOT_LEFT)
	blocks_clothing = SLOT_FOOT_LEFT | SLOT_FOOT_LEFT_U


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

	item_slot = SLOT_FOOT_LEFT
	protected_limbs = list(BODY_FOOT_LEFT)
	blocks_clothing = SLOT_FOOT_LEFT | SLOT_FOOT_LEFT_U
