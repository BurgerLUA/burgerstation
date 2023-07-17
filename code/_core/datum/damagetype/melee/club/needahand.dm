/damagetype/melee/club/needahand/

	//Base damage is high due to the high attack delay, which is due to the voicelines ranging up to 5 seconds long.
	attack_damage_base = list(
		BLUNT = 10,
		SANITY = 45
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 0,
		SANITY = 20
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 20,
		ATTRIBUTE_WILLPOWER = 20
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT,
		ATTRIBUTE_WILLPOWER = SANITY
	)

	skill_stats = list(
		SKILL_MELEE = 40
	)

	skill_damage = list(
		SKILL_MELEE = BLUNT
	)

	attack_delay = 30
	attack_delay_max = 45

	impact_sounds = list(
		'sound/weapons/melee/duke/ABORT.ogg',
		'sound/weapons/melee/duke/AISLE.ogg',
		'sound/weapons/melee/duke/BLOWIT.ogg',
		'sound/weapons/melee/duke/CHEW.ogg',
		'sound/weapons/melee/duke/DANCE.ogg',
		'sound/weapons/melee/duke/DIESOB.ogg',
		'sound/weapons/melee/duke/EATSHT.ogg',
		'sound/weapons/melee/duke/ESCAPE.ogg',
		'sound/weapons/melee/duke/FACE.ogg',
		'sound/weapons/melee/duke/GETSOM.ogg',
		'sound/weapons/melee/duke/GMEOVR.ogg',
		'sound/weapons/melee/duke/GOTHRT.ogg',
		'sound/weapons/melee/duke/GUYSUK.ogg',
		'sound/weapons/melee/duke/KICKA.ogg',
		'sound/weapons/melee/duke/MEAT.ogg',
		'sound/weapons/melee/duke/MEDEVL.ogg',
		'sound/weapons/melee/duke/MYSELF.ogg',
		'sound/weapons/melee/duke/POSTAL.ogg',
		'sound/weapons/melee/duke/QUAKE.ogg',
		'sound/weapons/melee/duke/RIP.ogg',
		'sound/weapons/melee/duke/RIPEM.ogg'
	)

/damagetype/melee/club/needahand/thrown

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 5,
		PIERCE = 15
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 0,
		SANITY = 20
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 10,
		ATTRIBUTE_WILLPOWER = 10
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT,
		ATTRIBUTE_WILLPOWER = SANITY
	)

	skill_stats = list(
		SKILL_MELEE = 20
	)

	skill_damage = list(
		SKILL_MELEE = BLUNT
	)

	attack_delay = 10
	attack_delay_max = 15

	impact_sounds = list(
		'sound/weapons/unarmed/slap.ogg'
	)