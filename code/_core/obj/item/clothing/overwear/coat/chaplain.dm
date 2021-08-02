/obj/item/clothing/overwear/coat/chaplain
	name = "priest garb"
	icon = 'icons/obj/item/clothing/suit/religious.dmi'

	desc = "Ultra fancy!"
	desc_extended = "Protects against magic attacks."

	defense_rating = list(
		ARCANE = 40,
		DARK = -60,
		HOLY = 60
	)

	size = SIZE_3


	value = 90

/obj/item/clothing/overwear/coat/chaplain/witchunter
	name = "witchunter garb"
	icon = 'icons/obj/item/clothing/suit/witchunter.dmi'
	rarity = RARITY_RARE
	desc = "Burn the witch!" //peak creativity
	desc_extended = "Once worn by those driven by zealous delusion, this suit has felt more than its fair share of warmth."

	defense_rating = list(
		BLADE = 20,
		BLUNT = 20,
		PIERCE = 20,
		ARCANE = 60,
		DARK = -80,
		HOLY = 80,
		HEAT = 40, //One who is close to fire...
		LASER = 20 //...must be careful not to be burnt.
	)
	protected_limbs = list(BODY_TORSO,BODY_GROIN,BODY_ARM_LEFT,BODY_ARM_RIGHT,BODY_LEG_LEFT,BODY_LEG_RIGHT) //hrnngh
	size = SIZE_3


	value = 2000
