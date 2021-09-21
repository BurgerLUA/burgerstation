/damagetype/ranged/bullet/shotgun_23/ //Russian

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = 15,
		BLUNT = 20,
		PIERCE = 15
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = 0,
		BLUNT = 0,
		PIERCE = 0
	)

	damage_type_to_fatigue = list( //What percentage of damage blocked is converted into fatigue.
		BLADE = 0.20,
		BLUNT = 0.3,
		PIERCE = 0.1,
		BOMB = 1
	)

	falloff = 3

/damagetype/ranged/bullet/shotgun_23/surplus
	damage_mod = SURPLUS_MUL
	penetration_mod = SURPLUS_MUL

/damagetype/ranged/bullet/shotgun_23/slug
	attack_damage_base = list(
		BLUNT = 80,
	)
	attack_damage_penetration = list(
		BLUNT = 0
	)
	falloff = VIEW_RANGE

/damagetype/ranged/bullet/shotgun_23/slug/surplus
	damage_mod = SURPLUS_MUL
	penetration_mod = SURPLUS_MUL

/damagetype/ranged/bullet/shotgun_23/flechette
	attack_damage_base = list(
		BLADE = 20,
		PIERCE = 30
	)
	attack_damage_penetration = list(
		BLADE = 25,
		PIERCE = 75,
	)
	falloff = 3

/damagetype/ranged/bullet/shotgun_23/flechette/surplus
	damage_mod = SURPLUS_MUL
	penetration_mod = SURPLUS_MUL

/damagetype/ranged/bullet/shotgun_23/rubber_slug
	name = "rubber shotgun slug"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 10,
		PAIN = 50
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 0,
		PAIN = 75
	)

	falloff = VIEW_RANGE

/damagetype/ranged/bullet/shotgun_23/rubber_slug/surplus
	damage_mod = SURPLUS_MUL
	penetration_mod = SURPLUS_MUL

/damagetype/ranged/bullet/shotgun_23/fire
	attack_damage_base = list(
		BLUNT = 20,
	)
	attack_damage_penetration = list(
		BLUNT = 0,
	)
	falloff = 3

/damagetype/ranged/bullet/shotgun_23/fire/post_on_hit(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/total_damage_dealt=0)
	if(is_living(victim))
		var/mob/living/L = victim
		L.add_status_effect(FIRE,30,30,stealthy=L.on_fire)
	return ..()