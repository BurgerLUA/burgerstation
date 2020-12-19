/obj/item/clothing/uniform/chemist
	name = "\improper Chemist's uniform"
	desc = "Who wants to try my Polytrinic Acid flavored Candy?"
	desc_extended = "The uniform of druglord- I mean, chemists."
	icon = 'icons/obj/item/clothing/uniforms/chemist.dmi'

	item_slot = SLOT_TORSO | SLOT_GROIN

	flags_clothing = FLAG_CLOTHING_NOBEAST_FEET

	defense_rating = list(
		BLADE = AP_DAGGER,
		BLUNT = AP_DAGGER,
		PIERCE = AP_DAGGER,
		LASER = AP_DAGGER,
		ARCANE = AP_SWORD,
		COLD = AP_DAGGER,
		BOMB = AP_DAGGER,
		BIO = AP_SWORD
	)

	value = 20