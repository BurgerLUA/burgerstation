/obj/item/organ/internal/brain
	name = "brain"
	id = BODY_BRAIN
	icon_state = BODY_BRAIN
	desc = "Produces thoughts. Requires oxygenated blood."

	attach_flag = BODY_HEAD

	var/list/addictions = list()
	var/list/withdrawal = list()

	health = /health/obj/item/organ

	has_life = TRUE

/obj/item/organ/internal/brain/on_life()

	if(length(addictions) && is_advanced(src.loc))
		var/mob/living/advanced/A = src.loc
		for(var/k in addictions)
			var/addiction/D = SSliving.stored_addictions[k]
			if(addictions[k] <= 0)
				D.on_remove(A,src)
				addictions -= k
				continue
			D.on_life(A,src,addictions[k],withdrawal[k])

	return ..()



/obj/item/organ/internal/brain/unattach_from_parent(var/turf/T,var/do_delete=FALSE)
	var/atom/old_loc = src.loc
	. = ..()
	if(is_advanced(old_loc))
		var/mob/living/advanced/A = old_loc
		if(A.client)
			A.client.make_ghost(T)
		A.death()


/obj/item/organ/internal/brain/robotic
	name = "robotic brain"
	health = /health/obj/item/organ/synthetic