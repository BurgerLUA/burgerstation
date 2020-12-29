/damagetype/ranged/bullet/rifle_223
	name = ".223 rifle bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = DAMAGE_AXE*0.5,
		PIERCE = DAMAGE_AXE*0.5
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = AP_AXE*0.5,
		PIERCE = AP_AXE*0.5
	)

	falloff = VIEW_RANGE + ZOOM_RANGE

/damagetype/ranged/bullet/rifle_223/ap
	name = "ap .223 rifle bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		PIERCE = DAMAGE_AXE*0.75
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		PIERCE = AP_AXE*3
	)

/damagetype/ranged/bullet/rifle_556mm
	name = "5.56mm rifle bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = DAMAGE_AXE*0.25,
		PIERCE = DAMAGE_AXE*0.75
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = AP_AXE*0.25,
		PIERCE = AP_AXE*0.75
	)

	falloff = VIEW_RANGE + ZOOM_RANGE

/damagetype/ranged/bullet/rifle_556mm/ap
	name = "AP 5.56mm rifle bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		PIERCE = DAMAGE_AXE*0.75
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		PIERCE = AP_AXE*3
	)

/damagetype/ranged/bullet/rifle_545mm
	name = "5.45mm rifle bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		PIERCE = DAMAGE_SWORD
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		PIERCE = AP_SWORD
	)

	falloff = VIEW_RANGE + ZOOM_RANGE

/damagetype/ranged/bullet/rifle_545mm/ap
	name = "AP 5.45mm rifle bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		PIERCE = DAMAGE_SWORD*0.75
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		PIERCE = AP_SWORD*3
	)

	falloff = VIEW_RANGE + ZOOM_RANGE

/damagetype/ranged/bullet/rifle_939mm
	name = "9x39mm subsonic rifle bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = DAMAGE_SWORD*0.75,
		PIERCE = DAMAGE_SWORD*0.25
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = DAMAGE_SWORD*0.5,
		PIERCE = DAMAGE_SWORD*0.5
	)

	falloff = VIEW_RANGE
