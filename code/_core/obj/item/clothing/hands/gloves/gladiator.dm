/obj/item/clothing/hands/gloves/colored/gladiator
	name = "right gladiator gauntlet"
	icon_state = "inventory_right"
	icon_state_worn = "worn_right"
	desc = "Fight people with these."
	desc_extended = "A long glove made of leather, to protect against shankings."
	icon = 'icons/obj/item/clothing/gloves/gladiator.dmi'
	color = "#FFFFFF"

	protected_limbs = list(BODY_ARM_RIGHT,BODY_HAND_RIGHT)

	defense_rating = list(
		BLADE = 40,
		BLUNT = 40,
		PIERCE = 40,
		ARCANE = -40
	)

	size = SIZE_3



	value = 20

/obj/item/clothing/hands/gloves/colored/gladiator/left
	name = "left gladiator gauntlet"
	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_HAND
	item_slot_mod = SLOT_MOD_LEFT
	protected_limbs = list(BODY_ARM_LEFT,BODY_HAND_LEFT)


/obj/item/clothing/hands/gloves/colored/gladiator/gold
	color = COLOR_GOLD


/obj/item/clothing/hands/gloves/colored/gladiator/gold/left
	name = "left gladiator gauntlet"
	desc = "Fight people with these."
	desc_extended = "A long glove made of leather, to protect against shankings."
	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_HAND
	item_slot_mod = SLOT_MOD_LEFT
	protected_limbs = list(BODY_ARM_LEFT,BODY_HAND_LEFT)

	color = COLOR_GOLD