/obj/item/organ/internal/implant/groin/syndicate_explosive
	name = "explosive groin implant"
	desc = "Orgasm jokes here."
	desc_extended = "A special implant for syndicate agents that explodes when they leave the Area of Operations. Acts as a deterent for betraying the syndicate as well as getting captured."
	has_life = TRUE

/obj/item/organ/internal/implant/groin/syndicate_explosive/on_life()
	. = ..()
	var/turf/T = get_turf(src)
	if(T.z < Z_LEVEL_MISSION && is_advanced(loc))
		var/mob/living/advanced/A = loc
		if(!A.dead)
			for(var/i=1,i<=10,i++)
				A.health.adjust_brute_loss(100)
				A.health.adjust_burn_loss(100)
			explode(T,7,A,src)
			A.queue_health_update = TRUE

	return .