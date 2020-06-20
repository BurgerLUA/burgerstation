/health/blob/


/health/blob/update_health(var/damage_dealt,var/atom/attacker,var/update_hud=TRUE)

	. = ..()

	if(.)
		if(health_current <= 0)
			qdel(owner)
		else
			owner.update_sprite()

	return .