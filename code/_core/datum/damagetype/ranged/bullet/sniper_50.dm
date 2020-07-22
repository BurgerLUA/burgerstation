/damagetype/ranged/bullet/sniper_50
	name = "sniper rifle bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 40,
		PIERCE = 120,
		FATIGUE = 50
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 50,
		PIERCE = 50
	)

	falloff = VIEW_RANGE*3



/damagetype/ranged/bullet/sniper_50/explosive
	name = "sniper rifle bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 40,
		FATIGUE = 50,
		BOMB = 100
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list()

/damagetype/ranged/bullet/sniper_50/ion
	name = "sniper rifle bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 40,
		FATIGUE = 50,
		ION = 200
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list()


/damagetype/ranged/bullet/sniper_50/ap
	name = "sniper rifle bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		PIERCE = 120
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		PIERCE = INFINITY
	)


/damagetype/ranged/bullet/sniper_50/incendiary
	name = "sniper rifle bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BOMB = 25,
		BLUNT = 40,
		FATIGUE = 50
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list()

/damagetype/ranged/bullet/sniper_50/incendiary/post_on_hit(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/total_damage_dealt=0)
	if(is_living(victim))
		var/mob/living/L = victim
		L.add_status_effect(FIRE,150,0,stealthy=L.on_fire)
	return ..()