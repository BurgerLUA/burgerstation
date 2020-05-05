/mob/post_move(var/atom/old_loc)

	. = ..()

	if(client)
		client.post_move(loc,old_loc)

	return .




