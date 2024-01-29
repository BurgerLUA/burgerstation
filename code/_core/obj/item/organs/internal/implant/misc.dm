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
				A.to_chat(span("danger","\The [src.name] in your [attached_organ.name] beeps..."))


/obj/item/organ/internal/implant/torso/death_alarm
	name = "death alarm implant"
	desc = "I died, please restart."
	desc_extended = "A special implant that detects if the user has died, then broadcasts the message to the medical frequency. Only has enough charge to broadcast one death."

/obj/item/organ/internal/implant/torso/death_alarm/on_organ_add(mob/living/advanced/new_owner)
	. = ..()
	HOOK_ADD("post_death","\ref[src]_implant_post_death",new_owner,src,src::trigger_implant())

/obj/item/organ/internal/implant/torso/death_alarm/on_organ_remove(mob/living/advanced/old_owner)
	. = ..()
	HOOK_REMOVE("post_death","\ref[src]_implant_post_death",old_owner)

/obj/item/organ/internal/implant/torso/death_alarm/proc/trigger_implant()

	if(loc && is_advanced(loc) && loc.loc)
		var/mob/living/advanced/A = loc
		var/turf/T = get_turf(src)
		play_sound('sound/effects/death_alarm_beep.ogg',T)
		A.to_chat(span("danger","\The [src.name] in your [attached_organ.name] beeps..."))
		talk(src,src,"Medical Alert: [A.real_name] has died!",TEXT_RADIO,RADIO_FREQ_MEDICAL,talk_range = YELL_RANGE)
		qdel(src)
		return TRUE

	return FALSE