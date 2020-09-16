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
		BLADE = 25,
		BLUNT = 50,
		PIERCE = 50,
		LASER = 25,
		ARCANE = -100,
		HEAT = 50,
		COLD = 50,
		BOMB = 25
	)

	value = 1200

	slowdown_mul_worn = 1.10


/obj/item/clothing/overwear/armor/nanotrasen/medium
	name = "medium Jaeger armor"
	polymorphs = list(
		"under" = "#FFFFFF",
		"medium" = "#FFFFFF"
	)

	defense_rating = list(
		BLADE = 50,
		BLUNT = 75,
		PIERCE = 75,
		LASER = 50,
		ARCANE = -125,
		HEAT = 50,
		COLD = 50,
		BOMB = 50
	)

	value = 1700

	slowdown_mul_worn = 1.25

/obj/item/clothing/overwear/armor/nanotrasen/heavy
	name = "heavy Jaeger armor"
	polymorphs = list(
		"under" = "#FFFFFF",
		"heavy" = "#FFFFFF"
	)

	defense_rating = list(
		BLADE = 75,
		BLUNT = 90,
		PIERCE = 90,
		LASER = 50,
		ARCANE = -200,
		HEAT = 50,
		COLD = 50,
		BOMB = 100
	)

	value = 3100

	slowdown_mul_worn = 1.5