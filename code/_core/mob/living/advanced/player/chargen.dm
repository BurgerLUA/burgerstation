/mob/living/advanced/player/proc/start_chargen()

	INITIALIZE(src)
	FINALIZE(src)
	equip_loadout(/loadout/new_player,TRUE)
	stop_music_track(client)

	nutrition *= 0.75
	hydration *= 0.75

	/*
	if(client)

		show_hud(FALSE,FLAG_HUD_ALL,FLAG_HUD_WIDGET | FLAG_HUD_CHARGEN,speed=0)

		var/list/lore = list(
			"In the year 2320, Humankind has advanced their interstellar space travel technology to allow for safe and reliable faster than light travel.",
			"Using bluespace drives, any living being or material can instantaneously move from one point to another with a minuscule amount of energy.",
			"With every nation on earth having this technology, it is now possible to travel to and from nearby planets outside our own Sol System regardless of nation or creed.",
			"But it was not just nations that benefited from this discovery; All corporations, even those without prior interest in space exploration, shifted their focus to the near-endless resources of the Universe.",
			"You work for one such corporation; NanoTrasen. Today is your first day at this technology giant.",
			"They promise it won't be your last."
		)

		play_music_track(/track/space_wayfarer,src.client)

		client.disable_controls = TRUE
		client.update_zoom(3)

		var/obj/hud/screen/S = new()
		S.icon = 'icons/hud/discovery.dmi' //320x320
		S.icon_state = "black"
		S.screen_loc = "CENTER-4.5,CENTER-4.5"
		S.client = src.client
		S.maptext = "<font size='4'>A.</font>"
		S.maptext_width = 320
		S.maptext_height = 300
		S.maptext_y = 20
		S.mouse_opacity = 2
		client.screen += S

		//SHITCODE AHOY
		var/cached_text = ""
		for(var/line in lore)
			cached_text += "<br><br>"
			S.maptext = "[cached_text]"
			for(var/char in splittext(line,""))
				cached_text += char
				S.maptext = "[cached_text]"
				sleep(world.tick_lag*2)
			sleep(30)
		sleep(50)
		animate(S,alpha = 0,time = 20)
		sleep(20)


		show_hud(TRUE,FLAG_HUD_ALL,FLAG_HUD_SPECIAL,speed=SECONDS_TO_DECISECONDS(3))
		client.screen -= S
		qdel(S)

		client.update_zoom(2)
		client.disable_controls = FALSE
	*/


/mob/living/advanced/player/proc/setup_iff()
	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/nanotrasen)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/nanotrasen)


/mob/living/advanced/player/post_perform_change(var/keep_items,var/chargen,var/list/kept_items = list())
	. = ..()
	setup_iff()