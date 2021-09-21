/damagetype/ranged/bullet/rifle_308
	attack_damage_base = list(
		BLUNT = 30,
		PIERCE = 30
	)

	attack_damage_penetration = list(
		BLUNT = 25,
		PIERCE = 25
	)
	falloff = VIEW_RANGE + ZOOM_RANGE*3

/damagetype/ranged/bullet/rifle_308/surplus
	damage_mod = SURPLUS_MUL
	penetration_mod = SURPLUS_MUL

/damagetype/ranged/bullet/rifle_308/ap
	damage_mod = SURPLUS_MUL
	penetration_mod = ARMOR_MUL

/damagetype/ranged/bullet/rifle_762mm

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 10,
		PIERCE = 50
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 25,
		PIERCE = 25
	)

	falloff = VIEW_RANGE + ZOOM_RANGE*3

/damagetype/ranged/bullet/rifle_762mm/surplus
	damage_mod = SURPLUS_MUL
	penetration_mod = SURPLUS_MUL

/damagetype/ranged/bullet/rifle_762mm/ap
	damage_mod = SURPLUS_MUL
	penetration_mod = ARMOR_MUL

/damagetype/ranged/bullet/rifle_762mm/premium
	damage_mod = PREMIUM_MUL
	penetration_mod = PREMIUM_MUL

/damagetype/ranged/bullet/rifle_762mm/short
	attack_damage_base = list(
		BLUNT = 40,
		PIERCE = 10
	)
	attack_damage_penetration = list(
		BLUNT = 25,
		PIERCE = 25
	)
	falloff = VIEW_RANGE + ZOOM_RANGE

/damagetype/ranged/bullet/rifle_762mm/short/surplus
	damage_mod = SURPLUS_MUL
	penetration_mod = SURPLUS_MUL

/damagetype/ranged/bullet/rifle_762mm/long
	attack_damage_base = list(
		BLUNT = 35,
		PIERCE = 25
	)
	attack_damage_penetration = list(
		BLUNT = 25,
		PIERCE = 25
	)
	falloff = VIEW_RANGE + ZOOM_RANGE*3

/damagetype/ranged/bullet/rifle_762mm/long/surplus
	damage_mod = SURPLUS_MUL
	penetration_mod = SURPLUS_MUL

/damagetype/ranged/bullet/revolver_762
	attack_damage_base = list(
		BLUNT = 40,
		PIERCE = 5
	)
	attack_damage_penetration = list(
		BLUNT = 25,
		PIERCE = 25
	)
	falloff = VIEW_RANGE + ZOOM_RANGE

/damagetype/ranged/bullet/revolver_762/surplus
	damage_mod = SURPLUS_MUL
	penetration_mod = SURPLUS_MUL