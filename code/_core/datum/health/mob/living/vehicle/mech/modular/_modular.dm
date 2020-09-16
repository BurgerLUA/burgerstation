/health/mob/living/vehicle/mech/modular/get_defense(var/atom/attacker,var/atom/hit_object)

	if(!is_modular_mech(owner))
		return ..()

	. = ..()

	if(is_mech_part(hit_object))
		var/obj/item/mech_part/O = hit_object
		var/list/O_defense_rating = O.armor_base.Copy()
		for(var/damage_type in O_defense_rating)
			if(IS_INFINITY(.[damage_type])) //If our defense is already infinity, then forget about it.
				continue
			if(IS_INFINITY(O_defense_rating[damage_type])) //If the organ's defense is infinity, set it to infinity.
				.[damage_type] = O_defense_rating[damage_type]
				continue
			.[damage_type] += O_defense_rating[damage_type]

	return .