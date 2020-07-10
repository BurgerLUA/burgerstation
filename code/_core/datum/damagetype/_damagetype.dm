/damagetype/
	var/name = "Damage type."
	var/list/attack_verbs = list("strike","hit","pummel") //Verbs to use
	var/list/miss_verbs = list("swing")
	var/weapon_name
	var/impact_sounds = list(
		'sound/weapons/fists/punch1.ogg',
		'sound/weapons/fists/punch2.ogg',
		'sound/weapons/fists/punch3.ogg',
		'sound/weapons/fists/punch4.ogg'
	)

	var/miss_sounds = list(
		'sound/weapons/fists/punchmiss.ogg'
	)

	var/impact_sounds_flesh = list() //Leave empty to just use impact sounds, no matter what.

	var/allow_parry = TRUE
	var/allow_miss = TRUE
	var/allow_block = TRUE
	var/allow_dodge = TRUE

	var/stealthy = FALSE //Set to true to not display any damage dealt as well as not to alert any NPCs when hit.

	var/attack_delay_mod = 1

	var/block_coefficient = 0.25 //The block co-efficient. High values means it penetrates armor easier.

	var/obj/effect/temp/impact/combat/hit_effect = /obj/effect/temp/impact/combat/smash

	var/draw_blood = FALSE //This weapon can cause bleed.
	var/draw_weapon = FALSE //This should display the weapon attack animation when it does damage.

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


	//Skill modifiers from 0 to 100.
	var/list/attribute_stats = list()

	var/list/attribute_damage = list()

	var/list/skill_stats = list()

	var/list/skill_damage = list()

	var/list/bonus_experience = list()

	var/use_blamed_stats = FALSE

	var/throw_mul = 1

	var/crit_multiplier = 2 //Damage multiplier.
	var/crit_chance = 5 //Base crit chance.
	var/crit_chance_max = 10 //Maximium crit chance at 100 luck.

	var/falloff = 0 //How many tiles it takes for the weapon to start loosing damage. Set to 0 to disable. Applys to projectile weapons only.

	var/allow_friendly_fire = FALSE

	var/cqc_tag

	var/fatigue_coefficient = 0.25 //What percentage of blocked damage to convert into fatigue damage. 1 means 100%, 0.25 means 25%, ect...

/damagetype/proc/get_examine_text(var/mob/caller)
	/*
	. = "<table>"
	. += "<tr><th>Damage type</th><th>Damage value</th><th>Skill modifier</th></tr>"
	for(var/damage_type in attack_damage_base)
		var/damage_value = attack_damage_base[damage_type]
		. += "<tr><td>[damage_type]</td><td>[damage_value]</td><td>Penis</td></tr>"
	. += "</table>"
	*/

	return list()

/damagetype/proc/get_crit_chance(var/mob/living/L)
	return crit_chance + (crit_chance_max - crit_chance)*(L.get_skill_power(SKILL_PRECISION)*0.75 + (L.get_attribute_power(ATTRIBUTE_LUCK) - 0.5)*0.25)

/damagetype/proc/get_combat_rating(var/mob/living/L)

	var/combat_rating = 0

	var/list/attack_damage = get_attack_damage(L)

	for(var/damage_type in attack_damage)
		var/damage = attack_damage[damage_type]
		combat_rating += damage

	if(!allow_parry)
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

/damagetype/proc/perform_miss(var/atom/attacker,var/atom/victim,var/atom/weapon)
	do_attack_animation(attacker,victim,weapon,null)
	do_miss_sound(attacker,victim,weapon)
	display_miss_message(attacker,victim,weapon,null,"missed")
	return TRUE

/damagetype/proc/do_critical_hit(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/list/damage_to_deal)

	/*
	var/best_damage_type = null
	var/best_damage_type_amount = 0

	for(var/damage_type in damage_to_deal)
		var/damage_amount = damage_to_deal[damage_type]
		if(!best_damage_type || damage_amount > best_damage_type_amount)
			best_damage_type = damage_type
			best_damage_type_amount = damage_amount
	*/

	return crit_multiplier

/damagetype/proc/get_attack_damage(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/damage_multiplier=1)

	if(!is_living(attacker))
		return attack_damage_base.Copy()

	var/mob/living/L = attacker
	var/list/new_attack_damage = attack_damage_base.Copy()

	for(var/attribute in attribute_stats)
		var/class = attribute_stats[attribute]
		if(!islist(attribute_damage[attribute]))
			new_attack_damage[attribute_damage[attribute]] += L.get_attribute_level(attribute) * class * 0.01
		else
			for(var/att in attribute_damage[attribute])
				new_attack_damage[att] += L.get_attribute_level(attribute) * class * 0.01 * (1/length(attribute_damage[attribute]))

	for(var/skill in skill_stats)
		var/class = skill_stats[skill]
		if(!islist(skill_damage[skill]))
			new_attack_damage[skill_damage[skill]] += L.get_skill_level(skill) * class * 0.01
		else
			for(var/ski in skill_damage[skill])
				new_attack_damage[ski] += L.get_skill_level(skill) * class * 0.01 * (1/length(skill_damage[skill]))

	for(var/k in new_attack_damage)
		new_attack_damage[k] *= hit_object.health.damage_multiplier*damage_multiplier
		new_attack_damage[k] *= RAND_PRECISE(1,1.1)

	return new_attack_damage

/damagetype/proc/get_critical_hit_condition(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)

	if(!attacker.is_player_controlled())
		return FALSE

	if(ismovable(victim))
		var/atom/movable/M = victim
		if(M.grabbing_hand)
			var/obj/hud/inventory/I = M.grabbing_hand
			if(I.owner == attacker)
				return TRUE

	if(is_living(victim))
		var/mob/living/L = victim
		if(L.ai && L.ai.alert_level <= ALERT_LEVEL_NOISE)
			return TRUE

	var/crit_chance = get_crit_chance(attacker)

	return luck(list(attacker,weapon),crit_chance)


//atom/proc/defer_victim(var/atom/attacker,var/atom/weapon,var/atom/hit_object,var/atom/blamed)

//atom/proc/defer_hit_object(var/atom/attacker,var/atom/weapon,var/atom/hit_object,var/atom/blamed)

/damagetype/proc/do_damage(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/damage_multiplier=1)

	spawn

		if(istype(victim,/mob/living/advanced/stand/))
			var/mob/living/advanced/stand/S = victim
			victim = S.owner
			if(is_organ(hit_object) && is_advanced(victim))
				var/mob/living/advanced/A = victim
				var/obj/item/organ/O = hit_object
				if(A.labeled_organs[O.id])
					hit_object = A.labeled_organs[O.id]

		if(!attacker || !victim || !weapon || !hit_object || !hit_object.health || !victim.health)
			return FALSE

		if(is_living(victim))
			var/mob/living/L = victim
			damage_multiplier *= L.damage_received_multiplier

		var/list/damage_to_deal = get_attack_damage(use_blamed_stats ? blamed : attacker,victim,weapon,hit_object,damage_multiplier)
		var/list/damage_to_deal_main = list(BRUTE=0,BURN=0,TOX=0,OXY=0,FATIGUE=0)
		var/critical_hit_multiplier = get_critical_hit_condition(attacker,victim,weapon,hit_object) ? do_critical_hit(attacker,victim,weapon,hit_object,damage_to_deal) : 1
		var/fatigue_damage = 0

		var/damage_blocked = 0
		var/defense_rating_victim = victim.health.get_defense(attacker,hit_object)
		var/defense_rating_attacker = list()
		if(attacker.health)
			defense_rating_attacker = attacker.health.get_defense(attacker,hit_object)

		for(var/damage_type in damage_to_deal)
			CHECK_TICK
			var/victim_defense = defense_rating_victim[damage_type]
			if(victim_defense >= INFINITY) //Defense is infinite. No point of doing damage.
				damage_to_deal[damage_type] = 0
				continue
			if(victim_defense > 0) //Penetrate armor only if it exists.
				victim_defense = max(0,victim_defense - attack_damage_penetration[damage_type])
			if((damage_type == MAGIC || damage_type == HOLY || damage_type == DARK) && defense_rating_attacker[damage_type]) //Deal bonus damage.
				if(defense_rating_attacker[damage_type] == INFINITY)
					damage_to_deal[damage_type] = 0
					continue
				damage_to_deal[damage_type] = calculate_damage_with_armor(damage_to_deal[damage_type],-defense_rating_attacker[damage_type])
			var/old_damage_amount = damage_to_deal[damage_type] * critical_hit_multiplier
			var/new_damage_amount = calculate_damage_with_armor(old_damage_amount,victim_defense)
			damage_blocked += max(0,old_damage_amount - new_damage_amount)
			damage_to_deal[damage_type] = CEILING(max(0,new_damage_amount),1)
			if(damage_type == BLUNT || damage_type == BLADE || damage_type == PIERCE)
				fatigue_damage += damage_blocked*src.fatigue_coefficient

		if(!length(defense_rating_victim) || !defense_rating_victim[FATIGUE] || defense_rating_victim[FATIGUE] != INFINITY)
			damage_to_deal[FATIGUE] += FLOOR(fatigue_damage,1)

		for(var/damage_type in damage_to_deal)
			CHECK_TICK
			var/damage_amount = damage_to_deal[damage_type]
			var/real_damage_type = attack_damage_conversion[damage_type]
			damage_to_deal_main[real_damage_type] += damage_amount

		do_attack_animation(attacker,victim,weapon,hit_object,critical_hit_multiplier > 1)

		var/total_damage_dealt = 0
		if(victim.immortal || hit_object.immortal)
			for(var/damage_type in damage_to_deal_main)
				CHECK_TICK
				if(damage_type == FATIGUE)
					continue
				total_damage_dealt += damage_to_deal_main[damage_type]
		else
			if(hit_object.health)
				hit_object.health.adjust_fatigue_loss(damage_to_deal_main[FATIGUE])
				total_damage_dealt += hit_object.health.adjust_loss_smart(brute=damage_to_deal_main[BRUTE],burn=damage_to_deal_main[BURN],tox=damage_to_deal_main[TOX],oxy=damage_to_deal_main[OXY],update=FALSE)
			else
				CRASH_SAFE("ERROR: Tried dealing damage to object [hit_object], but it had no health!")
				return TRUE

		do_attack_visuals(attacker,victim,weapon,hit_object,total_damage_dealt)
		do_attack_sound(attacker,victim,weapon,hit_object)

		if(is_living(victim))
			var/mob/living/L = victim
			L.to_chat(span("warning","Took <b>[round(total_damage_dealt,0.1)]</b> damage to [hit_object == victim ? "yourself" : "your [hit_object.name]"] by \the [attacker == weapon ? "[attacker.name]\s attack" : "[attacker.name]\s [weapon.name]"] (<b>[max(0,victim.health.health_current - total_damage_dealt)]/[victim.health.health_max]</b>)."),CHAT_TYPE_COMBAT)

		if(is_living(blamed) && victim.health && blamed != victim) //TODO: Seperate log for blamed.
			var/mob/living/L = blamed
			L.to_chat(span("notice","Dealt <b>[round(total_damage_dealt,0.1)]</b> damage with your [weapon.name] to \the [victim == hit_object ? victim.name : "[victim.name]\s [hit_object.name]"] (<b>[max(0,victim.health.health_current - total_damage_dealt)]/[victim.health.health_max]</b>)."),CHAT_TYPE_COMBAT)

		if(!total_damage_dealt)
			display_glance_message(attacker,victim,weapon,hit_object)
		else
			display_hit_message(attacker,victim,weapon,hit_object)
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

			if(is_living(victim) && is_living(attacker) && attacker != victim && total_damage_dealt)
				var/mob/living/A = attacker
				var/mob/living/V = victim
				if(!V.dead && A.is_player_controlled())
					var/experience_multiplier = victim.get_xp_multiplier()
					if(critical_hit_multiplier > 1)
						var/xp_to_give = CEILING((total_damage_dealt*experience_multiplier)/critical_hit_multiplier,1)
						if(xp_to_give > 0)
							A.add_skill_xp(SKILL_PRECISION,xp_to_give)

					for(var/skill in skill_stats)
						CHECK_TICK
						var/xp_to_give = CEILING(skill_stats[skill] * 0.01 * total_damage_dealt * experience_multiplier, 1)
						if(xp_to_give > 0)
							A.add_skill_xp(skill,xp_to_give)

					for(var/attribute in attribute_stats)
						CHECK_TICK
						var/xp_to_give = CEILING(attribute_stats[attribute] * 0.01 * total_damage_dealt * experience_multiplier, 1)
						if(xp_to_give > 0)
							A.add_attribute_xp(attribute,xp_to_give)

					for(var/skill in bonus_experience)
						CHECK_TICK
						var/xp_to_give = CEILING(bonus_experience[skill] * 0.01 * total_damage_dealt * experience_multiplier,1)
						if(xp_to_give > 0)
							A.add_skill_xp(skill,xp_to_give)


		src.post_on_hit(attacker,victim,weapon,hit_object,blamed,total_damage_dealt)

		victim.on_damage_received(hit_object,attacker,weapon,damage_to_deal,total_damage_dealt,critical_hit_multiplier,stealthy)
		if(victim != hit_object)
			hit_object.on_damage_received(hit_object,attacker,weapon,damage_to_deal,total_damage_dealt,critical_hit_multiplier,stealthy)

	return TRUE

/damagetype/proc/post_on_hit(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/total_damage_dealt=0)
	return TRUE

/damagetype/proc/do_attack_visuals(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/damage_dealt)

	if(hit_effect)
		new hit_effect(get_turf(victim))

	hit_object.do_impact_effect(attacker,weapon,src,damage_dealt)

	if(victim.health && victim.health.health_max && ismovable(victim))
		var/atom/movable/A = victim
		if(A.anchored)
			return

		var/multiplier = TILE_SIZE * (damage_dealt / victim.health.health_max) * 2
		multiplier = clamp(multiplier,0,TILE_SIZE*0.25)

		var/attack_direction = get_dir(attacker,victim)
		var/list/offsets = direction_to_pixel_offset(attack_direction)

		if(ismob(victim))
			var/mob/M = victim
			if(M.client)
				M.client.desired_punch_x += offsets[1]*multiplier
				M.client.desired_punch_y += offsets[2]*multiplier

		else if(victim.health.health_current - damage_dealt <= 0)
			if(victim.pixel_x == initial(victim.pixel_x) && victim.pixel_y == initial(victim.pixel_y))
				animate(victim, pixel_x = initial(victim.pixel_x) + offsets[1]*multiplier, pixel_y = initial(victim.pixel_y) + offsets[2]*multiplier,time=2)
		else
			animate(victim, pixel_x = initial(victim.pixel_x) + offsets[1]*multiplier, pixel_y = initial(victim.pixel_y) + offsets[2]*multiplier,time=1)
			animate(pixel_x = initial(victim.pixel_x), pixel_y = initial(victim.pixel_y), time = 5)

/damagetype/proc/do_attack_sound(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)

	if(is_living(victim) && length(impact_sounds_flesh))
		play(pick(impact_sounds_flesh),get_turf(hit_object))

	if(length(impact_sounds))
		play(pick(impact_sounds),get_turf(hit_object))

	create_alert(VIEW_RANGE,victim,attacker,ALERT_LEVEL_CAUTION)

	return TRUE

/damagetype/proc/do_miss_sound(var/atom/attacker,var/atom/victim,var/atom/weapon)
	if(length(miss_sounds))
		play(pick(miss_sounds),get_turf(victim))
		create_alert(VIEW_RANGE,victim,attacker,ALERT_LEVEL_NOISE)

/damagetype/proc/do_attack_animation(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/was_critical_hit)

	var/caller_attack_delay = attacker.attack_next - world.time
	var/weapon_attack_delay = weapon ? weapon.attack_next - world.time : attacker ? caller_attack_delay : ATTACK_ANIMATION_LENGTH * 2

	if(draw_weapon)
		new /obj/effect/temp/impact/weapon_clone(get_turf(attacker),FLOOR(weapon_attack_delay*0.25,1),victim,attacker,weapon)

	var/punch_distance = 12
	var/list/pixel_offset = direction_to_pixel_offset(get_dir(attacker,victim))

	if(is_living(attacker))
		var/mob/living/L = attacker
		var/matrix/attack_matrix = matrix()
		if(L.horizontal)
			attack_matrix = turn(attack_matrix,L.stun_angle)

		attack_matrix.Translate(pixel_offset[1]*punch_distance,pixel_offset[2]*punch_distance)

		animate(L, transform = attack_matrix, time = FLOOR(weapon_attack_delay*0.125,1), flags = ANIMATION_LINEAR_TRANSFORM)

		if(L.horizontal)
			animate(transform = turn(matrix(), L.stun_angle), time = FLOOR(caller_attack_delay*0.9,1), flags = ANIMATION_LINEAR_TRANSFORM)
		else
			animate(transform = matrix(), time = FLOOR(caller_attack_delay*0.9,1), flags = ANIMATION_LINEAR_TRANSFORM)

	sleep(CEILING(weapon_attack_delay*0.125,1))

/damagetype/proc/get_block_power_penetration(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	return 0

/damagetype/proc/get_weapon_name(var/atom/backup)
	if(weapon_name)
		return weapon_name
	if(backup)
		return backup.name
	return "weapon"

/damagetype/proc/get_attack_message_3rd(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)

	var/victim_text
	var/attacker_text

	if(hit_object && hit_object != victim)
		victim_text = "\the [victim.name]'s [hit_object.name]"
	else
		victim_text = "\the [victim.name]"

	if(weapon && attacker != weapon)
		attacker_text = " with \the [weapon.name]."
	else
		attacker_text = "."

	return "\The [attacker.name] [pick(attack_verbs)]s [victim_text][attacker_text]"

/damagetype/proc/get_attack_message_1st(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)

	var/victim_text
	var/attacker_text

	if(hit_object && hit_object != victim)
		victim_text = "\the [victim.name]'s [hit_object.name]"
	else
		victim_text = "\the [victim.name]"

	if(weapon && attacker != weapon)
		attacker_text = " with your [weapon.name]."
	else
		attacker_text = "."

	return "You [pick(attack_verbs)] [victim_text][attacker_text]"

/damagetype/proc/get_attack_message_sound(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	return "You hear a strong [pick(attack_verbs)]."

/damagetype/proc/get_miss_message_3rd(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	return "[copytext(get_attack_message_3rd(attacker,victim,weapon,hit_object),1,-1)], but the attack was #REASON!"

/damagetype/proc/get_miss_message_1st(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	return "[copytext(get_attack_message_1st(attacker,victim,weapon,hit_object),1,-1)], but the attack was #REASON!"

/damagetype/proc/get_miss_message_sound(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	return "You hear a swoosh..."

/damagetype/proc/get_glance_message_sound(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	return "You hear a weak [pick(attack_verbs)]."

/damagetype/proc/get_glance_message_3rd(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	return "[copytext(get_attack_message_3rd(attacker,victim,weapon,hit_object),1,-1)]... but it has no effect!"

/damagetype/proc/get_glance_message_1st(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	return "[copytext(get_attack_message_1st(attacker,victim,weapon,hit_object),1,-1)]... but it has no effect!"

/damagetype/proc/display_glance_message(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)

	if(!ENABLE_HIT_MESSAGES)
		return FALSE

	attacker.visible_message(\
		span("warning",get_glance_message_3rd(attacker,victim,weapon,hit_object)),\
		span("warning",get_glance_message_1st(attacker,victim,weapon,hit_object)),\
		span("warning",get_glance_message_sound(attacker,victim,weapon,hit_object))\
	)
	return TRUE

/damagetype/proc/display_hit_message(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)

	if(!ENABLE_HIT_MESSAGES)
		return FALSE

	attacker.visible_message(\
		span("warning", get_attack_message_3rd(attacker,victim,weapon,hit_object)),\
		span("danger",  get_attack_message_1st(attacker,victim,weapon,hit_object)),\
		span("warning", get_attack_message_sound(attacker,victim,weapon,hit_object))\
	)
	return TRUE

/damagetype/proc/display_miss_message(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/miss_text = "misses!")

	if(!ENABLE_HIT_MESSAGES)
		return FALSE

	attacker.visible_message(\
		span("warning", replacetext(get_miss_message_3rd(attacker,victim,weapon,hit_object),"#REASON",miss_text)),\
		span("danger",  replacetext(get_miss_message_1st(attacker,victim,weapon,hit_object),"#REASON",miss_text)),\
		span("warning", replacetext(get_miss_message_sound(attacker,victim,weapon,hit_object),"#REASON",miss_text))\
	)
	return TRUE
