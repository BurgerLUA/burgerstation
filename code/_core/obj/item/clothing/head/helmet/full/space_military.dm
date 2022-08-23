/obj/item/clothing/head/helmet/full/space_military
	name = "space military helmet"
	icon = 'icons/obj/item/clothing/hats/space_military_new.dmi'
	desc = "Military. In space!"
	desc_extended = "A helmet made from hardened carbon fibres."

	armor = /armor/military/medium/hard

	size = SIZE_3

	value = 500

	hidden_organs = list(
		BODY_HAIR_HEAD = TRUE,
		BODY_HAIR_FACE = TRUE
	)

	dyeable = TRUE

	polymorphs = list(
		"armor" = "#726858",
		"visor" = "#D6EEE4"
	)