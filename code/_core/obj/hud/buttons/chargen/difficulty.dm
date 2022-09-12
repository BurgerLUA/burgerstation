/obj/hud/button/chargen/difficulty/
	name = "change difficulty"
	icon = 'icons/hud/difficulty.dmi'
	icon_state = "hud_outline"
	screen_loc = "CENTER+2.5,CENTER+2:-8"

	desc_extended = "Click here to change your difficulty. Higher difficulties give more rewards and experience at the cost of fighting against a stronger force. The recommended experience is \"Normal\"."

	user_colors = TRUE

	chargen_flags = CHARGEN_NONE

	var/chosen_difficulty = DIFFICULTY_NORMAL

	maptext_x = -TILE_SIZE*0.5
	maptext_y = -10
	maptext_width = TILE_SIZE*2

/obj/hud/button/chargen/difficulty/update_owner(var/mob/desired_owner)
	if(is_player(desired_owner))
		var/mob/living/advanced/player/P = desired_owner
		chosen_difficulty = P.difficulty
	. = ..()

/obj/hud/button/chargen/difficulty/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	. = ..()

	if(. && is_player(caller))
		var/mob/living/advanced/player/A = caller

		var/difficulty_choice = input("What difficulty do you wish to change to?",chosen_difficulty) as null|anything in DIFFICULTY_ALL
		if(!difficulty_choice)
			return TRUE

		chosen_difficulty = difficulty_choice

		A.difficulty = chosen_difficulty
		A.setup_difficulty()

		update_sprite()

/obj/hud/button/chargen/difficulty/update_sprite()
	. = ..()
	maptext = "<center>[chosen_difficulty]</center>"

/obj/hud/button/chargen/difficulty/update_overlays()

	. = ..()

	var/initial_icon = initial(icon)

	var/image/I = new/image(initial_icon,chosen_difficulty)
	I.appearance_flags = RESET_COLOR | RESET_ALPHA | KEEP_APART
	var/icon/mask = new/icon(initial_icon,"hud_mask")
	I.filters += filter(type="alpha",icon=mask)

	var/list/alpha_mod = list(
		DIFFICULTY_EASY = 0,
		DIFFICULTY_NORMAL = 0,
		DIFFICULTY_HARD = 90,
		DIFFICULTY_EXTREME = 180,
		DIFFICULTY_NIGHTMARE = 255
	)

	var/chosen_alpha = alpha_mod[chosen_difficulty]
	if(chosen_alpha > 0)
		var/image/I2 = new/image(initial_icon,"blood_portrait")
		I2.alpha = chosen_alpha
		I2.appearance_flags = RESET_COLOR | RESET_ALPHA | KEEP_APART
		var/icon/mask2 = new/icon(initial_icon,"hud_mask_extended")
		I2.filters += filter(type="alpha",icon=mask2)
		I.color = blend_colors("#FFFFFF","#FF0000",(chosen_alpha/255)*0.25)
		src.add_overlay(I)
		src.add_overlay(I2)
	else
		I.color = "#FFFFFF"
		src.add_overlay(I)