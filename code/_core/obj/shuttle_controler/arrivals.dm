/obj/shuttle_controller/arrivals
	name = "arrivals shuttle controler"
	desc = "Controls the arrivals shuttle."

	var/mob/living/simple/linked_beepsky

	default_transit_time = 30 //Gotta be speedy or else players will probably D/C at stupid transit times.

	var/list/griefers = list()

	status_id = "arrivals"

	var/beepsky_fail_times = 0

/obj/shuttle_controller/arrivals/Initialize()
	. = ..()
	linked_beepsky = locate() in get_area(src)
	return .

/obj/shuttle_controller/arrivals/launch(var/mob/caller,var/desired_transit_time)

	if(get_area(src) != get_area(linked_beepsky))
		beepsky_fail_times++
		if(beepsky_fail_times >= 5)
			var/obj/marker/beepsky/BM = locate() in src.loc.loc.contents
			if(BM)
				linked_beepsky.force_move(BM)
				beepsky_fail_times = 0
			else
				log_error("BEEPSKY IS STUCK!")
		return FALSE

	. = ..()

	if(.)
		var/area/A = get_area(src)
		for(var/mob/living/advanced/player/P in A.contents)
			if(P.dead)
				continue
			if(!P.tutorial)
				continue
			var/savedata/client/mob/mobdata = MOBDATA(P.ckey_last)
			if(mobdata)
				mobdata.save_character(P)
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
			if(A.type == transit_end)
				state = SHUTTLE_STATE_WAITING
				time = 0
			else
				var/mob/living/advanced/player/P = locate() in A.contents
				if(P)
					state = SHUTTLE_STATE_WAITING
					time = 0

	return ..()

/obj/shuttle_controller/arrivals/alpha
	transit_start = /area/transit/arrivals_shuttle_01/centcomm
	transit_bluespace = /area/transit/arrivals_shuttle_01/bluespace
	transit_end = /area/transit/arrivals_shuttle_01/station

	status_id = "arrivals_01"

/obj/shuttle_controller/arrivals/bravo
	transit_start = /area/transit/arrivals_shuttle_02/centcomm
	transit_bluespace = /area/transit/arrivals_shuttle_02/bluespace
	transit_end = /area/transit/arrivals_shuttle_02/station

	status_id = "arrivals_02"