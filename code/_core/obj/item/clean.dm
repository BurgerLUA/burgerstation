/obj/item/on_chunk_clean()
	if(src.last_interacted && !is_player(src.last_interacted))
		qdel(src)
		return TRUE
	return FALSE