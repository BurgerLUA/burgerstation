/damagetype/cqc/
	impact_sounds = list(
		'sound/weapons/fists/cqchit1.ogg',
		'sound/weapons/fists/cqchit2.ogg'
	)

	allow_parry = FALSE
	allow_miss = FALSE
	allow_block = FALSE
	allow_dodge = FALSE

	attack_damage_base = list(
		BLADE = 0,
		BLUNT = 0,
		PIERCE = 0,
		LASER = 0,
		MAGIC = 0,
		HEAT = 0,
		COLD = 0,
		BOMB = 0,
		BIO = 0,
		RAD = 0,
		HOLY = 0,
		DARK = 0,
		FATIGUE = 0,
		ION = 0
	)


/damagetype/cqc/get_attack_type()
	return ATTACK_TYPE_UNARMED