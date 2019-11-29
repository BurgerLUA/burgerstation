/mob/living/advanced/player/Cross(atom/movable/O)

	if(is_player(O) && (area && (area.safe || area.singleplayer)))
		return TRUE

	return ..()
