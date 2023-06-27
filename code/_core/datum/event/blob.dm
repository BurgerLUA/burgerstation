/event/blob
	name = "Blob Biohazard"

	probability = 5 //relative

	occurances_max = 1

/event/blob/on_start()

	var/turf/T = find_safe_turf_for_event(attempts=10)

	if(!T)
		return FALSE

	announce(
		"Central Command Xenoviral Division",
		"Blob Alert",
		"A level 5 \"blob\" biohazard growth has been detected near the area of operations. Predicted location: [T.x],[T.y].",
		sound_to_play = 'sound/voice/announcement/blob.ogg'
	)

	CREATE(/obj/structure/interactive/blob/core,T)

	notify_ghosts("A blob is being created!",T)

	return ..()