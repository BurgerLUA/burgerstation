/obj/item/clothing/overwear/coat/vest/
	name = "tactical storage vest"
	icon = 'icons/obj/item/clothing/suit/black_vest.dmi'

	rarity = RARITY_UNCOMMON

	desc = "I NEED MORE POCKETS."
	desc_extended = "A sturdy vest that protects against bullets and inventory management."

	size = SIZE_1*6

	is_container = TRUE

	dynamic_inventory_count = 6
	container_max_size = SIZE_1

	defense_rating = list(
		BLUNT = AP_SWORD,
		PIERCE = AP_SWORD,
		LASER = -AP_SWORD,
		ARCANE = -AP_SWORD
	)

	protected_limbs = list(BODY_TORSO)

	value = 90

/obj/item/clothing/overwear/coat/vest/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(is_inventory(object)) //TODO: Move this to clothing?
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
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

/obj/item/clothing/overwear/coat/vest/colored/grey
	name = "grey vest"
	color = COLOR_GREY

/obj/item/clothing/overwear/coat/vest/sleeveless_leather_jacket
	name = "sleeveless leather jacket"
	icon = 'icons/obj/item/clothing/suit/leather_jacket_sleeveless.dmi'
	rarity = RARITY_COMMON
	desc = "For when you need pockets but not many."

	size = SIZE_2*2

	dynamic_inventory_count = 2
	container_max_size = SIZE_1

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


/obj/item/clothing/overwear/coat/vest/webbing
	name = "webbing"
	icon = 'icons/obj/item/clothing/suit/webbing.dmi'
	desc = " For a big guy."
	desc_extended = "A minimalistic set of webbing harness meant to hold the basics. Holds less than storage vests, but can fit larger items."

	size = SIZE_2*3

	dynamic_inventory_count = 3
	container_max_size = SIZE_2

	value = 100