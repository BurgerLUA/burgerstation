/obj/item/clothing/neck/vampire
	name = "vampire cloak"
	icon = 'icons/obj/item/clothing/neck/vampire.dmi'
	desc = "What is a man? A miserable pile of secrets!"
	desc_extended = "The centerpiece of vampire attire."
	worn_layer = LAYER_MOB_CLOTHING_ALL

	item_slot = SLOT_NECK
	item_slot_mod = SLOT_MOD_OVER

	protected_limbs = list(BODY_TORSO)

	defense_rating = list(
		ARCANE = AP_SWORD,
		COLD = AP_SWORD,
		DARK = AP_CLUB,
		HOLY = -AP_CLUB
	)

	value = 200
