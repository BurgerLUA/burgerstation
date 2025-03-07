/reagent_container/temp

	volume_max = 1000

	should_update_owner = FALSE

	flags_temperature = REAGENT_TEMPERATURE_NO_AMBIENT


/reagent_container/temp/update_container(var/mob/activator,var/update_owner = TRUE,var/force=FALSE)

	. = ..()

	if(volume_current <= 0)
		qdel(src)
		return FALSE


/reagent_container/temp/smoke
	var/obj/effect/temp/smoke/linked_smoke = list()