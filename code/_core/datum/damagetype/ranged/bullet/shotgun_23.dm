/damagetype/ranged/bullet/shotgun_23/
	damage_type_to_fatigue = list( //What percentage of damage blocked is converted into fatigue.
		BLADE = 0.20,
		BLUNT = 0.3,
		PIERCE = 0.1,
		BOMB = 1
	)

/damagetype/ranged/bullet/shotgun_23/buckshot
	name = "group of buckshot pellets"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = 60*0.5,
		BLUNT = 60*0.25,
		PIERCE = 60*0.25
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = 60*0.5,
		BLUNT = 60*0.25,
		PIERCE = 60*0.25
	)

	falloff = 3

/damagetype/ranged/bullet/shotgun_23/buckshot/surplus
	damage_mod = SURPLUS_MUL
	penetration_mod = SURPLUS_MUL

/damagetype/ranged/bullet/shotgun_23/slug
	name = "shotgun slug"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 75*0.8,
		PIERCE = 75*0.2
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 75*0.9,
		PIERCE = 75*0.1
	)

	falloff = VIEW_RANGE

/damagetype/ranged/bullet/shotgun_23/slug/surplus
	damage_mod = SURPLUS_MUL
	penetration_mod = SURPLUS_MUL

/damagetype/ranged/bullet/shotgun_23/fire
	name = "spicy pellet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list( //so uuh around 90% of regular damage?
		BLUNT = 75*0.75,
		HEAT = 75*0.25
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 75*0.7,
		HEAT = 75*0.3 //I am unsure of HEAT being that good at penetrating most armors (considering they usually have neat HEAT resistances) so let's keep it fairly high for a while.
	)

	falloff = VIEW_RANGE

/damagetype/ranged/bullet/shotgun_23/fire/post_on_hit(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/total_damage_dealt=0)
	if(is_living(victim))
		var/mob/living/L = victim
		L.add_status_effect(FIRE,100,0,stealthy=L.on_fire) //so uuuh 10 sec of fire
	return ..()

/damagetype/ranged/bullet/shotgun_23/fire/surplus
	damage_mod = SURPLUS_MUL
	penetration_mod = SURPLUS_MUL