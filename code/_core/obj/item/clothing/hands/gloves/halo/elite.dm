/obj/item/clothing/hands/gloves/halo/covenant/elite
	name = "Sangheili right Combat Gauntlet"
	desc = "Heavy."
	desc_extended = "Hand armour, to be used with the Sangheili Combat Harness."
	icon = 'icons/obj/item/clothing/gloves/elite_m.dmi'

	icon_state = "inventory_right"
	icon_state_worn = "worn_right"

	rarity = RARITY_LEGENDARY

	defense_rating = list(
		BLADE = AP_AXE,
		BLUNT = AP_AXE,
		PIERCE = AP_AXE,
		LASER = AP_SWORD,
		ARCANE = -AP_GREATCLUB,
		HEAT = AP_AXE,
		COLD = AP_AXE,
		BOMB = AP_AXE,
		BIO = AP_AXE,
		RAD = AP_AXE,
		FATIGUE = AP_GREATCLUB,
		PAIN = AP_GREATCLUB
	)

	protection_cold = list(
		BODY_HAND_RIGHT = 1
	)

	size = SIZE_1
	flags_clothing = FLAG_CLOTHING_NOHUMAN

	value = 800

/obj/item/clothing/hands/gloves/halo/covenant/elite/left
	name = "Sangheili left Combat Gauntlet"
	desc = "Heavy."
	desc_extended = "Hand armour, to be used with the Sangheili Combat Harness."

	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_HAND_LEFT
	protected_limbs = list(BODY_HAND_LEFT)
	blocks_clothing = SLOT_HAND_LEFT

	protection_cold = list(
		BODY_HAND_LEFT = 1
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
	item_slot = SLOT_HAND_LEFT
	protected_limbs = list(BODY_HAND_LEFT)
	blocks_clothing = SLOT_HAND_LEFT

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
	item_slot = SLOT_HAND_LEFT
	protected_limbs = list(BODY_HAND_LEFT)
	blocks_clothing = SLOT_HAND_LEFT

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
	item_slot = SLOT_HAND_LEFT
	protected_limbs = list(BODY_HAND_LEFT)
	blocks_clothing = SLOT_HAND_LEFT

	protection_cold = list(
		BODY_HAND_LEFT = 1
	)