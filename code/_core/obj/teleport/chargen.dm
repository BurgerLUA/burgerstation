
/obj/trigger/leave_chargen
	name = "leave chargen"
	invisibility = 101

	icon = 'icons/debug/mobs.dmi'
	icon_state = "directional"

	density = TRUE

/obj/trigger/leave_chargen/Cross(var/atom/movable/triggerer)

	if(is_player(triggerer))
		var/mob/living/advanced/player/A = triggerer
		var/turf/T = get_turf(A) //This is the old turf
		if(A.tutorial)
			spawn
				if(get_dir(T,src) & dir)
					var/response = input(A,"A strange feeling overwhelms you... \
						Is it insecurity? Is it self-loathing? \
						Perhaps you should consider if what you saw in the mirror is what you want to look like. \
						You seem to have a feeling you won't be able to change it for a very long time.",
						"Is this what you want to look like?"
					) as null|anything in list("Fuck, go back!","I'm perfect.","Cancel")

					if(response != "I'm perfect.")
						A.to_chat(span("thought","Maybe I should go back and change a few things..."))
					else
						A.to_chat(span("thought","Today I am beautiful and nothing will change that."))
						A.tutorial = FALSE
			return FALSE

	. = ..()


/obj/trigger/teleport_to_shuttle
	name = "teleport to shuttle"
	invisibility = 101

	var/list/obj/marker/shuttle_markers = list()

	density = TRUE

/obj/trigger/teleport_to_shuttle/Crossed(var/atom/movable/triggerer)

	. = ..()

	if(!is_living(triggerer))
		return .

	var/mob/living/L = triggerer

	if(!length(shuttle_markers))
		for(var/obj/marker/shuttle_marker/SM in world)
			shuttle_markers += SM
	var/obj/marker/shuttle_marker/SM = pick(shuttle_markers)
	L.force_move(get_turf(SM))




/obj/marker/shuttle_marker/
	name = "shuttle marker"



/*

/proc/play_the_fucking_tutorial(var/mob/living/advanced/A)
	spawn(0)
		A.paralyze_time = -1
		A.movement_flags = 0x0
		add_notification_colored_easy(A.client,"#FFFFFF",SECONDS_TO_DECISECONDS(3),fade_in = TRUE, fade_out = TRUE)
		sleep(SECONDS_TO_DECISECONDS(3))
		A.force_move(get_turf(transit_shuttle))
		A.paralyze_time = 0
		A.movement_flags = 0x0
		sleep(SECONDS_TO_DECISECONDS(10))
		dock_shuttle.do_move(A)
		sleep(SECONDS_TO_DECISECONDS(2))
		for(var/obj/structure/interactive/localmachine/snowflake/airlock/external/tutorial_dock/TD in tutorial_docks)
			TD.open_for(A)

/proc/play_the_fucking_game(var/mob/living/advanced/A)

	var/client/C = A.client

	var/show_disclaimer = FALSE

	if(!ENABLE_LORE)
		A.force_move(pick(spawnpoints_new_character))
		A.show_hud(TRUE,FLAGS_HUD_MOB,FLAGS_HUD_SPECIAL,3)
		return TRUE

	spawn(0)
		A.show_hud(FALSE,FLAGS_HUD_ALL,FLAGS_HUD_SPECIAL|FLAGS_HUD_WIDGET,1)
		var/obj/hud/button/skip/SB = new(A)
		SB.update_owner(A)
		A.sight |= SEE_THRU
		C.pixel_y = FLOOR(TILE_SIZE*-VIEW_RANGE*2, 1)

		if(show_disclaimer)
			add_notification_colored_easy(C,"#000000",SECONDS_TO_DECISECONDS(46),fade_in = FALSE)
			add_notification_easy(C,'icons/hud/discovery.dmi',"disclaimer",SECONDS_TO_DECISECONDS(18),fade_in = FALSE)
		else
			add_notification_colored_easy(C,"#000000",SECONDS_TO_DECISECONDS(28),fade_in = FALSE)

		sleep(1)

		A.force_move(pick(spawnpoints_new_character))
		A.stun_time = -1
		A.paralyze_time = -1
		A.movement_flags = 0x0

		if(show_disclaimer)
			sleep(SECONDS_TO_DECISECONDS(20))

		play_music_track("leaf",C)

		sleep(SECONDS_TO_DECISECONDS(5))
		A.see_invisible = INVISIBILITY_NO_PLAYERS
		add_notification_easy(C,'icons/hud/discovery.dmi',"byond",SECONDS_TO_DECISECONDS(3))
		sleep(SECONDS_TO_DECISECONDS(7))
		add_notification_easy(C,'icons/hud/discovery.dmi',"burger",SECONDS_TO_DECISECONDS(3))
		sleep(SECONDS_TO_DECISECONDS(10))
		add_notification_easy(C,'icons/hud/discovery.dmi',"logo",SECONDS_TO_DECISECONDS(10))
		sleep(SECONDS_TO_DECISECONDS(10))

		while(C.pixel_y<0)
			if(C.mob && C.mob.skip_cutscene)
				C.mob.skip_cutscene = FALSE
				C.pixel_y = 0
				break

			C.pixel_y = min(0,C.pixel_y + 1)
			sleep(0.2)

		SB.update_owner(null)

		sleep(1)

		A.sight &= ~SEE_THRU
		sleep(SECONDS_TO_DECISECONDS(3))
		A.show_hud(TRUE,FLAGS_HUD_MOB,FLAGS_HUD_SPECIAL,3)
		A.stun_time = 1
		A.paralyze_time = 1
		A.movement_flags = 0x0

*/