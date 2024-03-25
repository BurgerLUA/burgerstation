/damagetype/ranged/magic/pillar
	attack_damage_base = list(
		BLUNT = 280,
		HEAT = 40,
		ARCANE = 0,
		DARK = 0
	)

	attribute_stats = list(
		ATTRIBUTE_INTELLIGENCE = 60,
	)

	attribute_damage = list(
		ATTRIBUTE_INTELLIGENCE = ARCANE
	)

	skill_stats = list(
		SKILL_MAGIC = 100,
		SKILL_PRAYER = 100
	)

	skill_damage = list(
		SKILL_MAGIC = ARCANE,
		SKILL_PRAYER = DARK
	)

	force_attacker_armor_calculations_with = DARK

/damagetype/ranged/magic/pillar/process_damage(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/damage_multiplier=1)

	if(is_turf(hit_object))
		damage_multiplier *= 3 //More damage against walls.

	. = ..()