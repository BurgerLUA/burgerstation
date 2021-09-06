/damagetype/ranged/bullet/rocket

/damagetype/ranged/bullet/rocket/he/
	attack_damage_base = list(
		BLUNT = 50,
		PIERCE = 5
	)
	attack_damage_penetration = list(
		BLUNT = 0,
		PIERCE = 0
	)
	falloff = 0

/damagetype/ranged/bullet/rocket/wp //White phosphor
	attack_damage_base = list(
		BLUNT = 10,
		HEAT= 75
	)
	attack_damage_penetration = list(
		BLUNT = 0,
		HEAT = 50
	)
	falloff = 0

/damagetype/ranged/bullet/rocket/p/post_on_hit(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/total_damage_dealt=0)
	if(is_living(victim))
		var/mob/living/L = victim
		L.add_status_effect(FIRE,200,200,stealthy=L.on_fire)
	return ..()

/damagetype/ranged/bullet/rocket/ap
	attack_damage_base = list(
		BOMB = 400,
		PIERCE = 50
	)
	attack_damage_penetration = list(
		BOMB = 100,
		PIERCE = 100
	)
	falloff = 0

/damagetype/ranged/bullet/rocket_ap/post_on_hit(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/total_damage_dealt=0)
	if(is_living(victim))
		var/mob/living/L = victim
		L.add_status_effect(STUN,20,20)
	return ..()
