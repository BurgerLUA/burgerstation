/obj/item/clothing/uniform/stealth
	name = "combat uniform"
	desc = "Tacticool!"
	desc = "A skintight uniform for combat purposes."
	icon = 'icons/obj/item/clothing/uniforms/stealth.dmi'

	item_slot = SLOT_TORSO | SLOT_GROIN

	flags_clothing = FLAG_CLOTHING_NOBEAST_FEET

	defense_rating = list(
		BLADE = 25,
		BLUNT = 15,
		PIERCE = 25,
		LASER = -15,
		ARCANE = 25,
		HEAT = 15,
		COLD = 15,
		BOMB = 15
	)

	value = 300

	slowdown_mul_worn = 1.05