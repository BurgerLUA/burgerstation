/obj/item/clothing/underbottom/underwear
	name = "underwear"
	desc = "Use this to cover your naughty bits."
	desc_extended = "A regular pait of underwear."

	size = SIZE_1


/obj/item/clothing/underbottom/underwear/boxers
	name = "boxers"
	desc = "Smaller pants that go under your regular pants."
	desc_extended = "Just a regular pair of boxers."
	icon = 'icons/obj/item/clothing/underwear/boxers_new.dmi'
	flags_clothing = FLAG_CLOTHING_NOBEAST_FEET

	defense_rating = list(
		ARCANE = 10,
		COLD = 10,
	)

	dyeable = TRUE

	value = 10

/obj/item/clothing/underbottom/underwear/boxers/random/Generate()
	color = random_color()
	return ..()

/obj/item/clothing/underbottom/underwear/boxers/nanotrasen
	color = COLOR_NANOTRASEN

/obj/item/clothing/underbottom/underwear/boxers/engineering
	color = COLOR_ENGINEERING

/obj/item/clothing/underbottom/underwear/boxers/medical
	color = COLOR_MEDICAL

/obj/item/clothing/underbottom/underwear/boxers/heart
	name = "heart boxers"
	desc = "The layabout's classic."
	desc_extended = "A pair of boxers with hearts on them."
	icon = 'icons/obj/item/clothing/underwear/heart_boxers.dmi'

/obj/item/clothing/underbottom/underwear/long_johns
	name = "long johns"
	desc = "Comfy, if slightly old fashioned."
	desc_extended = "A pair of very long underwear."
	icon = 'icons/obj/item/clothing/underwear/long_john.dmi'
	flags_clothing = FLAG_CLOTHING_NOBEAST_FEET

	rarity = RARITY_UNCOMMON

	defense_rating = list(
		ARCANE = 10,
		HEAT = -20,
		COLD = 20,
	)

	dyeable = TRUE

	value = 30

/obj/item/clothing/underbottom/underwear/long_johns/grey
	color = "#888888"

/obj/item/clothing/underbottom/underwear/panty
	icon = 'icons/obj/item/clothing/underwear/panty.dmi'
	desc = "The choice of women, femme boys, and Programmers alike"
	desc_extended = "A pair of slim underwear."

	defense_rating = list(
		ARCANE = 10,
		COLD = 10,
	)

	dyeable = TRUE

	value = 10


/obj/item/clothing/underbottom/underwear/panty/pink
	color = "#ff66ff"

/obj/item/clothing/underbottom/underwear/panty/brown
	color = "#603A20"

/obj/item/clothing/underbottom/underwear/panty/red
	color = "#C60000"

/obj/item/clothing/underbottom/underwear/panty/random/Generate()
	color = random_color()
	return ..()

/obj/item/clothing/underbottom/underwear/panty/neko
	name = "cursed cat panty"
	desc = "who the fuck what the fuck"
	desc_extended = "why"
	icon = 'icons/obj/item/clothing/underwear/neko_panty.dmi'

	rarity = RARITY_MYTHICAL

	defense_rating = list(
		DARK = 20,
		HOLY = -20
	)

	value = 500

/obj/item/clothing/underbottom/underwear/thong
	name = "thong"
	desc = "Underwear, but just barely."
	desc_extended = "Possibly the barest minimum legal requirement to qualify as underwear."
	icon = 'icons/obj/item/clothing/underwear/thong.dmi'
	color = COLOR_WHITE
	defense_rating = list(
		ARCANE = 20,
		COLD = -20,
	)

	dyeable = TRUE

	dyeable = TRUE

	value = 30

/obj/item/clothing/underbottom/underwear/loincloth
	name = "loincloth"
	desc = "Emergency Underwear"
	desc_extended = "For when you don't have sewing tools available, this will do."
	icon = 'icons/obj/item/clothing/underwear/loincloth.dmi'

	defense_rating = list(
		ARCANE = 20
	)

	value = 5


/obj/item/clothing/underbottom/underwear/loincloth/brown
	color = "#603A20"

/obj/item/clothing/underbottom/underwear/loincloth/red
	color = "#8E0000"


