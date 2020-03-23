/obj/item/organ/internal/implant
	name = "implant"
	id = "implant"
	desc = "Implant."
	icon_state = "lungs"
	attach_flag = BODY_TORSO

/obj/item/organ/internal/implant/head/
	name = "head implant"
	id = "implant_head"
	attach_flag = BODY_HEAD

/obj/item/organ/internal/implant/head/loyalty
	var/registered_name = "none"
	var/registered_id = "none"
	var/registered_squad = "none"
	var/loyalty_tag = "NanoTrasen"

/obj/item/organ/internal/implant/head/loyalty/proc/register()
	if(loc.loc && is_advanced(loc.loc))
		var/mob/living/advanced/A = loc.loc
		registered_name = A.real_name
		registered_id = md5("\ref[src]")
		return TRUE

	return FALSE


/obj/item/organ/internal/implant/head/loyalty/nanotrasen
	name = "loyalty implant"
	desc = "Do you swear loyalty? No? Well that doesn't matter."
	desc_extended = "A state of the art NanoTrasen Loyalty Implant Tracker, or NT-LIT, as the cool kids call it. This implant prevents the user from doing most forms of physical harm to those who also have the same loyalty implant model, and vice versa. Note that technology isn't advanced enough to stop other sources of harm, but NanoTrasen doesn't want you to know about that."
	loyalty_tag = "NanoTrasen"

/obj/item/organ/internal/implant/head/loyalty/syndicate
	name = "freedom implant"
	desc = "An implant that gives you FREEDOM."
	desc_extended = "A highly illegal Syndicate Freedom Implant specifically designed to override and replace any other NanoTrasen Loyalty Implants. This implant prevents the user from doing harm to those who also have the same freedom implant model, and vice versa."
	loyalty_tag = "Syndicate"

/obj/item/organ/internal/implant/hand/left
	name = "left hand implant"
	id = "implant_hand_left"
	attach_flag = BODY_HAND_LEFT

var/global/list/obj/item/organ/internal/implant/hand/left/iff/all_IFFs = list() //For future use in tracking.

/obj/item/organ/internal/implant/hand/left/iff
	name = "\improper NanoTrasen IFF implant"
	desc = "Prevents friendly fire and collects your personal information."
	desc_extended = "A special integrated friend or foe implant based on the civilian model that prevents the user from being targeted with weapons registered to a database. Like the civilian counterpart, it also tracks movement and sents vitals data to nearby devices. Due to religious concenrs, it can only be implanted in the left hand."
	var/registered_name = "none"
	var/registered_id = "none"
	var/registered_squad = "none"
	var/iff_tag = "NanoTrasen"

/obj/item/organ/internal/implant/hand/left/iff/proc/register()

	if(loc.loc && is_advanced(loc.loc))
		var/mob/living/advanced/A = loc.loc
		registered_name = A.real_name
		registered_id = md5("\ref[src]")
		return TRUE

	return FALSE

/obj/item/organ/internal/implant/hand/left/iff/nanotrasen
	name = "\improper NanoTrasen IFF implant"
	desc = "Prevents friendly fire and collects your personal information."
	desc_extended = "A special integrated friend or foe implant based on the civilian model that prevents the user from being targeted with weapons registered to the NanoTrasen Firearms Database. Like the civilian counterpart, it also tracks movement and sents vitals data to nearby devices. Due to religious concenrs, it can only be implanted in the left hand."
	iff_tag = "NanoTrasen"

/obj/item/organ/internal/implant/hand/left/iff/syndicate
	name = "\improper NanoTrasen IFF implant"
	desc = "Prevents friendly fire and collects your personal information."
	desc_extended = "A special integrated friend or foe implant based on the civilian model that prevents the user from being targeted with weapons registered to Syndicate Operatives. Like the civilian counterpart, it also tracks movement and sents vitals data to nearby devices. Due to religious concenrs, it can only be implanted in the left hand."
	iff_tag = "Syndicate"

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

/obj/item/organ/internal/implant/hand/left/iff/on_organ_add(var/mob/living/advanced/new_owner)
	new_owner.set_iff_tag(iff_tag)
	return ..()

/obj/item/organ/internal/implant/hand/left/iff/on_organ_remove(var/mob/living/advanced/old_owner)
	old_owner.set_iff_tag(null)
	return ..()

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
				A.reagents.stored_reagents[reagent_id] = FLOOR(reagent_volume, 1)
			if(has_purged)
				A.to_chat(span("notice","Your [src.name] beeps..."))

	return .
