/obj/item/container/pill
	name = "pill"
	desc = "FLOORPILL"

	icon = 'icons/obj/items/container/pills.dmi'
	icon_state = "rectangle"

	desc_extended = "Hope you remember what the pill is."

	var/marking = "A"
	var/double = FALSE

	size = SIZE_0
	weight = WEIGHT_0

	var/reagent_container/reagents_2

/obj/item/container/pill/get_examine_text(var/mob/examiner)
	return ..() + div("notice","There is a marking that reads \"[marking]\" on the pill.")

/obj/item/container/pill/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	INTERACT_CHECK

	if(!is_advanced(object) || !is_advanced(caller))
		return ..()

	var/mob/living/advanced/A1 = caller
	var/mob/living/advanced/A2 = object

	if(A1 == A2)

		if(!A2.labeled_organs[BODY_STOMACH])
			A2.to_chat(span("warning","You don't know how you can swallow \the [src]!"))
			return FALSE

		var/obj/item/organ/internal/stomach/S = A2.labeled_organs[BODY_STOMACH]

		if(reagents)
			reagents.transfer_reagents_to(S.reagents,reagents.volume_current)

		if(reagents_2)
			reagents_2.transfer_reagents_to(S.reagents,reagents_2.volume_current)

		A2.to_chat(span("notice","You swallow \the [src]."))

		qdel(src)

	return TRUE

/obj/item/container/pill/on_spawn()
	. = ..()
	update_icon()
	return .

/obj/item/container/pill/update_icon()

	icon = initial(icon)
	icon_state = initial(icon_state)

	var/icon/I
	if(double)
		I = new/icon(icon,"[icon_state]_double_left")
		I.Blend(reagents.color,ICON_MULTIPLY)
		var/icon/I2 = new/icon(icon,"[icon_state]_double_right")
		I2.Blend(reagents_2.color,ICON_MULTIPLY)
		I.Blend(I2,ICON_OVERLAY)
	else
		I = new/icon(icon,icon_state)
		I.Blend(reagents.color,ICON_MULTIPLY)

	icon = I

	return TRUE

/obj/item/container/pill/New(var/desired_loc)

	if(double)
		reagents_2 = new/reagent_container/pill/half(src)
		reagents = /reagent_container/pill/half //new is made somewhere else
	else
		reagents = /reagent_container/pill/

	return ..()


/obj/item/container/pill/double/ //Yes, this is shitcode.
	double = TRUE
