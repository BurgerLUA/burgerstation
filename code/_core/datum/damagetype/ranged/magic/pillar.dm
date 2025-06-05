/damagetype/ranged/magic/pillar
	attack_damage_base = list(
		BLUNT = 280,
	)

	attribute_stats = list()

	attribute_damage = list()

	skill_stats = list(
		SKILL_PRAYER = 100
	)

	skill_damage = list(
		SKILL_PRAYER = BLUNT
	)

	damage_magic_type_consideration = list(
		BLUNT = DARK,
	)

/damagetype/ranged/magic/pillar/process_damage(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/damage_multiplier=1)

	if(is_turf(hit_object))
		damage_multiplier *= 3 //More damage against walls.

	. = ..()