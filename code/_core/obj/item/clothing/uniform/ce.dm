/obj/item/clothing/uniform/ce
	name = "chief engineer's uniform"
	desc = "SM DELAM CALL THE SHUTTLE"
	desc_extended = "An uniform worn by the most incompetent engineers, who get promoted to Chiefs."
	icon = 'icons/obj/item/clothing/uniforms/ce.dmi'
	rarity = RARITY_RARE

	item_slot = SLOT_TORSO | SLOT_GROIN

	flags_clothing = FLAG_CLOTHING_NOBEAST_FEET

	defense_rating = list(
		BLADE = AP_DAGGER,
		BLUNT = AP_DAGGER,
		PIERCE = AP_DAGGER,
		LASER = AP_DAGGER,
		ARCANE = AP_SWORD,
		COLD = AP_DAGGER,
		RAD = AP_AXE
	)

	value = 300