/ai/boss/xeno_queen/
	var/mob/living/simple/xeno/queen/owner_as_queen

	var/next_leap = 0
	var/next_spit = 0

	aggression = 2
	assistance = 1
	retaliate = TRUE

/ai/boss/xeno_queen/Destroy()
	owner_as_queen = null
	return ..()

/ai/boss/xeno_queen/New(var/mob/living/desired_owner)
	owner_as_queen = desired_owner
	return ..()

/ai/boss/xeno_queen/handle_attacking()

	. = ..()

	if(!. && objective_attack)

		if(world.time >= next_spit && get_dist(objective_attack,owner) >= 4)
			owner_as_queen.shoot_projectile(owner_as_queen,objective_attack,null,null,/obj/projectile/bullet/spit,/damagetype/ranged/spit/,16,16,0,TILE_SIZE*0.5,1,"#FFFFFF",0,0,1,owner_as_queen.iff_tag,owner_as_queen.loyalty_tag)
			next_spit = world.time + SECONDS_TO_DECISECONDS(4)
			return TRUE

	return .

/ai/boss/xeno_queen/on_damage_received(var/atom/atom_damaged,var/atom/attacker,var/atom/weapon,var/list/damage_table,var/damage_amount,var/critical_hit_multiplier,var/stealthy=FALSE)

	. = ..()

	if(!owner_as_queen.dead && owner_as_queen.health && owner_as_queen.health.health_current <= owner_as_queen.health.health_max*0.75 && owner_as_queen.next_screech <= world.time)
		owner_as_queen.screech()
		owner_as_queen.next_screech = world.time + SECONDS_TO_DECISECONDS(60)

	return .