/obj/item/clothing/overwear/coat/vest/
	name = "tactical storage vest"
	icon = 'icons/obj/item/clothing/suit/black_vest.dmi'

	rarity = RARITY_UNCOMMON

	desc = "I NEED MORE POCKETS."
	desc_extended = "A sturdy vest that protects against bullets and inventory management."

	size = SIZE_2*6

	is_container = TRUE

	dynamic_inventory_count = 6
	container_max_size = SIZE_2

	defense_rating = list(
		BLUNT = 10,
		PIERCE = 10,
		LASER = -25,
		ARCANE = -25
	)

	protected_limbs = list(BODY_TORSO)

	value = 90

	slowdown_mul_worn = 1.1

/obj/item/clothing/overwear/coat/vest/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(is_inventory(object))
		click_self(caller,location,control,params)
		return TRUE

	return ..()

/obj/item/clothing/overwear/coat/vest/colored
	name = "colored vest"
	icon = 'icons/obj/item/clothing/suit/white_vest.dmi'

	dyeable = TRUE

/obj/item/clothing/overwear/coat/vest/colored/brown
	name = "industrial vest"
	color = COLOR_BROWN_LIGHT

/obj/item/clothing/overwear/coat/vest/colored/medical
	name = "medical vest"
	color = COLOR_WHITE

/obj/item/clothing/overwear/coat/vest/sleeveless_leather_jacket
	name = "sleeveless leather jacket"
	icon = 'icons/obj/item/clothing/suit/leather_jacket_sleeveless.dmi'
	rarity = RARITY_COMMON
	desc = "For when you need pockets but not many."

	size = SIZE_2*4

	dynamic_inventory_count = 4
	container_max_size = SIZE_2

	defense_rating = list(
		BLADE = 25,
		BLUNT = 10,
		PIERCE = 10,
		LASER = -10,
		ARCANE = 10,
		HEAT = 10,
		COLD = 25
	)

	value = 30