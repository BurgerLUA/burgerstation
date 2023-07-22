/obj/item/organ/internal/implant/torso/spartan
	name = "spartan implant cluster"
	desc = "Does various things. Spooky."
	desc_extended = "Monitors the Spartan's body and broadcasts combat updates."
	var/next_alert = 0

	has_life = TRUE

/obj/item/organ/internal/implant/torso/spartan/on_life()
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
				A.to_chat(span("danger","\The [src.name] in your [attached_organ.name] buzzes..."))

	return .

/obj/item/organ/internal/implant/torso/spartan/on_organ_add(var/mob/living/advanced/new_owner)
	. = ..()
	HOOK_ADD("on_damage_received","\ref[src]_implant_alert",new_owner,src,.proc/trigger_combat_alert)
	return .

/obj/item/organ/internal/implant/torso/spartan/on_organ_remove(var/mob/living/advanced/old_owner)
	. = ..()
	HOOK_REMOVE("on_damage_received","\ref[src]_implant_alert",old_owner)
	return .

/obj/item/organ/internal/implant/torso/spartan/proc/can_alert(var/mob/caller,var/atom/target)
	if(next_alert >= world.time)
		caller.to_chat(span("warning","\The [src.name] groans!"))
		return FALSE
	return TRUE

/obj/item/organ/internal/implant/torso/spartan/proc/trigger_combat_alert(var/mob/caller as mob,var/atom/object,var/atom/target,location,control,params)

	if(loc && is_advanced(loc))
		if(next_alert > world.time)
			var/mob/living/advanced/A = loc
			A.to_chat(span("danger","Your [src.name] in your [attached_organ.name] buzzes..."))
			talk(src,src,"Medical Alert: [A.real_name] vitals indicate combat! Position: ([target.x],[target.y],[target.z]).",TEXT_RADIO,RADIO_FREQ_COMMON,talk_range = YELL_RANGE)
			next_alert = world.time + SECONDS_TO_DECISECONDS(60)
		return TRUE

	return FALSE