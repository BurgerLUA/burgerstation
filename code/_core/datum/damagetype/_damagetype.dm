/damagetype/
	var/name = "Damage type."
	var/id = null

	var/list/attack_verbs = list("strike","hit","pummel") //Verbs to use
	var/list/miss_verbs = list("swing")
	var/weapon_name
	var/impact_sounds = list(
		'sounds/weapons/fists/punch1.ogg',
		'sounds/weapons/fists/punch2.ogg',
		'sounds/weapons/fists/punch3.ogg',
		'sounds/weapons/fists/punch4.ogg'
	)

	var/miss_sounds = list(
		'sounds/weapons/fists/punchmiss.ogg'
	)

	var/allow_parry = TRUE
	var/allow_parry_counter = TRUE
	var/allow_miss = TRUE
	var/allow_block = TRUE
	var/allow_dodge = TRUE

	var/obj/effect/temp/impact/combat/hit_effect = /obj/effect/temp/impact/combat/smash

	var/draw_blood = FALSE
	var/draw_weapon = FALSE

	var/dodge_chance_mul = 1 //Higher values means more likely to block.
	var/block_chance_mul = 1
	var/parry_chance_mul = 1

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	var/list/attack_damage_base = list(
		BLADE = 0,
		BLUNT = 0,
		PIERCE = 0,
		LASER = 0,
		MAGIC = 0,
		HEAT = 0,
		COLD = 0,
		BOMB = 0,
		BIO = 0,
		RAD = 0,
		HOLY = 0,
		DARK = 0,
		FATIGUE = 0
	)

	//The damage conversion table of the weapon. Useful for when you want blade attacks to deal holy damage or something.
	var/list/attack_damage_conversion = list(
		BLADE = BRUTE,
		BLUNT = BRUTE,
		PIERCE = BRUTE,
		LASER = BURN,
		MAGIC = BURN,
		HEAT = BURN,
		COLD = BURN,
		BOMB = BRUTE,
		BIO = TOX,
		RAD = TOX,
		HOLY = BURN,
		DARK = BURN,
		FATIGUE = FATIGUE
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	var/list/attack_damage_penetration = list(
		BLADE = 0,
		BLUNT = 0,
		PIERCE = 0,
		LASER = 0,
		MAGIC = 0,
		HEAT = 0,
		COLD = 0,
		BOMB = 0,
		BIO = 0,
		RAD = 0,
		HOLY = 0,
		DARK = 0,
		FATIGUE = 0
	)


	var/list/attribute_stats = list(
		ATTRIBUTE_STRENGTH = CLASS_F,
		ATTRIBUTE_DEXTERITY = CLASS_F,
		ATTRIBUTE_INTELLIGENCE = CLASS_F
	)

	var/list/attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLADE,
		ATTRIBUTE_DEXTERITY = BLADE,
		ATTRIBUTE_INTELLIGENCE = BLADE
	)

	var/list/skill_stats = list(
		SKILL_UNARMED = CLASS_F,
		SKILL_MELEE = CLASS_F,
		SKILL_RANGED = CLASS_F
	)

	var/list/skill_damage = list(
		SKILL_UNARMED = BLADE,
		SKILL_MELEE = BLADE,
		SKILL_RANGED = BLADE
	)

	var/list/skill_xp_per_damage = list(
		SKILL_UNARMED = 0,
		SKILL_MELEE = 0,
		SKILL_RANGED = 0
	)

	var/use_blamed_stats = FALSE

	var/throw_mul = 1

	var/crit_multiplier = 2
	var/crit_chance = 5
	var/crit_chance_max = 10

	/*
	var/list/wound_types = list(
		/wound/bruise/ = 1,
	)
	*/

/damagetype/proc/get_crit_chance(var/mob/living/L)
	return crit_chance + (crit_chance_max - crit_chance)*(L.get_skill_power(SKILL_PRECISION) + L.get_attribute_power(ATTRIBUTE_LUCK) - 0.5)

/damagetype/proc/get_combat_rating(var/mob/living/L)

	var/combat_rating = 0

	var/list/attack_damage = get_attack_damage(L)

	for(var/damage_type in attack_damage)
		var/damage = attack_damage[damage_type]
		combat_rating += damage

	if(!allow_parry)
		combat_rating *= 1.1

	if(allow_parry_counter)
		combat_rating *= 1.1

	if(!allow_block)
		combat_rating *= 1.1

	if(!allow_dodge)
		combat_rating *= 1.1

	if(allow_miss)
		combat_rating *= (100-get_miss_chance())/100
	else
		combat_rating *= 1.1

	return round(combat_rating*0.25,1)

/damagetype/proc/get_miss_chance()
	return 0

/damagetype/proc/get_attack_type()
	return ATTACK_TYPE_MELEE

/damagetype/proc/perform_miss(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	if(!prob(victim.get_miss_chance(attacker,weapon,hit_object) + get_miss_chance()))
		return FALSE
	do_attack_animation(attacker,victim,weapon,hit_object)
	do_miss_sound(attacker,victim,weapon,hit_object)
	display_miss_message(attacker,victim,weapon,hit_object,"avoided")
	return TRUE

/damagetype/proc/do_critical_hit(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/list/damage_to_deal)

	var/best_damage_type = null
	var/best_damage_type_amount = 0

	for(var/damage_type in damage_to_deal)
		var/damage_amount = damage_to_deal[damage_type]
		if(!best_damage_type || damage_amount > best_damage_type_amount)
			best_damage_type = damage_type
			best_damage_type_amount = damage_amount

	hit_object.visible_message(span("danger","Critical hit!"))

	return crit_multiplier

/damagetype/proc/get_attack_damage(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/damage_multiplier=1)

	if(!is_living(attacker))
		return attack_damage_base

	var/mob/living/L = attacker
	var/list/new_attack_damage = attack_damage_base.Copy()

	for(var/attribute in attribute_stats)
		var/class = attribute_stats[attribute]
		new_attack_damage[attribute_damage[attribute]] += L.get_attribute_level(attribute) * class

	for(var/skill in skill_stats)
		var/class = skill_stats[skill]
		new_attack_damage[skill_damage[skill]] += L.get_skill_level(skill)* class

	for(var/k in new_attack_damage)
		new_attack_damage[k] *= hit_object.health.damage_multiplier*damage_multiplier

	return new_attack_damage

/damagetype/proc/display_hit_message(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)

	attacker.visible_message(\
		get_attack_message_3rd(attacker,victim,weapon,hit_object),\
		get_attack_message_1st(attacker,victim,weapon,hit_object),\
		get_attack_message_sound(attacker,victim,weapon,hit_object)\
	)

/damagetype/proc/display_miss_message(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/miss_text = "misses!")

	attacker.visible_message(\
		replacetext(get_miss_message_3rd(attacker,victim,weapon,hit_object),"#REASON",miss_text),\
		replacetext(get_miss_message_1st(attacker,victim,weapon,hit_object),"#REASON",miss_text),\
		replacetext(get_miss_message_sound(attacker,victim,weapon,hit_object),"#REASON",miss_text)\
	)

/damagetype/proc/get_critical_hit_condition(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	return is_living(attacker) && prob(get_crit_chance(attacker))

/damagetype/proc/do_damage(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/damage_multiplier=1)

	spawn()

		if(!attacker || !victim || !weapon || !hit_object)
			return FALSE

		if(!hit_object.health || !victim.health)
			return FALSE

		var/list/damage_to_deal = get_attack_damage(use_blamed_stats ? blamed : attacker,victim,weapon,hit_object,damage_multiplier)

		var/damage_blocked = 0

		var/defense_rating_victim = victim.health.get_defense(attacker,hit_object)

		for(var/damage_type in damage_to_deal)

			var/victim_defense = defense_rating_victim[damage_type]
			if(victim_defense > 0)
				victim_defense = max(0,victim_defense - attack_damage_penetration[damage_type])

			var/old_damage_amount = damage_to_deal[damage_type]
			var/new_damage_amount = calculate_armor(old_damage_amount,victim_defense)

			damage_blocked += max(0,old_damage_amount - new_damage_amount)
			damage_to_deal[damage_type] = new_damage_amount

		var/brute_damage_to_deal = 0
		var/burn_damage_to_deal = 0
		var/tox_damage_to_deal = 0
		var/oxy_damage_to_deal = 0
		var/fatigue_damage_to_deal = 0

		for(var/damage_type in damage_to_deal)
			var/damage_amount = damage_to_deal[damage_type]
			var/real_damage_type = attack_damage_conversion[damage_type]
			switch(real_damage_type)
				if(BRUTE)
					brute_damage_to_deal += damage_amount
				if(BURN)
					burn_damage_to_deal += damage_amount
				if(TOX)
					tox_damage_to_deal += damage_amount
				if(OXY)
					oxy_damage_to_deal += damage_amount
				if(FATIGUE)
					fatigue_damage_to_deal += damage_amount

		var/is_crit = get_critical_hit_condition(attacker,victim,weapon,hit_object)
		if(is_crit)
			var/final_crit_multiplier = do_critical_hit(attacker,victim,weapon,hit_object,damage_to_deal)
			brute_damage_to_deal *= final_crit_multiplier
			burn_damage_to_deal *= final_crit_multiplier
			tox_damage_to_deal *= final_crit_multiplier
			oxy_damage_to_deal *= final_crit_multiplier
			fatigue_damage_to_deal *= final_crit_multiplier

		do_attack_animation(attacker,victim,weapon,hit_object,is_crit)

		if(!attacker || !victim || !weapon || !hit_object || !hit_object.health)
			return FALSE

		var/total_damage_dealt = 0

		if(victim.immortal || hit_object.immortal)
			total_damage_dealt += brute_damage_to_deal + burn_damage_to_deal + tox_damage_to_deal + oxy_damage_to_deal
		else
			hit_object.health.adjust_fatigue_loss(fatigue_damage_to_deal)
			total_damage_dealt += hit_object.health.adjust_loss_smart(brute=brute_damage_to_deal,burn=burn_damage_to_deal,tox=tox_damage_to_deal,oxy=oxy_damage_to_deal)

		if(!total_damage_dealt)
			display_glance_message(attacker,victim,weapon,hit_object)
			return total_damage_dealt

		do_attack_visuals(attacker,victim,weapon,hit_object,total_damage_dealt)
		do_attack_sound(attacker,victim,weapon,hit_object)
		display_hit_message(attacker,victim,weapon,hit_object)

		if(!victim || !victim.health)
			return TRUE

		if(is_living(victim))
			var/mob/living/L = victim
			L.to_chat(span("warning","Took <b>[round(total_damage_dealt,0.1)]</b> damage to [hit_object == victim ? "yourself" : "your [hit_object.name]"] by \the [attacker == weapon ? "[attacker.name]\s attack" : "[attacker.name]\s [weapon.name]"] (<b>[max(0,victim.health.health_current - total_damage_dealt)]/[victim.health.health_max]</b>)."),CHAT_TYPE_COMBAT)

		if(is_living(blamed) && victim.health.health_max && blamed != victim) //TODO: Seperate log for blamed.
			var/mob/living/L = blamed
			L.to_chat(span("notice","Dealt <b>[round(total_damage_dealt,0.1)]</b> damage with your [weapon.name] to \the [victim == hit_object ? victim.name : "[victim.name]\s [hit_object.name]"] (<b>[max(0,victim.health.health_current - total_damage_dealt)]/[victim.health.health_max]</b>)."),CHAT_TYPE_COMBAT)

		if(is_living(attacker) && attacker != victim)
			var/mob/living/A = attacker
			if(A.client)
				for(var/skill in skill_xp_per_damage)
					var/xp_to_give = floor(skill_xp_per_damage[skill] * total_damage_dealt * victim.get_xp_multiplier())
					if(xp_to_give > 0)
						A.add_skill_xp(skill,xp_to_give)

		if(is_player(blamed) && is_player(victim))
			var/mob/living/advanced/player/PA = blamed
			var/mob/living/advanced/player/PV = victim
			if(!PV.dead)
				var/victim_health_final = PV.health.get_overall_health()
				var/list/attack_log_format = list()
				attack_log_format["attacker"] = PA
				attack_log_format["attacker_ckey"] = PA.ckey
				attack_log_format["time"] = world.time
				attack_log_format["damage"] = total_damage_dealt
				attack_log_format["critical"] = victim_health_final - total_damage_dealt < 0
				attack_log_format["lethal"] = (victim_health_final - total_damage_dealt) <= min(-50,PV.health.health_max*-0.25)
				PV.attack_logs += list(attack_log_format)

		victim.on_damage_received(hit_object,attacker,damage_to_deal,total_damage_dealt)
		if(victim != hit_object)
			hit_object.on_damage_received(hit_object,attacker,damage_to_deal,total_damage_dealt)

		post_on_hit(attacker,victim,weapon,hit_object,blamed,total_damage_dealt)

	return TRUE

/damagetype/proc/post_on_hit(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/total_damage_dealt=0)
	return TRUE

/damagetype/proc/do_attack_visuals(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/damage_dealt)

	if(hit_effect)
		new hit_effect(get_turf(victim))

	hit_object.do_impact_effect(attacker,weapon,src,damage_dealt)

	if(victim.health && victim.health.health_max && is_movable(victim))
		var/atom/movable/A = victim
		if(A.anchored)
			return

		var/multiplier = TILE_SIZE * (damage_dealt / victim.health.health_max) * 2
		multiplier = Clamp(multiplier,0,TILE_SIZE*0.25)

		var/attack_direction = get_dir(attacker,victim)
		var/offset_x = 0
		var/offset_y = 0

		if(attack_direction & EAST)
			offset_x += 1
		if(attack_direction & WEST)
			offset_x -= 1
		if(attack_direction & NORTH)
			offset_y += 1
		if(attack_direction & SOUTH)
			offset_y -= 1

		if(is_player(victim))
			var/mob/living/advanced/player/P = victim
			if(P && P.client)
				var/client/C = P.client
				animate(C,pixel_x = offset_x*multiplier, pixel_y = offset_y*multiplier,time=1)
				animate(pixel_x = 0, pixel_y = 0, time = 5)

		else if(victim.health.health_current - damage_dealt <= 0)
			if(victim.pixel_x == initial(victim.pixel_x) && victim.pixel_y == initial(victim.pixel_y))
				animate(victim, pixel_x = initial(victim.pixel_x) + offset_x*multiplier, pixel_y = initial(victim.pixel_y) + offset_y*multiplier,time=2)
		else
			animate(victim, pixel_x = initial(victim.pixel_x) + offset_x*multiplier, pixel_y = initial(victim.pixel_y) + offset_y*multiplier,time=1)
			animate(pixel_x = initial(victim.pixel_x), pixel_y = initial(victim.pixel_y), time = 5)

/damagetype/proc/do_attack_sound(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	if(length(impact_sounds))
		var/area/A = get_area(victim)
		play_sound(pick(impact_sounds),all_mobs_with_clients,vector(victim.x,victim.y,victim.z),environment = A.sound_environment)

/damagetype/proc/do_miss_sound(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	if(length(miss_sounds))
		var/area/A = get_area(victim)
		play_sound(pick(miss_sounds),all_mobs_with_clients,vector(victim.x,victim.y,victim.z),environment = A.sound_environment)

/damagetype/proc/do_attack_animation(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/was_critical_hit)

	if(draw_weapon)
		var/obj/effect/temp/impact/weapon_clone/WC = new(get_turf(attacker))
		WC.appearance = weapon.appearance
		WC.mouse_opacity = 0
		WC.plane = initial(WC.plane)

		var/offset_x = get_offset_x(victim,attacker)
		var/offset_y = get_offset_y(victim,attacker)

		animate(WC,pixel_x = offset_x, pixel_y = offset_y,time = ATTACK_ANIMATION_LENGTH)

	var/pixel_x_offset = 0
	var/pixel_y_offset = 0
	var/punch_distance = 12

	if(attacker.dir & NORTH)
		pixel_y_offset += punch_distance

	if(attacker.dir & SOUTH)
		pixel_y_offset += -punch_distance

	if(attacker.dir & EAST)
		pixel_x_offset += punch_distance

	if(attacker.dir & WEST)
		pixel_x_offset += -punch_distance

	var/weapon_attack_delay = weapon && attacker ? weapon.get_attack_delay(attacker) : ATTACK_ANIMATION_LENGTH * 2

	if(is_living(attacker))
		var/mob/living/L = attacker
		//M.add_animation(pixel_x = movement_x, pixel_y = movement_y, time = 2)
		//M.add_animation(pixel_x = -movement_x, pixel_y = -movement_y, time = 4, delay = 2, time = 4)

		var/matrix/attack_matrix = matrix()

		if(L.horizontal)
			attack_matrix = turn(attack_matrix,L.stun_angle)

		attack_matrix.Translate(pixel_x_offset,pixel_y_offset)

		animate(L, transform = attack_matrix, time = ATTACK_ANIMATION_LENGTH, flags = ANIMATION_LINEAR_TRANSFORM)

		if(L.horizontal)
			animate(transform = turn(matrix(), L.stun_angle), time = weapon_attack_delay, flags = ANIMATION_LINEAR_TRANSFORM)
		else
			animate(transform = matrix(), time = weapon_attack_delay, flags = ANIMATION_LINEAR_TRANSFORM)

	sleep(ATTACK_ANIMATION_LENGTH)

/damagetype/proc/get_weapon_name(var/atom/backup)
	if(weapon_name)
		return weapon_name
	else
		return backup.name

/damagetype/proc/get_attack_message_3rd(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	if(victim == hit_object)
		return span("danger","\The [attacker.name] [pick(attack_verbs)]s \the [hit_object.name] with \the [get_weapon_name(weapon)].")
	else
		return span("danger","\The [attacker.name] [pick(attack_verbs)]s \the [victim.name]'s [hit_object.name] with \the [get_weapon_name(weapon)].")

/damagetype/proc/get_attack_message_1st(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	if(victim == hit_object)
		return span("warning","You [pick(attack_verbs)] \the [hit_object.name] with your [get_weapon_name(weapon)].")
	else
		return span("warning","You [pick(attack_verbs)] \the [victim.name]'s [hit_object.name] with your [get_weapon_name(weapon)].")

/damagetype/proc/get_attack_message_sound(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	return span("danger","You hear a sickening impact.")

/damagetype/proc/get_miss_message_3rd(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	if(victim == hit_object)
		return span("danger","\The [attacker.name] [pick(miss_verbs)]s at \the [hit_object.name] with \the [get_weapon_name(weapon)], but the attack was #REASON!")
	else
		return span("danger","\The [attacker.name] [pick(miss_verbs)]s at \the [victim.name]'s [hit_object.name] with \the [get_weapon_name(weapon)], but the attack was #REASON!")

/damagetype/proc/get_miss_message_1st(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	if(victim == hit_object)
		return span("warning","You [pick(miss_verbs)] at \the [hit_object.name] with your [get_weapon_name(weapon)], but the attack was #REASON!")
	else
		return span("warning","You [pick(miss_verbs)] at \the [victim.name]'s [hit_object.name] with your [get_weapon_name(weapon)], but the attack was #REASON!")

/damagetype/proc/get_miss_message_sound(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	return span("danger","You hear a swoosh...")

/damagetype/proc/get_glance_message_sound(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	return span("danger","You hear a leaf hitting metal...")

/damagetype/proc/get_glance_message_1st(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	if(victim == hit_object)
		return span("warning","You [pick(attack_verbs)] \the [hit_object.name] with your [get_weapon_name(weapon)]... but it has no effect!")
	else
		return span("warning","You [pick(attack_verbs)] \the [victim.name]'s [hit_object.name] with your [get_weapon_name(weapon)]... but it has no effect!")

/damagetype/proc/get_glance_message_3rd(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	if(victim == hit_object)
		return span("danger","\The [attacker.name] [pick(attack_verbs)]s \the [hit_object.name] with \the [get_weapon_name(weapon)]... but it has no effect!")
	else
		return span("danger","\The [attacker.name] [pick(attack_verbs)]s \the [victim.name]'s [hit_object.name] with \the [get_weapon_name(weapon)]... but it has no effect!")

/damagetype/proc/display_glance_message(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)

	attacker.visible_message(\
		get_glance_message_3rd(attacker,victim,weapon,hit_object),\
		get_glance_message_1st(attacker,victim,weapon,hit_object),\
		get_glance_message_sound(attacker,victim,weapon,hit_object)\
	)

/*
/damagetype/proc/do_wound(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/damage_dealt)

	if(damage_dealt <= 0)
		return FALSE

	if(!length(wound_types))
		return FALSE

	if(!victim || !is_advanced(victim) || !hit_object || !is_organ(hit_object) || !hit_object.health)
		return FALSE

	var/obj/item/organ/O = hit_object

	if(!O.enable_wounds)
		return FALSE

	var/wound/W = pickweight(wound_types)

	return new W(victim,hit_object,attacker,weapon,damage_dealt)
*/
