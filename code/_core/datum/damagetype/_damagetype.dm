/damagetype/
	var/name //TODO:REMOVE
	var/list/attack_verbs = list("strike","hit","pummel") //Verbs to use
	var/list/miss_verbs = list("swing")
	var/weapon_name
	var/swing_sounds = list(
		'sound/weapons/fists/swing.ogg'
	)
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

	var/stealthy = FALSE //Set to true to not display any damage dealt as well as not to alert any NPCs when hit.

	var/attack_delay_mod = 1

	var/block_coefficient = 0.25 //The block co-efficient. High values means it penetrates armor easier.

	var/obj/effect/temp/impact/combat/hit_effect = /obj/effect/temp/impact/combat/smash

	var/draw_blood = FALSE //This weapon causes blood visual effects.
	var/draw_weapon = FALSE //This should display the weapon attack animation when it does damage.

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	var/list/attack_damage_base = list()

	//The damage conversion table of the weapon. Useful for when you want blade attacks to deal holy damage or something.
	var/list/attack_damage_conversion = list(
		BLADE = BRUTE,
		BLUNT = BRUTE,
		PIERCE = BRUTE,
		LASER = BURN,
		ARCANE = BURN,
		HEAT = BURN,
		COLD = list(BURN,FATIGUE),
		SHOCK = list(BURN,FATIGUE),
		BOMB = list(BRUTE,BURN),
		BIO = TOX,
		RAD = list(RAD,BURN),
		HOLY = BURN,
		DARK = BRUTE,
		FATIGUE = FATIGUE,
		PAIN = PAIN,
		ION = list(BRUTE,BURN),
		SANITY = SANITY
	)

	var/list/damage_type_to_fatigue = list( //What percentage of damage blocked is converted into fatigue.
		BLADE = 0.10,
		BLUNT = 0.15,
		PIERCE = 0.05,
		BOMB = 0.5
	)

	var/list/damage_type_to_pain = list(
		BLADE = 0.25,
		BLUNT = 0.25,
		PIERCE = 0.125,
		LASER = 0.25,
		ARCANE = 0.125,
		HEAT = 0.125,
		COLD = 0,
		SHOCK = 0.25,
		BOMB = 0.25,
		BIO = 0,
		RAD = 0,
		HOLY = 0.25,
		DARK = 0.5,
		FATIGUE = 0,
		PAIN = 0,
		ION = 0,
		SANITY = 0
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	var/list/attack_damage_penetration = list()


	//Skill modifiers from 0 to 100.
	var/list/attribute_stats = list()

	var/list/attribute_damage = list()

	var/list/skill_stats = list()

	var/list/skill_damage = list()

	var/list/bonus_experience_skill = list()
	var/list/bonus_experience_attribute = list()

	var/use_blamed_stats = FALSE

	var/throw_mul = 1

	var/crit_multiplier = 2 //Damage multiplier.
	var/crit_chance = 5 //Base crit chance.
	var/crit_chance_max = 10 //Maximium crit chance at 100 luck.

	var/falloff = 0 //How many tiles it takes for the weapon to start loosing damage. Set to 0 to disable. Applys to projectile weapons only.

	var/allow_friendly_fire = FALSE

	var/cqc_tag

	var/can_be_parried = TRUE //Can this damage be parried?

	var/debug = FALSE

	var/list/defense_bonuses = list()

	var/ignore_armor_bonus_damage = FALSE

	var/attack_delay = 10 //Time, in deciseconds. Attack delay with dex is 100
	var/attack_delay_max = 20 //Time, in deciseconds. Attack delay with dex is 0

	var/damage_mod = 1 //Simple multiplier for all damage of this type
	var/penetration_mod = 1 //Simple multiplier for all penetration of this type

	var/experience_mod = 1 //Simple multiplier for all experience gains via this type.

	var/target_floors = FALSE //Can this damagetype target floors?

	var/attack_animation_distance = 18

	var/savage_hit_threshold = 0.3 //30%

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
	return crit_chance + (crit_chance_max - crit_chance)*(L.get_skill_power(SKILL_PRECISION,0,1,2)*0.75 + (L.get_attribute_power(ATTRIBUTE_LUCK,0,1) - 0.5)*0.25)

/damagetype/proc/get_combat_rating(var/mob/living/L)

	var/combat_rating = 0

	var/list/attack_damage = get_attack_damage(L)

	for(var/damage_type in attack_damage)
		var/damage = attack_damage[damage_type]
		combat_rating += damage

	return round(combat_rating*0.25,1)

/damagetype/proc/calculate_value(var/obj/item/I)

	. = 0

	for(var/k in attack_damage_base)
		.var/total_damage = attack_damage_base[k] + attribute_stats[k] + skill_stats[k]
		. += calculate_damage_with_armor(total_damage,max(0,75 - attack_damage_penetration[k]))

	if(attack_delay)
		. *= 0.75 + 0.25*(10 / max(1,attack_delay))

/damagetype/proc/get_miss_chance()
	return 0

/damagetype/proc/get_attack_type()
	return ATTACK_TYPE_MELEE

/damagetype/proc/perform_miss(var/atom/attacker,var/atom/victim,var/atom/weapon)
	if(!victim)
		victim = get_step(attacker,attacker.dir)
	. = max(1,do_attack_animation(attacker,victim,weapon))
	CALLBACK("\ref[attacker]_\ref[victim]_[world.time]_miss_sound",.*0.125,src,.proc/do_miss_sound,attacker,victim,weapon)
	CALLBACK("\ref[attacker]_\ref[victim]_[world.time]_miss_message",.*0.125,src,.proc/display_miss_message,attacker,victim,weapon,null,"missed")
	if(is_living(victim) && attacker != victim)
		var/mob/living/L = victim
		if(L.client)
			L.add_skill_xp(SKILL_EVASION,1)

/damagetype/proc/do_critical_hit(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/list/damage_to_deal)
	return crit_multiplier

/damagetype/proc/get_attack_damage(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/damage_multiplier=1)

	var/list/new_attack_damage = attack_damage_base.Copy()

	if(is_living(attacker))
		var/mob/living/L = attacker
		for(var/attribute in attribute_stats)
			if(!islist(attribute_damage[attribute]))
				var/attack_damage = L.get_attribute_power(attribute,0,1,2) * attribute_stats[attribute]
				new_attack_damage[attribute_damage[attribute]] += attack_damage
				if(debug) log_debug("Getting [attack_damage] [attribute_damage[attribute]] damage from [attribute].")
			else
				for(var/damage_type in attribute_damage[attribute])
					var/attack_damage = L.get_attribute_power(attribute,0,1,2) * attribute_stats[attribute] * (1/length(attribute_damage[attribute]))
					new_attack_damage[damage_type] += attack_damage
					if(debug) log_debug("Getting [attack_damage] [damage_type] damage from [attribute].")

		for(var/skill in skill_stats)
			if(!islist(skill_damage[skill]))
				var/attack_damage = L.get_skill_power(skill,0,1,2) * skill_stats[skill]
				new_attack_damage[skill_damage[skill]] += attack_damage
				if(debug) log_debug("Getting [attack_damage] [skill_damage[skill]] damage from [skill].")
			else
				for(var/damage_type in skill_damage[skill])
					var/attack_damage = L.get_skill_power(skill,0,1,2) * skill_stats[skill] * (1/length(skill_damage[skill]))
					new_attack_damage[damage_type] += attack_damage
					if(debug) log_debug("Getting [attack_damage] [damage_type] damage from [skill].")

	var/final_damage_multiplier = RAND_PRECISE(1,1.1)*(hit_object && hit_object.health ? hit_object.health.get_damage_multiplier() : 1)*damage_multiplier*damage_mod
	if(debug) log_debug("Multiplying final damage by [final_damage_multiplier] from bonuses.")
	for(var/k in new_attack_damage)
		new_attack_damage[k] *= final_damage_multiplier

	return new_attack_damage

/damagetype/proc/get_critical_hit_condition(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)

	if(!attacker.is_player_controlled() || victim.is_player_controlled())
		return FALSE

	if(!is_living(attacker)) //Ghost Admins causing explosions.
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

/damagetype/proc/perform_clash(var/atom/attacker,var/atom/victim,var/atom/weapon_attacker,var/atom/weapon_victim)
	. = max(1,do_attack_animation(attacker,victim,weapon_attacker))
	CALLBACK("\ref[attacker]_\ref[victim]_[world.time]_clash_sound",.*0.125,src,.proc/do_clash_effect,attacker,victim,weapon_attacker)
	return .

/damagetype/proc/do_clash_effect(var/atom/attacker,var/atom/victim,var/atom/weapon)
	play_sound('sound/effects/deflect.ogg',get_turf(attacker),range_max=VIEW_RANGE*0.75)
	return FALSE

/damagetype/proc/swing(var/atom/attacker,var/list/atom/victims = list(),var/atom/weapon,var/list/atom/hit_objects = list(),var/atom/blamed,var/damage_multiplier=1)

	if(!length(victims))
		return perform_miss(attacker,null,weapon)

	if(!length(hit_objects))
		return perform_miss(attacker,victims[1],weapon)

	. = 0

	var/list/final_victims = list()

	var/did_animation = FALSE

	for(var/i=1,i<=length(victims),i++)

		var/atom/victim = victims[i]
		var/atom/hit_object = hit_objects[i]

		if(is_advanced(victim))
			var/mob/living/advanced/A = victim
			if(i==1 && is_weapon(weapon))
				if(is_weapon(A.left_item) && CALLBACK_EXISTS("hit_\ref[A.left_item]"))
					var/list/callback_data = CALLBACK_EXISTS("hit_\ref[A.left_item]")
					if(callback_data["time"] <= world.time + SECONDS_TO_DECISECONDS(0.25))
						CALLBACK_REMOVE("hit_\ref[A.left_item]")
						return perform_clash(attacker,victim,weapon,A.left_item)
				if(is_weapon(A.right_item) && CALLBACK_EXISTS("hit_\ref[A.right_item]"))
					var/list/callback_data = CALLBACK_EXISTS("hit_\ref[A.right_item]")
					if(callback_data["time"] <= world.time + SECONDS_TO_DECISECONDS(0.25))
						CALLBACK_REMOVE("hit_\ref[A.right_item]")
						return perform_clash(attacker,victim,weapon,A.right_item)
			if(istype(victim,/mob/living/advanced/stand/))
				var/mob/living/advanced/stand/S = victim
				victim = S.owner
				if(is_organ(hit_object))
					var/obj/item/organ/O = hit_object
					if(A.labeled_organs[O.id])
						hit_object = A.labeled_organs[O.id]

		if(!is_valid(attacker))
			CRASH_SAFE("Could not swing as there was no attacker!")
			return FALSE

		if(!is_valid(weapon))
			CRASH_SAFE("Could not swing as there was no weapon!")
			return FALSE

		if(!is_valid(victim))
			CRASH_SAFE("Could not swing as there was no victim!")
			return FALSE

		if(!is_valid(victim.health))
			CRASH_SAFE("Could not swing as there was no victim health! (Victim: [victim])")
			return FALSE

		if(!is_valid(hit_object))
			CRASH_SAFE("Could not swing as there was no hit_object!")
			return FALSE

		if(!is_valid(hit_object.health))
			CRASH_SAFE("Could not swing as there was no hit_object health! (Hitobject: [hit_object])")
			return FALSE

		if(!did_animation)
			. = max(1,do_attack_animation(attacker,victim,weapon,hit_object))
			did_animation = TRUE

		final_victims[victim] = hit_object

	if(!length(final_victims))
		return perform_miss(attacker,get_step(attacker,attacker.dir),weapon)

	CALLBACK("hit_\ref[weapon]",CEILING(.*0.125,1),src,.proc/process_damage_group,attacker,final_victims,weapon,blamed,damage_multiplier)

	return .

/damagetype/proc/process_damage_group(var/atom/attacker,var/list/atom/victims,var/atom/weapon,var/atom/blamed,var/damage_multiplier=1)

	for(var/k in victims)
		var/atom/victim = k
		var/atom/hit_object = victims[k]
		process_damage(attacker,victim,weapon,hit_object,blamed,damage_multiplier)

	return TRUE


/damagetype/proc/process_damage(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/damage_multiplier=1)

	if(!is_valid(attacker))
		return FALSE

	if(!is_valid(victim))
		return FALSE

	if(!is_valid(weapon))
		return FALSE

	if(!is_valid(hit_object))
		return FALSE

	if(!is_valid(hit_object.health))
		return FALSE

	if(!is_valid(victim.health))
		return FALSE

	if(debug)
		log_debug("**************************************")
		log_debug("Calculating: process_damage([attacker],[victim],[weapon],[hit_object],[blamed],[damage_multiplier])")

	var/block_multiplier = 0 //Different from damage_multiplier.
	if(attacker != victim && is_living(victim))
		var/mob/living/L = victim
		//Getting the damage
		damage_multiplier *= L.get_damage_received_multiplier(attacker,victim,weapon,hit_object,blamed,src)
		//Parrying
		if(is_advanced(victim) && can_be_parried)
			var/mob/living/advanced/A = victim
			if(A.parry(attacker,weapon,hit_object,src))
				A.to_chat(span("warning","You parried [attacker.name]'s attack!"),CHAT_TYPE_COMBAT)
				play_sound('sound/effects/parry.ogg',get_turf(A),range_max=VIEW_RANGE)
				if(is_living(attacker))
					var/mob/living/LA = attacker
					LA.to_chat(span("danger","Your attack was parried by \the [A.name]!"),CHAT_TYPE_ALL)
					if(get_dist(A,LA) <= 1)
						LA.add_status_effect(PARRIED,30,30, source = A)
				A.on_parried_hit(attacker,weapon,hit_object,blamed,damage_multiplier)
				return FALSE
		//Blocking
		if(L.attack_flags & CONTROL_MOD_BLOCK && abs(get_angle(victim,attacker)) <= 90)
			block_multiplier = L.get_block_multiplier(attacker,weapon,hit_object,blamed,src)
			L.on_blocked_hit(attacker,weapon,hit_object,blamed,src,damage_multiplier,block_multiplier)
		else
			L.on_unblocked_hit(attacker,weapon,hit_object,blamed,src,damage_multiplier)


	var/list/damage_to_deal = get_attack_damage(use_blamed_stats ? blamed : attacker,victim,weapon,hit_object,damage_multiplier)
	var/list/damage_to_deal_main = list(
		BRUTE = 0,
		BURN = 0,
		TOX = 0,
		OXY = 0,
		FATIGUE = 0,
		PAIN = 0,
		RAD = 0,
		SANITY = 0
	)
	var/critical_hit_multiplier = get_critical_hit_condition(attacker,victim,weapon,hit_object) ? do_critical_hit(attacker,victim,weapon,hit_object,damage_to_deal) : 1
	var/fatigue_damage = 0
	var/pain_damage = 0

	var/damage_blocked = 0
	var/defense_rating_victim = victim.health.get_defense(attacker,hit_object,FALSE)
	var/atom/object_to_check = null
	if(is_organ(hit_object))
		var/obj/item/organ/O = hit_object
		if(is_advanced(attacker))
			var/mob/living/advanced/A = attacker
			object_to_check = A.labeled_organs[O.id]
	var/defense_rating_attacker = (attacker && attacker.health) ? attacker.health.get_defense(attacker,object_to_check,TRUE) : list()
	if(debug) log_debug("Calculating [length(damage_to_deal)] damage types...")
	for(var/damage_type in damage_to_deal)
		if(!damage_type)
			continue
		if(debug) log_debug("Calculating [damage_type]...")
		var/old_damage_amount = damage_to_deal[damage_type] * critical_hit_multiplier
		if(damage_type != FATIGUE && block_multiplier > 0)
			if(debug) log_debug("Calculating [damage_type] with shield...")
			var/blocked_damage = block_multiplier * old_damage_amount
			old_damage_amount -= blocked_damage
			fatigue_damage += blocked_damage*0.5
		if(debug) log_debug("Initial [damage_type] damage: [old_damage_amount].")
		var/victim_defense = defense_rating_victim[damage_type]
		if(debug) log_debug("Inital victim's defense against [damage_type]: [victim_defense].")
		if(IS_INFINITY(victim_defense)) //Defense is infinite. No point in calculating further damage or armor.
			damage_to_deal[damage_type] = 0
			if(debug) log_debug("Victim has infinite [damage_type] defense.")
			continue
		if(victim_defense > 0 && attack_damage_penetration[damage_type]) //Penetrate armor only if it exists. Also makes it so that negative armor penetration penalties apply when there is armor.
			victim_defense = max(0,victim_defense - attack_damage_penetration[damage_type]*penetration_mod)
			if(debug) log_debug("Victim's [damage_type] defense after penetration: [victim_defense].")
		if(!ignore_armor_bonus_damage && old_damage_amount && length(defense_rating_attacker) && defense_rating_attacker[damage_type] && (damage_type == ARCANE || damage_type == HOLY || damage_type == DARK)) //Deal bonus damage.
			if(IS_INFINITY(defense_rating_attacker[damage_type])) //Don't do any magic damage if we resist magic.
				damage_to_deal[damage_type] = 0
				continue
			victim_defense -= defense_rating_attacker[damage_type]*0.5
			if(debug) log_debug("Victim's new [damage_type] defense due to attacker's [defense_rating_attacker[damage_type]] armor: [victim_defense].")
		var/new_damage_amount = calculate_damage_with_armor(old_damage_amount,victim_defense)
		if(debug) log_debug("Final [damage_type] damage: [new_damage_amount].")
		var/damage_to_block = max(0,old_damage_amount - new_damage_amount)
		if(debug) log_debug("Blocked [damage_type] damage: [damage_to_block].")
		damage_blocked += damage_to_block
		damage_to_deal[damage_type] = CEILING(max(0,new_damage_amount),1)
		if(damage_type_to_fatigue[damage_type])
			var/fatigue_damage_to_convert = damage_to_block*damage_type_to_fatigue[damage_type]
			if(is_living(victim))
				var/mob/living/L = victim
				fatigue_damage_to_convert *= L.fatigue_mul
			if(debug) log_debug("Converting blocked [damage_type] damage into [fatigue_damage_to_convert] fatigue damage.")
			fatigue_damage += fatigue_damage_to_convert
		if(damage_type_to_pain[damage_type])
			var/pain_damage_to_add = damage_to_deal[damage_type]*clamp(damage_type_to_pain[damage_type],0,1)
			if(is_living(victim))
				var/mob/living/L = victim
				pain_damage_to_add *= L.pain_mul
			if(debug) log_debug("Adding [damage_type] damage into [pain_damage_to_add] pain damage.")
			pain_damage += pain_damage_to_add

	if(!length(defense_rating_victim) || !defense_rating_victim[FATIGUE] || !IS_INFINITY(defense_rating_victim[FATIGUE]))
		damage_to_deal[FATIGUE] += CEILING(fatigue_damage,1)
		if(debug) log_debug("Dealing [fatigue_damage] extra fatigue damage due to blocked damage.")

	if(!length(defense_rating_victim) || !defense_rating_victim[FATIGUE] || !IS_INFINITY(defense_rating_victim[PAIN]))
		damage_to_deal[PAIN] += CEILING(pain_damage,1)
		if(debug) log_debug("Dealing [pain_damage] extra pain damage due to converted damage.")

	for(var/damage_type in damage_to_deal)
		var/damage_amount = damage_to_deal[damage_type]
		if(!damage_amount)
			continue
		var/real_damage_type = attack_damage_conversion[damage_type]
		if(islist(real_damage_type))
			var/list_length = length(real_damage_type)
			for(var/single_damage_type in real_damage_type)
				var/real_damage_amount = CEILING(damage_amount/list_length,1)
				damage_to_deal_main[single_damage_type] += real_damage_amount
				if(debug) log_debug("Converting [damage_amount] [damage_type] damage into [real_damage_amount] [single_damage_type] damage.")
		else
			damage_to_deal_main[real_damage_type] += CEILING(damage_amount,1)
			if(debug) log_debug("Converting [damage_amount] [damage_type] damage into [damage_amount] [real_damage_type] damage.")

	var/total_damage_dealt = 0
	if(victim.immortal || hit_object.immortal)
		for(var/damage_type in damage_to_deal_main)
			total_damage_dealt += damage_to_deal_main[damage_type]
	else
		if(hit_object.health)
			total_damage_dealt += hit_object.health.adjust_loss_smart(
				brute = damage_to_deal_main[BRUTE],
				burn = damage_to_deal_main[BURN],
				tox = damage_to_deal_main[TOX],
				oxy = damage_to_deal_main[OXY],
				fatigue = damage_to_deal_main[FATIGUE],
				pain = damage_to_deal_main[PAIN],
				rad = damage_to_deal_main[RAD],
				sanity = damage_to_deal_main[SANITY],
				mental = damage_to_deal_main[MENTAL],
				update = FALSE
			)
		else
			CRASH_SAFE("ERROR: Tried dealing damage to object [hit_object], but it had no health!")
			return TRUE

	if(debug) log_debug("Dealt [total_damage_dealt] total damage.")

	if(is_living(victim))
		var/mob/living/L = victim
		L.add_attribute_xp(ATTRIBUTE_CONSTITUTION,total_damage_dealt*0.1)

	do_attack_visuals(attacker,victim,weapon,hit_object,total_damage_dealt)
	do_attack_sound(attacker,victim,weapon,hit_object)

	if(is_living(victim) && victim.health)
		var/mob/living/L = victim
		L.to_chat(span("warning","Took <b>[round(total_damage_dealt,0.1)]</b> damage to [hit_object == victim ? "yourself" : "your [hit_object.name]"] by \the [attacker == weapon ? "[attacker.name]'s attack" : "[attacker.name]'s [weapon.name]"] (<b>[max(0,victim.health.health_current - total_damage_dealt)]/[victim.health.health_max]</b>)."),CHAT_TYPE_COMBAT)

	if(is_living(blamed) && victim.health && blamed != victim) //TODO: Seperate log for blamed.
		var/mob/living/L = blamed
		L.to_chat(span("notice","Dealt <b>[round(total_damage_dealt,0.1)]</b> damage with your [weapon.name] to \the [victim == hit_object ? victim.name : "[victim.name]\'s [hit_object.name]"] (<b>[max(0,victim.health.health_current - total_damage_dealt)]/[victim.health.health_max]</b>)."),CHAT_TYPE_COMBAT)

	if(!total_damage_dealt)
		display_glance_message(attacker,victim,weapon,hit_object)
	else
		display_hit_message(attacker,victim,weapon,hit_object)
		if(is_living(blamed) && is_living(victim))
			var/mob/living/A = blamed
			var/mob/living/V = victim
			if(!V.dead)
				var/victim_health_final = V.health.get_overall_health()
				var/list/hit_log_format = list()
				hit_log_format["attacker"] = A
				hit_log_format["attacker_ckey"] = A.ckey
				hit_log_format["time"] = world.time
				hit_log_format["damage"] = total_damage_dealt
				hit_log_format["critical"] = victim_health_final - total_damage_dealt < 0
				hit_log_format["lethal"] = (victim_health_final - total_damage_dealt) <= min(-50,V.health.health_max*-0.25)
				V.hit_logs += list(hit_log_format)

			if(attacker != victim && total_damage_dealt && !V.dead && A.is_player_controlled())
				var/list/experience_gained = list()
				var/experience_damage = SAFENUM(damage_to_deal_main[BRUTE]) + SAFENUM(damage_to_deal_main[BURN]) + SAFENUM(damage_to_deal_main[TOX]) + SAFENUM(damage_to_deal_main[RAD])
				var/experience_multiplier = victim.get_xp_multiplier() * experience_mod
				if(critical_hit_multiplier > 1)
					var/xp_to_give = CEILING((experience_damage*experience_multiplier)/critical_hit_multiplier,1)
					if(xp_to_give > 0)
						A.add_skill_xp(SKILL_PRECISION,xp_to_give)
						experience_gained[SKILL_PRECISION] += xp_to_give

				for(var/skill in skill_stats)
					var/xp_to_give = CEILING(skill_stats[skill] * 0.01 * experience_damage * experience_multiplier, 1)
					if(xp_to_give > 0)
						A.add_skill_xp(skill,xp_to_give)
						experience_gained[skill] += xp_to_give

				for(var/attribute in attribute_stats)
					var/xp_to_give = CEILING(attribute_stats[attribute] * 0.01 * experience_damage * experience_multiplier, 1)
					if(xp_to_give > 0)
						A.add_attribute_xp(attribute,xp_to_give)
						experience_gained[attribute] += xp_to_give

				for(var/skill in bonus_experience_skill)
					var/xp_to_give = CEILING(bonus_experience_skill[skill] * 0.01 * experience_damage * experience_multiplier,1)
					if(xp_to_give > 0)
						A.add_skill_xp(skill,xp_to_give)
						experience_gained[skill] += xp_to_give

				for(var/attribute in bonus_experience_attribute)
					var/xp_to_give = CEILING(bonus_experience_attribute[attribute] * 0.01 * experience_damage * experience_multiplier,1)
					if(xp_to_give > 0)
						A.add_attribute_xp(attribute,xp_to_give)
						experience_gained[attribute] += xp_to_give

				if(length(experience_gained))
					var/list/final_experience = list()
					for(var/k in experience_gained)
						var/v = experience_gained[k]
						final_experience += "[v] [k] xp"
					A.to_chat(span("notice","You gained [english_list(final_experience)]."),CHAT_TYPE_COMBAT)

	src.post_on_hit(attacker,victim,weapon,hit_object,blamed,total_damage_dealt)

	if(istype(weapon,/obj/item/weapon))
		var/obj/item/weapon/W = weapon
		if(W.reagents && victim.reagents)
			W.reagents.transfer_reagents_to(victim.reagents,W.reagents.volume_current*clamp(total_damage_dealt/200,0.25,1))
			W.reagents.remove_all_reagents()
		if(W.enchantment && W.enchantment.charge >= 0)
			W.enchantment.on_hit(attacker,victim,weapon,hit_object,blamed,total_damage_dealt)
			W.enchantment.charge -= W.enchantment.cost
			if(W.enchantment.charge <= 0)
				qdel(W.enchantment)
				W.enchantment = null


	victim.on_damage_received(hit_object,attacker,weapon,src,damage_to_deal,total_damage_dealt,critical_hit_multiplier,stealthy)
	if(victim != hit_object)
		hit_object.on_damage_received(hit_object,attacker,weapon,src,damage_to_deal,total_damage_dealt,critical_hit_multiplier,stealthy)

	return TRUE

/damagetype/proc/post_on_hit(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/total_damage_dealt=0)
	return TRUE

/damagetype/proc/do_attack_visuals(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/damage_dealt)

	if(hit_effect)
		new hit_effect(get_turf(victim))

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
		play_sound(pick(impact_sounds_flesh),get_turf(hit_object),range_max=VIEW_RANGE)

	if(length(impact_sounds))
		var/turf/T = get_turf(hit_object)
		play_sound(pick(impact_sounds),T,range_max=VIEW_RANGE)

	return TRUE

/damagetype/proc/do_swing_sound(var/atom/attacker,var/atom/victim,var/atom/weapon)
	if(length(swing_sounds))
		var/turf/T = get_turf(victim)
		play_sound(pick(swing_sounds),T,range_max=VIEW_RANGE*0.5)
		return TRUE
	return FALSE

/damagetype/proc/do_miss_sound(var/atom/attacker,var/atom/victim,var/atom/weapon)
	if(length(miss_sounds))
		var/turf/T = get_turf(victim)
		play_sound(pick(miss_sounds),T,range_max=VIEW_RANGE*0.75)
		return TRUE
	return FALSE

/damagetype/proc/do_attack_animation(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)

	var/attack_delay = get_attack_delay(attacker)

	var/list/pixel_offset = direction_to_pixel_offset(get_dir(attacker,victim))

	if(is_living(attacker))
		var/mob/living/L = attacker
		var/matrix/attack_matrix = L.get_base_transform()
		attack_matrix.Translate(pixel_offset[1]*attack_animation_distance,pixel_offset[2]*attack_animation_distance)
		animate(L, transform = attack_matrix, time = CEILING(attack_delay*0.125,1), flags = ANIMATION_PARALLEL, easing = BACK_EASING) // This does the attack
		animate(transform = L.get_base_transform(), time = FLOOR(attack_delay*0.5*0.99,1), flags = ANIMATION_PARALLEL) //This does the reset.

	. = CEILING(attack_delay,1)

	do_swing_sound(attacker,victim,weapon)

	if(draw_weapon)
		new /obj/effect/temp/impact/weapon_clone(get_turf(attacker),. * 0.5,victim,attacker,weapon)

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


/damagetype/proc/get_attack_delay(var/atom/attacker)

	if(is_living(attacker))
		var/mob/living/L = attacker
		if(attack_delay_max < attack_delay)
			attack_delay_max = attack_delay
		if(L.ai)
			return attack_delay + (attack_delay_max - attack_delay)*(2-L.get_attribute_power(ATTRIBUTE_DEXTERITY,0,1))
		else
			return attack_delay + (attack_delay_max - attack_delay)*(1-L.get_attribute_power(ATTRIBUTE_DEXTERITY,0,1))

	return attack_delay