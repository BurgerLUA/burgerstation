/status_effect/cursed
	name = "Cursed"
	desc = "You've been cursed!"
	id = CURSED

	minimum = 10 SECONDS
	maximum = 300 SECONDS
	default_duration = 60 SECONDS

/status_effect/cursed/can_add_status_effect(var/atom/attacker,var/mob/living/victim)

	. = ..()

	if(!.)
		return FALSE

	if(!victim || !victim.health)
		return FALSE

	var/list/defense = victim.health.get_defense(null,null,TRUE)

	if(defense[HOLY] < defense[DARK])
		return FALSE

	return TRUE

/status_effect/cursed/on_effect_life(var/mob/living/owner,var/magnitude,var/duration)
	. = ..()
	owner.brute_regen_buffer -= 5 * TICKS_TO_SECONDS(LIFE_TICK)


