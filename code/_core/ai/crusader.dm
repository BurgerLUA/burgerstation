/ai/crusader/
	name = "Crusader"

/ai/crusader/hostile_message()
	owner.say("DEUS VULT!")
	var/area/A = get_area(owner)
	play_sound('sounds/voice/deusvult.ogg',all_mobs,vector(owner.x,owner.y,owner.z),environment = A.sound_environment)


/ai/crusader/handle_attacking()

	if(attack_ticks < attack_delay)
		attack_ticks += 1
		return

	var/weapon_distance = 1

	if(is_advanced(owner))
		var/mob/living/advanced/A = owner
		if(is_ranged_gun(A.get_held_right()))
			weapon_distance = 100

	if(objective_attack && get_dist(owner,objective_attack) <= weapon_distance)
		owner.move_dir = 0
		var/list/params = list(
			"icon-x" = num2text(16),
			"icon-y" = num2text(pick(target_distribution)),
			"left" = 0,
			"right" = 0,
			"middle" = 0,
			"ctrl" = 0,
			"shift" = 0,
			"alt" = 0
		)

		if(prob(90))
			params["left"] = TRUE
			owner.on_left_down(objective_attack,owner,null,params)
		else
			params["right"] = TRUE
			owner.on_right_down(objective_attack,owner,null,params)

	attack_ticks = 0