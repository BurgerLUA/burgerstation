/obj/item/clothing/overwear/armor/seva
	name = "SEVA suit"
	desc = "Idi ko mne"
	desc_extended = "An eastern european model of Hazardous Enviroments Suit, favored by scientists, scavengers and anomaly worshipping fanatics alike!"
	icon = 'icons/obj/item/clothing/suit/seva_suit.dmi'
	rarity = RARITY_UNCOMMON

	item_slot = SLOT_TORSO_A
	protected_limbs = list(BODY_TORSO,BODY_GROIN,BODY_ARM_LEFT,BODY_ARM_RIGHT,BODY_LEG_LEFT,BODY_LEG_RIGHT,BODY_FOOT_LEFT,BODY_FOOT_RIGHT)
	worn_layer = LAYER_MOB_CLOTHING_HARDSUIT
	rarity = RARITY_MYTHICAL
	blocks_clothing = SLOT_TORSO | SLOT_TORSO_U | SLOT_TORSO_A

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

	size = SIZE_7


	additional_clothing = list(/obj/item/clothing/head/helmet/full/seva)


/obj/item/clothing/overwear/armor/seva/mono
	name = "custom SEVA suit"
	icon = 'icons/obj/item/clothing/suit/sevamono_suit.dmi'
	additional_clothing = list(/obj/item/clothing/head/helmet/full/seva/mono)

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