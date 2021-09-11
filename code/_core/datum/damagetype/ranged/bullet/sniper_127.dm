/damagetype/ranged/bullet/sniper_127
	attack_damage_base = list(
		PIERCE = 150,
		BLUNT = 50
	)
	attack_damage_penetration = list(
		PIERCE = 100,
		BLUNT = 100
	)
	falloff = VIEW_RANGE + ZOOM_RANGE*5

/damagetype/ranged/bullet/sniper_127/surplus
	damage_mod = SURPLUS_MUL
	penetration_mod = SURPLUS_MUL

/damagetype/ranged/bullet/sniper_50
	attack_damage_base = list(
		PIERCE = 50,
		BLUNT = 150
	)
	attack_damage_penetration = list(
		PIERCE = 100,
		BLUNT = 100
	)
	falloff = VIEW_RANGE + ZOOM_RANGE*5

/damagetype/ranged/bullet/sniper_50/ap
	damage_mod = SURPLUS_MUL
	penetration_mod = ARMOR_MUL

/damagetype/ranged/bullet/sniper_50/surplus
	damage_mod = SURPLUS_MUL
	penetration_mod = SURPLUS_MUL

/damagetype/ranged/bullet/sniper_50/explosive
	damage_mod = 0.5
	penetration_mod = 0

/damagetype/ranged/bullet/sniper_50/ion
	attack_damage_base = list(
		BLUNT = 50,
		ION = 200
	)
	attack_damage_penetration = list(
		BLUNT = 0,
		ION = 100
	)

/damagetype/ranged/bullet/sniper_50/incendiary
	damage_mod = 0.5
	penetration_mod = 0

/damagetype/ranged/bullet/sniper_50/incendiary/post_on_hit(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/total_damage_dealt=0)
	if(is_living(victim))
		var/mob/living/L = victim
		L.add_status_effect(FIRE,150,150,stealthy=L.on_fire)
	return ..()

/damagetype/ranged/bullet/bmg_50
	attack_damage_base = list(
		PIERCE = 50,
		BLUNT = 50
	)
	attack_damage_penetration = list(
		PIERCE = 75,
		BLUNT = 75
	)
	falloff = VIEW_RANGE + ZOOM_RANGE*2

/damagetype/ranged/bullet/bmg_50/surplus
	damage_mod = SURPLUS_MUL
	penetration_mod = SURPLUS_MUL