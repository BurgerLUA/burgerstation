/obj/item/clothing/head/helmet/plascrusader

	name = "plascrusader helmet"
	icon = 'icons/obj/item/clothing/hats/plascrusaderhelm.dmi'
	desc = "Plasma bro!"
	desc_extended = "A gold helmet with a large purple colored visor made with fine metals."

	value = 160
	rarity = RARITY_UNCOMMON

	hidden_organs = list(
		BODY_HEAD = TRUE,
		BODY_HAIR_HEAD = TRUE,
		BODY_HAIR_FACE = TRUE,
		BODY_EYES = TRUE
	)

	rarity = RARITY_UNCOMMON
	defense_rating = list(
		BLADE = AP_CLUB,
		BLUNT = AP_AXE,
		PIERCE = AP_AXE,
		LASER = AP_AXE,
		HEAT = -AP_AXE,
		ARCANE = -AP_CLUB,
		PAIN = AP_CLUB
	)

	size = SIZE_3

	blocks_clothing = SLOT_FACE_WRAP | SLOT_HEAD | SLOT_FACE | SLOT_EYES

