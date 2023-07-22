/obj/item/clothing/feet/shoes/halo/combat
	name = "right UNSC combat boot"
	desc = "Standard issue UNSC combat boot."
	desc_extended = "Standard issue UNSC combat boot, part of the UNSC BDU."
	rarity = RARITY_RARE
	icon_state = "inventory_right"
	icon_state_worn = "worn_right"
	worn_layer = LAYER_MOB_CLOTHING_BELT

	icon = 'icons/obj/item/clothing/shoes/ins.dmi'

	item_slot = SLOT_FOOT_RIGHT
	protected_limbs = list(BODY_FOOT_RIGHT)

	defense_rating = list(
		BLADE = AP_CLUB,
		BLUNT = AP_CLUB,
		PIERCE = AP_CLUB,
		LASER = -AP_CLUB,
		ARCANE = -AP_CLUB,
		PAIN = AP_CLUB
	)

	size = SIZE_2


	value = 150

	speed_bonus = 0


/obj/item/clothing/feet/shoes/halo/combat/left
	name = "left UNSC combat boot"
	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_FOOT_LEFT
	protected_limbs = list(BODY_FOOT_LEFT)
	blocks_clothing = SLOT_FOOT_LEFT | SLOT_FOOT_LEFT_U

/obj/item/clothing/feet/shoes/halo/combat/urf
	name = "right URF combat boot"
	rarity = RARITY_RARE
	icon_state = "inventory_right"
	icon_state_worn = "worn_right"
	worn_layer = LAYER_MOB_CLOTHING_BELT

	icon = 'icons/obj/item/clothing/shoes/ins.dmi'

/obj/item/clothing/feet/shoes/halo/combat/urf/left
	name = "left URF combat boot"
	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_FOOT_LEFT
	protected_limbs = list(BODY_FOOT_LEFT)
	blocks_clothing = SLOT_FOOT_LEFT | SLOT_FOOT_LEFT_U

/obj/item/clothing/feet/shoes/halo/combat/soe
	name = "right URFC combat boot"
	rarity = RARITY_RARE
	icon_state = "inventory_right"
	icon_state_worn = "worn_right"
	worn_layer = LAYER_MOB_CLOTHING_BELT

	icon = 'icons/obj/item/clothing/shoes/soe.dmi'

/obj/item/clothing/feet/shoes/halo/combat/soe/left
	name = "left URFC combat boot"
	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_FOOT_LEFT
	protected_limbs = list(BODY_FOOT_LEFT)
	blocks_clothing = SLOT_FOOT_LEFT | SLOT_FOOT_LEFT_U

/obj/item/clothing/feet/shoes/halo/combat/odst
	name = "right ODST combat boot"
	rarity = RARITY_RARE
	icon_state = "inventory_right"
	icon_state_worn = "worn_right"
	worn_layer = LAYER_MOB_CLOTHING_BELT

	icon = 'icons/obj/item/clothing/shoes/ins.dmi'

/obj/item/clothing/feet/shoes/halo/combat/odst/left
	name = "left ODST combat boot"
	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_FOOT_LEFT
	protected_limbs = list(BODY_FOOT_LEFT)
	blocks_clothing = SLOT_FOOT_LEFT | SLOT_FOOT_LEFT_U