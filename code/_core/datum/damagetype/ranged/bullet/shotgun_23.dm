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
		BLADE = DAMAGE_CLUB*0.5,
		BLUNT = DAMAGE_CLUB*0.25,
		PIERCE = DAMAGE_CLUB*0.25
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = AP_CLUB*0.5,
		BLUNT = AP_CLUB*0.25,
		PIERCE = AP_CLUB*0.25
	)

	falloff = 3

/damagetype/ranged/bullet/shotgun_23/slug
	name = "shotgun slug"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = DAMAGE_GREATSWORD*0.8,
		PIERCE = DAMAGE_GREATSWORD*0.2
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = DAMAGE_GREATSWORD*0.9,
		PIERCE = DAMAGE_GREATSWORD*0.1
	)

	falloff = VIEW_RANGE

/damagetype/ranged/bullet/shotgun_23/fire
	name = "spicy pellet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list( //so uuh around 90% of regular damage?
		BLUNT = DAMAGE_GREATSWORD*0.75,
		HEAT = DAMAGE_GREATSWORD*0.25
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = DAMAGE_GREATSWORD*0.7,
		HEAT = DAMAGE_GREATSWORD*0.3 //I am unsure of HEAT being that good at penetrating most armors (considering they usually have neat HEAT resistances) so let's keep it fairly high for a while.
	)

	falloff = VIEW_RANGE

/damagetype/ranged/bullet/shotgun_23/fire/post_on_hit(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/total_damage_dealt=0)
	if(is_living(victim))
		var/mob/living/L = victim
		L.add_status_effect(FIRE,100,0,stealthy=L.on_fire) //so uuuh 10 sec of fire
	return ..()