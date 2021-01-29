/health/obj/item/mech_part
	organic = FALSE

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

/health/obj/item/mech_part/adjust_loss_smart(var/brute,var/burn,var/tox,var/oxy,var/fatigue,var/pain,var/rad,var/sanity,var/mental,var/update=TRUE,var/organic=TRUE,var/robotic=TRUE)

	tox = 0
	oxy = 0
	pain = 0
	rad = 0
	fatigue = 0
	pain = 0
	sanity = 0
	mental = 0

	. = ..()

	if(. && update && is_modular_mech(owner.loc))
		var/mob/living/vehicle/mech/modular/A = owner.loc
		A.queue_health_update = TRUE

	return .