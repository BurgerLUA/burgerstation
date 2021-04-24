/obj/item/clothing/neck/vampire
	name = "vampire cloak"
	icon = 'icons/obj/item/clothing/neck/vampire.dmi'
	desc = "What is a man? A miserable pile of secrets!"
	desc_extended = "The centerpiece of vampire attire."
	worn_layer = LAYER_MOB_CLOTHING_ALL

	item_slot = SLOT_NECK


	protected_limbs = list(BODY_TORSO)

	defense_rating = list(
		ARCANE = 20,
		COLD = 20,
		DARK = 60,
		HOLY = -60
	)

	value = 200

	item_slot_layer = 3