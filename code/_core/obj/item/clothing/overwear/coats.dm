/obj/item/clothing/overwear/coat/
	name = "coat"
	icon = 'icons/obj/items/clothing/suit/detective_coat.dmi'

	desc = "The detective's favorite."
	desc_extended = "A dark brown leather coat. It is quite heavy."

	defense_rating = list(
		BLADE = 5,
		BLUNT = 5,
		PIERCE = 5,
		LASER = 0,
		MAGIC = 10,
		HEAT = 5,
		COLD = 50,
		BOMB = 0,
		BIO = 0,
		RAD = 0,
		HOLY = 0,
		DARK = 0,
		FATIGUE = 0
	)

/obj/item/clothing/overwear/coat/wizard
	name = "wizard's robes"
	icon = 'icons/obj/items/clothing/suit/wizard.dmi'

	desc = "Not a bathrobe."
	desc_extended = "A colorful bathrobe."

	defense_rating = list(
		BLADE = 0,
		BLUNT = 0,
		PIERCE = 0,
		LASER = 0,
		MAGIC = 75,
		HEAT = 0,
		COLD = 10,
		BOMB = 0,
		BIO = 0,
		RAD = 0,
		HOLY = 0,
		DARK = 0,
		FATIGUE = 0
	)

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
		BLADE = 0,
		BLUNT = 0,
		PIERCE = 0,
		LASER = 0,
		MAGIC = 25,
		HEAT = 0,
		COLD = 10,
		BOMB = 0,
		BIO = 0,
		RAD = 0,
		HOLY = -100,
		DARK = 100,
		FATIGUE = 0
	)

/obj/item/clothing/overwear/coat/winter
	name = "winter coat"
	icon = 'icons/obj/items/clothing/suit/winter_coat.dmi'

	defense_rating = list(
		BLADE = 5,
		BLUNT = 5,
		PIERCE = 5,
		LASER = -10,
		MAGIC = 25,
		HEAT = -50,
		COLD = 100,
		BOMB = 0,
		BIO = 0,
		RAD = 0,
		HOLY = 0,
		DARK = 0,
		FATIGUE = 0
	)

	protection_cold = list(
		BODY_TORSO = 5,
		BODY_ARM_LEFT = 4,
		BODY_ARM_RIGHT = 4,
		BODY_GROIN = 1
	)
