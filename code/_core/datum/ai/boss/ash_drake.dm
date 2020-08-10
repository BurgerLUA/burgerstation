/ai/boss/ash_drake/

	var/failed_attack_frames = 0
	var/mob/living/simple/npc/ash_drake/owner_as_ash_drake

	var/fly_time = 0

	var/fly_delay = SECONDS_TO_DECISECONDS(5)
	var/fireball_delay = SECONDS_TO_DECISECONDS(3)

/ai/boss/ash_drake/New(var/mob/living/desired_owner)
	owner_as_ash_drake = desired_owner
	return ..()

/ai/boss/ash_drake/handle_attacking()


	if(owner_as_ash_drake.boss_state == 1)
		if(fly_time >= 30)
			owner_as_ash_drake.land()
			fly_time = 0
		fly_time += 1

	else if(objective_attack)
		if(!owner_as_ash_drake.boss_state)
			var/distance = get_dist(owner,objective_attack)
			var/fly_chance = max(0,distance*10 - 50) + max(0,failed_attack_frames - 50)
			var/shoot_chance = max(0,distance*10 - 25) + max(0,failed_attack_frames - 25)
			if(!owner_as_ash_drake.health || (objective_attack && get_dist(owner,objective_attack) <= attack_distance_max))
				failed_attack_frames = 0
				return ..()
			else if(fly_delay <= 0 && prob(fly_chance))
				owner_as_ash_drake.fly()
				var/fly_multiplier = clamp(owner_as_ash_drake.health.health_current / owner_as_ash_drake.health.health_max,0.5,1)
				fly_delay = initial(fly_delay) * fly_multiplier
			else if(fireball_delay <= 0 && prob(shoot_chance))
				owner_as_ash_drake.shoot_fireball(objective_attack)
				var/fireball_multiplier = clamp(owner_as_ash_drake.health.health_current / owner_as_ash_drake.health.health_max,0.25,1)
				fireball_delay = initial(fireball_delay) * fireball_multiplier
			else
				failed_attack_frames += 1

	fireball_delay -= 1
	fly_delay -= 1
	owner.attack_next = world.time + 10

/ai/boss/ash_drake/handle_movement()

	if(owner_as_ash_drake.boss_state == 2)
		owner.move_dir = 0
		return FALSE

	if(objective_attack && (owner_as_ash_drake.boss_state || get_dist(owner,objective_attack) > attack_distance_max))
		owner.move_dir = get_dir(owner,objective_attack)
	else
		owner.move_dir = 0