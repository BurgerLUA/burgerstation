/mob/living/on_chunk_clean()
	if(src.dead && !src.ckey_owner)
		qdel(src)
		return TRUE
	if(src.ai && src.ai.delete_on_no_path && !length(src.ai.node_path_current) && !length(src.ai.node_path_current))
		qdel(src)
		return TRUE
	return FALSE