/health/blob/
	armor = /armor/blob

/health/blob/update_health(var/atom/attacker,var/damage_dealt=0,var/update_hud=TRUE,var/check_death=TRUE)
	. = ..()
	if(. && health_current <= 0)
		var/atom/C = owner
		C.on_destruction(attacker,TRUE)