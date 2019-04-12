/species/
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

	var/default_icon_hair = 'icons/mob/living/advanced/hair/head.dmi'
	var/default_icon_state_hair = "bald"

	var/default_icon_face = 'icons/mob/living/advanced/hair/face.dmi'
	var/default_icon_state_face = "none"

	var/genderless = FALSE

	var/list/obj/item/organ/spawning_organs_male = list()

	var/list/obj/item/organ/spawning_organs_female = list()

	var/list/obj/button/spawning_buttons = list(
		/obj/button/drop,
		/obj/button/drop/left,
		/obj/button/resist,
		/obj/button/resist_auto,
		/obj/button/hide_show_inventory,
		/obj/button/move,
		/obj/button/targeting,
		/obj/button/intent,
		/obj/button/defense,
		/obj/button/sneak,
		/obj/button/close_inventory
	)

	var/list/obj/button/health/spawning_health = list(
		"hp" = /obj/button/health/hp,
		"sp" = /obj/button/health/sp,
		"mp" = /obj/button/health/mp
	)

	var/list/chargen_hair_colors = list()

	var/list/chargen_skin_colors = list()

	var/list/chargen_eye_colors = list()

	var/list/chargen_detail_colors = list()

	var/list/chargen_glow_colors = list()