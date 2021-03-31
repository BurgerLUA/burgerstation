/obj/item/clothing/neck/neck_wrap
	name = "\improper neck wrap"
	icon = 'icons/obj/item/clothing/neck/neck_wrap.dmi'
	desc = "Seems as if it was stained red."
	desc_extended = "A neck wrap. Warm, and is tall enough to cover a portion of the face."
	worn_layer = LAYER_MOB_CLOTHING_MASK

	item_slot = SLOT_NECK


	protected_limbs = list(BODY_TORSO, BODY_HEAD)

	rarity = RARITY_RARE

	defense_rating = list(
		BLADE = AP_DAGGER,
		BLUNT = AP_DAGGER,
		PIERCE = AP_DAGGER,
		ARCANE = AP_SWORD,
		DARK = AP_AXE,
		HOLY = -AP_AXE
	)

	size = SIZE_1


	value = 400

	item_slot_layer = 2