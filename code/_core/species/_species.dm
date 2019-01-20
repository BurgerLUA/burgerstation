/datum/species/
	var/name = "BLANK SPECIES"
	var/desc = "OH MY GOD"

	var/eye_color_default = "#FF0000"
	var/color_skin_default = "#0000FF"
	var/color_hair_default = "#00FF00"
	var/hair_style_default = "bald"

	var/genderless = FALSE

	var/list/obj/item/organ/spawning_organs_male = list()

	var/list/obj/item/organ/spawning_organs_female = list()

	var/list/obj/button/spawning_buttons = list(
		///obj/button/equip,
		///obj/button/equip/left,
		/obj/button/resist,
		/obj/button/resist_auto,
		/obj/button/hide_show_inventory
	)

	var/list/obj/health/spawning_health = list(
		"hp" = /obj/health/hp,
		"sp" = /obj/health/sp,
		"mp" = /obj/health/mp
	)