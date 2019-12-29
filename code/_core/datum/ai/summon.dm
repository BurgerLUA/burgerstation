/ai/summon/

/ai/summon/handle_movement()

	if(objective_attack)
		if(get_dist(owner,objective_attack) > 1)
			owner.move_dir = get_dir(owner,objective_attack)
		else
			owner.move_dir = 0
	else if(is_summon(owner))
		var/mob/living/simple/npc/summon/S = owner
		var/mob/living/SO = S.owner
		if(get_dist(owner,SO) >= 3)
			owner.move_dir = get_dir(owner,SO)
		else
			owner.move_dir = 0

	else if(get_dist(owner,start_turf) >= 5)
		owner.move_dir = get_dir(owner,start_turf)
	else
		owner.move_dir = pick(list(0,0,0,0,NORTH,EAST,SOUTH,WEST))

	movement_ticks = 0

/ai/summon/hostile_message()
	owner.say("YOU SHALL SUFFER FOR THE SINS AGAINST MY MASTER.")

/ai/summon/should_attack_mob(var/mob/living/L)

	if(L.dead)
		return FALSE

	/*
	for(var/id in owner.factions)
		var/faction/F = owner.factions[id]
		if(F && F.is_hostile_to_mob(L))
			return TRUE

	for(var/id in L.factions)
		var/faction/F = L.factions[id]
		if(F && F.is_hostile_to_mob(owner))
			return TRUE
	*/

	return FALSE
