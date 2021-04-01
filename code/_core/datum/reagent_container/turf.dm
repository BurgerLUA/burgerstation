/reagent_container/turf

	volume_max = 1000
	should_update_owner = TRUE

	allow_recipe_processing = FALSE

	var/desired_reagent

/reagent_container/turf/update_container()

	. = ..()

	if(. && desired_reagent && (get_reagent_volume(desired_reagent) < 500 || length(stored_reagents) > 1) )
		stored_reagents.Cut()
		stored_reagents_temperature.Cut()
		add_reagent(desired_reagent,500)

