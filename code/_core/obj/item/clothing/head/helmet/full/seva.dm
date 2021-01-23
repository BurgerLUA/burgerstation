/obj/item/clothing/head/helmet/full/seva
	name = "SEVA suit"
	desc = "Idi ko mne"
	desc_extended = "An eastern european model of Hazardous Enviroments Suit, favored by scientists, scavengers and anomaly worshipping fanatics alike!"
	icon = 'icons/obj/item/clothing/hats/seva_suit.dmi'
	rarity = RARITY_UNCOMMON

	defense_rating = list(
		BLADE = AP_SWORD,
		BLUNT = AP_AXE,
		PIERCE = AP_AXE,
		LASER = AP_SWORD,
		ARCANE = -AP_SWORD,
		HEAT = AP_CLUB,
		COLD = AP_CLUB,
		BOMB = AP_CLUB,
		BIO = AP_CLUB
	)

	size = SIZE_3

/obj/item/clothing/head/helmet/full/seva/mono
	name = "custom SEVA suit"
	icon = 'icons/obj/item/clothing/hats/sevamono_suit.dmi'

	defense_rating = list(
		BLADE = AP_AXE,
		BLUNT = AP_CLUB,
		PIERCE = AP_CLUB,
		LASER = AP_SWORD,
		ARCANE = -AP_SWORD,
		HEAT = AP_CLUB,
		COLD = AP_CLUB,
		BOMB = AP_CLUB,
		BIO = AP_CLUB
	)