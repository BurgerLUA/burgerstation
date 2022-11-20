/status_effect/critical
	name = "Critical"
	desc = "You're in critical condition!"
	id = CRIT

	default_magnitude = 100
	default_duration = -1

	affects_dead = FALSE

/status_effect/critical/on_effect_added(var/mob/living/owner,var/atom/source,var/magnitude,var/duration,var/stealthy)
	owner.remove_status_effect(ADRENALINE)
	return ..()
/status_effect/paincrit
	name = "Paincrit"
	desc = "You're in pain!"
	id = PAINCRIT

	default_magnitude = 100
	default_duration = -1

	affects_dead = FALSE

/status_effect/paincrit/on_effect_added(var/mob/living/owner,var/atom/source,var/magnitude,var/duration,var/stealthy)
	owner.remove_status_effect(PAINKILLER)
	return ..()

/status_effect/stamcrit
	name = "Stamcrit"
	desc = "You're too tired!"
	id = STAMCRIT

	default_magnitude = 100
	default_duration = -1

	affects_dead = FALSE

/status_effect/stamcrit/on_effect_added(var/mob/living/owner,var/atom/source,var/magnitude,var/duration,var/stealthy)
	owner.remove_status_effect(ADRENALINE)
	owner.stamina_regen_delay = max(owner.stamina_regen_delay,owner.is_player_controlled() ? SECONDS_TO_DECISECONDS(4) : SECONDS_TO_DECISECONDS(10))
	return ..()
