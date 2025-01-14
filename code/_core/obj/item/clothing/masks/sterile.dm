/obj/item/clothing/mask/sterile
	name = "sterile medical mask"
	icon = 'icons/obj/item/clothing/masks/sterile.dmi'
	flags_clothing = FLAG_CLOTHING_NOBEAST_HEAD
	desc = "There is no reason for panic."
	desc_extended = "A face mask designed to prevent the spread of airborne viruses."

	armor = /armor/cloth/bio

	size = SIZE_2

	value = 1

	mob_values_add = list(
		SKILL_MEDICAL = 3
	)