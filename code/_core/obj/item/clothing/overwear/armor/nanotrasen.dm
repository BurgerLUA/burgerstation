/obj/item/clothing/overwear/armor/nanotrasen

	name = "nanotrasen armor"
	desc = "Futuristic!"
	desc_extended = "A suit of extremely expensive Jaeger prototype armor made by Space Germany. Offers the best protection possible."
	icon = 'icons/obj/item/clothing/suit/armor_modular.dmi'

	protected_limbs = list(BODY_TORSO,BODY_GROIN,BODY_ARM_LEFT,BODY_ARM_RIGHT,BODY_LEG_LEFT,BODY_LEG_RIGHT,BODY_FOOT_LEFT,BODY_FOOT_RIGHT)
	worn_layer = LAYER_MOB_CLOTHING_HARDSUIT
	rarity = RARITY_MYTHICAL

	drop_sound = 'sound/items/drop/metalboots.ogg'

	dyeable = TRUE



/obj/item/clothing/overwear/armor/nanotrasen/light
	name = "light Jaeger armor"
	polymorphs = list(
		"under" = "#FFFFFF",
		"light" = "#FFFFFF"
	)

	defense_rating = list(
		BLADE = 20,
		BLUNT = 20,
		PIERCE = 20,
		LASER = 40,
		ARCANE = -40,
		BOMB = 40
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
		BLADE = 40,
		BLUNT = 40,
		PIERCE = 40,
		LASER = 40,
		ARCANE = -60,
		BOMB = 40
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
		BLADE = 60,
		BLUNT = 60,
		PIERCE = 60,
		LASER = 40,
		ARCANE = -80,
		BOMB = 40
	)

	value = 1200

/obj/item/clothing/overwear/armor/nanotrasen/heavy/deathsquad
	polymorphs = list(
		"under" = "#FFFFFF",
		"heavy" = COLOR_DEATHSQUAD_BLACK
	)