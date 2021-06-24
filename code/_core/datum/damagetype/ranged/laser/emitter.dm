/damagetype/ranged/laser/emitter
	name = "Emitter shot"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		LASER = 100,
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		LASER = 200
	)

/damagetype/ranged/laser/emitter/process_damage(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/damage_multiplier=1)

	if(istype(hit_object,/obj/structure/interactive/supermatter))
		var/obj/structure/interactive/supermatter/S = hit_object
		S.add_charge(SECONDS_TO_DECISECONDS(6)/3)
		return TRUE

	. = ..()
