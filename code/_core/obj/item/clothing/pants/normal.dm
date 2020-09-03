/obj/item/clothing/pants/normal
	name = "pants"
	icon = 'icons/obj/item/clothing/pants/normal.dmi'

	desc = "Eat Pant."
	desc_extended = "The peak of fashion."

	defense_rating = list(
		BLADE = 5,
		BLUNT = 5,
		PIERCE = 5,
		ARCANE = 25,
		HEAT = 5,
		COLD = 10
	)

	dyeable = TRUE

	polymorphs = list(
		"pants" = COLOR_WHITE
	)

	size = SIZE_2


	value = 10


/obj/item/clothing/pants/normal/striped
	name = "striped pants"
	desc = "Stripes improve everything."
	desc_extended = "The pants of choice for Ska dancers, Mimes, and Clowns."
	polymorphs = list(
		"pants" = COLOR_BLACK,
		"stripes" = COLOR_WHITE
	)

/obj/item/clothing/pants/normal/chaps
	name = "chapped pants"
	desc = "Damn you're double cheeked up on a wednesday afternoon?"
	desc_extended = "Pants with chaps around the butt."
	polymorphs = list(
		"pants" = COLOR_WHITE,
		"chaps" = COLOR_BLACK
	)

/obj/item/clothing/pants/normal/chaps/assless
	name = "assless chaps"
	desc = "Damn you're double cheeked up on a wednesday afternoon?"
	desc_extended = "Pants that don't cover your butt. Please don't wear these."
	polymorphs = list(
		"chaps" = COLOR_WHITE
	)

/obj/item/clothing/pants/normal/security
	name = "security pants"
	desc = "Tacticool!"
	desc_extended = "Standard issue Security pants. The black colouring doesn't actually provide any tactical advantage whatsoever."
	polymorphs = list(
		"pants" = COLOR_SECURITY_DARK
	)

/obj/item/clothing/pants/normal/security/ancient
	name = "ancient security pants"
	desc = "From a forgotten age."
	desc_extended = "An ancient pair of security pants. Rumor is that it's red to hide greytide blood."
	polymorphs = list(
		"pants" = COLOR_CRIMSON
	)

/obj/item/clothing/pants/normal/botany
	name = "botanty pants"
	desc = "Good for plants."
	desc_extended = "Good pants to wear if you're on your knees a lot. Also good for botany."
	polymorphs = list(
		"pants" = COLOR_GREEN
	)


/obj/item/clothing/pants/normal/engineering
	name = "engineering pants"
	desc = "Offensively bright."
	desc_extended = "Standard issue engineering pants, pre-stained yellow for when the SM delaminates"
	polymorphs = list(
		"pants" = COLOR_ENGINEERING,
		"stripes" = COLOR_VISIBLE_GREEN
	)

/obj/item/clothing/pants/normal/medical
	name = "medical pants"
	desc = "Smells like disinfectant."
	desc_extended = "A pair of fastidiously sterilized pants. Looks like extra care was taken to scrub all the blood out."
	polymorphs = list(
		"pants" = COLOR_MEDICAL_LIGHT
	)

/obj/item/clothing/pants/normal/grey
	name = "assistant pants"
	desc = "Eat pant."
	desc_extended = "The signature grey pants of the tide."
	polymorphs = list(
		"pants" = COLOR_GREY
	)