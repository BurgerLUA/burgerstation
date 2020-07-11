/obj/item/clothing/overwear/hardsuit/seva
	name = "seva suit"
	desc = "Idi ko mne"
	desc_extended = "An eastern european model of Hazardous Enviroments Suit, favored by scientists, scavengers and anomaly worshipping fanatics alike!"
	icon = 'icons/obj/item/clothing/suit/seva_suit.dmi'
	rarity = RARITY_UNCOMMON

	defense_rating = list(
		BLADE = 50,
		BLUNT = 50,
		PIERCE = 50,
		LASER = 25,
		MAGIC = -50,
		DARK = 25,
		HOLY = -25,
		HEAT = 75,
		COLD = 75,
		BOMB = 25,
		BIO = 100,
		RAD = 100
	)

	size = SIZE_7


	additional_clothing = list(/obj/item/clothing/head/helmet/hardsuit/seva)

	slowdown_mul_worn = 1

	value = 80


/obj/item/clothing/overwear/hardsuit/seva/mono
	icon = 'icons/obj/item/clothing/suit/sevamono_suit.dmi'
	additional_clothing = list(/obj/item/clothing/head/helmet/hardsuit/seva/mono)