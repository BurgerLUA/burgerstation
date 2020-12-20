/obj/item/clothing/pants/skirt
	name = "skirt"
	icon = 'icons/obj/item/clothing/pants/skirt.dmi'

	desc = "For letting people know that you're a woman and/or a programmer."
	desc_extended = "The peak of fashion."

	defense_rating = list(
		BLADE = AP_DAGGER,
		BLUNT = AP_DAGGER,
		PIERCE = AP_DAGGER,
		ARCANE = AP_SWORD,
		COLD = AP_DAGGER
	)

	dyeable = TRUE

	polymorphs = list(
		"skirt" = COLOR_WHITE
	)

	size = SIZE_2


	value = 10

/obj/item/clothing/pants/skirt/striped
	name = "striped skirt"
	desc = "*me waves"
	desc_extended = "A skirt most commonly seen on female mimes. Careful to not get put in an invisible box."
	polymorphs = list(
		"skirt" = COLOR_WHITE,
		"stripes" = COLOR_BLACK
	)

/obj/item/clothing/pants/skirt/grey
	name = "assistant skirt"
	desc = "Whoops, I accidentally jabbed you with a spear, tee-hee!"
	desc_extended = "When you want to be a shitter, but also look cute when you're doing it."
	polymorphs = list(
		"skirt" = COLOR_GREY
	)
