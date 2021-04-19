/damagetype/melee/sword/plightbringer
	name = "unlit plightbringer"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = 75*0.2
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = 80
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 75*0.5
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLADE
	)

	skill_stats = list(
		SKILL_MELEE = 75*0.3,
	)

	skill_damage = list(
		SKILL_MELEE = BLADE
	)

	attack_delay = 16*0.5
	attack_delay_max = 16

/damagetype/melee/sword/plightbringer/on
	name = "blazing plightbringer"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = 90*0.1,
		LASER = 90*0.1,
		HEAT = 90*0.1
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = 100*0.3,
		LASER = 100*0.4,
		HEAT = 100*0.3
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 90*0.3
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLADE,
		ATTRIBUTE_DEXTERITY = BLADE
	)

	skill_stats = list(
		SKILL_MELEE = 90*0.2,
		SKILL_SORCERY = 90*0.2
	)

	skill_damage = list(
		SKILL_MELEE = BLADE,
		SKILL_SORCERY = HEAT
	)

	bonus_experience_skill = list(
		SKILL_MELEE = 25, //25%
		SKILL_SORCERY = 25
	)

	attack_delay = 18*0.5
	attack_delay_max = 18

/damagetype/melee/sword/plightbringer/on/post_on_hit(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/total_damage_dealt=0)

	. = ..()

	if(total_damage_dealt && is_living(victim))
		var/mob/living/L = victim
		L.ignite(18*2,attacker)
