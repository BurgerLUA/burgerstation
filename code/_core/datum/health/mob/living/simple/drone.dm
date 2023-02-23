/health/mob/living/simple/drone/
	organic = FALSE

/health/mob/living/simple/drone/update_health(var/atom/attacker,var/damage_dealt=0,var/update_hud=TRUE,var/check_death=TRUE)
	. = ..()
	var/mob/living/L = owner

	if(L.dead)
		L.icon_state = "drone_dead"
		return .

	var/health_mod = (health_current/health_max)*3
	health_mod = FLOOR(health_mod,1)
	L.icon_state = "drone[health_mod]"
