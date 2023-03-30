/ai/bodyguard_drone
	attack_distance_min = 4
	attack_distance_max = 8

	var/projectile_delay = SECONDS_TO_DECISECONDS(5)
	var/projectile_count = 3



/ai/bodyguard_drone/handle_attacking()

	if(objective_attack)
		handle_projectiles()

	return ..()

/ai/bodyguard_drone/proc/handle_projectiles()

	if(!objective_attack)
		return FALSE

	if(projectile_delay > 0)
		projectile_delay--
		return FALSE

	if(projectile_count > 0)
		play_sound('sound/weapons/ranged/energy/laser_rifle/shoot.ogg',get_turf(owner))
		owner.shoot_projectile(
			owner,
			objective_attack,
			null,
			null,
			/obj/projectile/bullet/laser/weak,
			/damagetype/ranged/laser/carbine,
			16,
			16,
			0,
			TILE_SIZE*0.5,
			1,
			COLOR_CYAN,
			0,
			1,
			owner.iff_tag,
			owner.loyalty_tag
		)
		owner.set_dir(get_dir(owner,objective_attack))
		projectile_count--
	else
		projectile_count = initial(projectile_count)
		projectile_delay = initial(projectile_delay)




/ai/bodyguard_drone/handle_movement()

	var/mob/living/simple/silicon/drone/D = owner

	if(D.owner && D.owner.ai && D.owner.ai.objective_attack && D.owner.ai.objective_attack.z && D.owner.z == owner.z)
		var/x_average = (D.owner.ai.objective_attack.x + D.owner.x) / 2
		var/y_average = (D.owner.ai.objective_attack.y + D.owner.y) / 2
		x_average = round(x_average,1)
		y_average = round(y_average,1)

		var/turf/T = locate(x_average,y_average,D.z)
		if(T)
			if(T == D.owner.loc || T == objective_attack.loc)
				T = objective_attack.loc
			last_movement_proc = "drone bodyguard"
			owner.movement_flags = MOVEMENT_NORMAL
			if(T == D.loc)
				owner.move_dir = 0x0
				return TRUE
			owner.move_dir = get_dir(D.loc,T)
			return TRUE

	. = ..()