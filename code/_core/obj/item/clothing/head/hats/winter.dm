/obj/item/clothing/head/hat/winter
	name = "winter hood"
	desc = "Protects your head against the elements."
	desc_extended = "Click this or shift-click the winter coat to bring the hood back down."
	icon = 'icons/obj/item/clothing/hats/winter_hood.dmi'

	hidden_organs = list(
		BODY_HAIR_HEAD = TRUE
	)

	armor = /armor/cloth/winter/mask

	protection_cold = list(
		BODY_HEAD = 5,
	)

	size = SIZE_2


	value = 30