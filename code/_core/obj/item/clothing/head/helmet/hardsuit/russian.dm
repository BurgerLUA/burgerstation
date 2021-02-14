/obj/item/clothing/head/helmet/hardsuit/exosuit
	name = "russian exosuit helmet"
	icon = 'icons/obj/item/clothing/hats/exosuit_helmet.dmi'
	desc = "Duty more like dooty."
	desc_extended = "So, it's an exosuit's helmet. It protects. It is cool, because gas masks are cool."
	rarity = RARITY_RARE

	defense_rating = list(
		BLADE = AP_SWORD,
		BLUNT = AP_CLUB,
		PIERCE = AP_CLUB,
		LASER = AP_CLUB,
		ARCANE = -AP_GREATSWORD,
		HEAT = AP_SWORD,
		COLD = AP_CLUB,
		BOMB = AP_SWORD
	)

	size = SIZE_4


	value = 400

/obj/item/clothing/head/helmet/hardsuit/skat
	blocks_clothing = SLOT_FACE_WRAP | SLOT_FACE | SLOT_EYES
	name = "SKAT-9 full-head mask/helmet assembly"
	icon = 'icons/obj/item/clothing/hats/helmet_skat.dmi'
	desc = "Milstalkers are just military but hetero."
	desc_extended = "So, it's a SKAT's helmet. It protects. It is cool, because milstalkers are cool."
	rarity = RARITY_RARE

	defense_rating = list(
		BLADE = AP_AXE,
		BLUNT = AP_CLUB,
		PIERCE = AP_CLUB,
		LASER = AP_AXE,
		ARCANE = -AP_GREATAXE,
		HEAT = AP_AXE,
		COLD = AP_AXE,
		BOMB = AP_AXE
	)

	size = SIZE_4


	value = 550