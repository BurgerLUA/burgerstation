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
	add_stun(2)
	src.visible_message("\The [src.name] seizes up and falls limp, their eyes dead and lifeless...")

	queue_delete(src,600)

/mob/living/proc/on_life_AI()
	if(status & FLAG_STATUS_DEAD)
		return FALSE

	return ..()

/mob/proc/on_stunned()
	return TRUE

/mob/living/proc/on_life()

	if(status & FLAG_STATUS_STUN && stun_time <= 0)
		status &= ~FLAG_STATUS_STUN
		animate(src,transform = matrix(), time = 1)

	if(!(status & FLAG_STATUS_STUN) && stun_time > 0)
		status |= FLAG_STATUS_STUN
		animate(src,transform = turn(matrix(), 90), time = 1)
		on_stunned()

	if(status & FLAG_STATUS_DEAD)
		return FALSE

	stun_time = max(0,stun_time - 1)

	return TRUE