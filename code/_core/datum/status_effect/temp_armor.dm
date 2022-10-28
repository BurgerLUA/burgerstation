/status_effect/temp_armor
	name = "Stoneskin"
	desc = "Your skin feels strong!"
	id = TEMP_ARMOR
	maximum = SECONDS_TO_DECISECONDS(150)
	minimum = SECONDS_TO_DECISECONDS(1)

	default_duration = SECONDS_TO_DECISECONDS(30)
	default_magnitude = 10

	affects_dead = FALSE

/status_effect/temp_armor/on_effect_added(mob/living/owner, atom/source, magnitude, duration, stealthy)
	for(var/armortype in ALL_DAMAGE)
		owner.defense_rating[armortype] += magnitude
	owner.visible_message(span("warn","\The [owner.name] looks tougher!"),span("warn","You feel resistant to damage!"))
	return TRUE
/status_effect/temp_armor/modify_magnitude(atom/attacker, mob/living/owner, magnitude)
	on_effect_removed(owner,magnitude,0)
	return magnitude
/status_effect/temp_armor/on_effect_removed(mob/living/owner, magnitude, duration)
	for(var/armortype in ALL_DAMAGE)
		owner.defense_rating[armortype] -= magnitude
	owner.visible_message(span("warn","\The [owner.name] Looks less tough!"),span("warn","You no longer feel resistant to damage!"))
	return TRUE
	
	
	