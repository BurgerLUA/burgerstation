


/reagent_container/big_tank
	volume_max = 1000
	should_update_owner = FALSE

	flags_temperature = REAGENT_TEMPERATURE_NO_AMBIENT


/reagent_container/big_tank/color/update_container(var/mob/activator,var/update_owner = TRUE,var/force=FALSE)
	. = ..()
	if(update_owner)
		owner.color = color