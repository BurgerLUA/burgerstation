/obj/structure/interactive/hand_implanter
	name = "hand implanter"
	desc = "Just shove your hand in there!"
	desc_extended = "A corporation-grade hand implanter. Allegedly and automatically insults implants into the user's left hand."
	icon = 'icons/obj/structure/scanner.dmi'
	icon_state = "hand"
	pixel_x = -4
	pixel_y = 4

	var/obj/item/organ/internal/stored_implant

	var/removes_existing = FALSE
	var/should_save_on_implant = FALSE

/obj/structure/interactive/hand_implanter/New(var/desired_loc)
	. = ..()
	if(stored_implant)
		name = "[initial(name)] ([initial(stored_implant.name)])"

	return .

/obj/structure/interactive/hand_implanter/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(!is_advanced(caller))
		return ..()

	INTERACT_CHECK
	INTERACT_CHECK_OBJECT
	INTERACT_DELAY(5)

	if(!stored_implant)
		caller.to_chat(span("warning","There is no implanter loaded!"))
		return TRUE

	var/mob/living/advanced/A = caller

	var/initial_id = initial(stored_implant.id)

	if(A.labeled_organs[initial_id])
		if(removes_existing)
			var/obj/item/organ/O = A.labeled_organs[initial_id]
			if(O.type == stored_implant)
				caller.to_chat(span("warning","You already have an implant of that type!"))
				return TRUE
			O.unattach_from_parent(A.loc)
		else
			caller.to_chat(span("warning","You already have an implant of that type!"))
			return TRUE

	var/obj/item/organ/internal/implant/added_implant = A.add_organ(stored_implant)
	if(added_implant)
		caller.visible_message(span("notice","\The [caller.name] implants something into their [added_implant.attached_organ.name]."),span("notice","You implant \the [added_implant.name] into your [added_implant.attached_organ.name]."))
		if(should_save_on_implant && is_player(A))
			var/savedata/client/mob/mobdata = MOBDATA(A.ckey_last)
			if(mobdata) mobdata.save_character(A)
	else
		caller.to_chat(span("danger","There was an error adding your implant."))

	return TRUE

/obj/structure/interactive/hand_implanter/IFF
	stored_implant = /obj/item/organ/internal/implant/hand/left/iff/nanotrasen

/obj/structure/interactive/hand_implanter/IFF/save
	should_save_on_implant = TRUE
	removes_existing = TRUE