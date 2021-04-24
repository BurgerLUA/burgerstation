/obj/item/clothing/overwear/armor/sinew
	name = "sinew armor"
	icon = 'icons/obj/item/clothing/suit/sinew_armor.dmi'
	desc = "Wearing the corpses of your enemies since 5000 BC."
	desc_extended = "Makeshift armor made from various sinews and tendons. Offers some pretty robust protection for its size and weight."

	rarity = RARITY_UNCOMMON

	protected_limbs = list(BODY_TORSO,BODY_GROIN,BODY_LEG_LEFT,BODY_LEG_RIGHT)

	defense_rating = list(
		BLADE = 10,
		BLUNT = 20,
		PIERCE = 20,
		ARCANE = 80,
		HEAT = 60,
		COLD = 80,
		FATIGUE = 20,
		PAIN = 100
	)

	size = SIZE_3

	value = 200