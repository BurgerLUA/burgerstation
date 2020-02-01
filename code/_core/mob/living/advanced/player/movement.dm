/mob/living/advanced/player/Cross(atom/movable/O,var/atom/NewLoc,var/atom/OldLoc)

	if(is_player(O))
		if(!PLAYER_COLLISIONS)
			return TRUE

		if(area && area.flags_area & FLAGS_AREA_NO_DAMAGE)
			return TRUE

	return ..()
