obj/item/clothing/back/wings/angel
	name = "angel wings"
	desc = "Proof of divinity."
	desc_extended = "A pair of absolutely divine angel wings. Significantly reduces carry weight at the cost of reduced armor to the entire body. Has excellent protection against dark attacks."
	icon = 'icons/obj/items/clothing/back/wings/angel.dmi'

	defense_rating = list(
		BLADE = -ARMOR_C,
		BLUNT = -ARMOR_D,
		PIERCE = -ARMOR_C,
		LASER = -ARMOR_C,
		MAGIC = ARMOR_C,
		HEAT = -ARMOR_C,
		COLD = -ARMOR_D,
		BOMB = -ARMOR_C,
		BIO = -ARMOR_C,
		RAD = -ARMOR_C,
		HOLY = -ARMOR_S,
		DARK = ARMOR_S
	)
