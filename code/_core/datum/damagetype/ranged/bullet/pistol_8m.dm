/damagetype/ranged/bullet/pistol_8mm
	name = "8mm pistol"
	id = "8mm"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = DAMAGE_E,
		PIERCE = DAMAGE_E
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = ARMOR_E,
		PIERCE = ARMOR_E
	)

/damagetype/ranged/bullet/pistol_8mm/hollowpoint
	name = "8mm pistol"
	id = "8mm_hollowpoint"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = DAMAGE_E*2,
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(

	)

	crit_multiplier = 2
	crit_chance = 100
	crit_chance_max = 100

/damagetype/ranged/bullet/pistol_8mm/hollowpoint/get_critical_hit_condition(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	return istype(hit_object,/obj/item/organ/head)