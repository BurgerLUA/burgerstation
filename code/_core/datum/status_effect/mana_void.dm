/status_effect/mana_void
	name = "Mana Void"
	desc = "You've been mana voided!"
	id = MANAVOID
	minimum = 0
	maximum = 0
	default_duration = 0

/status_effect/mana_void/on_effect_added(var/mob/living/owner,var/atom/source,var/magnitude,var/duration,var/stealthy)
	owner.mana_regen_buffer = -1000

/status_effect/stressed/on_effect_removed(var/mob/living/owner,var/magnitude,var/duration)
	owner.mana_regen_buffer = max(0,owner.mana_regen_buffer)
