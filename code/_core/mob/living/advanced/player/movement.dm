/mob/living/advanced/player/post_move(var/atom/old_loc)

	. = ..()

	if(. && loc != old_loc && finalized)

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

		var/new_chunk_x
		var/new_chunk_y //Chunky monkey.
		var/new_chunk_z

		var/old_chunk_x
		var/old_chunk_y
		var/old_chunk_z

		if(old_turf && old_turf.z)
			old_chunk_x = CEILING(old_turf.x/CHUNK_SIZE,1)
			old_chunk_y = CEILING(old_turf.y/CHUNK_SIZE,1)
			old_chunk_z = old_turf.z

		if(new_turf && new_turf.z)
			new_chunk_x = CEILING(new_turf.x/CHUNK_SIZE,1)
			new_chunk_y = CEILING(new_turf.y/CHUNK_SIZE,1)
			new_chunk_z = new_turf.z

		if(new_chunk_x != old_chunk_x || new_chunk_y != old_chunk_y || new_chunk_z != old_chunk_z)
			if(old_chunk_z)
				var/chunk/C = SSchunk.chunks[old_chunk_z][old_chunk_x][old_chunk_y]
				C.players -= src
			if(new_chunk_z)
				var/chunk/C = SSchunk.chunks[new_chunk_z][new_chunk_x][new_chunk_y]
				C.players += src
				if(ai_steps >= VIEW_RANGE+ZOOM_RANGE || !old_turf || old_turf.z != new_turf.z)
					var/list/chunks_to_check = C.adjacent_chunks + C
					for(var/k in chunks_to_check)
						var/chunk/C = k
						for(var/j in C.ai)
							var/ai/A = j
							if(!A.active) A.set_active(TRUE)
					ai_steps = 0

		ai_steps++

		if( (new_area?.flags_area & FLAG_AREA_SINGLEPLAYER) != (old_area?.flags_area & FLAG_AREA_SINGLEPLAYER) )
			src.update_eyes()