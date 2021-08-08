/obj/effect/cleanable
	enable_chunk_clean = TRUE


/obj/effect/cleanable/on_chunk_clean()
	qdel(src)
	return TRUE