/obj/item/clothing/shirt/normal
	name = "shirt"
	desc = "A T-Shirt."
	desc_extended = "Probably the most generic article of clothing in the universe."
	icon = 'icons/obj/item/clothing/shirts/normal.dmi'

	item_slot = SLOT_TORSO

	defense_rating = list(
		BLADE = 5,
		BLUNT = 5,
		PIERCE = 5,
		ARCANE = 25,
		COLD = 10,
	)

	dyeable = TRUE

	polymorphs = list(
		"shirt" = COLOR_WHITE
	)

	value = 20


/obj/item/clothing/shirt/normal/striped
	name = "striped shirt"
	desc = "Stripey!"
	desc_extended = "The shirt of choice for Ska Dancers, Mimes, and protags of Quirky RPGs."
	polymorphs = list(
		"shirt" = COLOR_WHITE,
		"stripes" = COLOR_BLACK
	)

/obj/item/clothing/shirt/normal/uniform
	name = "uniformed shirt"
	desc = "It's hip to be square"
	desc_extended = "The shirt of choice for people who hate Casual Fridays."
	polymorphs = list(
		"shirt" = COLOR_WHITE,
		"shoulders" = COLOR_BLACK
	)

/obj/item/clothing/shirt/normal/uniform/nanotrasen
	name = "nanotrasen uniformed shirt"
	desc = "It's hip to be square"
	desc_extended = "The shirt of choice for people who hate Casual Fridays."
	polymorphs = list(
		"shirt" = COLOR_NANOTRASEN,
		"shoulders" = COLOR_WHITE
	)

/obj/item/clothing/shirt/normal/uniform/botanty
	name = "botany uniformed shirt"
	desc = "Blue and green."
	desc_extended = "The shirt of choice for botanists."
	polymorphs = list(
		"shirt" = COLOR_BLUE,
		"shoulders" = COLOR_GREEN
	)


/obj/item/clothing/shirt/normal/security
	name = "security shirt"
	desc = "HALT HALT HALT"
	desc_extended = "A shirt identifying security members to the rest of the station, so they might promptly run away"
	polymorphs = list(
		"shirt" = COLOR_SECURITY_LIGHT,
	)

/obj/item/clothing/shirt/normal/security/ancient
	name = "ancient security shirt"
	desc = "Redshirts!"
	desc_extended = "An old outdated variant of the security shirt."
	polymorphs = list(
		"shirt" = COLOR_CRIMSON,
	)


/obj/item/clothing/shirt/normal/engineering
	name = "engineering shirt"
	desc = "Offensively bright."
	desc_extended = "A shirt with reflective stripes, so in case of an accident, the engineer's corpse will be easily found."
	polymorphs = list(
		"shirt" = COLOR_ENGINEERING,
		"shoulders" = COLOR_VISIBLE_GREEN
	)

/obj/item/clothing/shirt/normal/medical
	name = "medical shirt"
	desc = "Smells clean."
	desc_extended = "A pair of fastidiously sterilized scrubs. Looks like extra care was taken to scrub all the blood out."
	polymorphs = list(
		"shirt" = COLOR_MEDICAL_LIGHT
	)


/obj/item/clothing/shirt/normal/grey
	name = "assistant shirt"
	desc = "The shitter's choice"
	desc_extended = "The signature shirt of the gray tide."
	polymorphs = list(
		"shirt" = COLOR_GREY
	)