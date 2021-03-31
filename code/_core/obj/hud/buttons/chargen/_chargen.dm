var/global/list/obj/hud/button/chargen_buttons = list(

	/obj/hud/button/chargen/change_name,

	/obj/hud/button/chargen/hairstyle/main,
	/obj/hud/button/chargen/hairstyle/slot01,
	/obj/hud/button/chargen/hairstyle/slot02,
	/obj/hud/button/chargen/hairstyle/slot03,
	/obj/hud/button/chargen/hairstyle/slot04,

	/obj/hud/button/chargen/change_hairstyle/,
	/obj/hud/button/chargen/change_hairstyle/left,

	/obj/hud/button/chargen/beardstyle/main,
	/obj/hud/button/chargen/beardstyle/slot01,
	/obj/hud/button/chargen/beardstyle/slot02,
	/obj/hud/button/chargen/beardstyle/slot03,
	/obj/hud/button/chargen/beardstyle/slot04,

	/obj/hud/button/chargen/change_beardstyle/,
	/obj/hud/button/chargen/change_beardstyle/left,

	/obj/hud/button/chargen/sex/,
	/obj/hud/button/chargen/species/,

	/obj/hud/button/chargen/skin_color,
	/obj/hud/button/chargen/eye_color,

	/obj/hud/button/chargen/detail,
	/obj/hud/button/chargen/glow
)

/obj/hud/button/chargen
	name = "chargen button"
	desc = "Press this."
	desc_extended = "Press this button."
	icon_state = "square"
	screen_loc = "CENTER,CENTER"

	flags = FLAGS_HUD_CHARGEN

	user_colors = FALSE

	var/chargen_flags = CHARGEN_NONE

	has_quick_function = FALSE
