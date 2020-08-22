/health/obj/item/mech_part/update_health_stats()

	if(!is_mech_part(owner))
		return ..()

	if(!is_modular_mech(owner.loc))
		return ..()

	var/obj/item/mech_part/O = owner
	var/mob/living/vehicle/mech/modular/A = owner.loc

	. = ..()

	health_max = O.health_base * ( 1 + A.get_attribute_power(ATTRIBUTE_VITALITY)*A.mob_size)

	//A.update_health_element_icons(TRUE,TRUE,TRUE,TRUE) TODO: CHECK IF THIS IS NEEDED

	return .

/health/obj/item/mech_part/adjust_loss_smart(var/brute,var/burn,var/tox,var/oxy,var/update=TRUE)

	if(tox || oxy)
		if(owner.loc && is_modular_mech(owner.loc))
			var/mob/living/vehicle/mech/modular/A = owner.loc
			if(A.health)
				. += A.health.adjust_loss_smart(tox=tox,oxy=oxy)

		tox = 0
		oxy = 0


	. += ..(brute,burn,tox,oxy)

	if(. && update && is_modular_mech(owner.loc))
		var/mob/living/vehicle/mech/modular/A = owner.loc
		A.queue_health_update = TRUE

	return .

/health/obj/item/mech_part/adjust_tox_loss(var/value)
	if(!owner.loc || !is_modular_mech(owner.loc))
		return 0

	var/mob/living/vehicle/mech/modular/A = owner.loc

	if(!A.health)
		return FALSE

	return A.health.adjust_tox_loss(value)

/health/obj/item/mech_part/adjust_oxy_loss(var/value)
	if(!owner.loc || !is_modular_mech(owner.loc))
		return 0

	var/mob/living/vehicle/mech/modular/A = owner.loc

	if(!A.health)
		return FALSE

	return A.health.adjust_oxy_loss(value)

/health/obj/item/mech_part/adjust_fatigue_loss(var/value)
	if(!owner.loc || !is_modular_mech(owner.loc))
		return 0

	var/mob/living/vehicle/mech/modular/A = owner.loc

	if(!A.health)
		return FALSE

	return A.health.adjust_fatigue_loss(value)