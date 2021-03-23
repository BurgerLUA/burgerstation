/obj/item/clothing/neck/miner_talisman
	name = "bone talisman"
	icon = 'icons/obj/item/clothing/neck/talisman.dmi'
	desc = "Grody."
	desc_extended = "A talisman made from sinew and shards of bone."
	worn_layer = LAYER_MOB_CLOTHING_NECK_UNDER

	item_slot = SLOT_NECK_O
	blocks_clothing = SLOT_NECK_O

	protected_limbs = list(BODY_TORSO)

	rarity = RARITY_RARE

	defense_rating = list(
		ARCANE = AP_CLUB,
		DARK = AP_SWORD,
		HOLY = -AP_SWORD
	)

	size = SIZE_1


	value = 300
