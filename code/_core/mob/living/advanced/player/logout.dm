mob/living/advanced/player/proc/can_save(var/area/A)

	if(!client)
		return FALSE

	if(!A || !(A.flags_area & FLAGS_AREA_SAVEZONE))
		src.to_chat(span("danger","You cannot save and quit here! Find a suitable zone to rest first!"))
		return FALSE

	var/obj/structure/interactive/bed/sleeper/S = locate() in src.loc.contents
	if(!S)
		src.to_chat(span("danger","Find a sleeper and lie down on it first before saving!"))
		return FALSE

	if(!S.buckled)
		src.to_chat(span("danger","Lay down on the bed first before saving!"))
		return FALSE

	return TRUE


/mob/living/advanced/player/proc/force_logout()
	if(!ckey_last)
		return FALSE
	var/savedata/client/mob/mobdata = MOBDATA(ckey_last)
	if(!mobdata)
		return FALSE
	mobdata.save_character(src)
	if(client) client.make_ghost(get_turf(src))
	qdel(src)
	return TRUE