/mob/living/advanced/player/Cross(atom/movable/O)

	if(is_player(O))
		if(!PLAYER_COLLISIONS)
			return TRUE

		if(area && (area.safe || area.singleplayer))
			return TRUE

	return ..()
