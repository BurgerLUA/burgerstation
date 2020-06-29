var/global/list/obj/item/clothing/back/fulton/fulton_devices = list()

/obj/item/clothing/back/fulton
	name = "personal fulton extraction device"
	desc = "For when you're too lazy to escort high value times."
	icon = 'icons/obj/item/clothing/back/fulton.dmi'
	desc_extended = "One time use only. Activate in hand to toggle extraction. Can be worn by humanoids for a quick extraction. Does not work indoors, and targets are extracted only when the Delta Shuttle leaves the Area of Operations."
	size = SIZE_3
	weight = WEIGHT_4
	value = 400
	var/enabled = FALSE

/obj/item/clothing/back/fulton/Initialize()
	fulton_devices += src
	return ..()

/obj/item/clothing/back/fulton/Destroy()
	enabled = FALSE
	fulton_devices -= src
	return ..()

/obj/item/clothing/back/fulton/click_self(var/mob/caller)
	enabled = !enabled
	caller.to_chat("You [enabled ? "enable" : "disable"] \the [src].")
	return TRUE

/obj/item/clothing/back/fulton/proc/try_extract(var/turf/desired_turf)

	if(!enabled)
		return FALSE

	if(!is_inventory(loc))
		return FALSE

	var/obj/hud/inventory/I = loc

	if(!(src in I.worn_objects))
		return FALSE

	if(!I.loc || !is_organ(I.loc))
		return FALSE

	var/mob/living/advanced/A = I.loc.loc

	if(!is_advanced(A))
		return FALSE

	A.force_move(desired_turf)
	qdel(src)

	return TRUE