/obj/item/clothing/overwear/armor/knight
	name = "heavy knight armor"
	desc = "Fat roll mode on!"
	desc_extended = "Heavily padded steel armor. Provides great protection from all physical forms of damage, but makes it hard to move."
	icon = 'icons/obj/item/clothing/suit/knight_blank.dmi'
	worn_layer = LAYER_MOB_CLOTHING_HARDSUIT
	rarity = RARITY_UNCOMMON

	protected_limbs = list(BODY_TORSO,BODY_GROIN,BODY_ARM_LEFT,BODY_ARM_RIGHT,BODY_HAND_LEFT,BODY_HAND_RIGHT,BODY_LEG_LEFT,BODY_LEG_RIGHT)

	defense_rating = list(
		BLADE = 60,
		BLUNT = 40,
		PIERCE = 40,
		LASER = 40,
		HEAT = -40,
		ARCANE = -60,
		PAIN = 60
	)

	size = SIZE_6

	value = 150

/obj/item/clothing/overwear/armor/knight/red
	name = "red heavy knight armor"
	icon = 'icons/obj/item/clothing/suit/knight_red.dmi'

/obj/item/clothing/overwear/armor/knight/blue
	name = "blue heavy knight armor"
	icon = 'icons/obj/item/clothing/suit/knight_blue.dmi'

/obj/item/clothing/overwear/armor/knight/green
	name = "green heavy knight armor"
	icon = 'icons/obj/item/clothing/suit/knight_green.dmi'

/obj/item/clothing/overwear/armor/knight/yellow
	name = "yellow heavy knight armor"
	icon = 'icons/obj/item/clothing/suit/knight_yellow.dmi'

/obj/item/clothing/overwear/armor/knight/special
	name = "ultra heavy knight armor"
	desc = "Rolling in this would probably break all your bones."
	desc_extended = "A huge suit of armor made entirely of steel. Makes you almost impervious to all forms of physical damage, but makes it very hard to move. Plus, it's like being in an oven."
	icon = 'icons/obj/item/clothing/suit/knight_special.dmi'
	rarity = RARITY_MYTHICAL

	defense_rating = list(
		BLADE = 80,
		BLUNT = 40,
		PIERCE = 40,
		LASER = 40,
		HEAT = -40,
		ARCANE = -80,
		PAIN = 60
	)

	size = SIZE_7

	value = 1000

/obj/item/clothing/overwear/armor/knight/templar
	name = "templar knight armor"
	desc = "Fuck Elves."
	desc_extended = "Once worn by mercenaries who didn't understand religion, now it's often worn by cosplayers who also don't understand religion."
	icon = 'icons/obj/item/clothing/suit/knight_templar.dmi'
	rarity = RARITY_UNCOMMON

	defense_rating = list(
		BLADE = 60,
		BLUNT = 40,
		PIERCE = 40,
		LASER = 40,
		HEAT = -40,
		ARCANE = -60,
		HOLY = 60,
		PAIN = 60
	)

	size = SIZE_5


	value = 200

/obj/item/clothing/overwear/armor/knight/battlemage
	name = "battlemage armor"
	desc = "To protect your frail wizard form."
	desc_extended = "A suit of armor used by those in the Wizard Federation who aren't septuagenarian yet."
	icon = 'icons/obj/item/clothing/suit/knight_battlemage.dmi'
	rarity = RARITY_RARE

	defense_rating = list(
		BLADE = 60,
		BLUNT = 60,
		PIERCE = 60,
		LASER = 20,
		HEAT = -20,
		ARCANE = 60,
		PAIN = 60
	)

	size = SIZE_6


	value = 300

/obj/item/clothing/overwear/armor/knight/daddy
	name = "giant father's armor"
	rarity = RARITY_LEGENDARY
	desc = "THE LEGEND NEVER DIES"
	desc_extended = "A matching suit of armor for your Chaos Zweihander."
	icon = 'icons/obj/item/clothing/suit/knight_daddy.dmi'

	defense_rating = list(
		BLADE = 80,
		BLUNT = 40,
		PIERCE = 60,
		LASER = -40,
		ARCANE = -80,
		HEAT = -40,
		BOMB = 40
	)

	size = SIZE_7

	value = 4000

/obj/item/clothing/overwear/armor/knight/clockwork
	name = "clockwork armor"
	rarity = RARITY_RARE
	desc = "HAIL RATVAR."
	desc_extended = "A bronze plate of protective armor."
	icon = 'icons/obj/item/clothing/suit/clockwork.dmi'

	defense_rating = list(
		BLADE = 40,
		BLUNT = 40,
		PIERCE = 40,
		LASER = -60,
		ARCANE = 60,
		HEAT = -40
	)

	size = SIZE_6

	value = 900

/obj/item/clothing/overwear/armor/knight/magnus
	name = "magnus armor"
	icon = 'icons/obj/item/clothing/suit/magnus.dmi'
	rarity = RARITY_RARE

	defense_rating = list(
		BLADE = 20,
		BLUNT = 20,
		PIERCE = 20,
		LASER = -20,
		ARCANE = 60,
		HOLY = -20,
		DARK = 20
	)

	protected_limbs = list(BODY_TORSO,BODY_GROIN)

	size = SIZE_5

	value = 300

/obj/item/clothing/overwear/armor/knight/magnus/red
	color = COLOR_RED

/obj/item/clothing/overwear/armor/knight/magnus/gold
	color = COLOR_GOLD

/obj/item/clothing/overwear/armor/knight/goblin
	name = "goblin knight torso"
	desc = "Where's the pants?"
	desc_extended = "A kinght suit without the pants. Good for short goblins."
	icon = 'icons/obj/item/clothing/suit/goblin.dmi'

	defense_rating = list(
		BLADE = 80,
		BLUNT = 40,
		PIERCE = 40,
		LASER = 40,
		HEAT = -40,
		ARCANE = -80,
		PAIN = 60
	)

	protected_limbs = list(BODY_TORSO,BODY_GROIN,BODY_ARM_LEFT,BODY_ARM_RIGHT)