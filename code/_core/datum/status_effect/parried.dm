/status_effect/parried
	name = "Parried"
	desc = "You're parried!"
	id = PARRIED
	minimum = SECONDS_TO_DECISECONDS(1)
	maximum = SECONDS_TO_DECISECONDS(4)
	default_duration = SECONDS_TO_DECISECONDS(1)

	affects_dead = FALSE


/status_effect/parried/can_add_status_effect(var/atom/attacker,var/mob/living/victim)

	if(!attacker || victim.horizontal || victim.anchored)
		return FALSE

	. = ..()

/status_effect/parried/on_effect_added(var/mob/living/owner,var/atom/source,var/magnitude,var/duration,var/stealthy)

	. = ..()


	var/desired_move_dir = get_dir(source,owner)
	var/old_dir = owner.dir
	var/result = owner.Move(get_step(owner,desired_move_dir))
	owner.dir = old_dir
	owner.next_move = max(owner.next_move,DECISECONDS_TO_TICKS(duration))
	if(!result) //We can't move.
		var/list/movement = direction_to_pixel_offset(desired_move_dir)
		animate(owner,pixel_x = movement[1] * TILE_SIZE, pixel_y = movement[2] * TILE_SIZE,time = 1)
		var/stun_time = max(duration,10)
		owner.add_status_effect(STUN,stun_time,stun_time)
		spawn(1)
			animate(owner,pixel_x = 0, pixel_y = 0,time = max(0,stun_time - 1))

