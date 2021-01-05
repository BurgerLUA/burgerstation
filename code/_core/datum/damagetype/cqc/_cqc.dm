/damagetype/cqc/
	impact_sounds = list(
		'sound/weapons/fists/cqchit1.ogg',
		'sound/weapons/fists/cqchit2.ogg'
	)

	attack_damage_base = list()

	damage_type_to_fatigue = list( //What percentage of damage blocked is converted into fatigue.
		BLADE = 1,
		BLUNT = 1,
		PIERCE = 1
	)

	experience_mod = 2


/damagetype/cqc/get_attack_type()
	return ATTACK_TYPE_UNARMED