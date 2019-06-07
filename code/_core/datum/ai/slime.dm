/ai/slime/
	name = "Slime AI"
	radius_find_enemy = 12
	target_distribution = list(0,0,0,0,4,8)

	objective_delay = 10
	attack_delay = 1
	movement_delay = 1

	simple = TRUE
	sync_stats = TRUE

	stationary = FALSE

	roaming_distance = 32

	attack_distance = 0

/ai/slime/handle_movement()
	return ..()

/ai/slime/proc/can_absorb_slime(var/mob/living/simple/npc/slime/S)

	var/mob/living/simple/npc/slime/self = owner

	if(S == self)
		return FALSE

	if(S.slime_color == self.slime_color)
		return FALSE

	if(S.stored_slimes > self.stored_slimes)
		return FALSE

	if(self.stored_slimes >= 4)
		return FALSE

	if(S.can_attack(self))
		return FALSE

	return TRUE

/ai/slime/get_possible_targets()

	var/list/possible_targets = list()

	var/mob/living/simple/npc/slime/self = owner

	if(self.stored_slimes < 4)
		for(var/mob/living/simple/npc/slime/S in view(radius_find_enemy,owner))
			if(can_absorb_slime(S))
				possible_targets += S

	for(var/mob/living/advanced/player/P in view(radius_find_enemy,owner))
		if(should_attack_mob(P))
			possible_targets += P

	return possible_targets


/ai/slime/handle_attacking()

	if(objective_attack)
		var/is_slime = is_slime(objective_attack)
		if(is_slime && get_dist(owner,objective_attack) <= 0)
			if(!can_absorb_slime(objective_attack))
				objective_attack = null
				return
			var/mob/living/simple/npc/slime/self = owner
			self.absorb_slime(objective_attack)
		else if(!is_slime && get_dist(owner,objective_attack) <= 1)
			owner.move_dir = 0
				owner.attack(owner,objective_attack)

	attack_ticks = 0

