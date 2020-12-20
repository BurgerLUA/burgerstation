/obj/item/clothing/overwear/armor/hostile
	name = "hostile environment suit"
	desc = "RIP AND TEAR."
	desc_extended = "An extremely heavy duty armor set only meant for the badest of badasses."
	icon = 'icons/obj/item/clothing/suit/hostile.dmi'

	rarity = RARITY_LEGENDARY

	defense_rating = list(
		BLADE = AP_GREATSWORD,
		BLUNT = AP_CLUB,
		PIERCE = AP_CLUB,
		LASER = AP_AXE,
		ARCANE = -AP_GREATAXE,
		HEAT = AP_CLUB,
		COLD = AP_AXE,
		BOMB = AP_AXE,
		BIO = AP_SWORD,
		RAD = AP_SWORD
	)

	size = SIZE_7

	protected_limbs = list(BODY_TORSO,BODY_GROIN,BODY_ARM_LEFT,BODY_ARM_RIGHT)

	value = 4000

	dyeable = TRUE

/obj/item/clothing/overwear/armor/hostile/green
	color = "#4F770E"