


/reagent_container/big_tank
	volume_max = 1000
	should_update_owner = FALSE


/reagent_container/big_tank/color/update_container(var/update_owner = TRUE)
	. = ..()
	owner.color = color