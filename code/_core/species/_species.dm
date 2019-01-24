/datum/species/
	var/name = "BLANK SPECIES"
	var/desc = "OH MY GOD"
	var/id

	var/flags_species = SPECIES_NONE

	var/flags_chargen = CHARGEN_NONE

	var/default_color_eye = "#FF0000"


	var/default_color_skin = "#0000FF"
	var/default_color_detail = "#FFFFFF"
	var/default_color_glow = "#FFFFFF"
	var/default_color_hair = "#00FF00"

	var/default_icon_hair = 'icons/mob/living/advanced/hair/hair.dmi'
	var/default_icon_state_hair = "bald"

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

	var/list/chargen_hair_colors = list()

	var/list/chargen_skin_colors = list()

	var/list/chargen_eye_colors = list()

	var/list/chargen_detail_colors = list()

	var/list/chargen_glow_colors = list()