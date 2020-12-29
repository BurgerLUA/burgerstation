/damagetype/ranged/bullet/sniper_50
	name = "sniper rifle bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		PIERCE = DAMAGE_GREATCLUB*0.75,
		BLUNT = DAMAGE_GREATCLUB*0.25
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		PIERCE = AP_GREATCLUB,
		BLUNT = 0
	)

	falloff = VIEW_RANGE*3


/damagetype/ranged/bullet/sniper_50/explosive
	name = "sniper rifle bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		PIERCE = DAMAGE_GREATCLUB*0.25,
		BLUNT = DAMAGE_GREATCLUB*0.25,
		BOMB = DAMAGE_GREATCLUB*0.5
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		PIERCE = AP_GREATCLUB*0.1,
		BLUNT = AP_GREATCLUB*0.1,
		BOMB = AP_GREATCLUB*0.8
	)

/damagetype/ranged/bullet/sniper_50/ion
	name = "sniper rifle bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = DAMAGE_GREATCLUB*0.25,
		ION = DAMAGE_GREATCLUB*0.75
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = AP_GREATCLUB*0.25,
		ION = AP_GREATCLUB*0.75
	)


/damagetype/ranged/bullet/sniper_50/ap
	name = "sniper rifle bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		PIERCE = DAMAGE_GREATCLUB*0.75
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		PIERCE = AP_GREATCLUB*3
	)


/damagetype/ranged/bullet/sniper_50/incendiary
	name = "sniper rifle bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BOMB = DAMAGE_GREATCLUB*0.25,
		BLUNT = DAMAGE_GREATCLUB*0.25
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BOMB = AP_GREATCLUB*0.25,
		BLUNT = AP_GREATCLUB*0.25
	)

/damagetype/ranged/bullet/sniper_50/incendiary/post_on_hit(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/total_damage_dealt=0)
	if(is_living(victim))
		var/mob/living/L = victim
		L.add_status_effect(FIRE,150,150,stealthy=L.on_fire)
	return ..()