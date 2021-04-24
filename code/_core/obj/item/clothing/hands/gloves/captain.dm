/obj/item/clothing/hands/gloves/captain
	name = "right glove of the captain"
	desc = "Be a comdom with these."
	desc_extended = "Fancy one-of-a-kind glove, issued to the station Captain. Don't lose the other one!"
	icon = 'icons/obj/item/clothing/gloves/captain.dmi'

	icon_state = "inventory_right"
	icon_state_worn = "worn_right"

	rarity = RARITY_LEGENDARY

	defense_rating = list(
		BLADE = 40,
		BLUNT = 40,
		PIERCE = 40,
		LASER = 20,
		ARCANE = -120,
		HEAT = 40,
		COLD = 40,
		BOMB = 40,
		BIO = 40,
		RAD = 40,
		FATIGUE = 120,
		PAIN = 120
	)

	protection_cold = list(
		BODY_HAND_RIGHT = 1
	)

	size = SIZE_1

	value = 800

/obj/item/clothing/hands/gloves/captain/left
	name = "left glove of the captain"
	desc = "Be a comdom with these."
	desc_extended = "Fancy one-of-a-kind glove, issued to the station Captain. Don't lose the other one!"

	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_HAND
	item_slot_mod = SLOT_MOD_LEFT
	protected_limbs = list(BODY_HAND_LEFT)

	protection_cold = list(
		BODY_HAND_LEFT = 1
	)