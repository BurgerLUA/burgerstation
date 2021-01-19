/damagetype/melee/club/pickaxe/
	name = "pickaxe"

	impact_sounds = list(
		'sound/weapons/pickaxe/picaxe1.ogg',
		'sound/weapons/pickaxe/picaxe2.ogg',
		'sound/weapons/pickaxe/picaxe3.ogg'
	)


	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = DAMAGE_CLUB*0.2*BASE_MELEE_MUL,
		PIERCE = DAMAGE_CLUB*0.2*BASE_MELEE_MUL
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = AP_CLUB*0.5,
		PIERCE = AP_CLUB*0.5,
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = DAMAGE_CLUB*0.4
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = list(BLUNT, PIERCE)
	)

	skill_stats = list(
		SKILL_MELEE = DAMAGE_CLUB*0.2
	)

	skill_damage = list(
		SKILL_MELEE = list(BLUNT, PIERCE)
	)

	attack_delay = SPEED_CLUB*0.5
	attack_delay_max = SPEED_CLUB

	target_floors = TRUE

/damagetype/melee/club/pickaxe/get_critical_hit_condition(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	if(is_wall(victim))
		return TRUE
	return ..()

/damagetype/melee/club/pickaxe/do_critical_hit(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/list/damage_to_deal)
	if(is_wall(victim))
		return 4
	return ..()
