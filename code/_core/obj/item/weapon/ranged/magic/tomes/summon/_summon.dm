/obj/item/weapon/ranged/magic/tome/summon
	shoot_sounds = list('sound/weapons/magic/summon.ogg')
	projectile_speed = 8
	shoot_delay = 30
	projectile = /obj/projectile/bullet/summon

	var/atom/movable/object_to_summon
	var/duration = SECONDS_TO_DECISECONDS(300) //In deciseconds. Only applies to summoning mobs.

/obj/item/weapon/ranged/magic/tome/summon/on_projectile_hit(var/obj/projectile/P,var/atom/hit_atom)

	if(istype(P,/obj/projectile/bullet/thrown/))
		return ..()

	var/atom/movable/summoned_object = new object_to_summon(P.previous_loc)
	if(is_living(P.owner))
		var/mob/living/L2 = P.owner
		if(is_living(summoned_object))
			var/mob/living/L = summoned_object
			L.set_iff_tag(L2.iff_tag)
			L.set_loyalty_tag(L2.loyalty_tag)
			if(L2.minion)
				L2.minion.dust()
			L2.minion = L
			L.master = L2
			L.minion_remove_time = world.time + duration
			L.level_multiplier *= 20*L2.get_skill_power(SKILL_MAGIC)
		if(L2.is_player_controlled())
			L2.add_skill_xp(SKILL_MAGIC,cost_mana*1.5)
	INITIALIZE(summoned_object)
	GENERATE(summoned_object)
	FINALIZE(summoned_object)
	if(summoned_object)
		summoned_object.Move(get_turf(hit_atom))
		if(is_living(summoned_object))
			var/mob/living/L = summoned_object
			if(is_living(P.owner))
				var/mob/living/L2 = P.owner
				if(L.ai)
					L.ai.aggression = 2
					L.ai.assistance = 1
					L.ai.roaming_distance = 0
					L.ai.shoot_obstacles = FALSE
					L.ai.use_cone_vision = FALSE
					L.ai.reaction_time = 0
					L.ai.resist_grabs = FALSE
					L.ai.set_move_objective(L2,TRUE)

	return ..()