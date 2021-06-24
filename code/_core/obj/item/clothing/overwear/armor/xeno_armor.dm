/obj/item/clothing/overwear/armor/xeno
	name = "xeno chitin armor"
	icon = 'icons/obj/item/clothing/suit/xeno_armor.dmi'
	desc = "Wearing the corpses of your enemies since 5000 BC."
	desc_extended = "Makeshift armor made from the corpse of a xeno. Offers some pretty robust protection for its size and weight."

	rarity = RARITY_UNCOMMON

	protected_limbs = list(BODY_TORSO,BODY_GROIN,BODY_LEG_LEFT,BODY_LEG_RIGHT)

	defense_rating = list(
		BLADE = 10,
		BLUNT = 60,
		PIERCE = 60,
		HEAT = 10,
		COLD = 80
	)

	size = SIZE_3

	value = 200