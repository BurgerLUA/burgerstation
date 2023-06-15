/obj/item/clothing/overwear/coat/vest/
	name = "tactical storage vest"
	icon = 'icons/obj/item/clothing/suit/black_vest.dmi'

	desc = "I NEED MORE POCKETS."
	desc_extended = "A sturdy vest that protects against bullets and inventory management."

	size = SIZE_1*6

	is_container = TRUE

	dynamic_inventory_count = 6
	container_max_size = SIZE_2

	armor = /armor/cloth/hard

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

/obj/item/clothing/overwear/coat/vest/colored/merc
	name = "merc vest"
	color = "#BCAC86"

/obj/item/clothing/overwear/coat/vest/colored/black
	name = "tactical vest"
	color = "#212121"

/obj/item/clothing/overwear/coat/vest/sleeveless_leather_jacket
	name = "sleeveless leather jacket"
	icon = 'icons/obj/item/clothing/suit/leather_jacket_sleeveless.dmi'

	desc = "For when you need pockets but not many."

	size = SIZE_2*2

	dynamic_inventory_count = 2
	container_max_size = SIZE_1

	armor = /armor/leather/coat

	value = 30


/obj/item/clothing/overwear/coat/vest/webbing
	name = "webbing"
	icon = 'icons/obj/item/clothing/suit/webbing.dmi'
	desc = "For a big guy."
	desc_extended = "A minimalistic set of webbing harness meant to hold the basics. Holds less than storage vests, but can fit larger items."

	size = SIZE_2*3

	dynamic_inventory_count = 3
	container_max_size = SIZE_2

	value = 100


/obj/item/clothing/overwear/coat/vest/poly
	name = "polycolored vest"
	icon = 'icons/obj/item/clothing/suit/white_vest_poly.dmi'

	dyeable = TRUE

	polymorphs = list(
		"shirt" = COLOR_WHITE,
		"pockets" = COLOR_WHITE
	)

/obj/item/clothing/overwear/coat/vest/poly/merc
	name = "mercenary polycolored vest"

	polymorphs = list(
		"shirt" = COLOR_OLIVE_DRAB,
		"pockets" = COLOR_BLACK
	)

/obj/item/clothing/overwear/coat/vest/poly/pockets_only
	name = "webbing pockets"

	polymorphs = list(
		"pockets" = COLOR_BLACK
	)

/obj/item/clothing/overwear/coat/vest/poly/janitor

	polymorphs = list(
		"shirt" = COLOR_GREY,
		"pockets" = COLOR_JANITOR
	)

/obj/item/clothing/overwear/coat/vest/syndicate
	name = "syndicate combat webbing"
	desc = "The pinnacle of torso storaging."
	desc_extended = "Heavy-duty military webbing designed to hold lots of small (size two) items with ease. Issued to the Syndicate's high-ranking personnel."
	icon = 'icons/obj/item/clothing/suit/webbing_syndie.dmi'

	size = SIZE_2*5

	dynamic_inventory_count = 6
	container_max_size = SIZE_2
	value = 1500
	value_burgerbux = 1

	rarity = RARITY_RARE

/obj/item/clothing/overwear/coat/vest/revolutionary
	name = "revolutionary combat webbing"
	desc = "The pinnacle of torso storaging."
	desc_extended = "Ancient military webbing designed to hold lots of small (size two) items with ease. Issued to the revoluionaries' high-ranking personnel."
	icon = 'icons/obj/item/clothing/suit/webbing_rev.dmi'

	size = SIZE_2*5

	dynamic_inventory_count = 6
	container_max_size = SIZE_2
	value = 1500
	value_burgerbux = 1

	rarity = RARITY_RARE
