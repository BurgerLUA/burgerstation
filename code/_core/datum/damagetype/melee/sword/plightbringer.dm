/damagetype/melee/sword/plightbringer
	name = "unlit plightbringer"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = DAMAGE_GREATSWORD*0.2*BASE_MELEE_MUL
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = AP_GREATSWORD
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = DAMAGE_GREATSWORD*0.5
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLADE
	)

	skill_stats = list(
		SKILL_MELEE = DAMAGE_GREATSWORD*0.3,
	)

	skill_damage = list(
		SKILL_MELEE = BLADE
	)

	attack_delay = SPEED_GREATSWORD*0.5
	attack_delay_max = SPEED_GREATSWORD

/damagetype/melee/sword/plightbringer/on
	name = "blazing plightbringer"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = DAMAGE_GREATAXE*0.1*BASE_MELEE_MUL,
		LASER = DAMAGE_GREATAXE*0.1*BASE_MELEE_MUL,
		HEAT = DAMAGE_GREATAXE*0.1*BASE_MELEE_MUL
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = AP_GREATAXE*0.3,
		LASER = AP_GREATAXE*0.4,
		HEAT = AP_GREATAXE*0.3
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = DAMAGE_GREATAXE*0.3
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLADE,
		ATTRIBUTE_DEXTERITY = BLADE
	)

	skill_stats = list(
		SKILL_MELEE = DAMAGE_GREATAXE*0.2,
		SKILL_SORCERY = DAMAGE_GREATAXE*0.2
	)

	skill_damage = list(
		SKILL_MELEE = BLADE,
		SKILL_SORCERY = HEAT
	)

	bonus_experience = list(
		SKILL_MELEE = 25, //25%
		SKILL_SORCERY = 25
	)

	attack_delay = SPEED_GREATAXE*0.5
	attack_delay_max = SPEED_GREATAXE

/damagetype/melee/sword/plightbringer/on/post_on_hit(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/total_damage_dealt=0)

	. = ..()

	if(total_damage_dealt && is_living(victim))
		var/mob/living/L = victim
		L.ignite(SPEED_GREATAXE*2)

	return .
