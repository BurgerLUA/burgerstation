/obj/item/clothing/overwear/armor/seva
	name = "SEVA suit"
	desc = "Idi ko mne"
	desc_extended = "An eastern european model of Hazardous Enviroments Suit, favored by scientists, scavengers and anomaly worshipping fanatics alike!"
	icon = 'icons/obj/item/clothing/suit/seva_suit.dmi'
	rarity = RARITY_UNCOMMON

	protected_limbs = list(BODY_TORSO,BODY_GROIN,BODY_ARM_LEFT,BODY_ARM_RIGHT,BODY_LEG_LEFT,BODY_LEG_RIGHT,BODY_FOOT_LEFT,BODY_FOOT_RIGHT)
	worn_layer = LAYER_MOB_CLOTHING_HARDSUIT
	rarity = RARITY_MYTHICAL

	defense_rating = list(
		BLADE = 20,
		BLUNT = 40,
		PIERCE = 40,
		LASER = 20,
		ARCANE = -20,
		HEAT = 60,
		COLD = 60,
		BOMB = 60,
		BIO = 60
	)

	size = SIZE_7


	additional_clothing = list(/obj/item/clothing/head/helmet/full/seva)


/obj/item/clothing/overwear/armor/seva/mono
	name = "custom SEVA suit"
	icon = 'icons/obj/item/clothing/suit/sevamono_suit.dmi'
	additional_clothing = list(/obj/item/clothing/head/helmet/full/seva/mono)

	defense_rating = list(
		BLADE = 40,
		BLUNT = 60,
		PIERCE = 60,
		LASER = 20,
		ARCANE = -20,
		HEAT = 60,
		COLD = 60,
		BOMB = 60,
		BIO = 60
	)