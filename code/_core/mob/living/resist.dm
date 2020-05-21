/mob/living/proc/can_resist(var/messages = TRUE)

	if(next_resist > world.time)
		if(messages) to_chat(span("warning","You don't have enough strength to resist now!"))
		return FALSE

	if(health.stamina_current < 5)
		if(messages) to_chat(span("warning","You're too exhausted to resist!"))
		return FALSE

	return TRUE

/mob/living/proc/resist()

	if(!grabbing_hand)
		return FALSE

	var/mob/living/advanced/attacker = grabbing_hand.owner

	if(!attacker)
		return FALSE

	var/difficulty = attacker.get_attribute_power(ATTRIBUTE_STRENGTH)*10 - get_attribute_power(ATTRIBUTE_STRENGTH)*5

	if(resist_counter >= difficulty)
		src.visible_message(
			span("danger","\The [src.name] resists out of the grip of \the [attacker.name]!"),
			span("danger","You resist out of the grip of \the [attacker.name]!")
		)
		grabbing_hand.release_object()
		attacker.add_status_effect(STAGGER,10,source = attacker)
		return TRUE

	src.visible_message(
		span("warning","\The [src.name] tries to resist out of \the [attacker.name]'s grip!"),
		span("warning","You try to resist!"),

	)
	resist_counter += 1
	health.adjust_stamina(-5)

	next_resist = world.time + 10

	return FALSE