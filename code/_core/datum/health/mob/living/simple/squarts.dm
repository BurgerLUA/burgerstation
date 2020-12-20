/health/mob/living/simple/squats/update_health(var/atom/attacker,var/damage_dealt=0,var/update_hud=TRUE,var/check_death=TRUE)
	. = ..()
	owner.update_sprite()
	return .