
/ai/boss/slime_king

	var/mob/living/simple/slime_king/owner_as_slime_king

/ai/boss/slime_king/Destroy()
	owner_as_slime_king = null
	. = ..()

/ai/boss/slime_king/New(desired_loc,mob/living/desired_owner)
	owner_as_slime_king = desired_owner
	. = ..()

/ai/boss/slime_king/set_objective(atom/A)

	var/had_previous_objective = objective_attack

	. = ..()

	if(. && objective_attack && !had_previous_objective && owner_as_slime_king.next_special_attack <= world.time)
		owner_as_slime_king.next_special_attack = world.time + 5 SECONDS

/ai/boss/slime_king/handle_attacking()

	if(objective_attack && owner_as_slime_king.next_special_attack <= world.time && !owner_as_slime_king.has_status_effect(PARALYZE))

		if(owner_as_slime_king.health.health_current <= owner_as_slime_king.health.health_max*0.75 && owner_as_slime_king.heal_amount_current < owner_as_slime_king.heal_amount_max && owner_as_slime_king.next_slime_absorb_spam <= world.time)
			owner_as_slime_king.start_absorb()
			return TRUE

		if(owner_as_slime_king.next_slime_house <= world.time)
			owner_as_slime_king.build_a_house(VIEW_RANGE,build_walls=FALSE)
			return TRUE

		if(owner_as_slime_king.next_slime_bomb <= world.time)
			owner_as_slime_king.throw_bombs()
			return TRUE

		if(owner_as_slime_king.next_slime_wave <= world.time && get_dist(owner_as_slime_king,objective_attack) >= 3)
			var/objective_dir = get_dir(owner_as_slime_king,objective_attack)
			if(objective_dir in DIRECTIONS_CARDINAL)
				owner_as_slime_king.slime_wave(objective_dir)
				return TRUE

		if(owner_as_slime_king.next_slime_ball <= world.time && owner_as_slime_king.slime_balls_left > 0 && get_dist(owner_as_slime_king,objective_attack) >= 3)
			owner_as_slime_king.shoot_slime_ball(objective_attack)
			return TRUE




	. = ..()
