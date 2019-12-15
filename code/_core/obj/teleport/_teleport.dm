/obj/trigger/
	name = "trigger"
	invisibility = 101

/obj/trigger/Crossed(var/atom/crosser)
	..()
	on_trigger(crosser)

/obj/trigger/proc/on_trigger(var/atom/triggerer)
	return TRUE

/*
/obj/trigger/new_character
	name = "new character teleport trigger"
	desc = "turns the person into a player"

/obj/trigger/new_character/on_trigger(var/atom/triggerer)
	if(is_observer(triggerer))
		var/mob/abstract/observer/O = triggerer
		var/mob/living/advanced/player/P = new(pick(spawnpoints_new_character),O.client)
		P.Initialize()
		if(P.client)
			P.client.eye = P
			P.client.update_zoom(-1)
		qdel(O)

/obj/trigger/move_to_world
	name = "move to world"
	desc = "move to the world"

/obj/trigger/move_to_world/on_trigger(var/atom/triggerer)
	if(is_advanced(triggerer))
		var/mob/living/advanced/A = triggerer
		A.force_move(pick(world_spawnpoints))
		if(A.client)
			A.client.save_current_character()
*/


/obj/trigger/no_entry
	name = "no entry"
	var/message = "You cannot go that way."

/obj/trigger/no_entry/on_trigger(var/mob/triggerer)
	triggerer.to_chat(span("notice",message))

/obj/trigger/jumploc
	name = "loc jumper"
	var/x_move = 0
	var/y_move = 0
	var/dir_restriction = 0

/obj/trigger/jumploc/on_trigger(var/atom/movable/triggerer)

	if(!is_living(triggerer))
		return FALSE

	if(!(triggerer.dir & dir_restriction))
		return FALSE

	triggerer.force_move(locate(x + x_move, y + y_move,z))

/obj/trigger/jumploc/north
	x_move = 0
	y_move = 2
	dir_restriction = NORTH

/obj/trigger/jumploc/south
	x_move = 0
	y_move = -2
	dir_restriction = SOUTH

/obj/trigger/jumploc/east
	x_move = 2
	y_move = 0
	dir_restriction = EAST

/obj/trigger/jumploc/west
	x_move = -2
	y_move = 0
	dir_restriction = WEST

/*
/obj/trigger/jumplevel
	name = "level jumper"
	var/desired_x = 0
	var/desired_y = 0
	var/desired_map = ""
	var/dir_restriction = 0

/obj/trigger/jumplevel/on_trigger(var/atom/movable/triggerer)

	if(!is_mob(triggerer))
		return FALSE

	if(dir_restriction != 0 && !(triggerer.dir & dir_restriction))
		return FALSE

	triggerer.Move(locate(desired_x,desired_y,get_z_level(desired_map)))

	return TRUE
*/

/obj/trigger/jumpmarker
	name = "marker jumper"
	var/desired_marker = ""
	var/dir_restriction = 0

/obj/trigger/jumpmarker/on_trigger(var/atom/movable/triggerer)

	if(!is_mob(triggerer))
		return FALSE

	if(dir_restriction != 0 && !(triggerer.dir & dir_restriction))
		return FALSE

	var/turf/T = get_turf(teleport_locations[desired_marker])

	triggerer.force_move(T)

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
					var/actual_x = P.x + floor((P.client.pixel_x+16)/TILE_SIZE)
					var/actual_y = P.y + floor((P.client.pixel_y+16)/TILE_SIZE)
					var/mod_x = Clamp(desired_x_cord - actual_x,-speed,speed)
					var/mod_y = Clamp(desired_y_cord - actual_y,-speed,speed)

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
			return .
		else
			var/savedata/client/mob/U = P.mobdata
			U.loaded_data["tutorial"] = 0
			U.save_current_character()
			return ..()
	else
		return ..()

/obj/trigger/jumpmarker/clockwork_exit
	desired_marker = "clockwork_exit"