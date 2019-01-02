/datum/damagetype/
	var/name = "Damage type."
	var/id
	var/desc = "The type of damage dealt and all it's information."
	var/list/verbs = list("strike","hit","pummel") //Verbs to use
	var/weapon_name = "damage"
	var/impact_sounds = list()
	var/list/attack_damage = list(BRUTE = 0, BURN = 0, TOX = 0, OXY = 0) //How much attack damage to deal

	var/delay = 8
	var/last_hit = 0

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

	var/movement_x = 0
	var/movement_y = 0
	var/punch_distance = 12

	if(attacker.dir & NORTH)
		movement_y = punch_distance

	if(attacker.dir & SOUTH)
		movement_y = -punch_distance

	if(attacker.dir & EAST)
		movement_x = punch_distance

	if(attacker.dir & WEST)
		movement_x = -punch_distance

	animate(attacker, pixel_x = attacker.pixel_x + movement_x, pixel_y = attacker.pixel_y + movement_y, time = 4)
	animate(pixel_x = attacker.pixel_x - movement_x, pixel_y = attacker.pixel_y - movement_y, time = 4)

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
