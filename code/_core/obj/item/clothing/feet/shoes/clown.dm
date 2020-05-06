/obj/item/clothing/feet/shoes/clown
	name = "right clown shoe"
	rarity = RARITY_MYTHICAL
	icon_state = "inventory_right"
	icon_state_worn = "worn_right"

	icon = 'icons/obj/items/clothing/shoes/clown.dmi'

	item_slot = SLOT_FOOT_RIGHT
	protected_limbs = list(BODY_FOOT_RIGHT)

	defense_rating = list(
		MAGIC = 50,
		HOLY = 50,
		DARK = 50
	)

	size = SIZE_3
	weight = WEIGHT_2

	value = 100

	slowdown_mul_worn = 1.1

/obj/item/clothing/feet/shoes/clown/left
	name = "left clown shoe"
	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_FOOT_LEFT
	protected_limbs = list(BODY_FOOT_LEFT)