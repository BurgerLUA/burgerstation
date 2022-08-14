/ai/slime/
	roaming_distance = 32

/ai/slime/proc/can_absorb_slime(var/mob/living/simple/slime/S)

	var/mob/living/simple/slime/self = owner

	if(!S || !self || S == self)
		return FALSE

	if(S.color == self.color) //Can't absorb relatives.
		return FALSE

	if(S.stored_slimes > self.stored_slimes) //Can't absorb those stronger than you.
		return FALSE

	if(self.stored_slimes != S.stored_slimes && self.stored_slimes >= S.stored_slimes*0.5) // Can't absorb those twice as small as you.
		return FALSE

	if(self.stored_slimes + S.stored_slimes > self.stored_slimes_max) //Can't absorb if the resulting absorb is too much.
		return FALSE

	if(!S.can_attack(S,self,S,null,null)) //Can't absorb if we can't even attack.
		return FALSE

	return TRUE

/ai/slime/is_enemy(var/atom/A,var/safety_check=TRUE,var/aggression_check=TRUE)

	if(istype(A,/mob/living/simple/slime))
		return can_absorb_slime(A)

	. = ..()

/ai/slime/do_attack(var/atom/atom_to_attack)

	if(!istype(atom_to_attack,/mob/living/simple/slime/) || !can_absorb_slime(atom_to_attack)) //Double check to be safe.
		return ..()

	var/mob/living/simple/slime/self = owner
	self.absorb_slime(atom_to_attack)

	return TRUE
