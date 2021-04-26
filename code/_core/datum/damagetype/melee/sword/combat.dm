/damagetype/melee/sword/combat_knife
	name = "combat knife"

	attack_damage_base = list(
		BLADE = 20,
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = 50
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 25,
		ATTRIBUTE_DEXTERITY = 25,
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLADE,
		ATTRIBUTE_DEXTERITY = BLADE
	)

	skill_stats = list(
		SKILL_MELEE = 25
	)

	skill_damage = list(
		SKILL_MELEE = BLADE
	)

	attack_delay = 8
	attack_delay_max = 10

	crit_multiplier = 4

/damagetype/melee/sword/combat_knife/get_crit_chance(var/mob/living/L)
	return 0

/damagetype/melee/sword/combat_knife/get_critical_hit_condition(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	return attacker.dir == victim.dir
