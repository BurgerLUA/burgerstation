/obj/item/clothing/overwear/armor/nanotrasen

	name = "nanotrasen armor"
	desc = "Futuristic!"
	desc_extended = "A suit of extremely expensive Jaeger prototype armor made by Space Germany. Offers the best protection possible."
	icon = 'icons/obj/item/clothing/suit/armor_modular.dmi'

	protected_limbs = list(BODY_TORSO,BODY_GROIN,BODY_ARM_LEFT,BODY_ARM_RIGHT,BODY_LEG_LEFT,BODY_LEG_RIGHT,BODY_FOOT_LEFT,BODY_FOOT_RIGHT)
	worn_layer = LAYER_MOB_CLOTHING_HARDSUIT


	drop_sound = 'sound/items/drop/metalboots.ogg'

	dyeable = TRUE



/obj/item/clothing/overwear/armor/nanotrasen/light
	name = "light Jaeger armor"
	polymorphs = list(
		"under" = "#FFFFFF",
		"light" = "#FFFFFF"
	)

	armor = /armor/military/light/hard

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

	armor = /armor/military/medium/hard

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

	armor = /armor/military/heavy/hard

	value = 1200

/obj/item/clothing/overwear/armor/nanotrasen/heavy/deathsquad
	polymorphs = list(
		"under" = "#FFFFFF",
		"heavy" = COLOR_DEATHSQUAD_BLACK
	)


/obj/item/clothing/overwear/armor/nanotrasen/custom
	name = "custom Jaeger armor"
	icon = 'icons/obj/item/clothing/suit/nano.dmi'
	polymorphs = list(
		"base" = COLOR_BLACK,
		"chest" = COLOR_BLACK,
		"shoulders" = COLOR_NANOTRASEN
	)

	worn_layer = LAYER_MOB_CLOTHING_ARMOR

	armor = /armor/military/heavy/hard

	value = 1200