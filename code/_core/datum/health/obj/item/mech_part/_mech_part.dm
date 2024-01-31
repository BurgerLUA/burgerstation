/health/obj/item/mech_part
	organic = FALSE

/health/obj/item/mech_part/adjust_loss_smart(brute,burn,tox,oxy,fatigue,pain,rad,sanity,mental,organic=TRUE,robotic=TRUE,update=TRUE)

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
		QUEUE_HEALTH_UPDATE(A)

