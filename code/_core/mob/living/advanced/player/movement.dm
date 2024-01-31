/mob/living/advanced/player/post_move(atom/old_loc)

	. = ..()

	if(. && src.loc != old_loc && finalized)

		var/turf/old_turf = !old_loc || is_turf(old_loc) ? old_loc : get_turf(old_loc)
		var/turf/new_turf = !loc || is_turf(loc) ? loc : get_turf(loc)

		var/area/new_area = new_turf ? new_turf.loc : null
		var/area/old_area = old_turf ? old_turf.loc : null

		if(!dead && ckey_last && last_autosave + 600 SECONDS <= world.time)
			if(istype(new_area,/area/burgerstation) && !istype(old_area,/area/burgerstation))
				last_autosave = world.time //Safety
				var/savedata/client/mob/mobdata = MOBDATA(ckey_last)
				mobdata?.save_character(src)

		if(dialogue_target_id && !dialogue_loading)
			close_menu(src,/menu/dialogue/)
			dialogue_target_id = null
			dialogue_target = null

		if(active_structure && get_dist(src,active_structure) > 1)
			set_structure_unactive()

		if(active_device && get_dist(src,active_device) > 1)
			set_device_unactive()

		if( (new_area?.flags_area & FLAG_AREA_SINGLEPLAYER) != (old_area?.flags_area & FLAG_AREA_SINGLEPLAYER) )
			src.update_eyes()


/mob/living/advanced/player/on_chunk_cross(chunk/old_chunk,chunk/new_chunk)

	. = ..()

	if(old_chunk)
		old_chunk.players -= src

	if(new_chunk)
		new_chunk.players += src
		new_chunk.visited_by_player = TRUE
		QUEUE_CHUNK_AI_UPDATE(new_chunk)
		QUEUE_CHUNK_BOTANY_UPDATE(new_chunk)




