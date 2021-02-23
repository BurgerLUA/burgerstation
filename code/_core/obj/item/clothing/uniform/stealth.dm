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
		BLADE = AP_AXE,
		BLUNT = AP_CLUB,
		PIERCE = AP_CLUB,
		LASER = -AP_CLUB,
		ARCANE = -AP_CLUB,
		HEAT = AP_AXE,
		COLD = AP_AXE,
		BOMB = AP_AXE //Laugh, and grow fat.
	)

	blocks_clothing = SLOT_TORSO | SLOT_GROIN | SLOT_TORSO_U | SLOT_GROIN_U | SLOT_TORSO_A

	speed_bonus = 0.25