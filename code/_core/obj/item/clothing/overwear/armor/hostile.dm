/obj/item/clothing/overwear/armor/hostile
	name = "hostile environment suit"
	desc = "RIP AND TEAR."
	desc_extended = "An extremely heavy duty armor set only meant for the badest of badasses."
	icon = 'icons/obj/item/clothing/suit/hostile.dmi'

	rarity = RARITY_LEGENDARY

	defense_rating = list(
		BLADE = 200,
		BLUNT = 75,
		PIERCE = 75,
		LASER = 25,
		ARCANE = -100,
		HEAT = 125,
		COLD = 25,
		BOMB = 75,
		BIO = 25,
		RAD = 25
	)

	size = SIZE_7

	protected_limbs = list(BODY_TORSO,BODY_GROIN,BODY_ARM_LEFT,BODY_ARM_RIGHT)

	value = 4000

	dyeable = TRUE

/obj/item/clothing/overwear/armor/hostile/green
	color = "#4F770E"