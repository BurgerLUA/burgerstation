/obj/trigger/jumpmarker/ship_exit
	desired_marker = "ship_exit"


/obj/trigger/jumpmarker/ship_exit/on_trigger(var/atom/movable/triggerer)
	if(is_player(triggerer))
		var/mob/living/advanced/player/P = triggerer

		if(P.client)
			P.show_hud(FALSE,FLAGS_HUD_ALL,FLAGS_HUD_SPECIAL|FLAGS_HUD_WIDGET,SECONDS_TO_DECISECONDS(1))
			P.sight |= SEE_THRU
			. = ..()
			play_music_track("village_intro",P.client)
			P.client.disable_controls = TRUE
			P.move_dir = NORTH

			spawn(0)
				sleep(SECONDS_TO_DECISECONDS(2))
				P.move_dir = WEST
				sleep(SECONDS_TO_DECISECONDS(4))
				P.move_dir = 0

				var/list/points = list( //start at 116,100
					list(109,100), //Leaving the ship
					list(96,100), //Chapel
					list(60,100) //Bar
				)

				var/step_num = 1
				while(P.client)

					var/speed = 1

					var/desired_x_cord = WORLD_SIZE_SEGMENT*2 + points[step_num][1]
					var/desired_y_cord = WORLD_SIZE_SEGMENT*1 + points[step_num][2]
					var/actual_x = P.x + FLOOR((P.client.pixel_x+16)/TILE_SIZE, 1)
					var/actual_y = P.y + FLOOR((P.client.pixel_y+16)/TILE_SIZE, 1)
					var/mod_x = clamp(desired_x_cord - actual_x,-speed,speed)
					var/mod_y = clamp(desired_y_cord - actual_y,-speed,speed)

					if(mod_x == 0 && mod_y == 0)
						step_num += 1
						if(step_num == 2)
							add_notification_easy(P.client,'icons/hud/discovery.dmi',"village",SECONDS_TO_DECISECONDS(5))
						if(step_num > length(points))
							break
					else
						P.client.pixel_x += mod_x
						P.client.pixel_y += mod_y

					sleep(0.000001)

				add_notification_colored_easy(P.client,"#FFFFFF",SECONDS_TO_DECISECONDS(2),fade_in = TRUE)
				sleep(SECONDS_TO_DECISECONDS(2))
				P.client.pixel_x = 0
				P.client.pixel_y = 0

				P.client.disable_controls = FALSE
				P.sight &= ~SEE_THRU
				sleep(SECONDS_TO_DECISECONDS(3))
				P.show_hud(TRUE,FLAGS_HUD_MOB,FLAGS_HUD_SPECIAL,3)
				var/savedata/client/mob/U = P.mobdata
				U.loaded_data["tutorial"] = 0
				U.save_current_character()
			return
		else
			var/savedata/client/mob/U = P.mobdata
			U.loaded_data["tutorial"] = 0
			U.save_current_character()
			return ..()
	else
		return ..()