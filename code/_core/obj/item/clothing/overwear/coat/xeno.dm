/obj/item/clothing/overwear/coat/xeno
	name = "xeno costume"
	desc = "Hissss!"
	desc_extended = "A rather high quality xeno costume, it even comes with a mask!"
	icon = 'icons/obj/item/clothing/suit/xeno.dmi'
	rarity = RARITY_UNCOMMON

	protected_limbs = list(BODY_TORSO,BODY_GROIN,BODY_ARM_LEFT,BODY_ARM_RIGHT,BODY_LEG_LEFT,BODY_LEG_RIGHT,BODY_FOOT_LEFT,BODY_FOOT_RIGHT)

	defense_rating = list(
		BLADE = 10,
		BLUNT = 10,
		LASER = -20,
		ARCANE = 20,
		HEAT = -20,
		BOMB = -20,
		FATIGUE = 20
	)

	size = SIZE_5


	value = 500