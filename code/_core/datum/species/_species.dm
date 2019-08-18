/species/
	name = "BLANK SPECIES"
	desc = "OH MY GOD"
	id = null

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

	var/list/obj/hud/button/spawning_buttons = list(
		/obj/hud/button/drop,
		/obj/hud/button/drop/left,
		/obj/hud/button/resist,
		/obj/hud/button/resist_auto,
		/obj/hud/button/hide_show_inventory,
		/obj/hud/button/move,
		/obj/hud/button/targeting,
		/obj/hud/button/intent,
		/obj/hud/button/defense,
		/obj/hud/button/sneak,
		/obj/hud/button/close_inventory,
		/obj/hud/button/slot/A,
		/obj/hud/button/slot/B,
		/obj/hud/button/slot/C,
		/obj/hud/button/slot/D,
		/obj/hud/button/slot/E,
		/obj/hud/button/slot/F,
		/obj/hud/button/slot/G,
		/obj/hud/button/slot/H,
		/obj/hud/button/slot/I,
		/obj/hud/button/slot/J,

		/obj/hud/button/boss_health,

		/obj/hud/button/crafting/craft,
		/obj/hud/button/crafting/close
	)

	var/list/obj/hud/button/health/spawning_health = list(
		"hp" = /obj/hud/button/health/hp,
		"sp" = /obj/hud/button/health/sp,
		"mp" = /obj/hud/button/health/mp
	)

	var/list/chargen_hair_colors = list()

	var/list/chargen_skin_colors = list()

	var/list/chargen_eye_colors = list()

	var/list/chargen_detail_colors = list()

	var/list/chargen_glow_colors = list()