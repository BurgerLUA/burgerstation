/obj/item/clothing/uniform/stealth
	name = "combat uniform"
	desc = "Tacticool!"
	desc = "A skintight uniform for combat purposes."
	icon = 'icons/obj/item/clothing/uniforms/stealth.dmi'

	item_slot = SLOT_TORSO | SLOT_GROIN

	flags_clothing = FLAG_CLOTHING_NOBEAST_FEET

	defense_rating = list(
		BLADE = AP_DAGGER,
		BLUNT = AP_SWORD,
		PIERCE = AP_SWORD,
		LASER = -AP_SWORD,
		ARCANE = -AP_SWORD,
		HEAT = AP_DAGGER,
		COLD = AP_DAGGER,
		BOMB = AP_DAGGER
	)

	value = 300