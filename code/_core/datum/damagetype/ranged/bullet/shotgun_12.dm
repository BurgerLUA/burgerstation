/damagetype/ranged/bullet/shotgun/buckshot
	name = "group of buckshot pellets"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = 10,
		BLUNT = 20
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = 0,
		BLUNT = 0
	)

	falloff = VIEW_RANGE*0.5

	damage_type_to_fatigue = list( //What percentage of damage blocked is converted into fatigue.
		BLUNT = 0.75,
		PIERCE = 0.25
	)

/damagetype/ranged/bullet/shotgun/slug
	name = "shotgun slug"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 60,
		PIERCE = 10
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 0,
		PIERCE = 0
	)

	falloff = VIEW_RANGE

	damage_type_to_fatigue = list( //What percentage of damage blocked is converted into fatigue.
		BLUNT = 0.75,
		PIERCE = 0.25
	)

/damagetype/ranged/bullet/shotgun/flechette
	name = "shotgun flechette"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		PIERCE = 30
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		PIERCE = 50
	)

	falloff = VIEW_RANGE*0.5