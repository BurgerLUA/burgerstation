/obj/item/clothing/hands/gloves/colored/plascrusader
	name = "right plascrusader gauntlet"
	icon_state = "inventory_right"
	icon_state_worn = "worn_right"
	desc = "Bling bling."
	desc_extended = "A gold colored gauntlet made from fine metals for protection from blades."
	icon = 'icons/obj/item/clothing/gloves/plascrusadergloves.dmi'

	item_slot = SLOT_HAND_RIGHT
	protected_limbs = list(BODY_HAND_RIGHT,BODY_ARM_RIGHT)

	defense_rating = list(
		BLADE = AP_AXE,
		BLUNT = AP_AXE,
		PIERCE = AP_AXE,
		ARCANE = -AP_AXE
	)

	size = SIZE_3



	value = 20

/obj/item/clothing/hands/gloves/colored/plascrusader/left
	name = "left plascrusader gauntlet"
	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_HAND_LEFT
	protected_limbs = list(BODY_HAND_LEFT,BODY_ARM_LEFT)
	blocks_clothing = SLOT_HAND_LEFT

