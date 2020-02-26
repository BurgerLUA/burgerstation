/atom/proc/get_attack_delay(var/mob/user)

	if(is_living(user))
		var/mob/living/L = user
		return attack_delay + (attack_delay_max - attack_delay)*(1-L.get_attribute_power(ATTRIBUTE_DEXTERITY))

	return attack_delay

/atom/proc/on_damage_received(var/atom/atom_damaged,var/atom/attacker,var/list/damage_table,var/damage_amount)

	if(health)
		health.update_health(damage_amount,attacker)

	return TRUE

/atom/proc/change_victim(var/atom/attacker)
	return src

/atom/proc/help(var/atom/caller,var/atom/object,var/list/params=list()) //The src attacks the victim, with the blamed taking responsibility
	return FALSE

/atom/proc/attack(var/atom/attacker,var/atom/victim,var/list/params=list(),var/atom/blamed,var/ignore_distance = FALSE) //The src attacks the victim, with the blamed taking responsibility

	if(!attacker)
		attacker = src

	if(!blamed)
		blamed = attacker

	if(!length(params))
		params = list()

	victim = victim.change_victim(attacker)

	if(attacker && victim && attacker != victim && !ignore_distance)
		attacker.face_atom(victim)

	if(attacker && victim && is_living(attacker))
		var/mob/living/L = attacker
		if(L.intent == INTENT_HELP && src.help(attacker,victim,params))
			return TRUE

	if(is_player(attacker))
		var/mob/living/advanced/player/P = attacker
		if(P.client)
			var/click_flags = P.client.get_click_flags(params,TRUE)

			var/attack_x = 16
			var/attack_y = 16

			if(click_flags & CLICK_LEFT)
				attack_x = P.attack_left[P.attack_mode][1]
				attack_y = P.attack_left[P.attack_mode][2]
			else if(click_flags & CLICK_RIGHT)
				attack_x = P.attack_right[P.attack_mode][1]
				attack_y = P.attack_right[P.attack_mode][2]

			params[PARAM_ICON_X] = num2text(attack_x)
			params[PARAM_ICON_Y] = num2text(attack_y)

	var/atom/object_to_damage_with = get_object_to_damage_with(attacker,victim,params)
	var/atom/object_to_damage = victim.get_object_to_damage(attacker,params)

	if(!object_to_damage || !object_to_damage_with)
		if(ismob(blamed))
			var/mob/M = blamed
			M.to_chat(span("notice","You can't attack that!"))
		return FALSE

	if(!attacker.can_attack(victim,object_to_damage_with,params))
		return FALSE

	if(!ignore_distance && get_dist_advanced(attacker,victim) > object_to_damage_with.attack_range)
		return FALSE

	var/damagetype/DT = all_damage_types[object_to_damage_with.damage_type]

	if(!DT)
		LOG_ERROR("[attacker] can't inflict harm with the [object_to_damage_with.type] due to the damage type [object_to_damage_with.damage_type] not existing!")
		return FALSE

	attacker.attack_last = world.time

	if(attacker != object_to_damage_with)
		object_to_damage_with.attack_last = world.time

	if(DT.perform_miss(blamed,victim,object_to_damage_with,object_to_damage)) return FALSE
	if(victim.perform_block(blamed,object_to_damage_with,object_to_damage,DT)) return FALSE
	if(victim.perform_parry(blamed,object_to_damage_with,object_to_damage,DT,DT.allow_parry_counter)) return FALSE
	if(victim.perform_dodge(blamed,object_to_damage_with,object_to_damage,DT)) return FALSE

	DT.do_damage(attacker,victim,object_to_damage_with,object_to_damage,attacker)

	return TRUE

/atom/proc/get_object_to_damage(var/atom/attacker,params) //Which object should the attacker damage?
	return src

/atom/proc/get_object_to_damage_with(var/atom/attacker,var/atom/victim,params) //Which object should the attacker damage with?
	return src

/atom/proc/can_attack(var/atom/victim,var/atom/weapon,var/params)

	if(!mouse_opacity)
		return FALSE

	if(victim && is_valid(victim) && is_living(victim))

		var/area/A1 = get_area(victim)
		var/area/A2 = get_area(src)

		if(A1.flags_area & FLAGS_AREA_NO_DAMAGE != A2.flags_area & FLAGS_AREA_NO_DAMAGE)
			return FALSE

	if(attack_last + get_attack_delay(src) > world.time)
		return FALSE

	if(weapon && weapon.attack_last + weapon.get_attack_delay(src) > world.time)
		return FALSE

	if(victim && !victim.can_be_attacked(src,weapon,params))
		return FALSE

	return TRUE

/atom/proc/get_parry_chance(var/atom/attacker,var/atom/weapon,var/atom/target)
	return 0

/atom/proc/get_miss_chance(var/atom/attacker,var/atom/weapon,var/atom/target) //Chance that hitting this atom is a miss.
	return 0

/atom/proc/get_dodge_chance(var/atom/attacker,var/atom/weapon,var/atom/target,var/damagetype/DT)
	return 0

/atom/proc/get_block_chance(var/atom/attacker,var/atom/weapon,var/atom/target,var/damagetype/DT)
	return 0

/atom/proc/perform_block(var/atom/attacker,var/atom/weapon,var/atom/target,var/damagetype/DT)
	if(attacker == src)
		return FALSE
	var/base_chance = get_block_chance(attacker,weapon,target,DT) * DT.block_chance_mul
	if(!prob(base_chance))
		return FALSE
	DT.do_attack_animation(attacker,src,weapon,target)
	DT.display_miss_message(attacker,src,weapon,target,"blocked")
	new/obj/effect/temp/impact/combat/block(get_turf(target))

	if(is_living(attacker))
		var/mob/living/L = attacker
		L.to_chat(span("notice","\The [src.name] blocks your attack!"),CHAT_TYPE_COMBAT)

	if(is_living(src)) //YES, I KNOW
		var/mob/living/L = src
		L.to_chat(span("warning","You block \the [attacker.name]'s [weapon == attacker ? "attack" : weapon.name]!"),CHAT_TYPE_COMBAT)

	return TRUE

/atom/proc/perform_parry(var/atom/attacker,var/atom/weapon,var/atom/target,var/damagetype/DT,var/allow_parry_counter)
	if(attacker == src)
		return FALSE
	var/base_chance = get_parry_chance(attacker,weapon,target) * DT.parry_chance_mul
	if(!prob(base_chance))
		return FALSE
	DT.do_attack_animation(attacker,src,weapon,target)
	DT.display_miss_message(attacker,src,weapon,target,"parried")

	if(is_living(attacker))
		var/mob/living/L = attacker
		L.to_chat(span("notice","\The [src.name] parries your attack!"),CHAT_TYPE_COMBAT)

	if(is_living(src)) //YES, I KNOW
		var/mob/living/L = src
		L.to_chat(span("warning","You parry \the [attacker.name]'s [weapon == attacker ? "attack" : weapon.name]!"),CHAT_TYPE_COMBAT)

	if(allow_parry_counter)
		src.attack(src,attacker)

	return TRUE

/atom/proc/perform_dodge(var/atom/attacker,var/atom/weapon,var/atom/target,var/damagetype/DT)
	if(attacker == src)
		return FALSE
	var/base_chance = get_dodge_chance(attacker,weapon,target,DT) * DT.dodge_chance_mul
	if(!prob(base_chance))
		return FALSE
	DT.do_attack_animation(attacker,src,weapon,target)
	DT.display_miss_message(attacker,src,weapon,target,"dodged")

	if(is_living(attacker))
		var/mob/living/L = attacker
		L.to_chat(span("notice","\The [src.name] dodges your attack!"),CHAT_TYPE_COMBAT)

	if(is_living(src)) //YES, I KNOW
		var/mob/living/L = src
		L.to_chat(span("warning","You dodge \the [attacker.name]'s [weapon == attacker ? "attack" : weapon.name]!"),CHAT_TYPE_COMBAT)

	return TRUE