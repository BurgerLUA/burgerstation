/ai/slime/

	objective_delay = 10
	attack_delay = 1

	roaming_distance = 32

/ai/slime/proc/can_absorb_slime(var/mob/living/simple/npc/slime/S)

	var/mob/living/simple/npc/slime/self = owner

	if(S == self)
		return FALSE

	if(S.slime_color == self.slime_color)
		return FALSE

	if(S.stored_slimes > self.stored_slimes)
		return FALSE

	if(self.stored_slimes >= self.stored_slimes_max)
		return FALSE

	if(self.stored_slimes + S.stored_slimes > self.stored_slimes_max)
		return FALSE

	if(!S.can_attack(self,S,null,null))
		return FALSE

	return TRUE

/ai/slime/get_possible_targets()

	. = list()

	var/mob/living/simple/npc/slime/self = owner

	for(var/mob/living/advanced/A in view(radius_find_enemy,owner))
		CHECK_TICK
		if(should_attack_mob(A) && is_enemy(A))
			.[A] = TRUE

	if(!length(.) && self.stored_slimes < self.stored_slimes_max)
		for(var/mob/living/simple/npc/slime/S in view(radius_find_enemy,owner))
			CHECK_TICK
			if(can_absorb_slime(S))
				.[S] = TRUE

	return .

/ai/slime/do_attack(var/atom/atom_to_attack)

	if(!is_slime(atom_to_attack) || !can_absorb_slime(atom_to_attack))
		return ..()

	var/mob/living/simple/npc/slime/self = owner
	self.absorb_slime(atom_to_attack)

	return TRUE
