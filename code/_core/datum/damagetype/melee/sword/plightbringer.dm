/damagetype/melee/sword/plightbringer
	name = "Unlit Plightbringer"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = 50,
		HEAT = 30
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = 30
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 20
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLADE
	)

	skill_stats = list(
		SKILL_MELEE = 30,
	)

	skill_damage = list(
		SKILL_MELEE = BLADE
	)

/damagetype/melee/sword/plightbringer/on
	name = "Blazing Plightbringer"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = 10,
		LASER = 20,
		HEAT = 10
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = 10,
		HEAT = 30
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 10,
		ATTRIBUTE_DEXTERITY = 20,
		ATTRIBUTE_INTELLIGENCE = 50
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLADE,
		ATTRIBUTE_DEXTERITY = BLADE,
		ATTRIBUTE_INTELLIGENCE = list(HEAT,MAGIC)
	)

	skill_stats = list(
		SKILL_MELEE = 30,
		SKILL_SORCERY = 50
	)

	skill_damage = list(
		SKILL_MELEE = BLADE,
		SKILL_SORCERY = list(HEAT,MAGIC)
	)

/damagetype/melee/sword/plightbringer/post_on_hit(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/total_damage_dealt=0)
	if(is_living(victim))
		var/mob/living/L = victim
		L.add_status_effect(FIRE,100,0,stealthy=L.on_fire)
	return ..()
