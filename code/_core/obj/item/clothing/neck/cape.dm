/obj/item/clothing/neck/cape
	name = "cape"
	desc = "Is it a bird? Is it a plane?"
	desc_extended = "Attaches to the neck slot for extra fashion."
	icon = 'icons/obj/item/clothing/suit/cape.dmi'


	protected_limbs = list(BODY_TORSO)

	defense_rating = list(
		ARCANE = AP_AXE,
		COLD = AP_SWORD
	)

	rarity = RARITY_UNCOMMON

	size = SIZE_2


	worn_layer = LAYER_MOB_CLOTHING_NECK_OVER

	dyeable = TRUE

	polymorphs = list(
		"base" = COLOR_WHITE,
		"design" = COLOR_WHITE,
		"trim" = COLOR_WHITE
	)


	value = 60

/obj/item/clothing/neck/cape/hunter
	polymorphs = list(
		"base" = COLOR_CRIMSON,
		"design" = COLOR_RED_DARK,
		"trim" = COLOR_CRIMSON
	)

/obj/item/clothing/neck/cape/hide
	name = "hide cape"
	polymorphs = list(
		"base" = COLOR_BROWN,
		"design" = COLOR_BROWN,
		"trim" = COLOR_BROWN
	)

	defense_rating = list(
		BLADE = 10,
		BLUNT = 10,
		PIERCE = 10,
		COLD = 25
	)

	rarity = RARITY_UNCOMMON

	value = 30

/obj/item/clothing/neck/cape/goliath
	name = "goliath cloak"
	icon = 'icons/obj/item/clothing/suit/goliath_cloak.dmi'
	desc = "Is it a bird? Is it a plane? No, it's a Shaft Miner!"
	desc_extended = "A protective cloak made from goliath hide."

	additional_clothing = list(/obj/item/clothing/head/helmet/)

	defense_rating = list(
		BLADE = 25,
		BLUNT = 25,
		PIERCE = 25,
		LASER = -50,
		ARCANE = 25,
		HEAT = 50,
		COLD = 25
	)

	additional_clothing = list(/obj/item/clothing/head/hat/goliath)

	value = 200

	dyeable = FALSE