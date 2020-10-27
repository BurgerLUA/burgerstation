/obj/item/organ/internal/implant/torso/od_purge
	name = "overdose safety implant"
	desc = "Prevents overdoses."
	desc_extended = "A special implant that prevents the user from overdosing on chemicals by purging it from their bloodstream."

	has_life = TRUE

/obj/item/organ/internal/implant/torso/od_purge/on_life()
	. = ..()
	if(loc && is_advanced(loc))
		var/mob/living/advanced/A = loc
		if(A.reagents)
			var/has_purged = FALSE
			for(var/reagent_path in A.reagents.stored_reagents)
				var/reagent_volume = A.reagents.stored_reagents[reagent_path]
				var/reagent/R = REAGENT(reagent_path)
				if(!R.overdose_threshold || reagent_volume < R.overdose_threshold)
					continue
				reagent_volume *= 0.5
				has_purged = TRUE
				A.reagents.stored_reagents[reagent_path] = FLOOR(reagent_volume, 1)
			if(has_purged)
				A.to_chat(span("notice","Your [src.name] beeps..."))

	return .


/obj/item/organ/internal/implant/torso/death_alarm
	name = "death alarm implant"
	desc = "I died, please restart."
	desc_extended = "A special implant that detects if the user has died. It destroys itself once a message is broadcasted."

/obj/item/organ/internal/implant/torso/death_alarm/on_organ_add(var/mob/living/advanced/new_owner)
	. = ..()
	HOOK_ADD("post_death","\ref[src]_implant_post_death",new_owner,src,.proc/trigger_implant)
	return .

/obj/item/organ/internal/implant/torso/death_alarm/proc/trigger_implant()

	if(loc && is_advanced(loc))
		var/mob/living/advanced/A = loc
		A.to_chat(span("notice","Your death alarm goes off..."))
		talk(src,src,"Medical Alert: [A.real_name] has died!",TEXT_RADIO,RADIO_FREQ_COMMON)
		src.gib()
		HOOK_REMOVE("post_death","\ref[src]_implant_post_death",A)
		return TRUE

	return FALSE