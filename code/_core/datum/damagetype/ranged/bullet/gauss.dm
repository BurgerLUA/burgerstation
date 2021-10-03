/damagetype/ranged/bullet/gauss_gun
	name = "2mm steel ball"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 90,
		PIERCE = 90
	)
	attack_damage_penetration = list(
		BLUNT = 125,
		PIERCE = 125
	)
	falloff = VIEW_RANGE + ZOOM_RANGE*3

/damagetype/ranged/bullet/gauss_gun/surplus
	damage_mod = SURPLUS_MUL
	penetration_mod = SURPLUS_MUL

/damagetype/ranged/bullet/gauss_gun/ap
	name = "2mm depleted uranium ball"
	damage_mod = SURPLUS_MUL
	penetration_mod = ARMOR_MUL

/damagetype/ranged/bullet/gauss_gun/explosive
	name = "2mm gibtonite ball"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		PIERCE = 90
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		PIERCE = 40
	)

/damagetype/ranged/bullet/gauss_gun/ion
	name = "2mm uranium-iron alloy ball"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		PIERCE = 40,
		ION = 200
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		PIERCE = 40,
		ION = 450
	)

/damagetype/ranged/bullet/gauss_gun/incendiary
	name = "2mm compressed napalm alloy ball"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		PIERCE = 40,
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		PIERCE = 40
	)

/damagetype/ranged/bullet/gauss_gun/incendiary/post_on_hit(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/total_damage_dealt=0)
	if(is_living(victim))
		var/mob/living/L = victim
		L.add_status_effect(FIRE,300,300,stealthy=L.on_fire)
	return ..()