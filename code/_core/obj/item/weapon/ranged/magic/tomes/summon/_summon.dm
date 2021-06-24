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

	var/turf/T = get_turf(hit_atom)
	if(!T.is_safe_teleport())
		return ..()

	var/atom/movable/summoned_object = new object_to_summon(P.previous_loc)
	if(is_living(P.owner))
		var/mob/living/L2 = P.owner
		if(is_living(summoned_object))
			if(L2.minion)
				L2.minion.dust()
			var/mob/living/L = summoned_object
			L.class = /class/
			L.health_base = 100
			L.stamina_base = 100
			L.mana_base = 100
			L.set_iff_tag(L2.iff_tag)
			L.set_loyalty_tag(L2.loyalty_tag)
			L.master = L2
			L.minion_remove_time = world.time + duration
			L.level = min(L2.level,L2.get_skill_power(SKILL_MAGIC_DEFENSIVE,1,100,200) * (cost_mana/100))
			L.status_immune[DISARM] = TRUE
			L2.minion = L
		if(L2.is_player_controlled())
			L2.add_skill_xp(SKILL_MAGIC_DEFENSIVE,cost_mana*1.5)
	INITIALIZE(summoned_object)
	GENERATE(summoned_object)
	FINALIZE(summoned_object)

	if(summoned_object)
		summoned_object.Move(T)
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
					if(istype(L.ai,/ai/advanced/))
						var/ai/advanced/AI = L.ai
						AI.should_find_weapon = FALSE
						AI.checked_weapons = FALSE

	return ..()