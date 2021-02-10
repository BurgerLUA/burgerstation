#define PROJECTILE_MODE_CLOCKWISE "clockwise"
#define PROJECTILE_MODE_COUNTER_CLOCKWISE "counter-clockwise"
#define PROJECTILE_MODE_BULLETHELL "bullethell"
#define PROJECTILE_MODE_CIRCLE "circle"

/ai/boss/colossus/

	var/projectile_mode = PROJECTILE_MODE_BULLETHELL
	var/projectiles_to_shoot = 0

	var/projectile_ticks = 0
	var/delay_mod = 1

	var/bullet_count = 1
	var/angle_ticks = 0
	var/angle_mod = 5
	var/projectile_speed = TILE_SIZE - 1

	var/steps_to_take = 5

	var/slow_ticks = 0

	use_cone_vision = FALSE

/ai/boss/colossus/on_life()

	. = ..()

	if(.)
		handle_projectiles()

	return .

/ai/boss/colossus/proc/handle_projectiles()

	if(!objective_attack)
		return FALSE

	if(projectile_ticks > 0)
		projectile_ticks--
		return FALSE

	if(projectiles_to_shoot <= 0)
		play_sound('sound/effects/invoke_general.ogg',get_turf(owner), range_max = SOUND_RANGE * 3)
		switch(rand(1,10))
			if(1 to 3)
				projectile_mode = PROJECTILE_MODE_CLOCKWISE
				projectiles_to_shoot = rand(30,60)
				angle_mod = rand(3,20)
				projectile_speed = TILE_SIZE-1
				delay_mod = rand(2,4)
				bullet_count = pick(1,1,1,1,2,3)
				if(bullet_count > 1)
					owner.do_say("<font color='#DD1C1F' size='4'>REPENT.</font>",FALSE)
			if(4 to 6)
				projectile_mode = PROJECTILE_MODE_COUNTER_CLOCKWISE
				projectiles_to_shoot = rand(30,60)
				angle_mod = rand(3,20)
				projectile_speed = TILE_SIZE-1
				delay_mod = rand(2,4)
				bullet_count = pick(1,1,1,1,2,3)
				if(bullet_count > 1)
					owner.do_say("<font color='#DD1C1F' size='4'>REPENT.</font>",FALSE)
			if(7 to 10)
				projectile_mode = PROJECTILE_MODE_BULLETHELL
				projectiles_to_shoot = rand(10,20)
				projectile_speed = 8
				delay_mod = rand(1,3)
				bullet_count = 5
				owner.do_say("<font color='#DD1C1F' size='4'>SUFFER.</font>",FALSE)
			if(11)
				projectile_mode = PROJECTILE_MODE_CIRCLE
				projectiles_to_shoot = 3
				projectile_speed = 4
				delay_mod = 10
				bullet_count = 20
				owner.do_say("<font color='#DD1C1F' size='4'>DIE.</font>",FALSE)

		projectile_ticks = 30

	else
		var/list/params = list()
		params[PARAM_ICON_X] = rand(0,32)
		params[PARAM_ICON_Y] = rand(0,32)

		switch(projectile_mode)
			if(PROJECTILE_MODE_CLOCKWISE)
				angle_ticks = angle_ticks + angle_mod % 360
			if(PROJECTILE_MODE_COUNTER_CLOCKWISE)
				angle_ticks = angle_ticks + -angle_mod % 360
			if(PROJECTILE_MODE_BULLETHELL)
				angle_ticks = rand(1,360)

		play_sound('sound/effects/invoke_short.ogg',get_turf(owner), range_max = SOUND_RANGE * 3)

		for(var/i=1,i<=bullet_count,i++)

			var/local_angle = 0

			if(bullet_count > 1)
				local_angle = (i - (bullet_count / 2)) * (360/bullet_count)

			var/obj/projectile/magic/crystal/ice/P = new(
				get_turf(owner),
				owner,
				owner,
				cos(angle_ticks+local_angle) * projectile_speed,
				sin(angle_ticks+local_angle) * projectile_speed,
				rand(14,18),
				rand(14,18),
				null,
				/damagetype/ranged/laser/freezegun,
				null,
				"#FFFFFF",
				owner,
				1,
				owner.iff_tag
			)
			INITIALIZE(P)
			FINALIZE(P)

		projectile_ticks = delay_mod
		projectiles_to_shoot -= 1

	return TRUE