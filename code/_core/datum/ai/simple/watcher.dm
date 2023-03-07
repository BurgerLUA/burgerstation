/ai/watcher
	attack_distance_min = 4
	attack_distance_max = 8

	var/projectile_delay = SECONDS_TO_DECISECONDS(5)
	var/projectile_count = 2

	night_vision = 0

	roaming_distance = VIEW_RANGE*0.5

/ai/watcher/handle_attacking()

	if(objective_attack)
		handle_projectiles()

	return ..()

/ai/watcher/proc/handle_projectiles()

	if(!objective_attack)
		return FALSE

	if(projectile_delay > 0)
		projectile_delay--
		return FALSE

	if(projectile_count > 0)
		play_sound('sound/weapons/ranged/energy/freeze_gun/shoot1.ogg',get_turf(owner))
		owner.shoot_projectile(
			owner,
			objective_attack,
			null,
			null,
			/obj/projectile/magic/crystal/ice,
			/damagetype/ranged/laser/freezegun,
			16,
			16,
			0,
			TILE_SIZE*0.5,
			1,
			"#FFFFFF",
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

	return TRUE

/ai/watcher/clockwork
	projectile_count = 3
	projectile_delay = SECONDS_TO_DECISECONDS(2)

/ai/watcher/clockwork/handle_projectiles()

	if(!objective_attack)
		return FALSE

	if(projectile_delay > 0)
		projectile_delay--
		return FALSE

	if(projectile_count > 0)
		play_sound('sound/weapons/ranged/misc/clockwork_watcher_shot.ogg',get_turf(owner))
		owner.shoot_projectile(
			owner,
			objective_attack,
			null,
			null,
			/obj/projectile/bullet/laser,
			/damagetype/ranged/laser/rifle,
			16,
			16,
			0,
			TILE_SIZE*0.9,
			1,
			"#FF0000",
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

	return TRUE