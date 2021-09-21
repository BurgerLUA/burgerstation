/damagetype/melee/club/drill
	name = "drill"

	impact_sounds = list(
		'sound/items/drill.ogg',
	)


	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 30,
		PIERCE = 60
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 75,
		PIERCE = 75,
	)

	attribute_stats = list(

	)

	attribute_damage = list(

	)

	skill_stats = list(

	)

	skill_damage = list(

	)

	attack_delay = 5
	attack_delay_max = 5

	target_floors = TRUE

/damagetype/melee/club/drill/get_critical_hit_condition(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	if(is_wall(victim))
		return TRUE
	return ..()

/damagetype/melee/club/drill/do_critical_hit(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/list/damage_to_deal)
	if(is_wall(victim))
		return 4
	return ..()
