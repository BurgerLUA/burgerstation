/mob/living/advanced/proc/start_chargen()
	Initialize()
	chargen = TRUE
	add_chargen_buttons()
	show_hud(FALSE,FLAGS_HUD_ALL,speed=0)
	show_hud(TRUE,FLAGS_HUD_INVENTORY,FLAGS_HUD_SPECIAL,speed=5)
	handle_hairstyle_chargen(sex == MALE ? 2 : 16,"#000000")
	handle_beardstyle_chargen(1,"#000000")
	stop_sound('sounds/music/menu/lobby.ogg',list(src))


