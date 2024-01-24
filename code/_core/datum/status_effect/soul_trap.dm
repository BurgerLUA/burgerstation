/status_effect/soul_trap
	name = "Soul Trap"
	desc = "You've been soul trapped!"
	id = SOULTRAP
	minimum = 4 SECONDS
	maximum = 60 SECONDS
	default_duration = 30 SECONDS

	affects_dead = FALSE

/status_effect/soul_trap/can_add_status_effect(var/atom/attacker,var/mob/living/victim)

	if(victim.is_player_controlled())
		return FALSE

	. = ..()
