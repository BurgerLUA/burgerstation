/obj/item/clothing/overwear/armor/hostile
	name = "hostile environment suit"
	desc = "RIP AND TEAR."
	desc_extended = "An extremely heavy duty armor set only meant for the badest of badasses."
	icon = 'icons/obj/item/clothing/suit/hostile.dmi'

	rarity = RARITY_LEGENDARY

	defense_rating = list(
		BLADE = 80,
		BLUNT = 60,
		PIERCE = 60,
		LASER = 40,
		ARCANE = -100,
		HEAT = 60,
		COLD = 40,
		BOMB = 40,
		BIO = 20,
		RAD = 20
	)

	size = SIZE_7

	protected_limbs = list(BODY_TORSO,BODY_GROIN,BODY_ARM_LEFT,BODY_ARM_RIGHT,BODY_LEG_LEFT,BODY_LEG_RIGHT)

	value = 4000

	dyeable = TRUE

/obj/item/clothing/overwear/armor/hostile/green
	color = "#4F770E"