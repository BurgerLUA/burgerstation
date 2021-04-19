/obj/item/clothing/uniform/stealth
	name = "combat uniform"
	desc = "Tacticool!"
	desc = "A skintight uniform for combat purposes."
	icon = 'icons/obj/item/clothing/uniforms/stealth.dmi'

	item_slot = SLOT_TORSO | SLOT_GROIN

	flags_clothing = FLAG_CLOTHING_NOBEAST_FEET

	defense_rating = list(
		BLADE = 10,
		BLUNT = 20,
		PIERCE = 20,
		LASER = -20,
		ARCANE = -20,
		HEAT = 10,
		COLD = 10,
		BOMB = 10
	)

	value = 300

/obj/item/clothing/uniform/stealth/dyeable
	icon = 'icons/obj/item/clothing/uniforms/stealth_white.dmi'
	dyeable = TRUE

/obj/item/clothing/uniform/stealth/dyeable/merc
	color = "#6A778A"


/obj/item/clothing/uniform/stealth/dyeable/virtual
	name = "virtual combat uniform"
	desc_extended = "A bulky nanomesh combat suit that increases the agility of the wearer significantly. Unfortunately it is a little on the large side, and cannot be worn with armor."
	icon = 'icons/obj/item/clothing/uniforms/virtual_suit.dmi'

	defense_rating = list(
		BLADE = 40,
		BLUNT = 60,
		PIERCE = 60,
		LASER = -60,
		ARCANE = -60,
		HEAT = 40,
		COLD = 40,
		BOMB = 40 //Laugh, and grow fat.
	)

	speed_bonus = 0.25

	item_slot_additional = SLOT_GROIN | SLOT_TORSO_ARMOR