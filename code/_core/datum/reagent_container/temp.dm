/reagent_container/temp

	volume_max = 1000

	should_update_owner = FALSE


/reagent_container/temp/update_container()

	. = ..()

	if(volume_current <= 0)
		qdel(src)
		return FALSE

	return .