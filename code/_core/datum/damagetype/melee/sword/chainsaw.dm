/damagetype/melee/sword/chainsaw
	name = "chainsaw"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = 60*0.3,
		BLUNT = 60*0.1,
		PIERCE = 60*0.1
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 60*0.3
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = list(BLADE,BLUNT,PIERCE)
	)

	skill_stats = list(
		SKILL_MELEE = 60*0.2
	)

	skill_damage = list(
		SKILL_MELEE = BLADE
	)

	attack_delay = 14*0.5
	attack_delay_max = 14

/damagetype/melee/sword/chainsaw/on
	name = "chainsaw"


	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = DAMAGE_GREATSWORD*0.8,
		PIERCE = DAMAGE_GREATSWORD*0.2,
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = AP_GREATSWORD*0.75,
		PIERCE = AP_GREATSWORD*0.25
	)

	attribute_stats = list()

	attribute_damage = list()

	skill_stats = list()

	skill_damage = list()

	attack_delay = SPEED_GREATSWORD*0.5
	attack_delay_max = SPEED_GREATSWORD*0.5

	swing_sounds = list(
		'sound/weapons/chainsaw/swing.ogg'
	)