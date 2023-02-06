/health/plant
	organic = TRUE


/health/plant/update_health(var/atom/attacker,var/damage_dealt=0,var/update_hud=TRUE,var/check_death=TRUE)
	. = ..()
	if(. && health_current <= 0)
		var/obj/structure/interactive/plant/P = owner
		P.on_destruction(attacker,TRUE)