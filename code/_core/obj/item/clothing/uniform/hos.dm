/obj/item/clothing/uniform/hos
	name = "\improper Head of Security's uniform"
	desc = "Execute Order 66."
	desc_extended = "The uniform of choice for dictatorial fascists and Heads of Security alike."
	icon = 'icons/obj/item/clothing/uniforms/hos.dmi'

	item_slot = SLOT_TORSO | SLOT_GROIN

	flags_clothing = FLAG_CLOTHING_NOBEAST_FEET

	defense_rating = list(
		BLADE = AP_SWORD,
		BLUNT = AP_SWORD,
		PIERCE = AP_SWORD,
		LASER = AP_SWORD,
		ARCANE = -AP_AXE,
		COLD = AP_DAGGER,
		BOMB = AP_SWORD
	)

	value = 180