/status_effect/
	var/name //Name of the Status Effect
	var/desc //Description of the status effect.
	var/id //Status effect description

/status_effect/proc/on_effect_added(var/mob/living/owner,var/duration)
	return TRUE

/status_effect/proc/on_effect_removed(var/mob/living/owner,var/duration)
	return TRUE

/status_effect/stun
	name = "Stunned"
	desc = "You're stunned!"
	id = FLAG_STATUS_STUN

/status_effect/sleeping
	name = "Sleeping"
	desc = "You're sleeping!"
	id = FLAG_STATUS_SLEEP

/status_effect/paralyzed
	name = "Paralyzed"
	desc = "You're paralyzed!"
	id = FLAG_STATUS_PARALYZE

/status_effect/fatigued
	name = "Fatigued"
	desc = "You're fatigued!"
	id = FLAG_STATUS_FATIGUE

/status_effect/staggered
	name = "Staggered"
	desc = "You're staggered!"
	id = FLAG_STATUS_STAGGER

/status_effect/confused
	name = "Confused"
	desc = "You're confused!"
	id = FLAG_STATUS_CONFUSED

/status_effect/critical
	name = "Critical"
	desc = "You're in critical condition!"
	id = FLAG_STATUS_CRIT

/status_effect/energized
	name = "Energized"
	desc = "You're filled with adrenaline!"
	id = FLAG_STATUS_ADRENALINE

/status_effect/resting
	name = "Resting"
	desc = "You're resting!"
	id = FLAG_STATUS_REST




