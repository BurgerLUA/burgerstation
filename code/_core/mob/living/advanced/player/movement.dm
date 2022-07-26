/mob/living/advanced/player/post_move(var/atom/old_loc)

	. = ..()

	if(loc != old_loc)

		var/new_chunk_x
		var/new_chunk_y //Chunky monkey.
		var/new_chunk_z

		var/old_chunk_x
		var/old_chunk_y
		var/old_chunk_z

		if(old_loc && old_loc.z)
			old_chunk_x = CEILING(old_loc.x/CHUNK_SIZE,1)
			old_chunk_y = CEILING(old_loc.y/CHUNK_SIZE,1)
			old_chunk_z = old_loc.z

		if(loc && loc.z)
			new_chunk_x = CEILING(loc.x/CHUNK_SIZE,1)
			new_chunk_y = CEILING(loc.y/CHUNK_SIZE,1)
			new_chunk_z = loc.z

		if(new_chunk_x != old_chunk_x || new_chunk_y != old_chunk_y || new_chunk_z != old_chunk_z)
			if(old_chunk_z)
				var/chunk/C = SSchunk.chunks[old_chunk_z][old_chunk_x][old_chunk_y]
				C.players -= src
			if(new_chunk_z)
				var/chunk/C = SSchunk.chunks[new_chunk_z][new_chunk_x][new_chunk_y]
				C.players |= src

		var/area/A_old = get_area(old_loc)
		var/area/A_new = get_area(loc)
		if(!A_old || !A_new || ((A_old != A_new) && ( (A_old.flags_area & FLAG_AREA_SINGLEPLAYER) != (A_new.flags_area & FLAG_AREA_SINGLEPLAYER) )))
			src.update_eyes()