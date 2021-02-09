/ai/boss/herald/

	var/mob/living/simple/herald/owner_as_herald


/ai/boss/herald/New(var/desired_loc,var/mob/living/desired_owner)
	owner_as_herald = desired_owner
	return ..()

/ai/boss/herald/Destroy()
	owner_as_herald = null
	return ..()

/ai/boss/herald/handle_movement()

	. = ..()

	if(owner_as_herald.health && owner_as_herald.health.health_current <= owner_as_herald.health.health_max*0.5)
		owner_as_herald.movement_flags = MOVEMENT_RUNNING

	return .


/ai/boss/herald/on_damage_received(var/atom/atom_damaged,var/atom/attacker,var/atom/weapon,var/list/damage_table,var/damage_amount,var/critical_hit_multiplier,var/stealthy=FALSE)

	. = ..()

	if(!owner_as_herald.dead && owner_as_herald.next_teleport <= world.time && get_dist(owner_as_herald,attacker) >= 4)
		if(attacker)
			owner_as_herald.teleport_target(attacker)
			set_objective(attacker)
		else
			owner_as_herald.teleport_random()

	return .