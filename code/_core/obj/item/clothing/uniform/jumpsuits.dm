/obj/item/clothing/uniform/jumpsuit
	name = "jumpsuit"
	desc = "A nice jumpsuit."

	icon = 'icons/obj/items/clothing/uniforms/poly_suit.dmi'

	flags_clothing = FLAG_CLOTHING_NOBEAST_FEET

	item_slot = SLOT_TORSO | SLOT_GROIN

	polymorphic = TRUE

	no_initial_blend = TRUE

	protected_limbs = list(BODY_TORSO,BODY_GROIN,BODY_ARM_LEFT,BODY_ARM_RIGHT,BODY_LEG_LEFT,BODY_LEG_RIGHT)

	armor_rating = list(
		BRUTE = 15,
		BURN = 5
	)

/obj/item/clothing/uniform/jumpsuit/grey
	color_primary = "#A0A0A0"
	color_secondary = "#A0A0A0"
	color_tertiary = "#FFFFFF"

/obj/item/clothing/uniform/jumpsuit/red
	color_primary = "#FF0000"
	color_secondary = "#FF0000"
	color_tertiary = "#A0A0A0"

/obj/item/clothing/uniform/jumpsuit/blue
	color_primary = "#FF0000"
	color_secondary = "#FF0000"
	color_tertiary = "#A0A0A0"