/obj/item/clothing/uniform/skirt
	name = "skirt"
	desc = "Makes you look like a fucking weeb."
	icon = 'icons/obj/items/clothing/uniforms/poly_skirt.dmi'

	polymorphic = TRUE

	defense_rating = list(
		BLADE = 5,
		BLUNT = 5,
		PIERCE = 5,
		LASER = 0,
		MAGIC = 25,
		HEAT = 10,
		COLD = -20,
		BOMB = 0,
		BIO = 0,
		RAD = 0,
		HOLY = 0,
		DARK = 0,
		FATIGUE = 0
	)

	no_initial_blend = TRUE

	protected_limbs = list(BODY_TORSO,BODY_GROIN,BODY_ARM_LEFT,BODY_ARM_RIGHT)

/obj/item/clothing/uniform/skirt/white
	color_primary = "#FFFFFF"
	color_secondary = "#FFFFFF"
	color_tertiary = "#FFFFFF"