/status_effect/critical
	name = "Critical"
	desc = "You're in critical condition!"
	id = CRIT

	default_magnitude = 100
	default_duration = -1

	affects_dead = FALSE

/status_effect/critical/on_effect_added(var/mob/living/owner,var/atom/source,var/magnitude,var/duration,var/stealthy)
	owner.remove_status_effect(ADRENALINE)
	if(is_advanced(owner) && !owner.horizontal)
		owner.add_status_effect(DISARM,5,5,source = source,stealthy = TRUE)
	return ..()

/status_effect/paincrit
	name = "Paincrit"
	desc = "You're in pain!"
	id = PAINCRIT

	default_magnitude = 100
	default_duration = -1

	affects_dead = FALSE

/status_effect/paincrit/on_effect_added(var/mob/living/owner,var/atom/source,var/magnitude,var/duration,var/stealthy)
	if(is_advanced(owner) && !owner.horizontal)
		owner.add_status_effect(DISARM,5,5,source = source,stealthy = TRUE)
	return ..()

/status_effect/stamcrit
	name = "Stamcrit"
	desc = "You're too tired!"
	id = STAMCRIT

	default_magnitude = 100
	default_duration = -1

	affects_dead = FALSE

/status_effect/stamcrit/on_effect_added(var/mob/living/owner,var/atom/source,var/magnitude,var/duration,var/stealthy)
	if(is_advanced(owner) && !owner.horizontal)
		owner.add_status_effect(DISARM,5,5,source = source,stealthy = TRUE)
	owner.remove_status_effect(ADRENALINE)
	owner.stamina_regen_delay = max(owner.stamina_regen_delay,owner.is_player_controlled() ? 4 SECONDS : 10 SECONDS)
	return ..()
