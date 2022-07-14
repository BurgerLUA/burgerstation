/mob/living/on_chunk_clean()
	if(src.dead && !src.ckey_owner)
		qdel(src)
		return TRUE
	if(src.ai && src.ai.delete_on_no_path && !length(src.ai.current_node_path) && !length(src.ai.current_node_path))
		qdel(src)
		return TRUE
	return FALSE