/obj/item/clothing/overwear/armor/knight
	name = "heavy knight armor"
	icon = 'icons/obj/items/clothing/suit/knight_blank.dmi'
	item_slot = SLOT_TORSO_A | SLOT_TORSO_O
	worn_layer = LAYER_MOB_CLOTHING_HARDSUIT
	rarity = RARITY_UNCOMMON

	protected_limbs = list(BODY_TORSO,BODY_GROIN,BODY_ARM_LEFT,BODY_ARM_RIGHT,BODY_HAND_LEFT,BODY_HAND_RIGHT,BODY_LEG_LEFT,BODY_LEG_RIGHT)

	defense_rating = list(
		BLADE = 75,
		BLUNT = 50,
		PIERCE = 50,
		LASER = 75,
		HEAT = -50,
		MAGIC = -100
	)

	size = SIZE_6
	weight = WEIGHT_6
	slowdown_mul_worn = 1.3

	value = 150

/obj/item/clothing/overwear/armor/knight/red
	name = "red heavy knight armor"
	icon = 'icons/obj/items/clothing/suit/knight_red.dmi'

/obj/item/clothing/overwear/armor/knight/blue
	name = "blue heavy knight armor"
	icon = 'icons/obj/items/clothing/suit/knight_blue.dmi'

/obj/item/clothing/overwear/armor/knight/green
	name = "green heavy knight armor"
	icon = 'icons/obj/items/clothing/suit/knight_green.dmi'

/obj/item/clothing/overwear/armor/knight/yellow
	name = "yellow heavy knight armor"
	icon = 'icons/obj/items/clothing/suit/knight_yellow.dmi'

/obj/item/clothing/overwear/armor/knight/special
	name = "ultra heavy knight armor"
	icon = 'icons/obj/items/clothing/suit/knight_special.dmi'
	rarity = RARITY_MYTHICAL

	defense_rating = list(
		BLADE = 75,
		BLUNT = 100,
		PIERCE = 100,
		LASER = 100,
		HEAT = -100,
		MAGIC = -100
	)

	size = SIZE_7
	weight = WEIGHT_7
	slowdown_mul_worn = 1.5

	value = 1000

/obj/item/clothing/overwear/armor/knight/templar
	name = "templar knight armor"
	icon = 'icons/obj/items/clothing/suit/knight_templar.dmi'
	rarity = RARITY_UNCOMMON

	defense_rating = list(
		BLADE = 50,
		BLUNT = 50,
		PIERCE = 50,
		LASER = 50,
		MAGIC = -25,
		HEAT = -25,
		HOLY = -50,
		DARK = 100
	)

	size = SIZE_5
	weight = WEIGHT_4

	value = 200

/obj/item/clothing/overwear/armor/knight/battlemage
	name = "battlemage armor"
	icon = 'icons/obj/items/clothing/suit/knight_battlemage.dmi'
	rarity = RARITY_RARE

	defense_rating = list(
		BLADE = 50,
		BLUNT = 25,
		PIERCE = 25,
		LASER = 50,
		HEAT = -50,
		MAGIC = 50
	)

	size = SIZE_6
	weight = WEIGHT_6

	value = 300

/obj/item/clothing/overwear/armor/knight/daddy
	name = "giant father's armor"
	rarity = RARITY_LEGENDARY
	desc = "THE LEGEND NEVER DIES"
	icon = 'icons/obj/items/clothing/suit/knight_daddy.dmi'

	defense_rating = list(
		BLADE = 100,
		BLUNT = 25,
		PIERCE = 15,
		LASER = -25,
		MAGIC = -100,
		HEAT = -100,
		COLD = 15,
		BOMB = 10,
		HOLY = -25,
		DARK = -25
	)

	size = SIZE_7
	weight = WEIGHT_8


/obj/item/clothing/overwear/armor/knight/magnus
	name = "magnus armor"
	icon = 'icons/obj/items/clothing/suit/magnus.dmi'
	rarity = RARITY_RARE

	defense_rating = list(
		BLADE = 25,
		BLUNT = 25,
		PIERCE = 10,
		LASER = -25,
		MAGIC = 75,
		HEAT = 25,
		COLD = 15,
		HOLY = -25,
		DARK = 25
	)

	protected_limbs = list(BODY_TORSO,BODY_GROIN)

	size = SIZE_5
	weight = WEIGHT_5

	value = 300

/obj/item/clothing/overwear/armor/knight/magnus/red
	color = COLOR_RED

/obj/item/clothing/overwear/armor/knight/magnus/gold
	color = COLOR_GOLD