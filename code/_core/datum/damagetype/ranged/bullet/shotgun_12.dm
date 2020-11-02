/damagetype/ranged/bullet/shotgun/buckshot
	name = "group of buckshot pellets"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = DAMAGE_AXE*0.5,
		BLUNT = DAMAGE_AXE*0.25,
		PIERCE = DAMAGE_AXE*0.25
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = AP_AXE*0.5,
		BLUNT = AP_AXE*0.25,
		PIERCE = AP_AXE*0.25
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
		BLUNT = DAMAGE_CLUB*0.8,
		PIERCE = DAMAGE_CLUB*0.2
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = AP_CLUB*0.9,
		PIERCE = AP_CLUB*0.1
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
		PIERCE = DAMAGE_AXE
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		PIERCE = AP_AXE
	)

	falloff = VIEW_RANGE*0.5