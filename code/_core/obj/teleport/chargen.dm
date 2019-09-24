/obj/trigger/leave_chargen
	name = "leave chargen"
	invisibility = 101

/obj/trigger/leave_chargen/on_trigger(var/atom/triggerer)

	if(!is_advanced(triggerer))
		return FALSE

	var/mob/living/advanced/A = triggerer

	if(!A.client)
		return FALSE

	if(!A.used_mirror)
		A.to_chat(span("thought","I'm not going out like this!"))
		return TRUE

	if(!A.found_job)
		A.to_chat(span("thought","I should probably check my emails and then put some clothes on before I leave."))
		return TRUE

	if(!A.clothing_changed)
		A.to_chat(span("thought","I should put some clothes on before I leave for work!"))
		return TRUE

	//Move the player to the shuttle.
	spawn()
		A.paralyze_time = -1
		add_notification_colored_easy(A.client,"#FFFFFF",SECONDS_TO_DECISECONDS(3),fade_in = TRUE, fade_out = TRUE)
		sleep(SECONDS_TO_DECISECONDS(3))
		A.force_move(get_turf(transit_shuttle))
		A.paralyze_time = 0
		sleep(SECONDS_TO_DECISECONDS(10))
		dock_shuttle.do_move(A)
		sleep(SECONDS_TO_DECISECONDS(2))
		for(var/obj/structure/interactive/localmachine/snowflake/airlock/external/tutorial_dock/TD in tutorial_docks)
			TD.open_for(A)

	return TRUE



/obj/trigger/leave_bathroom
	name = "leave bathroom"
	invisibility = 101

/obj/trigger/leave_bathroom/Cross(var/atom/movable/triggerer)

	if(!is_advanced(triggerer))
		return ..()

	var/mob/living/advanced/A = triggerer

	if(!A.appearance_changed && A.used_mirror)

		var/turf/T = get_turf(A) //This is the old turf.

		if(!istype(T,/turf/simulated/floor/tile/)) //Fucking weird check, but it werks.
			return ..()

		var/response = input(A,"A strange feeling overwhelms you... \
			Is it insecurity? Is it self-loathing? \
			Perhaps you should consider if what you saw in the mirror is what you want to look like. \
			You seem to have a feeling you won't be able to change it for a very long time.",
			"Is this what you want to look like?"
		) in list("Fuck, go back!","I'm perfect.")

		if(response == "Fuck, go back!")
			A.to_chat(span("thought","Maybe I should go back and change a few things..."))
			return FALSE

		A.to_chat(span("thought","Today I am beautiful and nothing will change that."))
		A.appearance_changed = TRUE

	return ..()