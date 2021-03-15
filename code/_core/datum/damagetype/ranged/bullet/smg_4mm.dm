/damagetype/ranged/bullet/smg_4mm
	name = "smg bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		PIERCE = DAMAGE_SWORD
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		PIERCE = AP_SWORD
	)

	falloff = VIEW_RANGE

/damagetype/ranged/bullet/smg_4mm/surplus
	damage_mod = SURPLUS_MUL
	penetration_mod = SURPLUS_MUL

/damagetype/ranged/bullet/smg_4mm/ap
	name = "smg bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		PIERCE = DAMAGE_SWORD*0.75
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		PIERCE = AP_SWORD*3
	)

/damagetype/ranged/bullet/smg_4mm/toxin
	name = "smg bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BIO = DAMAGE_SWORD*0.75,
		PIERCE = DAMAGE_SWORD*0.25
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BIO= AP_SWORD*0.75,
		PIERCE = AP_SWORD*0.25

	)

/damagetype/ranged/bullet/smg_4mm/ion
	name = "smg bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		ION = DAMAGE_SWORD*0.75,
		PIERCE = DAMAGE_SWORD*0.25
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		ION = AP_SWORD*0.75,
		PIERCE = AP_SWORD*0.25

	)

/damagetype/ranged/bullet/smg_4mm/subsonic
	name = "smg bullet"

	//Hoping that putting Stalkeros' crit stuff here works, otherwise its just a stealthy, slower bullet.
	crit_multiplier = 4 //Damage multiplier.
	crit_chance = 10 //Base crit chance.
	crit_chance_max = 15 //Maximium crit chance at 100 luck.

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		PIERCE = DAMAGE_SWORD
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		PIERCE = AP_SWORD

	)

/damagetype/ranged/bullet/smg_4mm/incendiary
	name = "smg bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		HEAT = DAMAGE_SWORD*0.75,
		PIERCE = DAMAGE_SWORD*0.25
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		HEAT = AP_SWORD*0.75,
		PIERCE = AP_SWORD*0.25

	)

	//Fire strength probably needs tweaking, I didn't test it too much
/damagetype/ranged/bullet/smg_4mm/incendiary/post_on_hit(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/total_damage_dealt=0)
	if(is_living(victim))
		var/mob/living/L = victim
		L.add_status_effect(FIRE,25,25,stealthy=L.on_fire)
	return ..()