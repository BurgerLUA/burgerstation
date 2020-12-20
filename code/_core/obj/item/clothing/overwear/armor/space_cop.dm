/obj/item/clothing/overwear/armor/space_cop
	name = "space cop's armor"
	icon = 'icons/obj/item/clothing/suit/space_cop.dmi'
	desc = "Out of time, out of place."
	desc_extended = "Rudimentary protection for only the most special forces in the Galaxy."

	rarity = RARITY_UNCOMMON

	protected_limbs = list(BODY_TORSO,BODY_GROIN,BODY_ARM_LEFT,BODY_ARM_RIGHT,BODY_HAND_LEFT,BODY_HAND_RIGHT,BODY_LEG_LEFT,BODY_LEG_RIGHT)

	defense_rating = list(
		BLADE = AP_SWORD,
		BLUNT = AP_CLUB,
		PIERCE = AP_AXE,
		LASER = -AP_SWORD,
		ARCANE = -AP_SWORD
	)

	size = SIZE_4


	value = 400

	additional_clothing = list(
		/obj/item/clothing/head/hat/space_cop
	)