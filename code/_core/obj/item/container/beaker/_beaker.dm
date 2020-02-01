/obj/item/container/beaker
	name = "glass beaker"
	desc = "For the mad scientist in all of us."
	desc_extended = "Holds reagents."
	crafting_id = "beaker"

	icon = 'icons/obj/items/container/cup/beaker.dmi'
	icon_state = "beaker"

	var/consume_verb = "drink out of"

	reagents = /reagent_container/beaker/

	var/icon_count = 7

	var/transfer_amount = 10

	allow_beaker_transfer = TRUE

	var/overide_icon = FALSE

/obj/item/container/beaker/get_examine_text(var/mob/examiner)
	return ..() + div("notice",reagents.get_contents_english())

/obj/item/container/beaker/click_self(var/mob/caller,location,control,params)

	var/initial_amount = initial(transfer_amount)

	transfer_amount += initial_amount
	if(transfer_amount > reagents.volume_max)
		transfer_amount = initial_amount

	caller.to_chat(span("notice","You will now transfer [transfer_amount] units at a time with \the [src]."))

	return TRUE

/obj/item/container/beaker/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(get_dist(caller,object) > 1)
		return FALSE

	if(is_advanced(caller) && is_advanced(object))

		var/mob/living/advanced/A1 = caller
		var/mob/living/advanced/A2 = object
		var/area/A3 = get_area(object)

		if(A1 != A2 && A3.flags_area & FLAGS_AREA_NO_DAMAGE)
			A1.to_chat(span("notice","For some reason you can't bring yourself to feed [A2] the delicious [src.name]..."))
			return FALSE

		if(A1 == A2)
			var/list/callback_list = list()
			callback_list["object"] = src
			if(add_progress_bar(A1,"feed_self",transfer_amount,callback_list))
				A1.to_chat(span("notice","You start to [consume_verb] \the [src]..."))
		else
			var/list/callback_list = list()
			callback_list["target"] = A2
			callback_list["target_start_turf"] = get_turf(A2)
			callback_list["object"] = src
			callback_list["start_turf"] = get_turf(src)

			if(add_progress_bar(A1,"feed_other",transfer_amount*3,callback_list))
				A1.to_chat(span("notice","You force \the [src] to [consume_verb] \the [A2]..."))

		return TRUE

	if(object.reagents && object.allow_beaker_transfer)
		var/actual_transfer_amount = reagents.transfer_reagents_to(object.reagents,transfer_amount)
		caller.to_chat(span("notice","You transfer [actual_transfer_amount] units of liquid to \the [object]."))
		return TRUE

	return ..()

/obj/item/container/beaker/proc/consume(var/mob/living/consumer)

	if(!reagents || !length(reagents.stored_reagents) || reagents.volume_current <= 0)
		consumer.to_chat(span("warning","There is nothing left of \the [src] to [consume_verb]!"))
		return FALSE

	if(is_advanced(consumer))
		var/mob/living/advanced/A = consumer

		if(!A.labeled_organs[BODY_STOMACH])
			consumer.to_chat(span("warning","You don't know how you can [consume_verb] \the [src]!"))
			return FALSE

		var/final_flavor_text = reagents.get_flavor()

		if(final_flavor_text && (A.last_flavor_time + SECONDS_TO_DECISECONDS(3) <= curtime || A.last_flavor != final_flavor_text) )
			A.last_flavor = final_flavor_text
			A.last_flavor_time = curtime
			final_flavor_text = "You taste [final_flavor_text]."
		else
			final_flavor_text = null

		consumer.to_chat(span("notice","You [consume_verb] \the [src.name]."))

		if(final_flavor_text)
			consumer.to_chat(span("notice",final_flavor_text))

		var/obj/item/organ/internal/stomach/S = A.labeled_organs[BODY_STOMACH]
		return reagents.transfer_reagents_to(S.reagents,Clamp(transfer_amount,0,CONSUME_AMOUNT_MAX))

	else
		return reagents.transfer_reagents_to(consumer.reagents,Clamp(transfer_amount,0,CONSUME_AMOUNT_MAX))

	return 0

/obj/item/container/beaker/update_icon()

	if(!overide_icon)
		icon = initial(icon)
		icon_state = initial(icon_state)

		var/icon/I = new/icon(icon,icon_state)
		var/icon/I2 = new/icon(icon,"liquid_[ceiling(Clamp(reagents.volume_current/reagents.volume_max,0,1)*icon_count,1)]")

		I2.Blend(reagents.color,ICON_MULTIPLY)
		I.Blend(I2,ICON_UNDERLAY)

		icon = I

	..()