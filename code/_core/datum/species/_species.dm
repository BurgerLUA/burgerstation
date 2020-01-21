/species/
	var/name = "Species Name"
	var/desc = "Short species description."
	var/desc_extended = "Extended species description."
	var/id = null

	var/flags_species = SPECIES_NONE

	var/flags_chargen = CHARGEN_NONE

	var/default_color_eye = "#FF0000"


	var/default_color_skin = "#0000FF"
	var/default_color_detail = "#FFFFFF"
	var/default_color_glow = "#FFFFFF"
	var/default_color_hair = "#00FF00"

	var/default_icon_hair = 'icons/mob/living/advanced/hair/human_hair_head.dmi'
	var/default_icon_state_hair = "bald"


	var/list/all_hair_head = list()
	var/list/all_hair_face = list()

	var/default_icon_face = 'icons/mob/living/advanced/hair/human_hair_face.dmi'
	var/default_icon_state_face = "none"

	var/default_hairstyle_chargen_male = 2
	var/default_hairstyle_chargen_female = 16

	var/genderless = FALSE

	var/list/obj/item/organ/spawning_organs_male = list()

	var/list/obj/item/organ/spawning_organs_female = list()

	var/list/obj/hud/button/spawning_buttons = list(
		// /obj/hud/button/drop,
		// /obj/hud/button/drop/left,
		// /obj/hud/button/resist,
		// /obj/hud/button/resist_auto,
		/obj/hud/button/hide_show_inventory,
		/obj/hud/button/move,
		/obj/hud/button/targeting,
		/obj/hud/button/intent,
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
		/obj/hud/button/toggle_cash_money,
		/obj/hud/button/cash_money,

		/obj/hud/button/boss_health,

		/obj/hud/button/crafting/craft,
		/obj/hud/button/crafting/close,

		/obj/hud/button/widget/experience,
		/obj/hud/button/widget/logout,
		/obj/hud/button/widget/change_theme,

		//obj/hud/button/teleport/teleport_here,
		//obj/hud/button/teleport/cycle/right,
		//obj/hud/button/teleport/cycle/left,

		/obj/hud/button/squad/main,

		/obj/hud/button/ping,

		/obj/hud/button/message/,

		/obj/hud/button/keypad/top,
		/obj/hud/button/keypad/bottom

	)

	var/list/obj/hud/button/spawning_health = list(
		/obj/hud/button/health/bar/hp,
		/obj/hud/button/health/bar/sp,
		/obj/hud/button/health/bar/mp,
		/obj/hud/button/health/body
	)