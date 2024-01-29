/damagetype/melee/club/pickaxe/

	impact_sounds = list(
		'sound/weapons/melee/pickaxe/picaxe1.ogg',
		'sound/weapons/melee/pickaxe/picaxe2.ogg',
		'sound/weapons/melee/pickaxe/picaxe3.ogg'
	)


	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 20,
		PIERCE = 10
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 75,
		PIERCE = 75,
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 40
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = list(BLUNT, PIERCE)
	)

	skill_stats = list(
		SKILL_MELEE = 20
	)

	skill_damage = list(
		SKILL_MELEE = list(BLUNT, PIERCE)
	)

	attack_delay = 10
	attack_delay_max = 15

	target_floors = TRUE

/damagetype/melee/club/pickaxe/get_critical_hit_condition(atom/attacker,atom/victim,atom/weapon,atom/hit_object)
	if(is_wall(victim))
		return TRUE
	return ..()

/damagetype/melee/club/pickaxe/do_critical_hit(atom/attacker,atom/victim,atom/weapon,atom/hit_object,list/damage_to_deal)
	if(is_wall(victim))
		return 4
	return ..()

/damagetype/melee/club/pickaxe/diamond

	attack_damage_base = list(
		BLUNT = 20,
		PIERCE = 40
	)

	attack_damage_penetration = list(
		BLUNT = 100,
		PIERCE = 100,
	)