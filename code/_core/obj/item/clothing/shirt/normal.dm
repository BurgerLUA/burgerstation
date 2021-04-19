/obj/item/clothing/shirt/normal
	name = "shirt"
	desc = "A T-Shirt."
	desc_extended = "Probably the most generic article of clothing in the universe."
	icon = 'icons/obj/item/clothing/shirts/normal.dmi'

	item_slot = SLOT_TORSO

	defense_rating = list(
		BLADE = 10,
		BLUNT = 10,
		PIERCE = 10,
		ARCANE = 20,
		COLD = 10
	)

	dyeable = TRUE

	polymorphs = list(
		"shirt" = COLOR_WHITE
	)

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

/obj/item/clothing/shirt/normal/uniform/science
	name = "science uniformed shirt"
	desc = "Nerd."
	desc_extended = "The shirt of choice for people who hate Casual Fridays."
	polymorphs = list(
		"shirt" = COLOR_WHITE,
		"shoulders" = COLOR_SCIENCE
	)

/obj/item/clothing/shirt/normal/uniform/botanty
	name = "botany uniformed shirt"
	desc = "Blue and green."
	desc_extended = "The shirt of choice for botanists."
	polymorphs = list(
		"shirt" = COLOR_BLUE,
		"shoulders" = COLOR_GREEN
	)

/obj/item/clothing/shirt/normal/uniform/janitor
	name = "janitor uniformed shirt"
	desc = "Purple and grey."
	desc_extended = "The shirt of choice for janitor."
	polymorphs = list(
		"shirt" = COLOR_GREY,
		"shoulders" = COLOR_JANITOR
	)


/obj/item/clothing/shirt/normal/uniform/chemistry
	name = "chemistry uniformed shirt"
	desc = "Orange and white."
	desc_extended = "The shirt of choice for botanists."
	polymorphs = list(
		"shirt" = COLOR_WHITE,
		"shoulders" = COLOR_CHEMISTRY
	)

/obj/item/clothing/shirt/normal/uniform/red_soccer
	name = "red soccer shirt"
	polymorphs = list(
		"shirt_tee" = COLOR_RED,
		"shoulders" = COLOR_WHITE
	)

/obj/item/clothing/shirt/normal/uniform/blue_soccer
	name = "blue soccer shirt"
	polymorphs = list(
		"shirt_tee" = COLOR_BLUE,
		"shoulders" = COLOR_BLACK
	)

/obj/item/clothing/shirt/normal/uniform/ref_soccer
	name = "soccer ref shirt"
	polymorphs = list(
		"shirt_tee" = COLOR_YELLOW,
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

/obj/item/clothing/shirt/normal/military_green
	name = "military shirt"
	desc = "No stains here."
	desc_extended = "The signature shirt of the revolutionary."
	polymorphs = list(
		"shirt" = COLOR_GREY
	)

/obj/item/clothing/shirt/normal/janitor
	name = "janitor shirt"
	desc = "Offensively janitor."
	desc_extended = "A shirt that is purple as heck."
	polymorphs = list(
		"shirt" = COLOR_JANITOR,
	)

/obj/item/clothing/shirt/normal/reinforced
	name = "reinforced shirt"
	icon = 'icons/obj/item/clothing/shirts/reinforced.dmi'

	defense_rating = list(
		BLADE = 20,
		BLUNT = 10,
		PIERCE = 20,
		ARCANE = -10,
		COLD = 10,
	)

/obj/item/clothing/shirt/normal/reinforced/ntops
	name = "NT ops reinforced shirt"
	polymorphs = list(
		"shirt" = COLOR_WHITE,
		"shoulders" = COLOR_BLACK
	)

/obj/item/clothing/shirt/normal/reinforced/merc
	name = "mercenary reinforced shirt"
	polymorphs = list(
		"shirt_tee" = COLOR_OLIVE_DRAB
	)

/obj/item/clothing/shirt/normal/reinforced/merc_alt
	polymorphs = list(
		"shirt_tee" = "#626C65"
	)