/obj/item/clothing/overwear/hardsuit/ghostsheet
	name = "Ghost costume"
	desc = "Boo!"
	protected_limbs = list(BODY_TORSO,BODY_GROIN,BODY_ARM_LEFT,BODY_ARM_RIGHT,BODY_LEG_LEFT,BODY_LEG_RIGHT,BODY_FOOT_LEFT,BODY_FOOT_RIGHT)
	desc_extended = "A bedsheet with some holes cut out to see out of, a classic."
	icon = 'icons/obj/item/clothing/suit/ghostsheet.dmi'
	rarity = RARITY_COMMON

	defense_rating = list(
		BLADE = 5,
		BLUNT = 5,
		PIERCE = 5,
		DARK = 25,
		COLD = 25
	)

	size = SIZE_4

	additional_clothing = list(/obj/item/clothing/head/helmet/hardsuit/ghostsheedhood)

	value = 20
