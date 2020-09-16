/obj/item/clothing/overwear/hardsuit/seva
	name = "SEVA suit"
	desc = "Idi ko mne"
	desc_extended = "An eastern european model of Hazardous Enviroments Suit, favored by scientists, scavengers and anomaly worshipping fanatics alike!"
	icon = 'icons/obj/item/clothing/suit/seva_suit.dmi'
	rarity = RARITY_UNCOMMON

	defense_rating = list(
		BLADE = 25,
		BLUNT = 50,
		PIERCE = 25,
		LASER = 25,
		ARCANE = -50,
		HEAT = 25,
		COLD = 50,
		BOMB = 25,
		BIO = 150,
		RAD = 150
	)

	size = SIZE_7


	additional_clothing = list(/obj/item/clothing/head/helmet/hardsuit/seva)

	slowdown_mul_worn = 1.1

	value = 400


/obj/item/clothing/overwear/hardsuit/seva/mono
	name = "custom SEVA suit"
	icon = 'icons/obj/item/clothing/suit/sevamono_suit.dmi'
	additional_clothing = list(/obj/item/clothing/head/helmet/hardsuit/seva/mono)

	defense_rating = list(
		BLADE = 50,
		BLUNT = 75,
		PIERCE = 50,
		LASER = 50,
		ARCANE = -50,
		HEAT = 50,
		COLD = 50,
		BOMB = 50,
		BIO = INFINITY,
		RAD = 200
	)

	value = 1200