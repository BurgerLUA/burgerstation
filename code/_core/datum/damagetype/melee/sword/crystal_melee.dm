/damagetype/melee/sword/crystal
	name = "conjuring crystals"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = DAMAGE_DAGGER*0.1,
		FATIGUE = DAMAGE_DAGGER*0.5
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = AP_DAGGER*0.25,
		FATIGUE = AP_DAGGER*0.75
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = DAMAGE_DAGGER*0.3
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLADE
	)

	skill_stats = list(
		SKILL_MELEE = DAMAGE_DAGGER*0.1,
	)

	skill_damage = list(
		SKILL_MELEE = BLADE
	)

	attack_delay = SPEED_SWORD*0.5
	attack_delay_max = SPEED_SWORD

/damagetype/melee/sword/crystal/rapier
	name = "crystal rapier"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		PIERCE = DAMAGE_SWORD*0.2,
		ARCANE = DAMAGE_SWORD*0.3
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		PIERCE = AP_SWORD*0.6,
		ARCANE = AP_SWORD*0.4
	)

	attribute_stats = list(
		ATTRIBUTE_DEXTERITY = DAMAGE_SWORD*0.2,
		ATTRIBUTE_INTELLIGENCE = DAMAGE_SWORD*0.2
	)

	attribute_damage = list(
		ATTRIBUTE_DEXTERITY = PIERCE,
		ATTRIBUTE_INTELLIGENCE = ARCANE
	)

	skill_stats = list(
		SKILL_MAGIC = DAMAGE_SWORD*0.2
	)

	skill_damage = list(
		SKILL_MAGIC = ARCANE
	)

	attack_delay = SPEED_SWORD*0.5
	attack_delay_max = SPEED_AXE

/damagetype/melee/sword/crystal/longsword
	name = "crystal longsword"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		PIERCE = DAMAGE_AXE*0.2,
		ARCANE = DAMAGE_CLUB*0.3
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		PIERCE = AP_SWORD*0.4,
		ARCANE = AP_SWORD*0.6
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = DAMAGE_SWORD*0.2,
		ATTRIBUTE_INTELLIGENCE = DAMAGE_CLUB*0.2
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = list(BLADE,PIERCE),
		ATTRIBUTE_INTELLIGENCE = ARCANE
	)

	skill_stats = list(
		SKILL_MELEE = DAMAGE_AXE*0.2,
		SKILL_MAGIC = DAMAGE_CLUB*0.2
	)

	skill_damage = list(
		SKILL_MAGIC = ARCANE
	)

	attack_delay = SPEED_SWORD*0.5
	attack_delay_max = SPEED_SWORD