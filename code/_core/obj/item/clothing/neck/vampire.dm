/obj/item/clothing/neck/vampire
	name = "vampire cloak"
	icon = 'icons/obj/item/clothing/neck/vampire.dmi'
	desc = "What is a man? A miserable pile of secrets!"
	desc_extended = "The centerpiece of vampire attire."
	worn_layer = LAYER_MOB_CLOTHING_ALL

	protected_limbs = list(BODY_TORSO)

	defense_rating = list(
		ARCANE = 50,
		COLD = 25,
		DARK = 50,
		HOLY = -50
	)

	value = 200
