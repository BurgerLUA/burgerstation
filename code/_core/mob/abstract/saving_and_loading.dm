/client/proc/load(var/savedata/client/mob/U,var/file_num)

	U.loaded_data = U.load_json_data_from_id(file_num)
	src.save_slot = file_num
	to_chat(span("notice","Successfully loaded character [U.loaded_data["name"]]."))
	stop_music_track(src)

	var/mob/living/advanced/player/P = new(FALLBACK_TURF,src)
	P.mobdata = U
	INITIALIZE(P)

	return P
