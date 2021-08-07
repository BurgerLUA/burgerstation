/obj/item/on_chunk_clean()
	if(src.last_interacted && !istype(src.last_interacted,/mob/living/advanced/player/))
		qdel(src)
		return TRUE
	return FALSE