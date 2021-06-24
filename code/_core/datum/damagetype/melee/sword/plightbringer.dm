/damagetype/melee/sword/plightbringer
	name = "unlit plightbringer"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = 20
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = 75
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 50
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLADE
	)

	skill_stats = list(
		SKILL_MELEE = 30
	)

	skill_damage = list(
		SKILL_MELEE = BLADE
	)

	attack_delay = 10
	attack_delay_max = 20

/damagetype/melee/sword/plightbringer/on
	name = "blazing plightbringer"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = 10,
		LASER = 10,
		HEAT = 50
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = 50,
		LASER = 100,
		HEAT = 50
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 40
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLADE
	)

	skill_stats = list(
		SKILL_MELEE = 25,
		SKILL_MAGIC_OFFENSIVE = 50
	)

	skill_damage = list(
		SKILL_MELEE = BLADE,
		SKILL_MAGIC_OFFENSIVE = HEAT
	)

	bonus_experience_skill = list(
		SKILL_MELEE = 25, //25%
		SKILL_MAGIC_OFFENSIVE = 25
	)

	attack_delay = 20
	attack_delay_max = 20

/damagetype/melee/sword/plightbringer/on/post_on_hit(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/total_damage_dealt=0)

	. = ..()

	if(total_damage_dealt && is_living(victim))
		var/mob/living/L = victim
		L.ignite(18*2,attacker)
