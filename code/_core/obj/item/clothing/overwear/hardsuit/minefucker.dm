/obj/item/clothing/overwear/coat/miner
	name = "blocky skinsuit"
	desc = "punch trees"
	desc_extended = "A strange skin suit that feels pixlated to the touch.... somehow.."
	icon = 'icons/obj/item/clothing/suit/minefucker.dmi'

	protected_limbs = list(BODY_TORSO,BODY_GROIN,BODY_ARM_LEFT,BODY_ARM_RIGHT,BODY_LEG_LEFT,BODY_LEG_RIGHT,BODY_FOOT_LEFT,BODY_FOOT_RIGHT)

	rarity = RARITY_RARE
	value = 500

	defense_rating = list(
		BLADE = AP_DAGGER,
		BLUNT = AP_DAGGER,
		LASER = -AP_SWORD,
		ARCANE = AP_SWORD,
		HEAT = -AP_SWORD,
		BOMB = -AP_SWORD,
		FATIGUE = AP_SWORD
	)

	size = SIZE_5