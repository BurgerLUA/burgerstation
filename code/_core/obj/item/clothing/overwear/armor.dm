/obj/item/clothing/overwear/armor/
	name = "body armor"
	icon = 'icons/obj/items/clothing/suit/bulletproof_vest.dmi'
	item_slot = SLOT_TORSO_A
	desc = "Protecting against the greytide since 2193."
	desc_extended = "A sturdy suit of armor."

	protected_limbs = list(BODY_TORSO,BODY_GROIN)

	defense_rating = list(
		BLADE = 10,
		BLUNT = 10,
		PIERCE = 40,
		LASER = 10,
		MAGIC = -25,
		HEAT = 0,
		COLD = 10,
		BOMB = 10,
		BIO = 0,
		RAD = 0,
		HOLY = 0,
		DARK = 0,
		FATIGUE = 0
	)

/obj/item/clothing/overwear/armor/cult
	name = "cult robes"
	icon = 'icons/obj/items/clothing/suit/cult.dmi'
	item_slot = SLOT_TORSO_A | SLOT_TORSO_O
	worn_layer = LAYER_MOB_CLOTHING_OVER_MOB

	defense_rating = list(
		BLADE = 30,
		BLUNT = 20,
		PIERCE = 20,
		LASER = -50,
		MAGIC = -25,
		HEAT = 10,
		COLD = 30,
		BOMB = 0,
		BIO = 0,
		RAD = 0,
		HOLY = 75,
		DARK = -75,
		FATIGUE = 0
	)

/obj/item/clothing/overwear/armor/cult/old
	name = "ancient cult robes"
	icon = 'icons/obj/items/clothing/suit/cult_old.dmi'

	defense_rating = list(
		BLADE = 20,
		BLUNT = 10,
		PIERCE = 20,
		LASER = -50,
		MAGIC = -10,
		HEAT = 5,
		COLD = 30,
		BOMB = 0,
		BIO = 0,
		RAD = 0,
		HOLY = 90,
		DARK = -90,
		FATIGUE = 0
	)

/obj/item/clothing/overwear/armor/cult/hard
	name = "hardened cult robes"
	icon = 'icons/obj/items/clothing/suit/cult_hard.dmi'

	defense_rating = list(
		BLADE = 50,
		BLUNT = 30,
		PIERCE = 30,
		LASER = -50,
		MAGIC = -25,
		HEAT = 5,
		COLD = 15,
		BOMB = 0,
		BIO = 0,
		RAD = 0,
		HOLY = 50,
		DARK = -50,
		FATIGUE = 0
	)

/obj/item/clothing/overwear/armor/tutorial
	name = "tutorial armor"
	icon = 'icons/obj/items/clothing/suit/tutorial_dress.dmi'
	item_slot = SLOT_TORSO_O

	defense_rating = list(
		BLADE = 25,
		BLUNT = 25,
		PIERCE = 25,
		LASER = 0,
		MAGIC = 25,
		HEAT = 0,
		COLD = -20,
		BOMB = 0,
		BIO = 0,
		RAD = 0,
		HOLY = -50,
		DARK = 25,
		FATIGUE = 0
	)

/obj/item/clothing/overwear/armor/knight
	name = "heavy knight armor"
	icon = 'icons/obj/items/clothing/suit/knight_blank.dmi'
	item_slot = SLOT_TORSO_A | SLOT_TORSO_O
	worn_layer = LAYER_MOB_CLOTHING_OVER_MOB

	protected_limbs = list(BODY_TORSO,BODY_GROIN,BODY_ARM_LEFT,BODY_ARM_RIGHT,BODY_HAND_LEFT,BODY_HAND_RIGHT,BODY_LEG_LEFT,BODY_LEG_RIGHT)

	defense_rating = list(
		BLADE = 50,
		BLUNT = 10,
		PIERCE = 10,
		LASER = 0,
		MAGIC = -25,
		HEAT = -25,
		COLD = 10,
		BOMB = 5,
		BIO = 0,
		RAD = 0,
		HOLY = 0,
		DARK = 0,
		FATIGUE = 0
	)

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

	defense_rating = list(
		BLADE = 100,
		BLUNT = 50,
		PIERCE = 50,
		LASER = 75,
		MAGIC = -75,
		HEAT = 50,
		COLD = 50,
		BOMB = 25,
		BIO = 40,
		RAD = 10,
		HOLY = 0,
		DARK = 10,
		FATIGUE = 0
	)

/obj/item/clothing/overwear/armor/knight/templar
	name = "templar knight armor"
	icon = 'icons/obj/items/clothing/suit/knight_templar.dmi'

	defense_rating = list(
		BLADE = 25,
		BLUNT = 20,
		PIERCE = 10,
		LASER = 0,
		MAGIC = -10,
		HEAT = -10,
		COLD = 20,
		BOMB = 5,
		BIO = 0,
		RAD = 0,
		HOLY = -75,
		DARK = 75,
		FATIGUE = 0
	)

/obj/item/clothing/overwear/armor/knight/battlemage
	name = "battlemage armor"
	icon = 'icons/obj/items/clothing/suit/knight_battlemage.dmi'

	defense_rating = list(
		BLADE = 30,
		BLUNT = 20,
		PIERCE = 20,
		LASER = 10,
		MAGIC = 75,
		HEAT = 25,
		COLD = 25,
		BOMB = 10,
		BIO = 0,
		RAD = 0,
		HOLY = 0,
		DARK = 0,
		FATIGUE = 0
	)


/obj/item/clothing/overwear/armor/hardsuit/
	name = "hardsuit"
	protected_limbs = list(BODY_TORSO,BODY_GROIN,BODY_ARM_LEFT,BODY_ARM_RIGHT,BODY_LEG_LEFT,BODY_LEG_RIGHT)

/obj/item/clothing/overwear/armor/hardsuit/syndie1
	name = "mauler hardsuit mk1"
	icon = 'icons/obj/items/clothing/suit/syndie1.dmi'

	defense_rating = list(
		BLADE = 50,
		BLUNT = 50,
		PIERCE = 70,
		LASER = 50,
		MAGIC = -50,
		HEAT = 75,
		COLD = 75,
		BOMB = 50,
		BIO = 60,
		RAD = 60,
		HOLY = 0,
		DARK = 0,
		FATIGUE = 0
	)

	additional_clothing = list(/obj/item/clothing/head/helmet/hardsuit/syndie1)

/obj/item/clothing/overwear/armor/hardsuit/syndie2
	name = "mauler hardsuit mk2"
	icon = 'icons/obj/items/clothing/suit/syndie2.dmi'

	defense_rating = list(
		BLADE = 40,
		BLUNT = 40,
		PIERCE = 80,
		LASER = 60,
		MAGIC = -50,
		HEAT = 90,
		COLD = 90,
		BOMB = 90,
		BIO = 75,
		RAD = 75,
		HOLY = 0,
		DARK = 0,
		FATIGUE = 0
	)

	additional_clothing = list(/obj/item/clothing/head/helmet/hardsuit/syndie2)

/obj/item/clothing/overwear/armor/knight/magnus
	name = "white magnus armor"
	icon = 'icons/obj/items/clothing/suit/magnus.dmi'

	defense_rating = list(
		BLADE = 20,
		BLUNT = 20,
		PIERCE = 20,
		LASER = 5,
		MAGIC = 75,
		HEAT = 10,
		COLD = 20,
		BOMB = 0,
		BIO = 0,
		RAD = 0,
		HOLY = 25,
		DARK = 50,
		FATIGUE = 0
	)

	protected_limbs = list(BODY_TORSO,BODY_GROIN)

/obj/item/clothing/overwear/armor/carbon_armor
	name = "carbon fibre armor"
	icon = 'icons/obj/items/clothing/suit/captain_suit.dmi'

	defense_rating = list(
		BLADE = 50,
		BLUNT = 30,
		PIERCE = 80,
		LASER = 40,
		MAGIC = -50,
		HEAT = 25,
		COLD = 25,
		BOMB = 25,
		BIO = 25,
		RAD = 25,
		HOLY = 0,
		DARK = 0,
		FATIGUE = 0
	)

	protected_limbs = list(BODY_TORSO,BODY_GROIN,BODY_ARM_LEFT,BODY_ARM_RIGHT,BODY_LEG_LEFT,BODY_LEG_RIGHT)

/obj/item/clothing/overwear/armor/hardsuit/captain
	name = "captain's hardsuit"
	icon = 'icons/obj/items/clothing/suit/captain_suit.dmi'

	defense_rating = list(
		BLADE = 60,
		BLUNT = 40,
		PIERCE = 80,
		LASER = 40,
		MAGIC = -50,
		HEAT = 90,
		COLD = 90,
		BOMB = 50,
		BIO = 90,
		RAD = 90,
		HOLY = 0,
		DARK = 0,
		FATIGUE = 0
	)

/obj/item/clothing/overwear/armor/molded_armor
	name = "light armor"
	icon = 'icons/obj/items/clothing/suit/mod_chest_armor.dmi'

/obj/item/clothing/overwear/armor/molded_armor/leather
	name = "light leather armor"
	color = "#8C4438"

	defense_rating = list(
		BLADE = 15,
		BLUNT = 10,
		PIERCE = 10,
		LASER = 0,
		MAGIC = 0,
		HEAT = 0,
		COLD = 25,
		BOMB = 0,
		BIO = 0,
		RAD = 0,
		HOLY = 0,
		DARK = 0,
		FATIGUE = 0
	)

/obj/item/clothing/overwear/armor/molded_armor/security
	name = "light security armor"
	color = "#111111"

	defense_rating = list(
		BLADE = 10,
		BLUNT = 10,
		PIERCE = 20,
		LASER = 0,
		MAGIC = -10,
		HEAT = 0,
		COLD = 10,
		BOMB = 0,
		BIO = 0,
		RAD = 0,
		HOLY = 0,
		DARK = 0,
		FATIGUE = 0
	)


/obj/item/clothing/overwear/armor/medium_armor
	name = "medium armor"
	icon = 'icons/obj/items/clothing/suit/medium_chest_armor.dmi'

/obj/item/clothing/overwear/armor/medium_armor/leather
	name = "medium leather armor"
	color = "#8C4438"

	defense_rating = list(
		BLADE = 25,
		BLUNT = 10,
		PIERCE = 20,
		LASER = 0,
		MAGIC = -10,
		HEAT = 0,
		COLD = 25,
		BOMB = 0,
		BIO = 0,
		RAD = 0,
		HOLY = 0,
		DARK = 0,
		FATIGUE = 0
	)

/obj/item/clothing/overwear/armor/medium_armor/security
	name = "medium security armor"
	color = "#111111"

	defense_rating = list(
		BLADE = 10,
		BLUNT = 10,
		PIERCE = 40,
		LASER = 10,
		MAGIC = -25,
		HEAT = 0,
		COLD = 10,
		BOMB = 10,
		BIO = 0,
		RAD = 0,
		HOLY = 0,
		DARK = 0,
		FATIGUE = 0
	)

/obj/item/clothing/overwear/armor/gladiator
	name = "gladiator armor"
	icon = 'icons/obj/items/clothing/suit/gladiator.dmi'

/obj/item/clothing/overwear/armor/gladiator/brass
	name = "bronze gladiator armor"
	color = "#B7A33E"
	item_slot = SLOT_TORSO_A
	worn_layer = LAYER_MOB_CLOTHING_ARMOR

	defense_rating = list(
		BLADE = 35,
		BLUNT = 15,
		PIERCE = 35,
		LASER = 0,
		MAGIC = -25,
		HEAT = 0,
		COLD = 0,
		BOMB = 0,
		BIO = 0,
		RAD = 0,
		HOLY = 0,
		DARK = 0,
		FATIGUE = 0
	)



