/damagetype/melee/sword/chainsaw
	name = "chainsaw"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = 5,
		BLUNT = 15,
		PIERCE = 5
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 30
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = list(BLADE,BLUNT,PIERCE)
	)

	skill_stats = list(
		SKILL_MELEE = 10
	)

	skill_damage = list(
		SKILL_MELEE = BLADE
	)

	attack_delay = 20
	attack_delay_max = 20

/damagetype/melee/sword/chainsaw/on
	name = "chainsaw"


	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = 40,
		PIERCE = 10,
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = 50,
		PIERCE = 50
	)

	attribute_stats = list()

	attribute_damage = list()

	skill_stats = list()

	skill_damage = list()

	attack_delay = 8
	attack_delay_max = 10

	swing_sounds = list(
		'sound/weapons/chainsaw/swing.ogg'
	)