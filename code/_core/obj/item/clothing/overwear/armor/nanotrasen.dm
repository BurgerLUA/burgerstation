/obj/item/clothing/overwear/armor/nanotrasen

	name = "nanotrasen armor"
	desc = "Futuristic!"
	desc_extended = "A suit of extremely expensive Jaeger prototype armor made by Space Germany. Offers the best protection possible."
	icon = 'icons/obj/item/clothing/suit/armor_modular.dmi'

	item_slot = SLOT_TORSO_A
	protected_limbs = list(BODY_TORSO,BODY_GROIN,BODY_ARM_LEFT,BODY_ARM_RIGHT,BODY_LEG_LEFT,BODY_LEG_RIGHT,BODY_FOOT_LEFT,BODY_FOOT_RIGHT)
	worn_layer = LAYER_MOB_CLOTHING_HARDSUIT
	rarity = RARITY_MYTHICAL
	blocks_clothing = SLOT_TORSO_A

	drop_sound = 'sound/items/drop/metalboots.ogg'

	dyeable = TRUE



/obj/item/clothing/overwear/armor/nanotrasen/light
	name = "light Jaeger armor"
	polymorphs = list(
		"under" = "#FFFFFF",
		"light" = "#FFFFFF"
	)

	defense_rating = list(
		BLADE = AP_SWORD,
		BLUNT = AP_SWORD,
		PIERCE = AP_SWORD,
		LASER = AP_AXE,
		ARCANE = -AP_AXE,
		BOMB = AP_AXE
	)

	value = 300

	size = SIZE_6

/obj/item/clothing/overwear/armor/nanotrasen/light/deathsquad
	polymorphs = list(
		"under" = "#FFFFFF",
		"light" = COLOR_DEATHSQUAD_BLACK
	)


/obj/item/clothing/overwear/armor/nanotrasen/medium
	name = "medium Jaeger armor"
	polymorphs = list(
		"under" = "#FFFFFF",
		"medium" = "#FFFFFF"
	)

	defense_rating = list(
		BLADE = AP_AXE,
		BLUNT = AP_AXE,
		PIERCE = AP_AXE,
		LASER = AP_AXE,
		ARCANE = -AP_CLUB,
		BOMB = AP_AXE
	)

	value = 600

	size = SIZE_7

/obj/item/clothing/overwear/armor/nanotrasen/medium/deathsquad
	polymorphs = list(
		"under" = "#FFFFFF",
		"medium" = COLOR_DEATHSQUAD_BLACK
	)

/obj/item/clothing/overwear/armor/nanotrasen/heavy
	name = "heavy Jaeger armor"
	polymorphs = list(
		"under" = "#FFFFFF",
		"heavy" = "#FFFFFF"
	)

	defense_rating = list(
		BLADE = AP_CLUB,
		BLUNT = AP_CLUB,
		PIERCE = AP_CLUB,
		LASER = AP_AXE,
		ARCANE = -AP_GREATSWORD,
		BOMB = AP_AXE
	)

	value = 1200

/obj/item/clothing/overwear/armor/nanotrasen/heavy/deathsquad
	polymorphs = list(
		"under" = "#FFFFFF",
		"heavy" = COLOR_DEATHSQUAD_BLACK
	)