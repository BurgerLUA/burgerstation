/ai/simple/cultist/
	name = "Cultist AI"
	desc = "Unpredictable and savage"

/ai/simple/cultist/handle_movement()

	if(movement_ticks < movement_delay)
		movement_ticks += 1
		return

	if(objective_attack)
		if(get_dist(owner,objective_attack) > 1)
			owner.move_dir = get_dir(owner,objective_attack) & pick(0,0,0,0,NORTH,EAST,SOUTH,WEST)
		else
			owner.move_dir = 0

	else if(get_dist(owner,start_turf) >= 5)
		owner.move_dir = get_dir(owner,start_turf)
	else if(stationary)
		owner.move_dir = 0
	else
		owner.move_dir = pick(list(0,0,0,0,NORTH,EAST,SOUTH,WEST))

/ai/simple/cultist/hostile_message()

	var/list/possible_responses = list(
		"Hail Nar'sie!",
		"Another sacrifice for Nar'sie!",
		"Nar'sie will rise again!",
		"Join or die!",
		"AKH'LI SI THU'YU DAR!",
		"UR'I SHEM LAR CLTHU!",
		"LOK FI NI SHU'K NAR'THUM",
		"JU LUUK FI SHI'K NAR'SIE."
	)

	owner.say(pick(possible_responses))

/ai/simple/behemoth/
	name = "Behemoth AI"
	desc = "Tanky."

	stationary = TRUE

/ai/simple/artificer/
	name = "Artificer AI"
	desc = "Cautious."
	var/spawned_mobs = 0

	attack_delay = 10

/ai/simple/artificer/handle_attacking()

	if(attack_ticks < attack_delay)
		attack_ticks += 1
		return

	if(objective_attack && spawned_mobs < 5)
		new /mob/living/simple/npc/cult/harvester(owner.loc)
		spawned_mobs += 1

	attack_ticks = 0

/ai/simple/artificer/handle_movement()

	if(movement_ticks < movement_delay)
		movement_ticks += 1
		return

	if(objective_attack)
		if(get_dist(objective_attack,owner) <= 6)
			owner.move_dir = reverse_direction(get_dir(owner,objective_attack))
		else
			owner.move_dir = pick(list(0,0,0,0,NORTH,EAST,SOUTH,WEST))
	else if(get_dist(owner,start_turf) >= 5)
		owner.move_dir = get_dir(owner,start_turf)
	else if(stationary)
		owner.move_dir = 0
	else
		owner.move_dir = pick(list(0,0,0,0,NORTH,EAST,SOUTH,WEST))

/ai/simple/harvester/
	name = "Harvester AI"
	desc = "Eager."