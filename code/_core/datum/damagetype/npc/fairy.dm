/damagetype/npc/fairy
	attack_verbs = list("hey")


	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		SANITY = 30,
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		SANITY = 0,
	)

	attribute_stats = list(
		ATTRIBUTE_WILLPOWER = 50,
	)

	attribute_damage = list(
		ATTRIBUTE_WILLPOWER = SANITY
	)

	attack_delay = 10*0.5
	attack_delay_max = 10

	impact_sounds = list(
		'sound/effects/impacts/fairy/navi.ogg',
		'sound/effects/impacts/fairy/idubbbz.ogg',
		'sound/effects/impacts/fairy/orange.ogg',
		'sound/effects/impacts/fairy/lego.ogg',
		'sound/effects/impacts/fairy/weeb.ogg',
		'sound/effects/impacts/fairy/mario.ogg',
	)