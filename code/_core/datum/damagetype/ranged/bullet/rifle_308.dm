/damagetype/ranged/bullet/rifle_308
	name = ".308 rifle bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 60*0.5,
		PIERCE = 60*0.5
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 60*0.5,
		PIERCE = 60*0.5
	)

	falloff = VIEW_RANGE + ZOOM_RANGE*3

/damagetype/ranged/bullet/rifle_308/surplus
	damage_mod = SURPLUS_MUL
	penetration_mod = SURPLUS_MUL


/damagetype/ranged/bullet/rifle_308/ap
	name = ".308 ap rifle bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		PIERCE = 60*0.75
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		PIERCE = 60*3
	)

	falloff = VIEW_RANGE + ZOOM_RANGE*3


/damagetype/ranged/bullet/rifle_762mm
	name = "7.62mm rifle bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 60*0.25,
		PIERCE = 60*0.75
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 60*0.5,
		PIERCE = 60*0.5
	)

	falloff = VIEW_RANGE + ZOOM_RANGE*3

/damagetype/ranged/bullet/rifle_762mm/surplus
	damage_mod = SURPLUS_MUL
	penetration_mod = SURPLUS_MUL

/damagetype/ranged/bullet/rifle_762mm/ap
	name = "AP 7.62mm rifle bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		PIERCE = 60*0.75
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		PIERCE = 60*3
	)

/damagetype/ranged/bullet/rifle_762mm/short
	name = "7.62mm short rifle bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 60*0.75,
		PIERCE = 60*0.25
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 60*0.75,
		PIERCE = 60*0.25
	)

	falloff = VIEW_RANGE + ZOOM_RANGE

/damagetype/ranged/bullet/rifle_762mm/short/surplus
	damage_mod = SURPLUS_MUL
	penetration_mod = SURPLUS_MUL

/damagetype/ranged/bullet/rifle_762mm/long
	name = "7.62mm long rifle bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 60*0.75,
		PIERCE = 60*0.25
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 60*0.5,
		PIERCE = 60*0.5
	)

	falloff = VIEW_RANGE + ZOOM_RANGE*3

/damagetype/ranged/bullet/rifle_762mm/long/surplus
	damage_mod = SURPLUS_MUL
	penetration_mod = SURPLUS_MUL