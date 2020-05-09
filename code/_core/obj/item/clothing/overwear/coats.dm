/obj/item/clothing/overwear/coat/
	name = "coat"
	icon = 'icons/obj/items/clothing/suit/detective_coat.dmi'

	desc = "The detective's favorite."
	desc_extended = "A dark brown leather coat. It is quite heavy."

	defense_rating = list(
		BLADE = 15,
		BLUNT = 10,
		PIERCE = 10,
		MAGIC = 15,
		COLD = 25
	)

	size = SIZE_3
	weight = WEIGHT_2

	value = 10

/obj/item/clothing/overwear/coat/wizard
	name = "wizard's robes"
	icon = 'icons/obj/items/clothing/suit/wizard.dmi'

	desc = "Not a bathrobe."
	desc_extended = "A colorful bathrobe."

	defense_rating = list(
		MAGIC = 75,
		COLD = 25
	)

	size = SIZE_3
	weight = WEIGHT_2

	value = 30

	dyeable = TRUE

/obj/item/clothing/overwear/coat/wizard/red
	color = "#FF0000"

/obj/item/clothing/overwear/coat/wizard/blue
	color = "#0065FF"

/obj/item/clothing/overwear/coat/chaplain
	name = "priest garb"
	icon = 'icons/obj/items/clothing/suit/religious.dmi'

	desc = "Ultra fancy!"
	desc_extended = ""

	defense_rating = list(
		MAGIC = 25,
		DARK = 100
	)

	size = SIZE_3
	weight = WEIGHT_2

	value = 30

/obj/item/clothing/overwear/coat/winter
	name = "winter coat"
	icon = 'icons/obj/items/clothing/suit/winter_coat.dmi'

	defense_rating = list(
		BLADE = 15,
		BLUNT = 10,
		PIERCE = 10,
		LASER = -15,
		MAGIC = 25,
		HEAT = -75,
		COLD = 75
	)

	protection_cold = list(
		BODY_TORSO = 5,
		BODY_ARM_LEFT = 4,
		BODY_ARM_RIGHT = 4,
		BODY_GROIN = 2
	)

	additional_clothing = list(/obj/item/clothing/head/hood/winter)

	size = SIZE_3
	weight = WEIGHT_3

	value = 20


/obj/item/clothing/overwear/coat/hoodie
	name = "hoodie"
	icon = 'icons/obj/items/clothing/suit/hoodie.dmi'

	additional_clothing = list(/obj/item/clothing/head/hood/hoodie)

	dyeable = TRUE

	size = SIZE_3
	weight = WEIGHT_3

	value = 40

	dyeable = TRUE


/obj/item/clothing/overwear/coat/hoodie/black
	color = COLOR_BLACK

/obj/item/clothing/overwear/coat/hoodie/grey
	color = COLOR_GREY