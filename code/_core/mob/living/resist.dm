/mob/living/proc/can_resist(var/messages = TRUE)

	if(dead)
		if(messages) to_chat(span("warning","You can't resist while dead!"))
		return FALSE

	if(health?.stamina_current < 20)
		if(messages) to_chat(span("warning","You're too exhausted to resist!"))
		return FALSE

	if(has_status_effects(STAMCRIT,PARALYZE,SLEEP,PARRIED,FATIGUE,STUN))
		if(messages) to_chat(span("warning","You can't resist in this state!"))
		return FALSE

	return TRUE

/mob/living/proc/resist() //Return TRUE means you can resist. //Return FALSE means you can't resist

	if(next_resist > world.time)
		return FALSE

	if(!src.can_resist())
		next_resist = max(next_resist,world.time + 5) //Prevents spam.
		return FALSE

	if(grabbing_hand && grabbing_hand.owner)
		var/mob/living/advanced/attacker = grabbing_hand.owner

		var/src_power = src.get_attribute_power(ATTRIBUTE_STRENGTH,0.25,1,2)*5
		var/attacker_power = !attacker.dead ? attacker.get_attribute_power(ATTRIBUTE_STRENGTH,0,1)*10*grabbing_hand.grab_level : 0

		if(!allow_hostile_action(src.loyalty_tag,attacker))
			attacker_power = 0
		else if(attacker.horizontal && !src.horizontal)
			attacker_power *= 0.5
		else if(!attacker.horizontal && src.horizontal)
			src_power *= 0.5

		if(is_organ(grabbing_hand.loc))
			var/obj/item/organ/O = grabbing_hand.loc
			if(O.health && O.health.health_max > 0)
				attacker_power *= max(0,O.health.health_current/O.health.health_max)
				if(O.broken) attacker_power *= 0.25

		grab_difficulty = max((attacker_power - src_power)*2,1)

		if(grab_resist_counter >= grab_difficulty)
			src.visible_message(
				span("danger","\The [src.name] resists out of the grip of \the [attacker.name]!"),
				span("warning","You resist out of the grip of \the [attacker.name]!")
			)
			if(grabbing_hand)
				grabbing_hand.release_object()
				if(grabbing_hand.grab_level <= 1)
					attacker.add_status_effect(STAGGER,20,20,source=src)
				else
					attacker.add_status_effect(STUN,30,30,source=src)
			else
				attacker.add_status_effect(STUN,30,30,source=src)
			if(attacker.health)
				attacker.health.adjust_stamina(-src_power*4)
		else
			src.visible_message(
				span("danger","\The [src.name] tries to resist out of \the [attacker.name]'s grip!"),
				span("warning","You try to resist!"),
			)
			if(attacker.health)
				attacker.health.adjust_stamina(-src_power) //Attacker needs the strength to resist too.
			grab_resist_counter += 1
			health.adjust_stamina(-attacker_power)
			next_resist = max(next_resist,world.time + 5)

		stat_elements_to_update |= stat_elements["resist"]

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
		if(fire_stacks > 0)
			next_resist = max(next_resist,world.time + 15)

		stat_elements_to_update |= stat_elements["resist"]

		return FALSE

	else if(has_status_effect(REST))
		rest()
		return FALSE

	return TRUE

/mob/living/proc/get_resist_percent()
	if(grabbing_hand && grabbing_hand.owner)
		if(grab_difficulty <= 0)
			return -1
		return clamp(grab_resist_counter/grab_difficulty,0,1)
	if(on_fire)
		return clamp(1 - fire_stacks/fire_stacks_max,0,1)
	return -1

/mob/living/proc/rest()
	if(dead)
		to_chat(span("warning","You're already resting... in peace."))
		return FALSE
	if(STATUS_EFFECT_DURATION(src,REST) == -1)
		PROGRESS_BAR(src,src,3,src::remove_status_effect(),REST)
	else
		add_status_effect(REST,-1,-2, force = TRUE)
	return TRUE

/mob/living/advanced/resist()

	. = ..()

	if(. && handcuffed && !grabbing_hand)

		var/counter_to_add = src.get_attribute_power(ATTRIBUTE_STRENGTH,0.5,1,2)*10*(client ? 3 : 1)

		if(stored_handcuffs && stored_handcuffs.strength)
			counter_to_add *= (1/stored_handcuffs.strength)

		if(intent == INTENT_HARM)
			counter_to_add *= 3
			src.visible_message(
				span("danger","\The [src.name] tries to resist out of the handcuffs!"),
				span("danger","You visibly try to resist out of the handcuffs!")
			)
		else
			to_chat(span("warning","You attempt to stealthily resist out of the handcuffs..."))

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


