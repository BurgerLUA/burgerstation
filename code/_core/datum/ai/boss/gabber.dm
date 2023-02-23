/ai/boss/gabber
	var/next_trap = 0
	var/next_slam = 0
	var/next_shoot = 0
	var/next_curse = 0
	var/next_unblock = 0
	var/next_destroy_area = 0

	var/shoot_count = 0

	var/mob/living/simple/gabber/owner_as_gabber

	roaming_distance = 0

	var/next_objective_attack_health_update = 0
	var/last_objective_attack_health
	var/frustration_health = 0

/ai/boss/gabber/New(var/desired_loc,var/mob/living/desired_owner)
	owner_as_gabber = desired_owner
	return ..()

/ai/boss/gabber/Destroy()
	owner_as_gabber = null
	return ..()

/ai/boss/gabber/set_objective(var/atom/A)
	. = ..()
	if(.)
		next_trap = max(next_trap,world.time + SECONDS_TO_DECISECONDS(30))
		next_slam = max(next_slam,world.time + SECONDS_TO_DECISECONDS(10))
		next_shoot = max(next_shoot,world.time + SECONDS_TO_DECISECONDS(1))
		next_curse = max(next_curse,world.time + SECONDS_TO_DECISECONDS(60))
		if(objective_attack && objective_attack.health)
			last_objective_attack_health = objective_attack.health.health_current
		frustration_health = 0

/ai/boss/gabber/handle_movement()

	if(next_slam > 0 && next_slam <= world.time + SECONDS_TO_DECISECONDS(1)) //Doing slam.
		owner.move_dir = 0x0
		last_movement_proc = "slam override"
		return TRUE

	/*
	if(home_turf && get_dist(home_turf,owner) > VIEW_RANGE*2)
		owner.move_dir = get_dir(owner,home_turf)
		last_movement_proc = "returning to arena"
		return TRUE
	*/

	if(next_trap > world.time + SECONDS_TO_DECISECONDS(5) && next_slam > world.time + SECONDS_TO_DECISECONDS(5))
		if(get_dist(owner,objective_attack) <= 4)
			owner.move_dir = get_dir(owner,objective_attack)
			last_movement_proc = "projectiles distance"
			return TRUE

	. = ..()

/ai/boss/gabber/handle_attacking()

	//Slam attack. This should always take first priority as it affects movement above.
	if(objective_attack && next_slam > 0 && next_slam <= world.time + SECONDS_TO_DECISECONDS(1))

		if(owner_as_gabber.attack_flags & CONTROL_MOD_BLOCK)
			owner_as_gabber.attack_flags &= ~CONTROL_MOD_BLOCK
			owner_as_gabber.handle_blocking()

		if(next_slam > world.time)
			return TRUE

		var/turf/T = get_turf(objective_attack)

		if(T)
			var/checked_distance = get_dist(owner,T)

			if(checked_distance > 3)
				owner.dash_direction = get_dir(owner,T)
				owner.dash_amount = checked_distance - 1
				play_sound('sound/effects/dodge.ogg',get_turf(owner))
				next_slam = world.time + SECONDS_TO_DECISECONDS(1)
				return TRUE

			owner_as_gabber.slam(T)

			next_slam = world.time + (prob(25) ? SECONDS_TO_DECISECONDS(30) : SECONDS_TO_DECISECONDS(4))

			return TRUE

	//Parrying/Blocking.
	if(objective_attack && is_advanced(objective_attack))
		var/mob/living/advanced/A = objective_attack
		if(prob(80))
			if( (A.left_item && CALLBACK_EXISTS("hit_\ref[A.left_item]")) || (A.right_item && CALLBACK_EXISTS("hit_\ref[A.right_item]")))
				if(!(owner_as_gabber.attack_flags & CONTROL_MOD_BLOCK))
					owner_as_gabber.attack_flags |= CONTROL_MOD_BLOCK
					owner_as_gabber.do_voice(pick(gabber_voice_block))
					owner_as_gabber.set_dir(get_dir(owner_as_gabber,objective_attack))
					next_unblock = world.time + SECONDS_TO_DECISECONDS(3)
					owner_as_gabber.handle_blocking()
			else if(next_unblock <= world.time)
				owner_as_gabber.attack_flags &= ~CONTROL_MOD_BLOCK
				owner_as_gabber.handle_blocking()
			return TRUE

	else if(owner_as_gabber.attack_flags & CONTROL_MOD_BLOCK)
		owner_as_gabber.attack_flags &= ~CONTROL_MOD_BLOCK
		owner_as_gabber.handle_blocking()


	//Trap attack.
	if(objective_attack && next_trap > 0 && next_trap <= world.time + SECONDS_TO_DECISECONDS(1))

		if(next_trap > world.time)
			return TRUE

		owner_as_gabber.trap_spam(objective_attack)

		next_trap = world.time + rand(SECONDS_TO_DECISECONDS(30),SECONDS_TO_DECISECONDS(90))
		return TRUE

	//Curse attack.
	if(objective_attack && next_curse > 0 && next_curse <= world.time)
		owner_as_gabber.curse()
		next_curse = world.time + rand(SECONDS_TO_DECISECONDS(30),SECONDS_TO_DECISECONDS(90))
		return TRUE

	//Ranged attack.
	if(objective_attack && next_shoot > 0 && next_shoot <= world.time && get_dist(owner,objective_attack) >= 3)
		next_shoot = world.time + SECONDS_TO_DECISECONDS(0.5)
		shoot_count++
		var/projectiles_to_fire = shoot_count % 5 ? 1 : 5
		owner_as_gabber.shoot_bouncy_projectiles(objective_attack,projectiles_to_fire)
		return TRUE

	. = ..()


/ai/boss/gabber/on_life(var/tick_rate=1)

	. = ..()

	if(objective_attack && objective_attack.health && next_objective_attack_health_update <= world.time)

		next_objective_attack_health_update = world.time + SECONDS_TO_DECISECONDS(3)

		if(last_objective_attack_health && objective_attack.health.health_current >= last_objective_attack_health)
			frustration_health++
			if(frustration_health >= 4)
				owner_as_gabber.destroy_surrounding_obstacles()
				next_objective_attack_health_update = world.time + SECONDS_TO_DECISECONDS(30)
				frustration_health = 0
		else
			frustration_health = 0
		last_objective_attack_health = objective_attack.health.health_current
