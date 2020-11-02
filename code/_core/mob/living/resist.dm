/mob/living/proc/can_resist(var/messages = TRUE)

	if(next_resist > world.time)
		//if(messages) to_chat(span("warning","You don't have enough strength to resist now!"))
		return FALSE

	if(dead)
		if(messages) to_chat(span("warning","You can't resist while dead!"))
		return FALSE

	if(health.stamina_current < 20)
		if(messages) to_chat(span("warning","You're too exhausted to resist!"))
		return FALSE

	if(has_status_effects(PARALYZE,SLEEP,STAGGER,FATIGUE,STUN))
		if(messages) to_chat(span("warning","You can't resist in this state!"))
		return FALSE

	return TRUE

/mob/living/proc/resist() //Return TRUE means you can resist. //Return FALSE means you can't resist

	if(!src.can_resist())
		return FALSE

	if(grabbing_hand)
		var/mob/living/advanced/attacker = grabbing_hand.owner
		if(attacker)
			var/attacker_power = attacker.get_attribute_power(ATTRIBUTE_STRENGTH)*10
			var/src_power = src.get_attribute_power(ATTRIBUTE_STRENGTH)*5
			var/difficulty = (attacker_power - src_power) * (get_dir(attacker,src) == src.dir) ? 5 : 1
			if(resist_counter >= difficulty)
				src.visible_message(
					span("danger","\The [src.name] resists out of the grip of \the [attacker.name]!"),
					span("danger","You resist out of the grip of \the [attacker.name]!")
				)
				grabbing_hand.release_object()
				attacker.add_status_effect(STAGGER,10,source = src)
				resist_counter = 0
				return TRUE
			else
				src.visible_message(
					span("warning","\The [src.name] tries to resist out of \the [attacker.name]'s grip!"),
					span("warning","You try to resist!"),
				)
		resist_counter += 1
		health.adjust_stamina(-20)
		next_resist = world.time + 10
		return FALSE

	else if(on_fire)
		var/stacks_to_remove = 0
		if(horizontal)
			stacks_to_remove = min(fire_stacks,100)
			src.visible_message(
				span("warning","\The [src.name] rolls on the ground!"),
				span("danger","You quickly roll on the ground!"),
			)
		else
			stacks_to_remove = min(fire_stacks,25)
			src.visible_message(
				span("warning","\The [src.name] quickly pats out the flames!"),
				span("danger","You quickly pat out the flames!"),
			)
		adjust_fire_stacks(-stacks_to_remove)
		health.adjust_stamina(-5)
		next_resist = world.time + 15
		return FALSE

	else if(has_status_effect(REST))
		rest()
		return FALSE

	return TRUE

/mob/living/proc/rest()
	if(dead)
		to_chat(span("warning","You're already resting... in peace."))
		return FALSE
	if(has_status_effect(REST) && get_status_effect_duration(REST) == -1)
		PROGRESS_BAR(src,src,3,.proc/remove_status_effect,REST)
	else
		add_status_effect(REST,-1,-2, force = TRUE)
	return TRUE

/mob/living/advanced/resist()

	. = ..()

	if(. && handcuffed && !horizontal && !grabbing_hand)

		var/counter_to_add = src.get_attribute_power(ATTRIBUTE_STRENGTH)*10*(client ? 3 : 1)

		if(stored_handcuffs && stored_handcuffs.strength)
			counter_to_add *= (1/stored_handcuffs.strength)

		if(intent == INTENT_HARM)
			counter_to_add *= 3
			src.visible_message(
				span("danger","\The [src.name] tries to resist out of the handcuffs!"),
				span("danger","You try to resist out of the handcuffs!")
			)
		else
			to_chat(span("warning","You attempt to stealthfully resist out of the handcuffs..."))

		handcuff_break_counter += counter_to_add
		health.adjust_stamina(-20)

		switch(handcuff_break_counter)
			if(0 to 25)
				src.to_chat(span("warning","...the handcuffs are pretty strong."))
			if(25 to 50)
				src.to_chat(span("warning","...the handcuffs are getting a little loose."))
			if(50 to 75)
				src.to_chat(span("warning","...the handcuffs start to feel weak!"))
			if(75 to 99)
				src.to_chat(span("warning","...the handcuffs feel fragile, and could break at any moment!"))
			else
				src.set_handcuffs(FALSE)
				src.visible_message(
					span("danger","\The [src.name] breaks out of the handcuffs!"),
					span("danger","You break out of the handcuffs!")
				)


	return .