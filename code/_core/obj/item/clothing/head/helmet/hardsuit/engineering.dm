/obj/item/clothing/head/helmet/hardsuit/engineering
	name = "engineering rig helmet"
	desc = "The SM is at 9% health? Eh, it's probably gonna be fine"
	desc_extended = "A hardsuit worn by engineers. Able to withstand incredible heat in order to work with engines."
	icon = 'icons/obj/item/clothing/hats/engineering_rig_helmet.dmi'
	rarity = RARITY_UNCOMMON

	defense_rating = list(
		BLADE = AP_CLUB,
		BLUNT = AP_SWORD,
		PIERCE = AP_SWORD,
		LASER = AP_SWORD,
		ARCANE = -AP_CLUB,
		HEAT = AP_CLUB,
		COLD = AP_CLUB,
		BOMB = AP_SWORD,
		BIO = AP_CLUB,
		RAD = AP_CLUB,
		FATIGUE = AP_SWORD,
		PAIN = AP_SWORD
	)

	size = SIZE_3