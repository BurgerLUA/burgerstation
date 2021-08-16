/damagetype/ranged/bullet/rocket/
	name = "Rocket Impact"

/damagetype/ranged/bullet/rocket_he/
	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 20,
		PIERCE = 5,
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 0,
		PIERCE = 0
	)

	falloff = 0

/damagetype/ranged/bullet/rocket_wp/
	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 10,
		HEAT= 100
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 0,
		HEAT = 20
	)

	falloff = 0

/damagetype/ranged/bullet/rocket_wp/post_on_hit(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/total_damage_dealt=0)
	if(is_living(victim))
		var/mob/living/L = victim
		L.add_status_effect(FIRE,200,0,stealthy=L.on_fire)
	return ..()

/damagetype/ranged/bullet/rocket_ap/
	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BOMB = 900,
		PIERCE = 100
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BOMB = 900,
		PIERCE = 100
	)

	falloff = 0

/damagetype/ranged/bullet/rocket_ap/post_on_hit(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/total_damage_dealt=0)
	if(is_living(victim))
		var/mob/living/L = victim
		L.add_status_effect(STUN,20,20)
		L.add_status_effect(PARALYZE,20,20,stealthy=TRUE)
	return ..()
