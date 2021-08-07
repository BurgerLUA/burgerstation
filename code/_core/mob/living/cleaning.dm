/mob/living/on_chunk_clean()
	if(src.dead && !src.ckey_owner)
		qdel(src)
		return TRUE
	return FALSE