/obj/item/container/food
	name = "food"
	desc = "Edible reagent"
	desc_extended = "Edible."

	var/bite_size = 10 //How many reagents to remove per bite?
	var/bite_count = 0 //How many times someone has taken a bite from this.
	var/consume_verb = "take a bite out of"

	reagents = /reagent_container/food/

/obj/item/container/food/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(get_dist(caller,object) > 1)
		return FALSE

	if(!is_advanced(object) || !is_advanced(caller))
		return ..()

	var/mob/living/advanced/A1 = caller
	var/mob/living/advanced/A2 = object

	if(A1 == A2)
		var/list/callback_list = list()
		callback_list["object"] = src
		if(add_progress_bar(A1,"feed_self",SECONDS_TO_DECISECONDS(1),callback_list))
			A1.to_chat(span("notice","You start eating \the [src]..."))

	else
		var/list/callback_list = list()
		callback_list["target"] = A2
		callback_list["target_start_turf"] = get_turf(A2)
		callback_list["object"] = src
		callback_list["start_turf"] = get_turf(src)

		if(add_progress_bar(A1,"feed_other",SECONDS_TO_DECISECONDS(3),callback_list))
			A1.to_chat(span("notice","You start to forcefeed \the [src] to \the [A2]..."))

	return TRUE

/obj/item/container/food/proc/consume(var/mob/living/consumer)

	if(!reagents || !length(reagents.stored_reagents) || reagents.total_volume <= 0)
		consumer.to_chat(span("warning","There is nothing left of \the [src] to [consume_verb]!"))
		return FALSE

	if(is_advanced(consumer))
		var/mob/living/advanced/A = consumer

		if(!A.labeled_organs[BODY_STOMACH])
			consumer.to_chat(span("warning","You don't know how you can [consume_verb] \the [src]!"))
			return FALSE

		bite_count += 1

		var/obj/item/organ/internal/stomach/S = A.labeled_organs[BODY_STOMACH]
		return reagents.transfer_reagents_to(S.reagents,bite_size)

	else
		bite_count += 1
		return reagents.transfer_reagents_to(consumer.reagents,bite_size)

	return 0