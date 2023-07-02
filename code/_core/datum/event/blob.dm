/event/blob
	name = "Blob Biohazard"

	probability = 5 //relative

	occurances_max = 1

/event/blob/on_start()

	var/gamemode/G = SSgamemode.active_gamemode

	if(!G)
		return FALSE

	if(!G.add_objective(/objective/kill_blob))
		return FALSE

	announce(
		"Central Command Xenoviral Division",
		"Blob Alert",
		"A level 5 \"blob\" biohazard growth has been detected near the area of operations.",
		sound_to_play = 'sound/voice/announcement/blob.ogg'
	)

	. = ..()