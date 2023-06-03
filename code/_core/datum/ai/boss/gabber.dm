
/ai/boss/gabber
	var/next_trap = 0
	var/next_slam = 0
	var/next_shoot = 0
	var/next_unblock = 0
	var/next_destroy_area = 0

	var/shoot_count = 0
	var/super_slams_left = 2

	var/super_traps_left = 2

	var/mob/living/simple/gabber/owner_as_gabber

	roaming_distance = 0

	var/next_objective_attack_health_update = 0
	var/last_objective_attack_health
	var/frustration_health = 0

	var/next_self_health_update = 0
	var/last_self_health

	ignore_hazard_turfs = FALSE

/ai/boss/gabber/New(var/desired_loc,var/mob/living/desired_owner)
	owner_as_gabber = desired_owner
	return ..()

/ai/boss/gabber/Destroy()
	owner_as_gabber = null
	return ..()

/ai/boss/gabber/set_objective(var/atom/A)
	var/had_previous_objective = objective_attack
	. = ..()
	if(. && objective_attack && !had_previous_objective)
		next_trap = max(next_trap,world.time + SECONDS_TO_DECISECONDS(30))
		next_slam = max(next_slam,world.time + SECONDS_TO_DECISECONDS(10))
		next_shoot = max(next_shoot,world.time + SECONDS_TO_DECISECONDS(1))
		if(objective_attack && objective_attack.health)
			last_objective_attack_health = objective_attack.health.health_current
		frustration_health = 0

/ai/boss/gabber/handle_movement()

	if(objective_attack && is_living(objective_attack))
		var/mob/living/L = objective_attack
		if(L.horizontal)
			owner.move_dir = get_dir(owner,objective_attack)
			owner.movement_flags = MOVEMENT_RUNNING
			last_movement_proc = "horizontal grief"
			return TRUE

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

	if(!owner_as_gabber.sword_mode && next_trap > world.time + SECONDS_TO_DECISECONDS(5) && next_slam > world.time + SECONDS_TO_DECISECONDS(5))
		if(get_dist(owner,objective_attack) <= 4)
			owner.move_dir = get_dir(owner,objective_attack)
			last_movement_proc = "projectiles distance"
			return TRUE

	. = ..()

/ai/boss/gabber/proc/start_block(var/duration = SECONDS_TO_DECISECONDS(3))
	owner_as_gabber.attack_flags |= CONTROL_MOD_BLOCK
	next_unblock = world.time + duration
	owner_as_gabber.handle_blocking()

/ai/boss/gabber/proc/stop_block()
	owner_as_gabber.attack_flags &= ~CONTROL_MOD_BLOCK
	owner_as_gabber.handle_blocking()

/ai/boss/gabber/handle_attacking()

	if(owner_as_gabber.attack_flags & CONTROL_MOD_BLOCK)
		if(!objective_attack || next_unblock <= world.time)
			stop_block()
			return TRUE
		owner_as_gabber.set_dir(get_dir(owner_as_gabber,objective_attack))
		return TRUE

	if(owner_as_gabber.next_special_attack > world.time)
		return ..()

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

			if(checked_distance > (owner_as_gabber.sword_mode ? 5 : 3))
				owner.dash_direction = get_dir(owner,T)
				owner.dash_amount = checked_distance - 1
				play_sound('sound/effects/dodge.ogg',get_turf(owner))
				next_slam = world.time + SECONDS_TO_DECISECONDS(1)
				return TRUE

			if(owner_as_gabber.sword_mode)
				var/do_super_slam = super_slams_left <= 0
				if(do_super_slam)
					owner_as_gabber.super_slam_jam(T)
					next_slam = world.time + SECONDS_TO_DECISECONDS(15)
					super_slams_left = initial(super_slams_left)
				else
					owner_as_gabber.slam(T)
					next_slam = world.time + 18
					super_slams_left--
			else
				owner_as_gabber.slam(T)
				next_slam = world.time + (prob(25) ? SECONDS_TO_DECISECONDS(20) : SECONDS_TO_DECISECONDS(5))

			return TRUE

	//Parrying/Blocking. Sword mode only.
	if(owner_as_gabber.sword_mode && objective_attack && is_advanced(objective_attack) && !(owner_as_gabber.attack_flags & CONTROL_MOD_BLOCK))
		var/mob/living/advanced/A = objective_attack
		var/obj/item/right_item = A.inventories_by_id[BODY_HAND_RIGHT_HELD]?.get_top_object()
		var/obj/item/left_item = A.inventories_by_id[BODY_HAND_LEFT_HELD]?.get_top_object()
		if(prob(80) && (left_item && CALLBACK_EXISTS("hit_\ref[left_item]")) || (right_item && CALLBACK_EXISTS("hit_\ref[right_item]")))
			start_block()

	//Trap attack.
	if(objective_attack && next_trap > 0 && next_trap <= world.time + SECONDS_TO_DECISECONDS(1))

		if(next_trap > world.time)
			return TRUE

		if(owner_as_gabber.sword_mode)
			owner_as_gabber.trap_lines(super_traps_left)
			super_traps_left--
			if(super_traps_left > 0)
				next_trap = world.time + SECONDS_TO_DECISECONDS(5)
			else
				next_trap = world.time + SECONDS_TO_DECISECONDS(30)
				super_traps_left = initial(super_traps_left)
		else
			owner_as_gabber.trap_spam(objective_attack)
			next_trap = world.time + SECONDS_TO_DECISECONDS(60)

		return TRUE

	//Ranged attack. Non-sword mode only (unless there are other players fighting it).
	if(objective_attack && next_shoot > 0 && next_shoot <= world.time)

		var/projectiles_to_fire = 1 + shoot_count % 3
		shoot_count++

		if(!owner_as_gabber.sword_mode && get_dist(owner,objective_attack) >= 3)
			owner_as_gabber.shoot_bouncy_projectiles(objective_attack,projectiles_to_fire)

		if(projectiles_to_fire >= 3)
			//Also fire at nearby enemies in sword mode.
			if(owner_as_gabber.sword_mode && length(owner_as_gabber.players_fighting_boss))
				var/list/players_to_shoot_at = owner_as_gabber.players_fighting_boss - objective_attack
				for(var/k in players_to_shoot_at)
					var/mob/living/L = k
					owner_as_gabber.shoot_bouncy_projectiles(L,1)
			next_shoot = world.time + SECONDS_TO_DECISECONDS(0.75)*projectiles_to_fire
		else
			next_shoot = world.time + SECONDS_TO_DECISECONDS(0.25)*projectiles_to_fire

		return TRUE

	. = ..()

/ai/boss/gabber/should_life()
	. = ..()
	if(owner_as_gabber)
		if(owner_as_gabber.has_status_effect(IMMORTAL))
			return FALSE

/ai/boss/gabber/on_life(var/tick_rate=1)

	. = ..()

	if(owner_as_gabber.sword_mode)

		if(next_self_health_update <= world.time)

			var/current_health = owner_as_gabber.health.health_current / owner_as_gabber.health.health_max

			if(last_self_health && (last_self_health - current_health >= 0.05)) //Lost more than 5% hp in a second.
				start_block() //Taking a lot of damage means they should block.

			last_self_health = current_health
			next_self_health_update = world.time + SECONDS_TO_DECISECONDS(1)

		else if(next_destroy_area <= world.time)

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
