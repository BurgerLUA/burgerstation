/mob/living/
	var/list/experience/attribute/attributes
	var/list/experience/skill/skills
	var/list/faction/factions
	var/list/starting_factions = list()

	var/list/health_elements

	var/ai/ai

	mouse_over_pointer = MOUSE_ACTIVE_POINTER

	var/status = 0 //Negative status

	var/stun_time = 0 //Deciseconds of stun
	var/sleep_time = 0 //Decieconds of sleep
	var/paralyze_time = 0 //Decieconds of paralyze

/mob/living/get_xp_multiplier()
	return 1

/mob/living/can_move(var/turf/new_loc,var/movement_override = 0)

	if(status & FLAG_STATUS_DEAD)
		return FALSE

	return ..()

/mob/living/proc/is_sideways()
	return status > 0

/mob/living/proc/death()

	if(status & FLAG_STATUS_DEAD)
		return

	if(client)
		client.make_ghost(get_turf(src))
	status |= FLAG_STATUS_DEAD
	if(ai)
		ai = null
	movement_flags = 0
	attack_flags = 0
	add_stun(10)
	src.visible_message("\The [src.name] seizes up and falls limp, their eyes dead and lifeless...")

/mob/living/on_life_AI()
	if(status & FLAG_STATUS_DEAD)
		return FALSE

	return ..()

/mob/living/on_life()

	..()

	if(status & FLAG_STATUS_STUN && stun_time <= 0)
		status &= ~FLAG_STATUS_STUN
		animate(src,transform = matrix(), time = 1)

	if(!(status & FLAG_STATUS_STUN) && stun_time > 0)
		status |= FLAG_STATUS_STUN
		animate(src,transform = turn(matrix().Translate(10,0), 90), time = 1)

		if(left_hand)
			left_hand.drop_held_objects(src.loc)

		if(right_hand)
			right_hand.drop_held_objects(src.loc)

	if(status & FLAG_STATUS_DEAD)
		return FALSE

	stun_time = max(0,stun_time - 1)

	if(move_delay <= 0)
		stamina_current = min(stamina_current + stamina_regeneration,stamina_max)
		mana_current = min(mana_current + mana_regeneration,mana_max)

	return TRUE

/mob/living/proc/add_stun(var/value,var/max_value = 40)

	value = max(value,10)

	if(stun_time > max_value)
		return FALSE

	stun_time = min(max_value,stun_time + value)

	return TRUE

/mob/living/New()
	. = ..()
	attributes = list()
	skills = list()
	factions = list()
	health_elements = list()

	initialize_attributes()
	initialize_skills()

	if(ai)
		ai = new(src)

/mob/living/Initialize()
	for(var/k in starting_factions)
		factions[k] = all_factions[k]
	..()

/mob/living/do_bump(var/atom/bumper, var/bump_direction = 0, var/movement_override = 0)
	if(move_delay > 0)
		return FALSE
	return do_move(get_step(src,bump_direction),movement_override)

/mob/living/can_not_enter(var/atom/A,var/move_direction)

	if(is_living(A))
		var/mob/living/L = A
		if(L.status & FLAG_STATUS_STUN)
			return FALSE

	if(status & FLAG_STATUS_STUN)
		return FALSE

	return src
