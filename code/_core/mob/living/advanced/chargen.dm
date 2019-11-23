/mob/living/advanced/proc/start_chargen()

	spawn()

		Initialize()
		chargen = TRUE
		show_hud(FALSE,FLAGS_HUD_ALL,speed=0)
		handle_hairstyle_chargen(sex == MALE ? 2 : 16,"#000000")
		handle_beardstyle_chargen(1,"#000000")

		stop_sound('sounds/music/menu/lobby.ogg',list(src))

		if(ENABLE_LORE)

			play_sound('sounds/music/menu/space.ogg',list(src),list(src.x,src.y,src.z),channel = SOUND_CHANNEL_MUSIC)

			client.allow_zoom_controls = FALSE
			client.update_zoom(2)

			stun_time = -1
			paralyze_time = -1

			add_notification_colored_easy(client,"#000000",200*5 + 10,fade_in = FALSE, fade_out = TRUE)

			add_notification_easy(client,'icons/hud/discovery.dmi',"intro_1",180,fade_in = TRUE)
			sleep(200)

			add_notification_easy(client,'icons/hud/discovery.dmi',"intro_2",180,fade_in = TRUE)
			sleep(200)

			add_notification_easy(client,'icons/hud/discovery.dmi',"intro_3",180,fade_in = TRUE)
			sleep(200)

			add_notification_easy(client,'icons/hud/discovery.dmi',"intro_4",180,fade_in = TRUE)
			sleep(200)

			add_notification_easy(client,'icons/hud/discovery.dmi',"intro_5",180,fade_in = TRUE)
			sleep(200)

			stun_time = 20
			paralyze_time = 20


