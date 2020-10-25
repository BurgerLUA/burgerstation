/damagetype/melee/club/shield
	name = "shield"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = DAMAGE_AXE*0.1
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = AP_AXE
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = DAMAGE_AXE*0.5,
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT
	)

	skill_stats = list(
		SKILL_MELEE = DAMAGE_AXE*0.4,
	)

	skill_damage = list(
		SKILL_MELEE = BLUNT,
	)

/damagetype/melee/club/shield/energy/on
	name = "active energy shield"


	//impact_sounds = list('sound/weapon/melee/saberon.ogg')

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = DAMAGE_AXE*0.1,
		LASER = DAMAGE_AXE*0.4,
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = AP_AXE*0.25,
		LASER = AP_AXE*0.75,
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = DAMAGE_AXE*0.4
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT
	)

	skill_stats = list(
		SKILL_MELEE = DAMAGE_AXE*0.1
	)

	skill_damage = list(
		SKILL_MELEE = LASER
	)

/damagetype/melee/club/shield/energy
	name = "ianctive energy shield"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = DAMAGE_DAGGER*0.1
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = AP_DAGGER
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = DAMAGE_DAGGER*0.5,
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT
	)

	skill_stats = list(
		SKILL_MELEE = DAMAGE_DAGGER*0.4,
	)

	skill_damage = list(
		SKILL_MELEE = BLUNT,
	)