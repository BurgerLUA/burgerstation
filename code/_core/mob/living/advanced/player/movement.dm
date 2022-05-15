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
			old_chunk_x = CEILING(world.maxx/CHUNK_SIZE,1)
			old_chunk_y = CEILING(world.maxy/CHUNK_SIZE,1)
			old_chunk_z = world.maxz

		if(loc && loc.z)
			new_chunk_x = CEILING(world.maxx/CHUNK_SIZE,1)
			new_chunk_y = CEILING(world.maxy/CHUNK_SIZE,1)
			new_chunk_z = world.maxz

		if(new_chunk_x != old_chunk_x || new_chunk_y != old_chunk_y || new_chunk_z != old_chunk_z)
			if(old_chunk_z)
				var/chunk/C = SSchunk.active_chunks[old_chunk_z][old_chunk_x][old_chunk_y]
				C.players -= src
			if(new_chunk_z)
				var/chunk/C = SSchunk.active_chunks[new_chunk_z][new_chunk_x][new_chunk_y]
				C.players |= src