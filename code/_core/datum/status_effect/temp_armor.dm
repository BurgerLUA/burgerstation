/status_effect/temp_armor
	name = "Stoneskin"
	desc = "Your skin feels strong!"
	id = TEMP_ARMOR
	maximum = SECONDS_TO_DECISECONDS(150)
	minimum = SECONDS_TO_DECISECONDS(1)

	default_duration = SECONDS_TO_DECISECONDS(30)
	default_magnitude = 10

	affects_dead = FALSE
	var/to_block = list(BRUTE,BURN,TOX)

/status_effect/temp_armor/on_effect_added(mob/living/owner, atom/source = null, magnitude, duration, stealthy = TRUE)
	if(!is_advanced(owner))
		return FALSE
	var/mob/living/advanced/L = owner
	for(var/i = 0, i < FLOOR(magnitude/2.5,1),i++)
		var/fakeboi = new /obj/item/clothing/special/imaginary()
		L.worn_objects += list(fakeboi)
	owner.visible_message(span("warning","\The [owner.name] looks tougher!"),span("warning","You feel more resistant to damage!"))
	return TRUE

/status_effect/temp_armor/on_effect_removed(mob/living/owner, magnitude, duration)
	var/mob/living/advanced/L = owner
	for(var/obj/item/clothing/reference in L.worn_objects)
		if(reference.should_go_poof)
			L.worn_objects -= reference
	L.visible_message(span("warning","\The [L.name] looks weaker!!"),span("warning","You feel less resistant to damage!"))
	return TRUE


/status_effect/temp_armor/can_add_status_effect(atom/attacker, mob/living/victim)
	. = ..()
	if(victim.status_effects[TEMP_ARMOR])
		return FALSE
	
	