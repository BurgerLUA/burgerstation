/damagetype/ranged/bullet/rifle_308
	name = ".308 rifle bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = DAMAGE_CLUB*0.5,
		PIERCE = DAMAGE_CLUB*0.5
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = DAMAGE_CLUB*0.5,
		PIERCE = DAMAGE_CLUB*0.5
	)

	falloff = VIEW_RANGE + ZOOM_RANGE*3


/damagetype/ranged/bullet/rifle_308/ap
	name = ".308 ap rifle bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		PIERCE = DAMAGE_CLUB*0.75
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		PIERCE = AP_CLUB*3
	)

	falloff = VIEW_RANGE + ZOOM_RANGE*3


/damagetype/ranged/bullet/rifle_762mm
	name = "7.62mm rifle bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = DAMAGE_CLUB*0.25,
		PIERCE = DAMAGE_CLUB*0.75
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = AP_CLUB*0.5,
		PIERCE = AP_CLUB*0.5
	)

	falloff = VIEW_RANGE + ZOOM_RANGE*3

/damagetype/ranged/bullet/rifle_762mm/ap
	name = "AP 7.62mm rifle bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		PIERCE = DAMAGE_CLUB*0.75
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		PIERCE = AP_CLUB*3
	)



/damagetype/ranged/bullet/rifle_762mm/short
	name = "7.62mm short rifle bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = DAMAGE_CLUB*0.75,
		PIERCE = DAMAGE_CLUB*0.25
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = AP_CLUB*0.75,
		PIERCE = AP_CLUB*0.25
	)

	falloff = VIEW_RANGE + ZOOM_RANGE

/damagetype/ranged/bullet/rifle_762mm/long
	name = "7.62mm long rifle bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = DAMAGE_CLUB*0.75,
		PIERCE = DAMAGE_CLUB*0.25
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = AP_CLUB*0.5,
		PIERCE = AP_CLUB*0.5
	)

	falloff = VIEW_RANGE + ZOOM_RANGE*3