/obj/shuttle_controller/arrivals
	name = "arrivals shuttle controler"
	desc = "Controls the arrivals shuttle."

	transit_start = "arrivals_shuttle_centcomm"
	transit_bluespace = "arrivals_shuttle_bluespace"
	transit_end = "arrivals_shuttle_station"

	var/mob/living/simple/npc/captain_beepsky/linked_beepsky

	var/list/griefers = list()

	status_id = "arrivals"

/obj/shuttle_controller/arrivals/Initialize()
	. = ..()
	linked_beepsky = locate() in get_area(src)
	return .

/obj/shuttle_controller/arrivals/launch(var/desired_transit_time)

	if(get_area(src) != get_area(linked_beepsky))
		return FALSE

	return ..()

/obj/shuttle_controller/arrivals/trigger(var/mob/caller,var/atom/source,var/signal_freq,var/signal_code)

	if(!caller || !linked_beepsky)
		return FALSE

	var/caller_ref = "\ref[caller]"
	griefers[caller_ref] += 1

	if(griefers[caller_ref] >= 10)
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