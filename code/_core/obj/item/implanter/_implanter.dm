/obj/item/implanter
	name = "autoimplanter"
	desc = "Breast implants when?"
	desc_extended = "A handheld chip implanter that allows you to self-insert implant chips, and sometimes even organs, into your skin and bones. Just scan the target area and press the button. Cannot be used to implant those other than the user."
	var/removes_existing = FALSE

	var/obj/item/organ/internal/stored_implant

	icon = 'icons/obj/item/implanter.dmi'
	icon_state = "implanter"

	value = 50

	weight = 3


/obj/item/implanter/update_icon()

	icon_state = initial(icon_state)

	if(stored_implant)
		icon_state = "[icon_state]_1"

	return ..()

/obj/item/implanter/New(var/desired_loc)
	. = ..()
	if(stored_implant)
		name = "[initial(name)] ([initial(stored_implant.name)])"
	update_sprite()
	return .

/obj/item/implanter/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(caller != object || !is_advanced(caller))
		return ..()

	INTERACT_CHECK
	INTERACT_CHECK_OBJECT
	INTERACT_DELAY(5)

	if(!stored_implant)
		caller.to_chat(span("warning","There is no implanter loaded in \the [src.name]!"))
		return TRUE

	var/mob/living/advanced/A = caller

	var/initial_id = initial(stored_implant.id)

	if(A.labeled_organs[initial_id])
		if(removes_existing)
			var/obj/item/organ/O = A.labeled_organs[initial_id]
			O.unattach_from_parent(A.loc)
		else
			caller.to_chat(span("warning","You already have an implant of that type!"))
			return TRUE

	var/obj/item/organ/internal/implant/added_implant = A.add_organ(stored_implant)
	if(added_implant)
		caller.visible_message(span("notice","\The [caller.name] implants something into their [added_implant.attached_organ.name]."),span("notice","You implant \the [added_implant.name] into your [added_implant.attached_organ.name]."))
		name = initial(name)
		stored_implant = null

	update_sprite()

	return TRUE

/obj/item/implanter/IFF
		stored_implant = /obj/item/organ/internal/implant/hand/left/iff/nanotrasen
		removes_existing = FALSE

/obj/item/implanter/od_purge
		stored_implant = /obj/item/organ/internal/implant/torso/od_purge
		removes_existing = TRUE

/obj/item/implanter/death_alarm
		stored_implant = /obj/item/organ/internal/implant/torso/death_alarm
		removes_existing = TRUE