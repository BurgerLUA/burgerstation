
/ai/boss/slime_king

	var/mob/living/simple/slime_king/owner_as_slime_king

	var/next_slime_bomb = 0
	var/next_slime_wave = 0
	var/next_slime_house = 0
	var/next_special_attack = 0

	var/list/ranged_people = list()

/ai/boss/slime_king/Destroy()
	owner_as_slime_king = null
	ranged_people.Cut()
	ranged_people = null
	. = ..()

/ai/boss/slime_king/New(var/desired_loc,var/mob/living/desired_owner)
	owner_as_slime_king = desired_owner
	. = ..()


/ai/boss/slime_king/set_objective(var/atom/A)

	var/had_previous_objective = objective_attack

	. = ..()

	if(. && objective_attack && !had_previous_objective)
		next_slime_bomb = max(next_slime_bomb,world.time + SECONDS_TO_DECISECONDS(30))
		next_slime_wave = max(next_slime_wave,world.time + SECONDS_TO_DECISECONDS(10))
		next_slime_house = max(next_slime_house,world.time + SECONDS_TO_DECISECONDS(30))

/ai/boss/slime_king/handle_attacking()

	if(objective_attack && next_special_attack <= world.time && !owner_as_slime_king.has_status_effect(PARALYZE))

		if(next_slime_house > 0 && next_slime_house <= world.time)
			owner_as_slime_king.build_a_house(rand(4,6))
			next_slime_house = world.time + rand(300,600)
			next_special_attack = world.time + 50
			return TRUE

		if(next_slime_bomb > 0 && next_slime_bomb <= world.time)
			owner_as_slime_king.throw_bombs()
			next_slime_bomb = world.time + rand(200,400)
			next_special_attack = world.time + 50
			return TRUE

		if(next_slime_wave > 0 && next_slime_wave <= world.time && get_dist(owner_as_slime_king,objective_attack) >= 3)
			var/objective_dir = get_dir(owner_as_slime_king,objective_attack)
			if(objective_dir in DIRECTIONS_CARDINAL)
				owner_as_slime_king.slime_wave(objective_dir)
				next_slime_wave = world.time + rand(100,300)
				next_special_attack = world.time + 50
				return TRUE

		if(owner_as_slime_king.next_slime_ball_shoot <= world.time && owner_as_slime_king.slime_balls_left > 0 && get_dist(owner_as_slime_king,objective_attack) >= 3)
			owner_as_slime_king.shoot_slime_ball(objective_attack)

	. = ..()