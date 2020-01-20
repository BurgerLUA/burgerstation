/obj/item/organ/internal/implant
	name = "implant"
	id = "implant"
	desc = "Implant."
	icon_state = "lungs"
	attach_flag = BODY_TORSO

/obj/item/organ/internal/implant/hand/left
	name = "head implant"
	id = "implant_head"
	attach_flag = BODY_HAND_LEFT

var/global/list/obj/item/organ/internal/implant/hand/left/iff/all_IFFs = list()

/obj/item/organ/internal/implant/hand/left/iff
	name = "deluxe NanoTrasen utility implant"
	desc = "Prevents friendly fire and collects your personal information."
	desc_extended = "A special implant based on the civilian model that prevents the user from being targeted with weapons registered to the NanoTrasen Firearms Database. Like the civilian counterpart, it also tracks movement and sents vitals data to nearby devices. Due to religious concenrs, it can only be implanted in the left hand."
	var/registered_name = "none"
	var/registered_id = "none"
	var/registered_squad = "none"
	var/iff_tag = "NanoTrasen"

/obj/item/organ/internal/implant/hand/left/iff/New(var/desired_loc)
	all_IFFs += src
	return ..()

/obj/item/organ/internal/implant/hand/left/iff/Destroy()
	all_IFFs -= src
	return ..()

/obj/item/organ/internal/implant/hand/left/iff/proc/update_iff(var/desired_name,var/desired_id,var/desired_squad)

	if(desired_name)
		registered_name = desired_name

	if(desired_id)
		registered_id = desired_id

	if(desired_squad)
		registered_squad = desired_squad

	if(is_living(loc))
		var/mob/living/L = loc
		L.to_chat("\The [src.name] in your [attached_organ.name] beeps.")

	return TRUE

/obj/item/organ/internal/implant/torso
	name = "torso implant"
	id = "implant_torso"
	attach_flag = BODY_TORSO

/obj/item/organ/internal/implant/torso/od_purge
	name = "overdose safety implant"
	desc = "Prevents overdoses."
	desc_extended = "A special implant that prevents the user from overdosing on chemicals by purging it from their bloodstream."

/obj/item/organ/internal/implant/torso/od_purge/on_life()
	. = ..()
	if(loc && is_advanced(loc))
		var/mob/living/advanced/A = loc
		if(A.reagents)
			var/has_purged = FALSE
			for(var/reagent_id in A.reagents.stored_reagents)
				var/reagent_volume = A.reagents.stored_reagents[reagent_id]
				var/reagent/R = all_reagents[reagent_id]
				if(!R.overdose_threshold || reagent_volume < R.overdose_threshold)
					continue
				reagent_volume *= 0.5
				has_purged = TRUE
				A.reagents.stored_reagents[reagent_id] = floor(reagent_volume)
			if(has_purged)
				A.to_chat(span("notice","Your [src.name] beeps..."))

	return .
