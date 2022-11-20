/status_effect/soul_trap
	name = "Soul Trap"
	desc = "You've been soul trapped!"
	id = SOULTRAP
	minimum = SECONDS_TO_DECISECONDS(4)
	maximum = SECONDS_TO_DECISECONDS(60)
	default_duration = SECONDS_TO_DECISECONDS(30)

	affects_dead = FALSE

/status_effect/soul_trap/can_add_status_effect(var/atom/attacker,var/mob/living/victim)

	if(victim.is_player_controlled())
		return FALSE

	. = ..()