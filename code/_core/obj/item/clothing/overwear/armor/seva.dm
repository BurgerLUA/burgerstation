/obj/item/clothing/overwear/armor/seva
	name = "SEVA suit"
	desc = "Idi ko mne"
	desc_extended = "An eastern european model of Hazardous Enviroments Suit, favored by scientists, scavengers and anomaly worshipping fanatics alike!"
	icon = 'icons/obj/item/clothing/suit/seva_suit.dmi'
	rarity = RARITY_UNCOMMON
	protected_limbs = list(BODY_TORSO,BODY_GROIN,BODY_ARM_LEFT,BODY_ARM_RIGHT,BODY_LEG_LEFT,BODY_LEG_RIGHT,BODY_FOOT_LEFT,BODY_FOOT_RIGHT)
	worn_layer = LAYER_MOB_CLOTHING_HARDSUIT

	defense_rating = list(
		BLADE = 25,
		BLUNT = 25,
		PIERCE = 40,
		LASER = 20,
		ARCANE = -20,
		HEAT = 60,
		COLD = 60,
		BOMB = 60,
		BIO = 90
	)

	size = SIZE_7


	additional_clothing = list(/obj/item/clothing/head/helmet/full/seva)


/obj/item/clothing/overwear/armor/seva/mono
	name = "custom SEVA suit"
	desc_extended = "An eastern european model of Hazardous Enviroments Suit, favored by scientists, scavengers and anomaly worshipping fanatics alike! This is revolutionaries' modification for urban combat."
	icon = 'icons/obj/item/clothing/suit/sevamono_suit.dmi'

	defense_rating = list(
		BLADE = 40,
		BLUNT = 60,
		PIERCE = 60,
		LASER = 20,
		ARCANE = -20,
		HEAT = 60,
		COLD = 60,
		BOMB = 60,
		BIO = 90
	)

	additional_clothing = list(/obj/item/clothing/head/helmet/full/seva/mono)

/obj/item/clothing/overwear/armor/seva/syndie
	name = "fireproof SEVA suit"
	desc_extended = "An eastern european model of Hazardous Enviroments Suit, favored by scientists, scavengers and anomaly worshipping fanatics alike! This is revolutionaries' modification for high temperatures, exported to the Syndicate."
	icon = 'icons/obj/item/clothing/suit/sevasyndie_suit.dmi'

	defense_rating = list(
		BLADE = 50,
		BLUNT = 50,
		PIERCE = 40,
		LASER = 60,
		ARCANE = -20,
		HEAT = 90,
		COLD = 20,
		BOMB = 50,
		BIO = 90
	)

	additional_clothing = list(/obj/item/clothing/head/helmet/full/seva/syndie)