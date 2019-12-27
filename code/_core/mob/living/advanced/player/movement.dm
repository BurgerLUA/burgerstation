/mob/living/advanced/player/Cross(atom/movable/O,var/atom/NewLoc,var/atom/OldLoc)

	if(is_player(O))
		if(!PLAYER_COLLISIONS)
			return TRUE

		if(area && (area.safe || area.singleplayer))
			return TRUE

	return ..()
