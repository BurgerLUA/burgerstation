/obj/effect/cleanable


/obj/effect/cleanable/on_chunk_clean()
	. = ..()
	qdel(src)
	return TRUE