//AI that kicks people off the ship if they're intentionally trying to block doors.

/ai/doorman
	roaming_distance = 0
	left_click_chance = 100
	use_alerts = FALSE
	true_sight = TRUE

	var/obj/marker/beepsky/beepsky_marker

	enabled = TRUE

/ai/doorman/handle_movement()

	if(frustration > frustration_threshold)
		owner.force_move(beepsky_marker.loc)
		frustration = 0

	if(objective_attack)
		if(get_dist(owner,objective_attack) > 1)
			owner.move_dir = get_dir(owner,objective_attack)
		else
			owner.move_dir = 0x0
	else
		if(owner.loc != beepsky_marker.loc)
			owner.move_dir = get_dir(owner,beepsky_marker)
		else
			owner.move_dir = 0x0

	return TRUE

/ai/doorman/handle_objectives()

	if(!beepsky_marker)
		beepsky_marker = locate() in owner.loc.loc.contents

	if(!objective_attack && length(attackers))
		var/mob/living/chosen_target = pick(attackers)
		attackers -= chosen_target
		set_objective(chosen_target)

	if(objective_attack && !(locate(/obj/structure/interactive/scanner/living) in objective_attack.loc.contents))
		attackers -= objective_attack
		set_objective(null)

	return TRUE


