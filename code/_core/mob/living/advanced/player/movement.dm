/mob/living/advanced/player/post_move(var/atom/old_loc)

	. = ..()

	if(. && src.loc != old_loc && finalized)

		var/turf/old_turf = !old_loc || is_turf(old_loc) ? old_loc : get_turf(old_loc)
		var/turf/new_turf = !loc || is_turf(loc) ? loc : get_turf(loc)

		var/area/new_area = new_turf ? new_turf.loc : null
		var/area/old_area = old_turf ? old_turf.loc : null

		if(!dead && ckey_last && last_autosave + SECONDS_TO_DECISECONDS(600) <= world.time)
			if(istype(new_area,/area/burgerstation) && !istype(old_area,/area/burgerstation))
				last_autosave = world.time //Safety
				var/savedata/client/mob/mobdata = MOBDATA(ckey_last)
				mobdata?.save_character(src)

		if(dialogue_target_id)
			dialogue_target_id = null
			close_menu(src,/menu/dialogue/)

		if(active_structure && get_dist(src,active_structure) > 1)
			set_structure_unactive()

		if(active_device && get_dist(src,active_device) > 1)
			set_device_unactive()

		if( (new_area?.flags_area & FLAG_AREA_SINGLEPLAYER) != (old_area?.flags_area & FLAG_AREA_SINGLEPLAYER) )
			src.update_eyes()


/mob/living/advanced/player/on_chunk_cross(var/chunk/old_chunk,var/chunk/new_chunk)

	. = ..()

	if(old_chunk)
		old_chunk.players -= src

	if(new_chunk)
		new_chunk.players += src
		if(ai_steps >= VIEW_RANGE+ZOOM_RANGE)
			for(var/k in new_chunk.adjacent_chunks + new_chunk)
				var/chunk/C = k
				for(var/j in C.ai)
					var/ai/A = j
					if(!A.active) A.set_active(TRUE)
			ai_steps = 0
		else
			ai_steps++