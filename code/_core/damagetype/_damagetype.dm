/datum/damagetype/
	var/name = "Damage type."
	var/id
	var/desc = "The type of damage dealt and all it's information."
	var/list/verbs = list("strike","hit","pummel") //Verbs to use
	var/weapon_name = "damage"
	var/impact_sounds = list()
	var/list/attack_damage = list(BRUTE = 0, BURN = 0, TOX = 0, OXY = 0) //How much attack damage to deal

	var/attack_delay = 8
	var/attack_last = 0

/datum/damagetype/proc/can_attack(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)

	if(attack_last + get_attack_delay(attacker,victim,weapon,hit_object) > world.time)
		return FALSE

	return TRUE

/datum/damagetype/proc/do_damage(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)

	play_effects(attacker,victim,weapon,hit_object)

	attacker.visible_message(\
		get_attack_message_3rd(attacker,victim,weapon,hit_object),\
		get_attack_message_1st(attacker,victim,weapon,hit_object),\
		get_attack_message_sound(attacker,victim,weapon,hit_object)\
	)

	var/damage_to_deal = get_attack_damage(attacker,victim,weapon,hit_object)
	var/damage_dealt = hit_object.adjust_brute_loss(damage_to_deal[BRUTE]) + hit_object.adjust_burn_loss(damage_to_deal[BURN]) + hit_object.adjust_tox_loss(damage_to_deal[TOX]) + hit_object.adjust_oxy_loss(damage_to_deal[OXY])
	victim.update_icon()

	return damage_dealt

/datum/damagetype/proc/play_effects(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	if(length(impact_sounds))
		var/area/A = get_area(victim)
		play_sound(pick(impact_sounds),all_mobs,vector(victim.x,victim.y,victim.z),environment = A.sound_environment)

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

		animate(M, pixel_x = M.pixel_x + pixel_x_offset, pixel_y = M.pixel_y + pixel_y_offset, time = ATTACK_ANIMATION_LENGTH * 0.5, flags = ANIMATION_LINEAR_TRANSFORM)
		animate(pixel_x = M.pixel_x - pixel_x_offset, pixel_y = M.pixel_y - pixel_y_offset, time = ATTACK_ANIMATION_LENGTH, flags = ANIMATION_LINEAR_TRANSFORM)


/datum/damagetype/proc/get_attack_message_3rd(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	if(victim == hit_object)
		return span("danger","\The [attacker] [pick(verbs)]s \the [hit_object] with \his [weapon_name].")
	else
		return span("danger","\The [attacker] [pick(verbs)]s \the [victim]'s [hit_object] with \his [weapon_name].")

/datum/damagetype/proc/get_attack_message_1st(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	if(victim == hit_object)
		return span("danger","You [pick(verbs)] \the [hit_object] with your [weapon_name].")
	else
		return span("danger","You [pick(verbs)] \the [victim]'s [hit_object] with your [weapon_name].")
/datum/damagetype/proc/get_attack_message_sound(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	return span("danger","You hear a sickening impact.")

/datum/damagetype/proc/get_attack_damage(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	return attack_damage

/datum/damagetype/proc/get_attack_delay(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	return attack_delay
