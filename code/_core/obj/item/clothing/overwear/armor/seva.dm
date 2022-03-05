/obj/item/clothing/overwear/armor/seva
	name = "SEVA suit"
	desc = "Idi ko mne"
	desc_extended = "An eastern european model of Hazardous Enviroments Suit, favored by scientists, scavengers and anomaly worshipping fanatics alike!"
	icon = 'icons/obj/item/clothing/suit/seva_suit.dmi'

	protected_limbs = list(BODY_TORSO,BODY_GROIN,BODY_ARM_LEFT,BODY_ARM_RIGHT,BODY_LEG_LEFT,BODY_LEG_RIGHT,BODY_FOOT_LEFT,BODY_FOOT_RIGHT)
	worn_layer = LAYER_MOB_CLOTHING_HARDSUIT

	hidden_organs = list(
		BODY_TORSO = TRUE,
		BODY_GROIN = TRUE,
		BODY_ARM_RIGHT = TRUE,
		BODY_ARM_LEFT = TRUE,
		BODY_LEG_RIGHT = TRUE,
		BODY_LEG_LEFT = TRUE,
		BODY_FOOT_RIGHT = TRUE,
		BODY_FOOT_LEFT = TRUE
	)

	armor = /armor/leather/mining/advanced

	size = SIZE_7


	additional_clothing = list(/obj/item/clothing/head/helmet/full/seva)


/obj/item/clothing/overwear/armor/seva/mono
	name = "custom SEVA suit"
	desc_extended = "An eastern european model of Hazardous Enviroments Suit, favored by scientists, scavengers and anomaly worshipping fanatics alike! This is revolutionaries' modification for urban combat."
	icon = 'icons/obj/item/clothing/suit/sevamono_suit.dmi'

	armor = /armor/leather/mining/elite

	additional_clothing = list(/obj/item/clothing/head/helmet/full/seva/mono)

/obj/item/clothing/overwear/armor/seva/syndie
	name = "fireproof SEVA suit"
	desc_extended = "An eastern european model of Hazardous Enviroments Suit, favored by scientists, scavengers and anomaly worshipping fanatics alike! This is revolutionaries' modification for high temperatures, exported to the Syndicate."
	icon = 'icons/obj/item/clothing/suit/sevasyndie_suit.dmi'

	armor = /armor/leather/mining/elite

	additional_clothing = list(/obj/item/clothing/head/helmet/full/seva/syndie)