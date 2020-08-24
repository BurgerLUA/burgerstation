/obj/shuttle_controller/arrivals
	name = "arrivals shuttle controler"
	desc = "Controls the arrivals shuttle."

	transit_start = "arrivals_shuttle_centcomm"
	transit_bluespace = "arrivals_shuttle_bluespace"
	transit_end = "arrivals_shuttle_station"

	var/mob/living/simple/npc/captain_beepsky/linked_beepsky

	default_transit_time = 30 //Gotta be speedy or else players will probably D/C at stupid transit times.

	var/list/griefers = list()

	status_id = "arrivals"

/obj/shuttle_controller/arrivals/Initialize()
	. = ..()
	linked_beepsky = locate() in get_area(src)
	return .

/obj/shuttle_controller/arrivals/launch(var/mob/caller,var/desired_transit_time)

	if(get_area(src) != get_area(linked_beepsky))
		return FALSE

	. = ..()

	if(.)
		var/area/A = get_area(src)
		for(var/mob/living/advanced/player/P in A.contents)
			if(P.dead)
				continue
			if(!P.tutorial)
				continue
			P.save()
			P.tutorial = FALSE

	return .

/obj/shuttle_controller/arrivals/trigger(var/mob/caller,var/atom/source,var/signal_freq,var/signal_code)

	if(!caller || !linked_beepsky)
		return FALSE

	var/caller_ref = "\ref[caller]"
	griefers[caller_ref] += 1

	if(griefers[caller_ref] >= 3)
		linked_beepsky.ai.attackers += caller
		griefers -= caller_ref

	return ..()


/obj/shuttle_controller/arrivals/on_shuttle_think()

	if(state == SHUTTLE_STATE_LANDED)
		display = "Landed"
		if(time >= SHUTTLE_DEFAULT_IDLE_TIME)
			var/area/A = get_area(src)
			if(A.id == transit_end)
				state = SHUTTLE_STATE_WAITING
				time = 0
			else
				var/mob/living/advanced/player/P = locate() in A.contents
				if(P)
					state = SHUTTLE_STATE_WAITING
					time = 0

	return ..()

/obj/shuttle_controller/arrivals/alpha
	transit_start = "arrivals_shuttle_centcomm_01"
	transit_bluespace = "arrivals_shuttle_bluespace_01"
	transit_end = "arrivals_shuttle_station_01"

	status_id = "arrivals_01"

/obj/shuttle_controller/arrivals/bravo
	transit_start = "arrivals_shuttle_centcomm_02"
	transit_bluespace = "arrivals_shuttle_bluespace_02"
	transit_end = "arrivals_shuttle_station_02"

	status_id = "arrivals_02"