/mob/living/advanced/proc/start_chargen()
	Initialize()
	chargen = TRUE
	add_chargen_buttons()
	show_hud(FALSE,FLAGS_HUD_ALL,speed=0)
	show_hud(TRUE,FLAGS_HUD_INVENTORY,FLAGS_HUD_SPECIAL,speed=5)
	show_hud(TRUE,FLAGS_HUD_CHARGEN,FLAGS_HUD_SPECIAL,speed=5)
	stop_sound('sounds/music/menu/lobby.ogg',list(src))


