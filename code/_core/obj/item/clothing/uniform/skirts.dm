/obj/item/clothing/uniform/skirt
	name = "skirt"
	desc = "Makes you look like a fucking weeb."
	icon = 'icons/obj/items/clothing/uniforms/poly_skirt.dmi'

	polymorphic = TRUE

	color_primary = "#FFFFFF"
	color_secondary = "#FFFFFF"
	color_tertiary = "#FFFFFF"

	defense_rating = list(
		BLADE = ARMOR_E,
		BLUNT = ARMOR_E,
		PIERCE = ARMOR_E,
		MAGIC = ARMOR_D,
		COLD = -ARMOR_D,
		HEAT = ARMOR_D
	)

	no_initial_blend = TRUE

	protected_limbs = list(BODY_TORSO,BODY_GROIN,BODY_ARM_LEFT,BODY_ARM_RIGHT)

	value = 10


/obj/item/clothing/uniform/skirt/random/on_spawn()
	color_primary = random_color()
	color_secondary = random_color()
	color_tertiary = random_color()
	return ..()