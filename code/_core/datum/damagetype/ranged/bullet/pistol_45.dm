/damagetype/ranged/bullet/pistol_45
	name = "pistol bullet"

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

	falloff = VIEW_RANGE



/damagetype/ranged/bullet/pistol_45/ap
	name = "ap pistol bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		PIERCE = DAMAGE_AXE*0.75
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		PIERCE = AP_AXE*3
	)

	falloff = VIEW_RANGE


/damagetype/ranged/bullet/pistol_45/hp
	name = "hp pistol bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = DAMAGE_AXE
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = 0
	)

	falloff = VIEW_RANGE