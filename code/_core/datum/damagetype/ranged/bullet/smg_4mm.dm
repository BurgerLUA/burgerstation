/damagetype/ranged/bullet/smg_4mm
	attack_damage_base = list(
		PIERCE = 20
	)
	attack_damage_penetration = list(
		PIERCE = 50
	)

	falloff = VIEW_RANGE

/damagetype/ranged/bullet/smg_4mm/surplus
	damage_mod = SURPLUS_MUL
	penetration_mod = SURPLUS_MUL

/damagetype/ranged/bullet/smg_4mm/ap
	damage_mod = ARMOR_DAM_MUL
	penetration_mod = ARMOR_AP_MUL

/damagetype/ranged/bullet/smg_4mm/du
	damage_mod = DU_MUL
	penetration_mod = DU_MUL


/damagetype/ranged/bullet/smg_4mm/toxin
	attack_damage_base = list(
		BIO = 15,
		PIERCE = 5
	)
	attack_damage_penetration = list(
		BIO = 50,
		PIERCE = 25

	)

/damagetype/ranged/bullet/smg_4mm/ion
	attack_damage_base = list(
		ION = 15,
		PIERCE = 5
	)
	attack_damage_penetration = list(
		ION = 50,
		PIERCE = 25
	)

/damagetype/ranged/bullet/smg_4mm/incendiary
	attack_damage_base = list(
		HEAT = 5,
		PIERCE = 5
	)
	attack_damage_penetration = list(
		HEAT = 25,
		PIERCE = 25
	)

/damagetype/ranged/bullet/smg_4mm/incendiary/post_on_hit(var/atom/attacker,var/turf/attacker_turf,var/atom/victim,var/turf/victim_turf,var/atom/weapon,var/atom/hit_object,var/total_damage_dealt=0)
	if(is_living(victim))
		var/mob/living/L = victim
		L.add_status_effect(FIRE,20,20,stealthy=L.on_fire)
	return ..()