/damagetype/ranged/bullet/sniper_50
	name = "sniper rifle bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		PIERCE = 105*0.75,
		BLUNT = 105*0.25
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		PIERCE = 120,
		BLUNT = 0
	)

	falloff = VIEW_RANGE*3

/damagetype/ranged/bullet/sniper_50/surplus
	damage_mod = SURPLUS_MUL
	penetration_mod = SURPLUS_MUL

/damagetype/ranged/bullet/sniper_50/explosive
	name = "sniper rifle bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		PIERCE = 105*0.25,
		BLUNT = 105*0.25,
		BOMB = 105*0.5
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		PIERCE = 120*0.1,
		BLUNT = 120*0.1,
		BOMB = 120*0.8
	)

/damagetype/ranged/bullet/sniper_50/ion
	name = "sniper rifle bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 105*0.25,
		ION = 105*0.75
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 120*0.25,
		ION = 120*0.75
	)


/damagetype/ranged/bullet/sniper_50/ap
	name = "sniper rifle bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		PIERCE = 105*0.75
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		PIERCE = 120*3
	)


/damagetype/ranged/bullet/sniper_50/incendiary
	name = "sniper rifle bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BOMB = 105*0.25,
		BLUNT = 105*0.25
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BOMB = 120*0.25,
		BLUNT = 120*0.25
	)

/damagetype/ranged/bullet/sniper_50/incendiary/post_on_hit(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/total_damage_dealt=0)
	if(is_living(victim))
		var/mob/living/L = victim
		L.add_status_effect(FIRE,150,150,stealthy=L.on_fire)
	return ..()