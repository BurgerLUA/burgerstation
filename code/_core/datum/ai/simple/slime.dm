/ai/slime/

	roaming_distance = VIEW_RANGE*2

	aggression = 1
	assistance = 1

	target_distribution_x = list(12,16,20)
	target_distribution_y = list(4.8,12,16)

/ai/slime/proc/can_absorb_slime(mob/living/simple/slime/S)

	var/mob/living/simple/slime/self = owner

	if(!S || !self || S == self)
		return FALSE

	if(self.slime_traits & SLIME_TRAIT_THORNS) //Spiky slimes can't absorb.
		return FALSE

	if(S.slime_traits & SLIME_TRAIT_THORNS) //Spiky slimes can't absorb.
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

/ai/slime/is_enemy(atom/A,safety_check=TRUE,aggression_check=TRUE)

	if(istype(A,/mob/living/simple/slime))
		return can_absorb_slime(A)

	. = ..()

/ai/slime/do_attack(atom/atom_to_attack)

	if(!istype(atom_to_attack,/mob/living/simple/slime/) || !can_absorb_slime(atom_to_attack)) //Double check to be safe.
		return ..()

	var/turf/atom_turf = get_step(src,atom_to_attack) //Only 1 step to prevent funny teleporting
	if(!atom_turf)
		return FALSE

	if(atom_turf != atom_to_attack.loc)
		owner.Move(atom_turf)

	if(atom_turf != owner.loc)
		return FALSE

	var/mob/living/simple/slime/self = owner
	self.absorb_slime(atom_to_attack)

	return TRUE
