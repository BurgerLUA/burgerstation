/ai/xeno
	var/next_leap = 0
	var/next_spit = 0

	aggression = 2
	assistance = 1
	retaliate = TRUE

/ai/xeno/handle_attacking()

	. = ..()

	if(!istype(owner,/mob/living/simple/xeno/))
		return .

	var/mob/living/simple/xeno/X = owner

	if(!. && objective_attack)
		if(X.can_leap && world.time >= next_leap && get_dist(objective_attack,owner) >= 3)
			var/list/offsets = direction_to_pixel_offset(get_dir(owner,objective_attack))
			var/throw_velocity = 20
			owner.throw_self(owner,objective_attack,16,16,offsets[1]*throw_velocity,offsets[2]*throw_velocity,lifetime = SECONDS_TO_DECISECONDS(4), steps_allowed = 6, desired_iff = owner.iff_tag)
			next_leap = world.time + SECONDS_TO_DECISECONDS(10)
			return TRUE

		if(X.can_spit && world.time >= next_spit && get_dist(objective_attack,owner) >= 4)
			X.shoot_projectile(X,objective_attack,null,null,/obj/projectile/bullet/spit,/damagetype/ranged/spit/,16,16,0,TILE_SIZE*0.5,1,"#FFFFFF",0,0,1,X.iff_tag,X.loyalty_tag)
			next_spit = world.time + SECONDS_TO_DECISECONDS(4)
			return TRUE

	return .