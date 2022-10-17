/obj/item/clothing/overwear/armor/knight
	name = "heavy knight armor"
	desc = "Fat roll mode on!"
	desc_extended = "Heavily padded steel armor. Provides great protection from all physical forms of damage, but makes it hard to move."
	icon = 'icons/obj/item/clothing/suit/knight_blank.dmi'
	worn_layer = LAYER_MOB_CLOTHING_HARDSUIT


	protected_limbs = list(BODY_TORSO,BODY_GROIN,BODY_ARM_LEFT,BODY_ARM_RIGHT,BODY_HAND_LEFT,BODY_HAND_RIGHT,BODY_LEG_LEFT,BODY_LEG_RIGHT)

	hidden_organs = list(
		BODY_TORSO = TRUE,
		BODY_GROIN = TRUE,
		BODY_ARM_RIGHT = TRUE,
		BODY_ARM_LEFT = TRUE,
		BODY_HAND_RIGHT = TRUE,
		BODY_HAND_LEFT = TRUE,
		BODY_LEG_RIGHT = TRUE,
		BODY_LEG_LEFT = TRUE,
		BODY_FOOT_RIGHT = TRUE,
		BODY_FOOT_LEFT = TRUE
	)

	armor = /armor/steel

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

	armor = /armor/steel/heavy

	size = SIZE_7

	value = 1000

	value_burgerbux = 1

/obj/item/clothing/overwear/armor/knight/templar
	name = "templar knight armor"
	desc = "Fuck Elves."
	desc_extended = "Once worn by mercenaries who didn't understand religion, now it's often worn by cosplayers who also don't understand religion."
	icon = 'icons/obj/item/clothing/suit/knight_templar.dmi'

	armor = /armor/steel/holy

	size = SIZE_5


	value = 200

/obj/item/clothing/overwear/armor/knight/battlemage
	name = "battlemage armor"
	desc = "To protect your frail wizard form."
	desc_extended = "A suit of armor used by those in the Wizard Federation who aren't septuagenarian yet."
	icon = 'icons/obj/item/clothing/suit/knight_battlemage.dmi'

	armor = /armor/steel/arcane

	size = SIZE_6

	value = 300

	value_burgerbux = 1

/obj/item/clothing/overwear/armor/knight/daddy
	name = "giant father's armor"

	desc = "THE LEGEND NEVER DIES"
	desc_extended = "A matching suit of armor for your Chaos Zweihander."
	icon = 'icons/obj/item/clothing/suit/knight_daddy.dmi'

	armor = /armor/steel/heavy

	size = SIZE_7

	value = 4000

/obj/item/clothing/overwear/armor/knight/clockwork
	name = "clockwork armor"

	desc = "HAIL RATVAR."
	desc_extended = "A bronze plate of protective armor."
	icon = 'icons/obj/item/clothing/suit/clockwork.dmi'

	armor = /armor/brass/armor

	size = SIZE_6

	value = 900

/obj/item/clothing/overwear/armor/knight/magnus
	name = "magnus armor"
	icon = 'icons/obj/item/clothing/suit/magnus.dmi'

	armor = /armor/steel/arcane/light

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

	armor = /armor/steel

	protected_limbs = list(BODY_TORSO,BODY_GROIN,BODY_ARM_LEFT,BODY_ARM_RIGHT,BODY_HAND_LEFT,BODY_HAND_RIGHT)

	size = SIZE_4

	hidden_organs = list(
		BODY_TORSO = TRUE,
		BODY_GROIN = TRUE,
		BODY_ARM_RIGHT = TRUE,
		BODY_ARM_LEFT = TRUE,
		BODY_HAND_RIGHT = TRUE,
		BODY_HAND_LEFT = TRUE
	)


/obj/item/clothing/overwear/armor/knight/runic
	name = "runic platebody"
	desc = "Where's the pants?"
	desc_extended = "A kinght suit without the pants. Good for short goblins."
	icon = 'icons/obj/item/clothing/suit/runic.dmi'

	worn_layer = LAYER_MOB_CLOTHING_ARMOR

	armor = /armor/steel/runic

	size = SIZE_4

	protected_limbs = list(BODY_TORSO,BODY_GROIN,BODY_ARM_LEFT,BODY_ARM_RIGHT)

	hidden_organs = list(
		BODY_TORSO = TRUE,
		BODY_GROIN = TRUE
	)