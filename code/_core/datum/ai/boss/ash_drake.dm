/ai/boss/ash_drake/

	var/failed_attack_frames = 0
	var/mob/living/simple/ash_drake/owner_as_ash_drake

	var/fly_time = 0

	var/fly_delay = SECONDS_TO_DECISECONDS(10)
	var/fireball_delay = SECONDS_TO_DECISECONDS(5)

	var/last_fly = 0
	var/last_fireball = 0


/ai/boss/ash_drake/New(var/mob/living/desired_owner)
	owner_as_ash_drake = desired_owner
	return ..()

/ai/boss/ash_drake/Destroy()
	owner_as_ash_drake = null
	return ..()

/ai/boss/ash_drake/handle_attacking()

	if(owner_as_ash_drake.boss_state == 2)
		// Don't attack when landing.
		return TRUE

	if(owner_as_ash_drake.boss_state == 1)
		if(fly_time >= 10)
			owner_as_ash_drake.land()
			fly_time = 0
			last_fly = world.time
		fly_time += 1
		return TRUE

	if(!owner_as_ash_drake.health || (objective_attack && get_dist(owner,objective_attack) <= attack_distance_max))
		return ..()

	if(objective_attack && !owner_as_ash_drake.boss_state)
		if(last_fly != -1 && last_fly + fly_delay <= world.time)
			owner_as_ash_drake.fly()
			last_fly = -1 //Only start counting when you land.
			return TRUE
		if(last_fireball + fireball_delay <= world.time)
			owner_as_ash_drake.shoot_fireball(objective_attack)
			last_fireball = world.time
			return TRUE

	return ..()



/ai/boss/ash_drake/handle_movement()

	if(owner_as_ash_drake.boss_state == 2)
		owner.move_dir = 0
		return TRUE

	return ..()