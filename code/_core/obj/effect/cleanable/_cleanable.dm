/obj/effect/cleanable
	enable_chunk_clean = TRUE
	enable_chunk_handling = TRUE


/obj/effect/cleanable/on_chunk_clean()
	qdel(src)
	return TRUE