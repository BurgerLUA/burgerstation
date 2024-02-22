/ai/boss/can_man/

	enemy_tags = list("NanoTrasen")

	assistance = 0
	aggression = 1

	attack_distance_min = 0
	attack_distance_max = 1

	distance_target_min = 1
	distance_target_max = VIEW_RANGE*1.5

	var/mob/living/simple/can_man/owner_as_can_man
	var/next_minigun_sweep = 0
	var/strafe_count = 0
	var/strafe_latch = -1 //-1 or 1

/ai/boss/can_man/New(var/desired_loc,var/mob/living/desired_owner)
	owner_as_can_man = desired_owner
	return ..()

/ai/boss/can_man/Destroy()
	owner_as_can_man = null
	return ..()


/ai/boss/can_man/set_objective(var/atom/A)
	var/had_previous_objective = objective_attack
	. = ..()
	if(. && objective_attack && !had_previous_objective)
		next_minigun_sweep = max(next_minigun_sweep,world.time + SECONDS_TO_DECISECONDS(30))

/ai/boss/can_man/handle_movement()

	//Strafing (At a distance).
	if(objective_attack && get_dist(objective_attack,owner) >= 4)
		if(strafe_count > 0)
			var/desired_dir = get_dir(owner,objective_attack)
			desired_dir = turn(desired_dir,90*strafe_latch)
			owner.movement_flags = MOVEMENT_RUNNING
			owner.move_dir = desired_dir
			strafe_count -= 1
			return TRUE
		else if(prob(3))
			strafe_count = 5
			strafe_latch = pick(-1,1)

	. = ..()


/ai/boss/can_man/handle_attacking()

	if(objective_attack)
		//Charged minigun attack
		if(next_minigun_sweep <= world.time)
			owner_as_can_man.telegraph_special_minigun_sweep(objective_attack)
			next_minigun_sweep = world.time + SECONDS_TO_DECISECONDS(30)
			return TRUE
		//Basic minigun attack.
		if(owner_as_can_man.minigun_delay <= world.time && get_dist(owner,objective_attack) >= 2)
			owner_as_can_man.shoot_minigun(objective_attack)
			return TRUE

	. = ..()