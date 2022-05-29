/obj/item/clothing/overwear/coat/winter
	name = "winter coat"
	desc = "Ice climber."
	desc_extended = "Protects against the cold, but leaves you vurnerable to heat."
	icon = 'icons/obj/item/clothing/suit/winter_coat.dmi'

	armor = /armor/cloth/winter

	protection_cold = list(
		BODY_TORSO = 5,
		BODY_ARM_LEFT = 4,
		BODY_ARM_RIGHT = 4,
		BODY_GROIN = 2
	)

	additional_clothing = list(/obj/item/clothing/head/hat/winter)

	size = SIZE_3


	value = 20

/obj/item/clothing/overwear/coat/winter/bomber
	name = "bomber jacket"
	desc = "Does not actually protect against bombs."
	desc_extended = "Does not actually protect against bombs."
	icon = 'icons/obj/item/clothing/suit/bomberjacket.dmi'
	additional_clothing = null // no hood

	size = SIZE_3

	value = 120