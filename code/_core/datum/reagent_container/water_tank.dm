


/reagent_container/big_tank
	volume_max = 1000
	should_update_owner = FALSE


/reagent_container/big_tank/color/update_container(var/mob/caller,var/update_owner = TRUE)
	. = ..()
	if(update_owner)
		owner.color = color