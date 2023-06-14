var/global/list/all_damage_numbers = list()

/damagetype/
	var/list/attack_verbs = list("strike","hit","pummel") //Verbs to use
	var/list/miss_verbs = list("swing")
	var/weapon_name
	var/swing_sounds = list(
		'sound/weapons/unarmed/swing.ogg'
	)
	var/impact_sounds = list(
		'sound/weapons/unarmed/punch1.ogg',
		'sound/weapons/unarmed/punch2.ogg',
		'sound/weapons/unarmed/punch3.ogg',
		'sound/weapons/unarmed/punch4.ogg'
	)

	var/miss_sounds = list(
		'sound/weapons/unarmed/punchmiss.ogg'
	)

	var/impact_sounds_flesh = list() //Leave empty to just use impact sounds, no matter what.

	var/stealthy = FALSE //Set to true to not display any damage dealt as well as not to alert any NPCs when hit.

	var/attack_delay_mod = 1

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
		ACID = BURN,
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
		HEAT = 0.5,
		COLD = 0,
		SHOCK = 0.75,
		ACID = 0.75,
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
	var/inaccuracy_mod = 1 //Simple multiplier for inaccuracy. Only applies to melee/unarmed.

	var/experience_mod = 1 //Simple multiplier for all experience gains via this type.

	var/target_floors = FALSE //Can this damagetype target floors?

	var/attack_animation_distance = 18

	var/savage_hit_threshold = 0.4 //40%

	var/sneak_attack_multiplier = 2 //200%

	var/alert_on_impact = ALERT_LEVEL_NONE
	var/alert_range = 2

	var/allow_power_attacks = TRUE

	var/animate = FALSE

	// 0 = no logs
	// 1 = victim recieves logs only
	// 2 = victim and attacks recieves logs
	// 3 = everyone recieves logs (hit logging must be enabled in config)
	var/enable_logs = 3

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

/damagetype/proc/get_miss_chance()
	return 0

/damagetype/proc/get_attack_type()
	return ATTACK_TYPE_MELEE

/damagetype/proc/perform_miss(var/atom/attacker,var/atom/victim,var/atom/weapon)
	if(!victim)
		victim = get_step(attacker,attacker.dir)
	. = max(1,do_attack_animation(attacker,victim,weapon))
	CALLBACK("\ref[attacker]_\ref[victim]_[world.time]_miss_sound",.*0.125,src,src::do_miss_sound(),attacker,victim,weapon)
	CALLBACK("\ref[attacker]_\ref[victim]_[world.time]_miss_message",.*0.125,src,src::display_miss_message(),attacker,victim,weapon,null,"missed")
	if(is_living(victim) && is_living(attacker))
		var/mob/living/V = victim
		var/mob/living/A = attacker
		if(V.loyalty_tag != A.loyalty_tag && V.is_player_controlled())
			V.add_skill_xp(SKILL_EVASION,1)

/damagetype/proc/do_critical_hit(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/list/damage_to_deal)
	return crit_multiplier

/damagetype/proc/do_sneak_hit(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/list/damage_to_deal)
	return sneak_attack_multiplier

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

	var/final_damage_multiplier = (hit_object && hit_object.health ? hit_object.health.get_damage_multiplier(attacker,victim,weapon,hit_object) : 1)*damage_multiplier*damage_mod
	if(debug) log_debug("Multiplying final damage by [final_damage_multiplier] from bonuses.")
	for(var/k in new_attack_damage)
		new_attack_damage[k] *= final_damage_multiplier
		new_attack_damage[k] = CEILING(new_attack_damage[k],1)

	return new_attack_damage

/damagetype/proc/get_sneak_hit_condition(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)

	if(is_living(victim))
		var/mob/living/L = victim
		if(L.ai && L.ai.alert_level <= ALERT_LEVEL_NOISE)
			return TRUE

	return FALSE

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

	var/crit_chance = get_crit_chance(attacker)

	return luck(list(attacker,weapon),crit_chance)

/damagetype/proc/perform_clash(var/atom/attacker,var/atom/victim,var/atom/weapon_attacker,var/atom/weapon_victim)
	. = max(1,do_attack_animation(attacker,victim,weapon_attacker))
	CALLBACK("\ref[attacker]_\ref[victim]_[world.time]_clash_sound",.*0.125,src,src::do_clash_effect(),attacker,victim,weapon_attacker)
	return .

/damagetype/proc/do_clash_effect(var/atom/attacker,var/atom/victim,var/atom/weapon)
	play_sound('sound/effects/deflect.ogg',get_turf(attacker),range_max=VIEW_RANGE*0.75)
	return FALSE

/damagetype/proc/windup(var/atom/attacker,var/list/atom/victims = list(),var/atom/weapon,var/list/atom/hit_objects = list(),var/atom/blamed,var/damage_multiplier=1)

	if(!length(victims))
		return FALSE

	var/local_power_attack_delay = attack_delay_max*0.25

	attacker.attack_next = world.time + local_power_attack_delay + 1
	if(attacker != weapon)
		weapon.attack_next = local_power_attack_delay

	if(animate)
		var/list/pixel_offset = get_directional_offsets(attacker,victims[1])

		animate(attacker, pixel_x = -pixel_offset[1]*attack_animation_distance*0.5, pixel_y = -pixel_offset[2]*attack_animation_distance, time = FLOOR(local_power_attack_delay*0.75,1), flags = ANIMATION_PARALLEL | ANIMATION_RELATIVE, easing = BACK_EASING) // This does the attack
		animate(pixel_x = pixel_offset[1]*attack_animation_distance*0.5, pixel_y = pixel_offset[2]*attack_animation_distance, time = CEILING(local_power_attack_delay*1.1,1), flags = ANIMATION_PARALLEL | ANIMATION_RELATIVE) //This does the reset.

		if(is_living(attacker))
			var/mob/living/M = attacker
			if(M.client)
				M.client.recoil_pixel_x += pixel_offset[1]
				M.client.recoil_pixel_y += pixel_offset[2]

	play_sound('sound/effects/power_attack.ogg',get_turf(attacker))

	CALLBACK("swing_\ref[weapon]",local_power_attack_delay,src,src::swing(),attacker,victims,weapon,hit_objects,blamed,damage_multiplier)


/damagetype/proc/swing(var/atom/attacker,var/list/atom/victims = list(),var/atom/weapon,var/list/atom/hit_objects = list(),var/atom/blamed,var/damage_multiplier=1)

	. = do_swing(attacker,victims,weapon,hit_objects,blamed,damage_multiplier)

	if(attacker != weapon)
		weapon.attack_next = world.time + .
		attacker.attack_next = world.time + .*0.5
	else
		attacker.attack_next = world.time + .

/damagetype/proc/do_swing(var/atom/attacker,var/list/atom/victims = list(),var/atom/weapon,var/list/atom/hit_objects = list(),var/atom/blamed,var/damage_multiplier=1)

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
			if(i==1 && !ismob(weapon))
				var/obj/item/left_item = A.inventories_by_id[BODY_HAND_LEFT_HELD]?.get_top_object()
				if(left_item && CALLBACK_EXISTS("hit_\ref[left_item]"))
					var/list/callback_data = CALLBACK_EXISTS("hit_\ref[left_item]")
					if(callback_data["time"] <= world.time + SECONDS_TO_DECISECONDS(0.25))
						CALLBACK_REMOVE("hit_\ref[left_item]")
						return perform_clash(attacker,victim,weapon,left_item)
				var/obj/item/right_item = A.inventories_by_id[BODY_HAND_RIGHT_HELD]?.get_top_object()
				if(right_item && CALLBACK_EXISTS("hit_\ref[right_item]"))
					var/list/callback_data = CALLBACK_EXISTS("hit_\ref[right_item]")
					if(callback_data["time"] <= world.time + SECONDS_TO_DECISECONDS(0.25))
						CALLBACK_REMOVE("hit_\ref[right_item]")
						return perform_clash(attacker,victim,weapon,right_item)
			/*
			if(istype(victim,/mob/living/advanced/stand/))
				var/mob/living/advanced/stand/S = victim
				victim = S.owner
				if(is_organ(hit_object))
					var/obj/item/organ/O = hit_object
					if(A.labeled_organs[O.id])
						hit_object = A.labeled_organs[O.id]
			*/

		if(!is_valid(attacker))
			CRASH("Could not swing as there was no attacker!")

		if(!is_valid(weapon))
			CRASH("Could not swing as there was no weapon!")

		if(!is_valid(victim))
			CRASH("Could not swing as there was no victim!")

		if(!is_valid(victim.health))
			CRASH("Could not swing as there was no victim health! (Victim: [victim])")

		if(!is_valid(hit_object))
			CRASH("Could not swing as there was no hit_object!")

		if(!is_valid(hit_object.health))
			CRASH("Could not swing as there was no hit_object health! (Hitobject: [hit_object])")

		if(!did_animation)
			. = max(1,do_attack_animation(attacker,victim,weapon,hit_object))
			did_animation = TRUE

		final_victims[victim] = hit_object

	if(!length(final_victims))
		return perform_miss(attacker,get_step(attacker,attacker.dir),weapon)

	CALLBACK("hit_\ref[weapon]",CEILING(.*0.125,1),src,src::process_damage_group(),attacker,final_victims,weapon,blamed,damage_multiplier)

	return .

/damagetype/proc/process_damage_group(var/atom/attacker,var/list/atom/victims,var/atom/weapon,var/atom/blamed,var/damage_multiplier=1)

	/* Disabled for now.
	if(allow_heavy_attack && is_advanced(attacker))
		var/mob/living/advanced/A = attacker
		if(A.client && (!A.health || A.health.stamina_current >= 25))
			var/obj/item/organ/hand/H
			if(istype(weapon,/obj/item/organ/hand))
				H = weapon
			else if(weapon.loc && istype(weapon.loc.loc,/obj/item/organ/hand))
				H = weapon.loc.loc
			if(H)
				if(A.attack_flags & CONTROL_MOD_LEFT && H.id == (A.client.settings.loaded_data["swap_mouse"] ? BODY_HAND_LEFT : BODY_HAND_RIGHT))
					damage_multiplier *= 2
					A.health?.adjust_stamina(-25)
					play_sound('sound/effects/power_attack.ogg',get_turf(attacker))
				else if(A.attack_flags & CONTROL_MOD_RIGHT && H.id == (A.client.settings.loaded_data["swap_mouse"] ? BODY_HAND_RIGHT : BODY_HAND_LEFT))
					damage_multiplier *= 2
					A.health?.adjust_stamina(-25)
					play_sound('sound/effects/power_attack.ogg',get_turf(attacker))
	*/

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

	var/turf/attacker_turf = get_turf(attacker)
	if(!attacker_turf)
		return FALSE

	var/turf/victim_turf = get_turf(victim)
	if(!victim_turf)
		return FALSE


	if(debug)
		log_debug("**************************************")
		log_debug("Calculating: process_damage([attacker],[victim],[weapon],[hit_object],[blamed],[damage_multiplier])")

	var/block_multiplier = 0 //Different from damage_multiplier.
	var/atom/block_atom = null

	if(is_living(victim))
		var/mob/living/L = victim
		damage_multiplier *= L.get_damage_received_multiplier(attacker,victim,weapon,hit_object,blamed,src)
		if(attacker != victim)
			//Parrying
			if(src.can_be_parried)
				var/mob/living/A = victim
				if(A.parry(attacker,weapon,hit_object,src))
					A.to_chat(span("warning","You parried [attacker.name]'s attack!"),CHAT_TYPE_COMBAT)
					play_sound('sound/effects/parry.ogg',victim_turf,range_max=VIEW_RANGE)
					if(is_living(attacker))
						var/mob/living/LA = attacker
						LA.to_chat(span("danger","Your attack was parried by \the [A.name]!"),CHAT_TYPE_ALL)
						if(get_dist(A,LA) <= 1)
							LA.add_status_effect(PARRIED,30,30, source = A)
					A.on_parried_hit(attacker,weapon,hit_object,blamed,damage_multiplier)
					return FALSE
			//Blocking
			if(L.blocking)
				var/list/block_data = L.get_block_data(attacker,weapon,hit_object,blamed,src)
				if(block_data)
					block_atom = block_data[1]
					block_multiplier = block_data[2]

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
	var/stealth_multiplier = get_sneak_hit_condition(attacker,victim,weapon,hit_object) ? do_sneak_hit(attacker,victim,weapon,hit_object,damage_to_deal) : 1

	var/fatigue_damage = 0
	var/pain_damage = 0

	var/damage_blocked_with_armor = 0
	var/damage_blocked_with_shield = 0
	var/defense_rating_victim = victim.health.get_defense(attacker,hit_object,FALSE)
	var/deflection_rating = defense_rating_victim ? defense_rating_victim["deflection"] : 0
	var/atom/object_to_check = null
	if(is_organ(hit_object))
		var/obj/item/organ/O = hit_object
		if(is_advanced(attacker))
			var/mob/living/advanced/A = attacker
			object_to_check = A.labeled_organs[O.id]
	var/defense_rating_attacker = (attacker && attacker.health) ? attacker.health.get_defense(attacker,object_to_check,TRUE) : list()
	if(debug) log_debug("Calculating [length(damage_to_deal)] damage types...")

	if(is_weapon(weapon))
		var/obj/item/weapon/I = weapon
		if(I.stored_spellswap)
			var/total_damage = 0
			for(var/k in damage_to_deal)
				total_damage += damage_to_deal[k]
			damage_to_deal = list()
			for(var/k in I.stored_spellswap.damage_conversion)
				var/v = I.stored_spellswap.damage_conversion[k]
				damage_to_deal[k] = v * total_damage

	for(var/damage_type in damage_to_deal)
		if(!damage_type)
			continue
		if(debug) log_debug("Calculating [damage_type]...")
		var/old_damage_amount = damage_to_deal[damage_type] * critical_hit_multiplier * stealth_multiplier
		if(!ignore_armor_bonus_damage && (damage_type == ARCANE || damage_type == HOLY || damage_type == DARK)) //Deal bonus damage.
			if(length(defense_rating_attacker) && defense_rating_attacker[damage_type] && IS_INFINITY(defense_rating_attacker[damage_type])) //Don't do any damage if we are immune that type (arcane, holy, dark).
				damage_to_deal[damage_type] = 0
				continue
			if(is_advanced(attacker) && attacker.health)
				var/mob/living/advanced/A = attacker
				damage_to_deal[damage_type] *= clamp(1 + A.overall_clothing_defense_rating[damage_type]*0.02,0,1) //Deal 2% more damage per 100 magic resist of attacker, max of 100% more damage.
				if(debug) log_debug("Victim's new [damage_type] damage taken due to attacker's [damage_type]: [damage_to_deal[damage_type]].")
		if(damage_type != FATIGUE && block_multiplier > 0)
			if(debug) log_debug("Calculating [damage_type] with blocking...")
			var/blocked_damage = block_multiplier * old_damage_amount
			old_damage_amount -= blocked_damage
			fatigue_damage += blocked_damage*0.5
			damage_blocked_with_shield += blocked_damage
		if(debug) log_debug("Initial [damage_type] damage: [old_damage_amount].")
		var/victim_defense = defense_rating_victim[damage_type]
		if(debug) log_debug("Inital victim's defense against [damage_type]: [victim_defense].")
		if(IS_INFINITY(victim_defense)) //Defense is infinite. No point in calculating further damage or armor.
			damage_to_deal[damage_type] = 0
			if(debug) log_debug("Victim has infinite [damage_type] defense. No damage can be dealt.")
			continue
		if(debug) log_debug("Victim's [damage_type] defense before penetration calculations: [victim_defense].")
		var/local_penetration = attack_damage_penetration[damage_type] * penetration_mod
		if(IS_INFINITY(local_penetration))
			victim_defense = 0
		else
			if(local_penetration < 0)
				if(victim_defense > 0)
					victim_defense -= local_penetration //This adds extra armor.
			else
				if(victim_defense > 0)
					victim_defense = max(0,victim_defense - local_penetration)
		if(debug) log_debug("Victim's [damage_type] defense after penetration calculations: [victim_defense].")
		var/new_damage_amount = calculate_damage_with_armor(old_damage_amount,victim_defense)
		if(debug) log_debug("Final [damage_type] damage: [new_damage_amount].")
		var/damage_to_block = max(0,old_damage_amount - new_damage_amount)
		if(debug) log_debug("Blocked [damage_type] damage: [damage_to_block].")
		damage_blocked_with_armor += damage_to_block
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

	var/total_damage_dealt = 0
	for(var/damage_type in damage_to_deal)
		var/damage_amount = damage_to_deal[damage_type]
		if(!damage_amount)
			continue
		total_damage_dealt += damage_amount
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

	if(defense_rating_victim && defense_rating_victim["items"])
		for(var/k in defense_rating_victim["items"])
			var/obj/item/I = k
			if(I.uses_until_condition_fall > 0)
				I.use_condition(total_damage_dealt)
			if(total_damage_dealt > 0 && I.can_negate_damage && I.negate_damage(attacker,victim,weapon,hit_object,blamed,total_damage_dealt))
				total_damage_dealt = 0

	var/victim_was_dead = FALSE
	if(is_living(victim))
		var/mob/living/LV = victim
		if(LV.dead)
			victim_was_dead = TRUE

	if(total_damage_dealt > 0 && hit_object.health)
		total_damage_dealt = hit_object.health.adjust_loss_smart(
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
		//This forces it to immediately update.
		//Organs have weird health updating code, which is handled here.
		if(is_organ(hit_object))
			var/obj/item/organ/O = hit_object
			O.health.update_health()
			if(is_advanced(O.loc))
				var/mob/living/advanced/A = O.loc
				if(A.health)
					A.health.update_health()
		else
			hit_object.health.update_health()

	if(debug) log_debug("Dealt [total_damage_dealt] total damage.")

	do_attack_visuals(attacker,attacker_turf,victim,victim_turf,total_damage_dealt)
	do_attack_sound(attacker,attacker_turf,victim,victim_turf,total_damage_dealt,victim.health && victim.health.organic && is_living(victim))

	if(enable_logs >= 1 && is_living(victim) && victim.health)
		var/mob/living/L = victim
		L.to_chat(span("warning","Took <b>[round(total_damage_dealt,0.1)]</b> damage to [hit_object == victim ? "yourself" : "your [hit_object.name]"] by \the [attacker == weapon ? "[attacker.name]'s attack" : "[attacker.name]'s [weapon.name]"] (<b>[max(0,victim.health.health_current - total_damage_dealt)]/[victim.health.health_max]</b>)."),CHAT_TYPE_COMBAT)

	if(enable_logs >= 2 && is_living(blamed) && victim.health && blamed != victim) //TODO: Seperate log for blamed.
		var/mob/living/L = blamed
		L.to_chat(span("notice","Dealt <b>[round(total_damage_dealt,0.1)]</b> damage with your [weapon.name] to \the [victim == hit_object ? victim.name : "[victim.name]\'s [hit_object.name]"] (<b>[max(0,victim.health.health_current - total_damage_dealt)]/[victim.health.health_max]</b>)."),CHAT_TYPE_COMBAT)

	if(!total_damage_dealt)
		display_glance_message(attacker,victim,weapon,hit_object)
	else
		display_hit_message(attacker,victim,weapon,hit_object)
		if(is_living(blamed) && is_living(victim))
			var/mob/living/A = blamed
			var/mob/living/V = victim
			if(!victim_was_dead)
				var/list/hit_log_format = list()
				hit_log_format["attacker"] = A
				hit_log_format["attacker_ckey"] = A.ckey
				hit_log_format["time"] = world.time
				hit_log_format["damage"] = total_damage_dealt
				hit_log_format["critical"] = V.health ? V.health.health_current - total_damage_dealt < 0 : TRUE
				hit_log_format["lethal"] = V.health ? (V.health.health_current - total_damage_dealt) <= min(-50,V.health.health_max*-0.25) : TRUE
				V.hit_logs += list(hit_log_format)
				if(attacker != victim && V.is_player_controlled())
					if(total_damage_dealt > 0)
						V.add_attribute_xp(ATTRIBUTE_CONSTITUTION,total_damage_dealt*0.1)
					if(damage_blocked_with_armor > 0)
						V.add_skill_xp(SKILL_ARMOR,damage_blocked_with_armor*0.1)
					if(damage_blocked_with_shield > 0)
						V.add_skill_xp(SKILL_BLOCK,damage_blocked_with_shield*0.1)

			if(attacker != victim && total_damage_dealt && !victim_was_dead && A.is_player_controlled())
				var/list/experience_gained = list()
				var/experience_multiplier = victim.get_xp_multiplier() * experience_mod
				if(critical_hit_multiplier > 1)
					var/xp_to_give = CEILING((total_damage_dealt*experience_multiplier)/critical_hit_multiplier,1)
					if(xp_to_give > 0)
						A.add_skill_xp(SKILL_PRECISION,xp_to_give)
						experience_gained[SKILL_PRECISION] += xp_to_give

				if(stealth_multiplier > 1)
					var/xp_to_give = CEILING((total_damage_dealt*experience_multiplier)/stealth_multiplier,1)
					if(xp_to_give > 0)
						A.add_skill_xp(SKILL_SURVIVAL,xp_to_give)
						experience_gained[SKILL_SURVIVAL] += xp_to_give

				for(var/skill in skill_stats)
					//var/experience/skill/E = SSexperience.all_skills[skill]
					var/xp_to_give = CEILING(skill_stats[skill] * 0.01 * total_damage_dealt * experience_multiplier, 1)
					if(xp_to_give > 0)
						A.add_skill_xp(skill,xp_to_give)
						experience_gained[skill] += xp_to_give

				for(var/attribute in attribute_stats)
					var/experience/attribute/E = SSexperience.all_attributes[attribute]
					if(!(E.flags & ATTRIBUTE_DAMAGE))
						continue
					var/xp_to_give = CEILING(attribute_stats[attribute] * 0.01 * total_damage_dealt * experience_multiplier, 1)
					if(xp_to_give > 0)
						A.add_attribute_xp(attribute,xp_to_give)
						experience_gained[attribute] += xp_to_give

				for(var/skill in bonus_experience_skill)
					//var/experience/skill/E = SSexperience.all_skills[skill]
					var/xp_to_give = CEILING(bonus_experience_skill[skill] * 0.01 * total_damage_dealt * experience_multiplier, 1)
					if(xp_to_give > 0)
						A.add_skill_xp(skill,xp_to_give)
						experience_gained[skill] += xp_to_give

				for(var/attribute in bonus_experience_attribute)
					var/experience/attribute/E = SSexperience.all_attributes[attribute]
					if(!(E.flags & ATTRIBUTE_DAMAGE))
						continue
					var/xp_to_give = CEILING(bonus_experience_attribute[attribute] * 0.01 * total_damage_dealt * experience_multiplier, 1)
					if(xp_to_give > 0)
						A.add_attribute_xp(attribute,xp_to_give)
						experience_gained[attribute] += xp_to_give

				if(length(experience_gained))
					var/list/final_experience = list()
					for(var/k in experience_gained)
						var/v = experience_gained[k]
						final_experience += "[v] [k] xp"
					A.to_chat(span("notice","You gained [english_list(final_experience)]."),CHAT_TYPE_COMBAT)

	if(is_living(victim))
		var/mob/living/L = victim
		if(block_multiplier > 0)
			L.on_blocked_hit(attacker,weapon,hit_object,blamed,src,block_atom,block_multiplier,damage_blocked_with_shield)
		else
			L.on_unblocked_hit(attacker,weapon,hit_object,blamed,src,total_damage_dealt)

	if(CONFIG("ENABLE_DAMAGE_NUMBERS",FALSE) && !stealthy && (damage_blocked_with_armor + damage_blocked_with_shield + total_damage_dealt) > 0)
		var/desired_id = "\ref[weapon]_\ref[victim]_[world.time]"
		var/obj/effect/damage_number/DN
		if(length(all_damage_numbers) && all_damage_numbers[desired_id])
			DN = all_damage_numbers[desired_id]
			DN.add_value(total_damage_dealt,damage_blocked_with_armor+damage_blocked_with_shield)
		else
			DN = new(victim_turf,total_damage_dealt,damage_blocked_with_armor+damage_blocked_with_shield,desired_id)

	if(is_weapon(weapon))
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
		if(W.stored_spellswap && W.stored_spellswap.desired_sound)
			play_sound(W.stored_spellswap.desired_sound,victim_turf,range_max=VIEW_RANGE,volume=25)

	victim.on_damage_received(hit_object,attacker,weapon,src,damage_to_deal,total_damage_dealt,critical_hit_multiplier,stealthy)
	if(victim != hit_object)
		hit_object.on_damage_received(hit_object,attacker,weapon,src,damage_to_deal,total_damage_dealt,critical_hit_multiplier,stealthy)

	post_on_hit(attacker,attacker_turf,victim,victim_turf,weapon,hit_object,total_damage_dealt)

	return list(total_damage_dealt,damage_blocked_with_armor,damage_blocked_with_shield,deflection_rating)

/damagetype/proc/post_on_hit(var/atom/attacker,var/turf/attacker_turf,var/atom/victim,var/turf/victim_turf,var/atom/weapon,var/atom/hit_object,var/total_damage_dealt=0)

	if(alert_on_impact != ALERT_LEVEL_NONE && alert_range > 0)
		create_alert(VIEW_RANGE,victim_turf,attacker,alert_level = alert_on_impact)

	return TRUE

/damagetype/proc/do_attack_visuals(var/atom/attacker,var/turf/attacker_turf,var/atom/victim,var/turf/victim_turf,var/total_damage_dealt=0)

	if(hit_effect)
		new hit_effect(victim_turf)

	if(animate)
		var/list/offsets = get_directional_offsets(attacker_turf,victim_turf)

		if(offsets[1] || offsets[2])
			var/multiplier = clamp(TILE_SIZE * (total_damage_dealt / max(1,victim?.health?.health_max)) * 2,0,TILE_SIZE*0.25)
			if(is_living(victim))
				var/mob/living/M = victim
				if(M.client)
					M.client.recoil_pixel_x -= offsets[1]*multiplier
					M.client.recoil_pixel_y -= offsets[2]*multiplier

			if(is_living(attacker))
				var/mob/living/M = attacker
				if(M.client)
					M.client.recoil_pixel_x -= offsets[1]*multiplier*0.5
					M.client.recoil_pixel_y -= offsets[2]*multiplier*0.5

/damagetype/proc/do_attack_sound(var/atom/attacker,var/turf/attacker_turf,var/atom/victim,var/turf/victim_turf,var/total_damage_dealt=0,var/flesh=FALSE)

	var/desired_volume = 25 + min(75,total_damage_dealt/2)

	if(flesh && length(impact_sounds_flesh))
		play_sound(pick(impact_sounds_flesh),victim_turf,range_max=VIEW_RANGE,volume=desired_volume)

	else if(length(impact_sounds))
		play_sound(pick(impact_sounds),victim_turf,range_max=VIEW_RANGE,volume=desired_volume)

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

	if(!attacker)
		return 0

	var/attack_delay = get_attack_delay(attacker)

	if(animate)
		var/list/pixel_offset = get_directional_offsets(attacker,victim)

		animate(attacker, pixel_x = pixel_offset[1]*attack_animation_distance, pixel_y = pixel_offset[2]*attack_animation_distance, time = CEILING(attack_delay*0.125,1), flags = ANIMATION_PARALLEL | ANIMATION_RELATIVE, easing = BACK_EASING) // This does the attack
		animate(pixel_x = -pixel_offset[1]*attack_animation_distance, pixel_y = -pixel_offset[2]*attack_animation_distance, time = FLOOR(attack_delay*0.5*0.99,1), flags = ANIMATION_PARALLEL | ANIMATION_RELATIVE) //This does the reset.

		if(is_living(attacker))
			var/mob/living/M = attacker
			if(M.client)
				M.client.recoil_pixel_x -= pixel_offset[1]
				M.client.recoil_pixel_y -= pixel_offset[2]

	. = CEILING(attack_delay,1)

	do_swing_sound(attacker,victim,weapon)

	if(draw_weapon && is_item(weapon))
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

	if(enable_logs < 3)
		return FALSE

	if(!CONFIG("ENABLE_HIT_MESSAGES",FALSE))
		return FALSE

	attacker.visible_message(\
		span("warning",get_glance_message_3rd(attacker,victim,weapon,hit_object)),\
		span("warning",get_glance_message_1st(attacker,victim,weapon,hit_object)),\
		span("warning",get_glance_message_sound(attacker,victim,weapon,hit_object))\
	)
	return TRUE

/damagetype/proc/display_hit_message(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)

	if(enable_logs < 3)
		return FALSE

	if(!CONFIG("ENABLE_HIT_MESSAGES",FALSE))
		return FALSE

	attacker.visible_message(\
		span("warning", get_attack_message_3rd(attacker,victim,weapon,hit_object)),\
		span("danger",  get_attack_message_1st(attacker,victim,weapon,hit_object)),\
		span("warning", get_attack_message_sound(attacker,victim,weapon,hit_object))\
	)
	return TRUE

/damagetype/proc/display_miss_message(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/miss_text = "misses!")

	if(enable_logs < 3)
		return FALSE

	if(!CONFIG("ENABLE_HIT_MESSAGES",FALSE))
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
