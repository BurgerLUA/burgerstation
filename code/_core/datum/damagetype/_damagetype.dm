/damagetype/
	name = "Damage type."
	id = null
	desc = "The type of damage dealt and all it's information."

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

	var/list/wound/wound_types = list()

	//How much base attack damage to deal
	var/list/base_attack_damage = list(
		BRUTE = 0,
		BURN = 0,
		TOX = 0,
		OXY = 0
	)

	var/attack_delay = 8
	var/attack_last = 0

	var/list/attribute_stats = list(
		ATTRIBUTE_STRENGTH = CLASS_F,
		ATTRIBUTE_AGILITY = CLASS_F,
		ATTRIBUTE_INTELLIGENCE = CLASS_F
	)

	var/list/attribute_damage = list(
		ATTRIBUTE_STRENGTH = BRUTE,
		ATTRIBUTE_AGILITY = BRUTE,
		ATTRIBUTE_INTELLIGENCE = BRUTE
	)

	var/list/skill_stats = list(
		SKILL_UNARMED = CLASS_F,
		SKILL_MELEE = CLASS_F,
		SKILL_RANGED = CLASS_F
	)

	var/list/skill_damage = list(
		SKILL_UNARMED = BRUTE,
		SKILL_MELEE = BRUTE,
		SKILL_RANGED = BRUTE
	)

	var/list/skill_xp_per_damage = list(
		SKILL_UNARMED = 0,
		SKILL_MELEE = 0,
		SKILL_RANGED = 0
	)

	var/allow_parry = TRUE
	var/allow_parry_counter = TRUE
	var/allow_miss = TRUE
	var/allow_block = TRUE
	var/allow_dodge = TRUE

	var/obj/effect/temp/impact/hit_effect = /obj/effect/temp/impact/combat/smash

	var/draw_blood = FALSE
	var/draw_weapon = FALSE

/damagetype/proc/get_miss_chance()
	return 0

/damagetype/proc/get_attack_type()
	return ATTACK_TYPE_MELEE

/damagetype/proc/perform_miss(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	if(!victim.get_miss_chance(attacker,weapon,hit_object) + get_miss_chance())
		return FALSE
	do_miss_sound(attacker,victim,weapon,hit_object)
	do_attack_animation(attacker,victim,weapon,hit_object)
	display_miss_message(attacker,victim,weapon,hit_object,"avoided")
	return TRUE

/damagetype/proc/can_attack(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)

	if(attack_last + get_attack_delay(attacker,victim,weapon,hit_object) > world.time)
		return FALSE

	return TRUE

/damagetype/proc/get_attack_damage(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)

	if(!is_living(attacker))
		return base_attack_damage

	var/mob/living/L = attacker
	var/list/new_attack_damage = base_attack_damage.Copy()

	for(var/k in attribute_stats)
		var/v = attribute_stats[k]
		new_attack_damage[attribute_damage[k]] += L.get_attribute_level(k)*v

	for(var/k in skill_stats)
		var/v = skill_stats[k]
		new_attack_damage[skill_damage[k]] += L.get_skill_level(k)*v

	return new_attack_damage

/damagetype/proc/get_attack_delay(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	return attack_delay

/damagetype/proc/get_rating()

	var/returning = 0

	for(var/k in base_attack_damage)
		returning += base_attack_damage[k]*0.05

	for(var/k in attribute_stats)
		returning += attribute_stats[k]

	for(var/k in skill_stats)
		returning += skill_stats[k]

	return returning*10

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

/damagetype/proc/do_damage(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)

	var/brute_armor = 0
	var/burn_armor = 0

	if(is_living(victim))
		var/mob/living/L = victim
		if(L.status & FLAG_STATUS_IMMORTAL)
			return 0

		brute_armor += L.armor_brute_base
		burn_armor += L.armor_burn_base

		if(is_advanced(victim) && is_organ(hit_object))
			var/mob/living/advanced/A = victim
			var/armor_level_mod = 1 + A.get_skill_power(SKILL_ARMOR,0,100)
			var/obj/item/organ/O = hit_object
			for(var/obj/item/clothing/C in A.worn_objects)
				if(O.id in C.protected_limbs)
					brute_armor += C.armor_rating[BRUTE] * armor_level_mod
					burn_armor += C.armor_rating[BURN] * armor_level_mod

			A.add_skill_xp(SKILL_ARMOR,brute_armor + burn_armor)

	var/damage_to_deal = get_attack_damage(attacker,victim,weapon,hit_object)
	var/brute_damage_dealt = calculate_damage_with_armor(hit_object.adjust_brute_loss(damage_to_deal[BRUTE]),brute_armor)
	var/burn_damage_dealt = calculate_damage_with_armor(hit_object.adjust_burn_loss(damage_to_deal[BURN]),burn_armor)
	var/tox_damage_dealt = hit_object.adjust_tox_loss(damage_to_deal[TOX])
	var/oxy_damage_dealt = hit_object.adjust_oxy_loss(damage_to_deal[OXY])
	var/damage_dealt =  brute_damage_dealt + burn_damage_dealt + tox_damage_dealt + oxy_damage_dealt

	if(length(wound_types))
		var/wound/W = pick(wound_types)
		W = new W(victim,hit_object,attacker,weapon,damage_dealt)
		hit_object.wounds += W
		if(victim != hit_object)
			victim.wounds += W

	play_effects(attacker,victim,weapon,hit_object,damage_dealt)
	display_hit_message(attacker,victim,weapon,hit_object)

	hit_object.update_health(damage_dealt,attacker)

	if(victim != hit_object)
		victim.update_health(damage_dealt,attacker)

	if(is_living(attacker) && victim && attacker != victim)
		var/mob/living/A = attacker
		for(var/skill in skill_xp_per_damage)
			var/xp_to_give = floor(skill_xp_per_damage[skill] * damage_dealt * victim.get_xp_multiplier())
			if(xp_to_give > 0)
				A.add_skill_xp(skill,xp_to_give)


	return damage_dealt

/damagetype/proc/play_effects(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/damage_dealt=0)
	do_attack_sound(attacker,victim,weapon,hit_object)
	do_attack_animation(attacker,victim,weapon,hit_object)
	do_attack_visuals(attacker,victim,weapon,hit_object,damage_dealt)

/damagetype/proc/do_attack_visuals(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/damage_dealt)


	if(hit_effect)
		new hit_effect(get_turf(victim))

	hit_object.do_impact_effect(attacker,weapon,src,damage_dealt)

	if(draw_weapon)
		var/obj/effect/temp/impact/weapon_clone/WC = new(get_turf(attacker))

		var/offset_x = (victim.x - attacker.x)*TILE_SIZE
		var/offset_y = (victim.y - attacker.y)*TILE_SIZE

		animate(WC,pixel_x = offset_x, pixel_y = offset_y,time = 3)

	if(victim.health_max)

		var/multiplier = TILE_SIZE * (damage_dealt / victim.health_max) * 2
		multiplier = Clamp(multiplier,0,TILE_SIZE*0.5)

		var/offset_x = (victim.x - attacker.x)
		var/offset_y = (victim.y - attacker.y)

		if(!offset_x && !offset_y)
			offset_x = rand(-1,1)
		//TODO: Just make a normalize proc
		var/total_offset = abs(offset_x) + abs(offset_y)

		if(total_offset)
			offset_x = offset_x/total_offset
			offset_y = offset_y/total_offset
			offset_x *= multiplier
			offset_y *= multiplier
		else
			offset_x = 0
			offset_y = 0

		if(is_player(victim))
			var/mob/living/advanced/player/P = victim
			if(P && P.client)
				var/client/C = P.client
				animate(C,pixel_x = offset_x, pixel_y = offset_y,time=1)
				animate(pixel_x = 0, pixel_y = 0, time = 5)

		if(is_movable(victim) && victim.health_current <= 0)
			if(multiplier >= TILE_SIZE)
				var/atom/movable/M = victim
				M.glide_size = TILE_SIZE
				var/move_direction = 0
				if(offset_x)
					if(offset_x > 0)
						move_direction &= WEST
					else
						move_direction &= EAST
				if(offset_y)
					if(offset_y > 0)
						move_direction &= NORTH
					else
						move_direction &= SOUTH
				step(M,move_direction)

			else if(victim.pixel_x == initial(victim.pixel_x) && victim.pixel_y == initial(victim.pixel_y))
				animate(victim,pixel_x = offset_x, pixel_y = offset_y,time=1)

		else
			animate(victim,pixel_x = offset_x, pixel_y = offset_y,time=1)
			animate(pixel_x = initial(victim.pixel_x), pixel_y = initial(victim.pixel_y), time = 5)




/damagetype/proc/do_attack_sound(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	if(length(impact_sounds))
		var/area/A = get_area(victim)
		play_sound(pick(impact_sounds),all_mobs_with_clients,vector(victim.x,victim.y,victim.z),environment = A.sound_environment)

/damagetype/proc/do_miss_sound(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	if(length(miss_sounds))
		var/area/A = get_area(victim)
		play_sound(pick(miss_sounds),all_mobs_with_clients,vector(victim.x,victim.y,victim.z),environment = A.sound_environment)

/damagetype/proc/do_attack_animation(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	var/pixel_x_offset = 0
	var/pixel_y_offset = 0
	var/punch_distance = 12

	if(attacker.dir & NORTH)
		pixel_y_offset = punch_distance

	if(attacker.dir & SOUTH)
		pixel_y_offset = -punch_distance

	if(attacker.dir & EAST)
		pixel_x_offset = punch_distance

	if(attacker.dir & WEST)
		pixel_x_offset = -punch_distance

	if(is_mob(attacker))
		var/mob/M = attacker
		//M.add_animation(pixel_x = movement_x, pixel_y = movement_y, time = 2)
		//M.add_animation(pixel_x = -movement_x, pixel_y = -movement_y, time = 4, delay = 2, time = 4)

		var/matrix/attack_matrix = matrix()
		attack_matrix.Translate(pixel_x_offset,pixel_y_offset)

		animate(M, transform = attack_matrix, time = ATTACK_ANIMATION_LENGTH * 0.5, flags = ANIMATION_LINEAR_TRANSFORM)
		animate(transform = matrix(), time = ATTACK_ANIMATION_LENGTH, flags = ANIMATION_LINEAR_TRANSFORM)

/damagetype/proc/get_weapon_name(var/atom/backup)
	if(weapon_name)
		return weapon_name
	else
		return backup.name

/damagetype/proc/get_attack_message_3rd(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	if(victim == hit_object)
		return span("danger","\The [attacker] [pick(attack_verbs)]s \the [hit_object] with \the [get_weapon_name(weapon)].")
	else
		return span("danger","\The [attacker] [pick(attack_verbs)]s \the [victim]'s [hit_object.name] with \the [get_weapon_name(weapon)].")

/damagetype/proc/get_attack_message_1st(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	if(victim == hit_object)
		return span("warning","You [pick(attack_verbs)] \the [hit_object] with your [get_weapon_name(weapon)].")
	else
		return span("warning","You [pick(attack_verbs)] \the [victim]'s [hit_object.name] with your [get_weapon_name(weapon)].")

/damagetype/proc/get_attack_message_sound(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	return span("danger","You hear a sickening impact.")

/damagetype/proc/get_miss_message_3rd(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	if(victim == hit_object)
		return span("danger","\The [attacker] [pick(miss_verbs)]s at \the [hit_object] with \the [get_weapon_name(weapon)], but the attack was #REASON!")
	else
		return span("danger","\The [attacker] [pick(miss_verbs)]s at \the [victim]'s [hit_object.name] with \the [get_weapon_name(weapon)], but the attack was #REASON!")

/damagetype/proc/get_miss_message_1st(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	if(victim == hit_object)
		return span("warning","You [pick(miss_verbs)] at \the [hit_object.name] with your [get_weapon_name(weapon)], but the attack was #REASON!")
	else
		return span("warning","You [pick(miss_verbs)] at \the [victim]'s [hit_object.name] with your [get_weapon_name(weapon)], but the attack was #REASON!")

/damagetype/proc/get_miss_message_sound(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	return span("danger","You hear a swoosh...")