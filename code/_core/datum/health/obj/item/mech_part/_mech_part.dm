/health/obj/item/mech_part
	organic = FALSE

/health/obj/item/mech_part/adjust_loss_smart(var/brute,var/burn,var/tox,var/oxy,var/fatigue,var/pain,var/rad,var/sanity,var/mental,var/update=TRUE,var/organic=TRUE,var/robotic=TRUE)

	tox = 0
	oxy = 0
	fatigue = 0
	pain = 0
	rad = 0
	pain = 0
	sanity = 0
	mental = 0

	. = ..()

	if(. && update && istype(owner.loc,/mob/living/vehicle/mech/modular/))
		var/mob/living/vehicle/mech/modular/A = owner.loc
		A.queue_health_update = TRUE

