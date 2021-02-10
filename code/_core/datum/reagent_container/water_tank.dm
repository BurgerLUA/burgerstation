/reagent_container/water_tank
	volume_max = 1000
	should_update_owner = FALSE

/reagent_container/water_tank/update_container(var/update_owner = TRUE)
	. = ..()
	owner.color = color
	return .