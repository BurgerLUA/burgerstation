/obj/item/clothing/hands/gloves/halo/covenant/elite
	name = "Sangheili right Combat Gauntlet"
	desc = "Heavy."
	desc_extended = "Hand armour, to be used with the Sangheili Combat Harness."
	icon = 'icons/obj/item/clothing/gloves/elite_m.dmi'

	icon_state = "inventory_right"
	icon_state_worn = "worn_right"

	armor = /armor/military/light

	protection_cold = list(
		BODY_HAND_RIGHT = 3
	)

	size = SIZE_1

	value = 120
	flags_clothing = FLAG_CLOTHING_NOHUMAN

/obj/item/clothing/hands/gloves/halo/covenant/elite/left
	name = "Sangheili left Combat Gauntlet"
	desc = "Heavy."
	desc_extended = "Hand armour, to be used with the Sangheili Combat Harness."

	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_HAND
	item_slot_mod = SLOT_MOD_LEFT
	protected_limbs = list(BODY_HAND_LEFT)

	protection_cold = list(
		BODY_HAND_LEFT = 3
	)

/obj/item/clothing/hands/gloves/halo/covenant/elite/major
	name = "Sangheili right Combat Gauntlet"
	icon = 'icons/obj/item/clothing/gloves/elite_mj.dmi'

	icon_state = "inventory_right"
	icon_state_worn = "worn_right"

/obj/item/clothing/hands/gloves/halo/covenant/elite/major/left
	name = "Sangheili left Combat Gauntlet"

	icon_state = "inventory_left"
	icon_state_worn = "worn_left"
	item_slot = SLOT_HAND
	item_slot_mod = SLOT_MOD_LEFT
	protected_limbs = list(BODY_HAND_LEFT)

	protection_cold = list(
		BODY_HAND_LEFT = 1
	)

/obj/item/clothing/hands/gloves/halo/covenant/elite/ultra
	name = "Sangheili right Combat Gauntlet"
	icon = 'icons/obj/item/clothing/gloves/elite_ultra.dmi'

	icon_state = "inventory_right"
	icon_state_worn = "worn_right"

/obj/item/clothing/hands/gloves/halo/covenant/elite/ultra/left
	name = "Sangheili left Combat Gauntlet"

	icon_state = "inventory_left"
	icon_state_worn = "worn_left"
	item_slot = SLOT_HAND
	item_slot_mod = SLOT_MOD_LEFT
	protected_limbs = list(BODY_HAND_LEFT)

	protection_cold = list(
		BODY_HAND_LEFT = 1
	)

/obj/item/clothing/hands/gloves/halo/covenant/elite/shipmaster
	name = "Sangheili right Combat Gauntlet"
	icon = 'icons/obj/item/clothing/gloves/elite_sm.dmi'

	icon_state = "inventory_right"
	icon_state_worn = "worn_right"

/obj/item/clothing/hands/gloves/halo/covenant/elite/shipmaster/left
	name = "Sangheili left Combat Gauntlet"

	icon_state = "inventory_left"
	icon_state_worn = "worn_left"
	item_slot = SLOT_HAND
	item_slot_mod = SLOT_MOD_LEFT
	protected_limbs = list(BODY_HAND_LEFT)

	protection_cold = list(
		BODY_HAND_LEFT = 1
	)