/damagetype/melee/club/shovel/
	name = "shovel"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = DAMAGE_CLUB*0.2*BASE_MELEE_MUL,
		BLUNT = DAMAGE_CLUB*0.2*BASE_MELEE_MUL,
		PIERCE = DAMAGE_CLUB*0.1*BASE_MELEE_MUL
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = AP_CLUB*0.5,
		BLUNT = AP_CLUB*0.25,
		PIERCE = AP_CLUB*0.25
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = DAMAGE_CLUB*0.3
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = list(BLUNT, BLADE, PIERCE)
	)

	skill_stats = list(
		SKILL_MELEE = DAMAGE_CLUB*0.2
	)

	skill_damage = list(
		SKILL_MELEE = list(BLUNT, BLADE, PIERCE)
	)

	attack_delay = SPEED_CLUB*0.5
	attack_delay_max = SPEED_CLUB

	target_floors = TRUE

/damagetype/melee/club/shovel/get_critical_hit_condition(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	if(is_floor(hit_object))
		return TRUE
	return ..()

/damagetype/melee/club/shovel/do_critical_hit(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/list/damage_to_deal)
	if(is_floor(hit_object))
		return 4
	return ..()
