/obj/item/clothing/overwear/armor/bulletproof
	name = "bulletproof armor"
	icon = 'icons/obj/items/clothing/suit/bulletproof_vest.dmi'
	item_slot = SLOT_TORSO_A
	desc = "Protecting against the greytide since 2193."
	desc_extended = "A sturdy chestplate of bulletproof armor. Should protect against most small arms fire."

	protected_limbs = list(BODY_TORSO)

	defense_rating = list(
		BLADE = ARMOR_E,
		BLUNT = ARMOR_C,
		PIERCE = ARMOR_D,
		LASER = ARMOR_E,
		MAGIC = -ARMOR_C,
		COLD = ARMOR_C
	)

/obj/item/clothing/overwear/armor/cult
	name = "cult robes"
	icon = 'icons/obj/items/clothing/suit/cult.dmi'
	item_slot = SLOT_TORSO_A | SLOT_TORSO_O
	worn_layer = LAYER_MOB_CLOTHING_OVER_MOB

	defense_rating = list(
		BLADE = ARMOR_C,
		BLUNT = ARMOR_E,
		PIERCE = ARMOR_D,
		LASER = -ARMOR_B,
		MAGIC = -ARMOR_D,
		HEAT = ARMOR_E,
		COLD = ARMOR_C,
		HOLY = -ARMOR_B,
		DARK = ARMOR_B
	)

/obj/item/clothing/overwear/armor/cult/old
	name = "ancient cult robes"
	icon = 'icons/obj/items/clothing/suit/cult_old.dmi'

	defense_rating = list(
		BLADE = ARMOR_C,
		BLUNT = ARMOR_E,
		PIERCE = ARMOR_D,
		LASER = -ARMOR_A,
		MAGIC = -ARMOR_C,
		HEAT = ARMOR_E,
		COLD = ARMOR_C,
		HOLY = -ARMOR_A,
		DARK = ARMOR_A
	)

/obj/item/clothing/overwear/armor/cult/hard
	name = "hardened cult robes"
	icon = 'icons/obj/items/clothing/suit/cult_hard.dmi'

	defense_rating = list(
		BLADE = ARMOR_C,
		BLUNT = ARMOR_C,
		PIERCE = ARMOR_C,
		LASER = -ARMOR_A,
		MAGIC = -ARMOR_A,
		HEAT = ARMOR_B,
		COLD = ARMOR_B,
		HOLY = -ARMOR_C,
		DARK = ARMOR_C
	)

/obj/item/clothing/overwear/armor/tutorial
	name = "tutorial armor"
	icon = 'icons/obj/items/clothing/suit/tutorial_dress.dmi'
	item_slot = SLOT_TORSO_O

	defense_rating = list(
		BLADE = ARMOR_C,
		BLUNT = ARMOR_D,
		PIERCE = ARMOR_D,
		LASER = ARMOR_E,
		MAGIC = ARMOR_D,
		COLD = -ARMOR_C,
		HOLY = ARMOR_D,
		DARK = ARMOR_D
	)

/obj/item/clothing/overwear/armor/knight
	name = "heavy knight armor"
	icon = 'icons/obj/items/clothing/suit/knight_blank.dmi'
	item_slot = SLOT_TORSO_A | SLOT_TORSO_O
	worn_layer = LAYER_MOB_CLOTHING_OVER_MOB

	protected_limbs = list(BODY_TORSO,BODY_GROIN,BODY_ARM_LEFT,BODY_ARM_RIGHT,BODY_HAND_LEFT,BODY_HAND_RIGHT,BODY_LEG_LEFT,BODY_LEG_RIGHT)

	defense_rating = list(
		BLADE = ARMOR_B,
		BLUNT = ARMOR_D,
		PIERCE = ARMOR_C,
		LASER = ARMOR_C,
		MAGIC = -ARMOR_S,
		HEAT = -ARMOR_A,
		COLD = ARMOR_D,
		BOMB = ARMOR_D
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
		BLADE = ARMOR_S,
		BLUNT = ARMOR_D,
		PIERCE = ARMOR_C,
		LASER = ARMOR_C,
		MAGIC = -ARMOR_S,
		HEAT = -ARMOR_S,
		COLD = ARMOR_D,
		BOMB = ARMOR_D
	)

/obj/item/clothing/overwear/armor/knight/templar
	name = "templar knight armor"
	icon = 'icons/obj/items/clothing/suit/knight_templar.dmi'

	defense_rating = list(
		BLADE = ARMOR_C,
		BLUNT = ARMOR_C,
		PIERCE = ARMOR_E,
		LASER = ARMOR_E,
		MAGIC = -ARMOR_C,
		HEAT = -ARMOR_D,
		COLD = ARMOR_B,
		BOMB = ARMOR_E,
		HOLY = -ARMOR_A,
		DARK = ARMOR_A
	)

/obj/item/clothing/overwear/armor/knight/battlemage
	name = "battlemage armor"
	icon = 'icons/obj/items/clothing/suit/knight_battlemage.dmi'

	defense_rating = list(
		BLADE = ARMOR_C,
		BLUNT = ARMOR_D,
		PIERCE = ARMOR_E,
		LASER = -ARMOR_C,
		MAGIC = ARMOR_C,
		HEAT = ARMOR_C,
		COLD = ARMOR_C,
		BOMB = ARMOR_E,
		HOLY = -ARMOR_C,
		DARK = -ARMOR_C
	)


/obj/item/clothing/overwear/armor/hardsuit/
	name = "hardsuit"
	protected_limbs = list(BODY_TORSO,BODY_GROIN,BODY_ARM_LEFT,BODY_ARM_RIGHT,BODY_LEG_LEFT,BODY_LEG_RIGHT,BODY_FOOT_LEFT,BODY_FOOT_RIGHT)
	worn_layer = LAYER_MOB_CLOTHING_OVER_MOB

/obj/item/clothing/overwear/armor/hardsuit/syndie1
	name = "mauler hardsuit mk1"
	icon = 'icons/obj/items/clothing/suit/syndie1.dmi'

	defense_rating = list(
		BLADE = ARMOR_B,
		BLUNT = ARMOR_C,
		PIERCE = ARMOR_D,
		LASER = ARMOR_C,
		MAGIC = -ARMOR_S,
		HEAT = ARMOR_B,
		COLD = ARMOR_A,
		BOMB = ARMOR_C,
		BIO = ARMOR_A,
		RAD = ARMOR_C
	)

	additional_clothing = list(/obj/item/clothing/head/helmet/hardsuit/syndie1)

/obj/item/clothing/overwear/armor/hardsuit/syndie2
	name = "mauler hardsuit mk2"
	icon = 'icons/obj/items/clothing/suit/syndie2.dmi'

	defense_rating = list(
		BLADE = ARMOR_B,
		BLUNT = ARMOR_B,
		PIERCE = ARMOR_C,
		LASER = ARMOR_B,
		MAGIC = -ARMOR_S,
		HEAT = ARMOR_C,
		COLD = ARMOR_B,
		BOMB = ARMOR_D,
		BIO = ARMOR_C,
		RAD = ARMOR_D
	)

	additional_clothing = list(/obj/item/clothing/head/helmet/hardsuit/syndie2)

/obj/item/clothing/overwear/armor/knight/magnus
	name = "white magnus armor"
	icon = 'icons/obj/items/clothing/suit/magnus.dmi'

	defense_rating = list(
		BLADE = ARMOR_C,
		BLUNT = ARMOR_C,
		PIERCE = ARMOR_E,
		LASER = -ARMOR_C,
		MAGIC = ARMOR_C,
		HEAT = ARMOR_C,
		COLD = ARMOR_D,
		HOLY = -ARMOR_C,
		DARK = ARMOR_C
	)

	protected_limbs = list(BODY_TORSO,BODY_GROIN)

/obj/item/clothing/overwear/armor/knight/magnus/red
	name = "red magnus armor"
	defense_rating = list(
		BLADE = ARMOR_D,
		BLUNT = ARMOR_D,
		PIERCE = ARMOR_E,
		LASER = -ARMOR_D,
		MAGIC = ARMOR_D,
		HEAT = ARMOR_B,
		COLD = -ARMOR_C,
		HOLY = ARMOR_C,
		DARK = -ARMOR_C
	)
	color = "#FF0000"

/obj/item/clothing/overwear/armor/carbon_armor
	name = "carbon fibre armor"
	icon = 'icons/obj/items/clothing/suit/captain_suit.dmi'

	defense_rating = list(
		BLADE = ARMOR_B,
		BLUNT = ARMOR_D,
		PIERCE = ARMOR_C,
		LASER = ARMOR_S,
		MAGIC = -ARMOR_S,
		BOMB = ARMOR_D
	)

	protected_limbs = list(BODY_TORSO,BODY_GROIN,BODY_ARM_LEFT,BODY_ARM_RIGHT,BODY_LEG_LEFT,BODY_LEG_RIGHT,BODY_FOOT_LEFT,BODY_FOOT_RIGHT)

/obj/item/clothing/overwear/armor/molded_armor
	name = "light armor"
	icon = 'icons/obj/items/clothing/suit/mod_chest_armor.dmi'

/obj/item/clothing/overwear/armor/molded_armor/leather
	name = "light leather armor"
	color = "#8C4438"

	defense_rating = list(
		BLADE = ARMOR_C,
		BLUNT = ARMOR_D,
		PIERCE = ARMOR_D,
		COLD = ARMOR_C
	)

/obj/item/clothing/overwear/armor/molded_armor/security
	name = "light security armor"
	color = "#111111"

	defense_rating = list(
		BLADE = ARMOR_C,
		BLUNT = ARMOR_D,
		PIERCE = ARMOR_C,
		LASER = ARMOR_E,
		MAGIC = -ARMOR_D,
		COLD = ARMOR_D
	)


/obj/item/clothing/overwear/armor/medium_armor
	name = "medium armor"
	icon = 'icons/obj/items/clothing/suit/medium_chest_armor.dmi'

/obj/item/clothing/overwear/armor/medium_armor/leather
	name = "medium leather armor"
	color = "#8C4438"

	defense_rating = list(
		BLADE = ARMOR_C,
		BLUNT = ARMOR_C,
		PIERCE = ARMOR_C,
		COLD = ARMOR_C
	)

/obj/item/clothing/overwear/armor/medium_armor/security
	name = "medium security armor"
	color = "#111111"

	defense_rating = list(
		BLADE = ARMOR_C,
		BLUNT = ARMOR_C,
		PIERCE = ARMOR_B,
		MAGIC = -ARMOR_B,
		COLD = ARMOR_D
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
		BLADE = ARMOR_B,
		BLUNT = ARMOR_D,
		PIERCE = ARMOR_C,
		LASER = ARMOR_C,
		MAGIC = -ARMOR_A
	)



