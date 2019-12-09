/obj/item/clothing/overwear/armor/bulletproof
	name = "bulletproof armor"
	icon = 'icons/obj/items/clothing/suit/bulletproof_vest.dmi'
	item_slot = SLOT_TORSO_A
	desc = "Protecting against the greytide since 2193."
	desc_extended = "A sturdy chestplate of bulletproof armor. Should protect against most small arms fire."

	protected_limbs = list(BODY_TORSO)

	rarity = RARITY_UNCOMMON

	defense_rating = list(
		BLADE = ARMOR_E,
		BLUNT = ARMOR_C,
		PIERCE = ARMOR_B,
		LASER = ARMOR_E,
		MAGIC = -ARMOR_C,
		COLD = ARMOR_C
	)

	size = SIZE_4
	weight = WEIGHT_4

/obj/item/clothing/overwear/armor/cult
	name = "cult robes"
	icon = 'icons/obj/items/clothing/suit/cult.dmi'
	item_slot = SLOT_TORSO_A | SLOT_TORSO_O
	worn_layer = LAYER_MOB_CLOTHING_OVER_MOB

	rarity = RARITY_UNCOMMON

	defense_rating = list(
		BLADE = ARMOR_C,
		BLUNT = ARMOR_E,
		PIERCE = ARMOR_D,
		LASER = -ARMOR_B,
		MAGIC = -ARMOR_D,
		HEAT = ARMOR_E,
		COLD = ARMOR_C,
		HOLY = ARMOR_B
	)

	size = SIZE_4
	weight = WEIGHT_4

/obj/item/clothing/overwear/armor/cult/old
	name = "ancient cult robes"
	icon = 'icons/obj/items/clothing/suit/cult_old.dmi'

	rarity = RARITY_RARE

	defense_rating = list(
		BLADE = ARMOR_C,
		BLUNT = ARMOR_E,
		PIERCE = ARMOR_D,
		LASER = -ARMOR_A,
		MAGIC = -ARMOR_C,
		HEAT = ARMOR_E,
		COLD = ARMOR_C,
		HOLY = ARMOR_A
	)

	size = SIZE_3
	weight = WEIGHT_3

/obj/item/clothing/overwear/armor/cult/hard
	name = "hardened cult robes"
	icon = 'icons/obj/items/clothing/suit/cult_hard.dmi'

	rarity = RARITY_MYTHICAL

	defense_rating = list(
		BLADE = ARMOR_C,
		BLUNT = ARMOR_C,
		PIERCE = ARMOR_C,
		LASER = -ARMOR_A,
		MAGIC = -ARMOR_A,
		HEAT = ARMOR_B,
		COLD = ARMOR_B,
		HOLY = ARMOR_C,
	)

	size = SIZE_5
	weight = WEIGHT_5

/obj/item/clothing/overwear/armor/tutorial
	name = "tutorial armor"
	icon = 'icons/obj/items/clothing/suit/tutorial_dress.dmi'
	item_slot = SLOT_TORSO_O
	rarity = RARITY_MYTHICAL

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

	size = SIZE_4
	weight = WEIGHT_4

/obj/item/clothing/overwear/armor/knight
	name = "heavy knight armor"
	icon = 'icons/obj/items/clothing/suit/knight_blank.dmi'
	item_slot = SLOT_TORSO_A | SLOT_TORSO_O
	worn_layer = LAYER_MOB_CLOTHING_OVER_MOB
	rarity = RARITY_UNCOMMON

	protected_limbs = list(BODY_TORSO,BODY_GROIN,BODY_ARM_LEFT,BODY_ARM_RIGHT,BODY_HAND_LEFT,BODY_HAND_RIGHT,BODY_LEG_LEFT,BODY_LEG_RIGHT)

	defense_rating = list(
		BLADE = ARMOR_B,
		BLUNT = ARMOR_D,
		PIERCE = ARMOR_E,
		LASER = ARMOR_C,
		MAGIC = -ARMOR_S,
		HEAT = -ARMOR_A,
		COLD = ARMOR_D,
		BOMB = ARMOR_D
	)

	size = SIZE_6
	weight = WEIGHT_6
	slowdown_mul_worn = 1.3

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
		BLADE = ARMOR_S,
		BLUNT = ARMOR_D,
		PIERCE = ARMOR_D,
		LASER = ARMOR_C,
		MAGIC = -ARMOR_S,
		HEAT = -ARMOR_S,
		COLD = ARMOR_D,
		BOMB = ARMOR_D
	)

	size = SIZE_7
	weight = WEIGHT_7

/obj/item/clothing/overwear/armor/knight/templar
	name = "templar knight armor"
	icon = 'icons/obj/items/clothing/suit/knight_templar.dmi'
	rarity = RARITY_UNCOMMON

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

	size = SIZE_5
	weight = WEIGHT_4

/obj/item/clothing/overwear/armor/knight/battlemage
	name = "battlemage armor"
	icon = 'icons/obj/items/clothing/suit/knight_battlemage.dmi'
	rarity = RARITY_RARE

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

	size = SIZE_6
	weight = WEIGHT_6

/obj/item/clothing/overwear/armor/knight/daddy
	name = "giant father's armor"
	rarity = RARITY_LEGENDARY
	desc = "THE LEGEND NEVER DIES"
	icon = 'icons/obj/items/clothing/suit/knight_daddy.dmi'

	defense_rating = list(
		BLADE = ARMOR_S,
		BLUNT = ARMOR_C,
		PIERCE = ARMOR_D,
		LASER = -ARMOR_C,
		MAGIC = -ARMOR_S,
		HEAT = -ARMOR_S,
		COLD = ARMOR_D,
		BOMB = ARMOR_E,
		HOLY = -ARMOR_C,
		DARK = -ARMOR_C
	)

	size = SIZE_7
	weight = WEIGHT_8

/obj/item/clothing/overwear/armor/hardsuit/
	name = "hardsuit"
	protected_limbs = list(BODY_TORSO,BODY_GROIN,BODY_ARM_LEFT,BODY_ARM_RIGHT,BODY_LEG_LEFT,BODY_LEG_RIGHT,BODY_FOOT_LEFT,BODY_FOOT_RIGHT)
	worn_layer = LAYER_MOB_CLOTHING_OVER_MOB
	rarity = RARITY_MYTHICAL


/obj/item/clothing/overwear/armor/hardsuit/syndie
	name = "mauler hardsuit mk1"
	icon = 'icons/obj/items/clothing/suit/syndie_basic.dmi'
	rarity = RARITY_UNCOMMON

	defense_rating = list(
		BLADE = ARMOR_C,
		BLUNT = ARMOR_D,
		PIERCE = ARMOR_E,
		LASER = ARMOR_D,
		MAGIC = -ARMOR_S,
		HEAT = ARMOR_C,
		COLD = ARMOR_B,
		BOMB = ARMOR_D,
		BIO = ARMOR_B,
		RAD = ARMOR_D
	)

	size = SIZE_7
	weight = WEIGHT_7

	additional_clothing = list(/obj/item/clothing/head/helmet/hardsuit/syndie)

	slowdown_mul_worn = 1.2

/obj/item/clothing/overwear/armor/hardsuit/syndie/advanced
	name = "mauler hardsuit mk2"
	icon = 'icons/obj/items/clothing/suit/syndie_advanced.dmi'
	rarity = RARITY_RARE

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

	size = SIZE_6
	weight = WEIGHT_6

	additional_clothing = list(/obj/item/clothing/head/helmet/hardsuit/syndie/advanced)

	slowdown_mul_worn = 1.2

/obj/item/clothing/overwear/armor/hardsuit/syndie/elite
	name = "mauler hardsuit mk3"
	icon = 'icons/obj/items/clothing/suit/syndie_elite.dmi'
	rarity = RARITY_MYTHICAL

	defense_rating = list(
		BLADE = ARMOR_B,
		BLUNT = ARMOR_B,
		PIERCE = ARMOR_D,
		LASER = ARMOR_B,
		MAGIC = -ARMOR_S,
		HEAT = ARMOR_C,
		COLD = ARMOR_B,
		BOMB = ARMOR_D,
		BIO = ARMOR_C,
		RAD = ARMOR_D
	)

	additional_clothing = list(/obj/item/clothing/head/helmet/hardsuit/syndie/elite)

	size = SIZE_6
	weight = WEIGHT_5
	slowdown_mul_worn = 1

/obj/item/clothing/overwear/armor/knight/magnus
	name = "white magnus armor"
	icon = 'icons/obj/items/clothing/suit/magnus.dmi'
	rarity = RARITY_RARE

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

	size = SIZE_5
	weight = WEIGHT_5

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
	color = "#7F0000"

/obj/item/clothing/overwear/armor/carbon_armor
	name = "prototype carbon fibre armor"
	icon = 'icons/obj/items/clothing/suit/captain_suit.dmi'

	rarity = RARITY_MYTHICAL

	defense_rating = list(
		BLADE = ARMOR_B,
		BLUNT = ARMOR_D,
		PIERCE = ARMOR_C,
		LASER = ARMOR_S,
		MAGIC = -ARMOR_S,
		BOMB = ARMOR_D
	)

	size = SIZE_6
	weight = WEIGHT_4

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

	size = SIZE_3
	weight = WEIGHT_3

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

	size = SIZE_3
	weight = WEIGHT_4

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

	size = SIZE_4
	weight = WEIGHT_4

/obj/item/clothing/overwear/armor/medium_armor/security
	name = "medium security armor"
	color = "#404040"

	defense_rating = list(
		BLADE = ARMOR_C,
		BLUNT = ARMOR_C,
		PIERCE = ARMOR_B,
		MAGIC = -ARMOR_B,
		COLD = ARMOR_D
	)

	size = SIZE_4
	weight = WEIGHT_5

/obj/item/clothing/overwear/armor/gladiator
	name = "gladiator armor"
	icon = 'icons/obj/items/clothing/suit/gladiator.dmi'
	rarity = RARITY_UNCOMMON

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

	size = SIZE_5
	weight = WEIGHT_5

