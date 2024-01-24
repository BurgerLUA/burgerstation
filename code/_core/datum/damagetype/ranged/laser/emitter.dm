/damagetype/ranged/laser/emitter
	attack_damage_base = list(
		LASER = 100,
	)
	attack_damage_penetration = list(
		LASER = 0
	)

/damagetype/ranged/laser/emitter/process_damage(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/damage_multiplier=1)

	if(istype(hit_object,/obj/structure/interactive/supermatter))
		var/obj/structure/interactive/supermatter/S = hit_object
		S.add_charge(6 SECONDS/3)
		return TRUE

	. = ..()
