/obj/item/container/food
	name = "food"
	desc = "Edible reagent"
	desc_extended = "Edible."

	var/bite_size = 5 //How many reagents to remove per bite?
	var/bite_count = 0 //How many times someone has taken a bite from this.
	consume_verb = "take a bite out of"

	reagents = /reagent_container/food/

	var/scale_sprite = TRUE

	var/remove_on_no_reagents = TRUE

	var/original_volume = 0 //For cooking and stuff.

	value = 10

/obj/item/container/food/save_item_data(var/save_inventory = TRUE)
	. = ..()
	.["original_volume"] = original_volume
	return .

/obj/item/container/food/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()
	if(object_data["original_volume"]) original_volume = object_data["original_volume"]
	return .

/obj/item/container/food/Generate()
	original_volume = reagents.volume_current
	return ..()

/obj/item/container/food/update_icon()

	if(scale_sprite)
		var/matrix/M = matrix()
		var/scale_math = max(0.5 + (original_volume/reagents.volume_max)*0.5)
		M.Scale(scale_math)
		transform = M
	else
		transform = matrix()

	return ..()


/obj/item/container/food/get_examine_list(var/mob/examiner)
	return ..() + div("notice",reagents.get_contents_english())

/obj/item/container/food/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(!is_living(object))
		return ..()

	if(can_consume(caller,object))
		PROGRESS_BAR(caller,src,SECONDS_TO_DECISECONDS(1),.proc/consume,caller,object)
		PROGRESS_BAR_CONDITIONS(caller,src,.proc/can_consume,caller,object)

	return TRUE


/obj/item/container/food/proc/get_reagents_to_eat() //Should only be called when it's about to be eaten.
	return reagents

/obj/item/container/food/proc/can_consume(var/mob/caller,var/mob/living/consumer)

	if(get_dist(caller,consumer) > 1)
		caller.to_chat("You're too far away from \the [consumer.name]!")
		return FALSE

	if(get_dist(src,consumer) > 1)
		caller.to_chat("You're too far away from \the [src.name]!")
		return FALSE

	if(remove_on_no_reagents && (!reagents || !length(reagents.stored_reagents) || reagents.volume_current <= 0))
		if(caller == consumer)
			consumer.to_chat(span("warning","There is nothing left of \the [src.name] to [consume_verb]!"))
		else
			caller.to_chat(span("warning","There is nothing left of \the [src.name] for \the [consumer.name] to [consume_verb]!"))
		qdel(src)
		return FALSE

	if(is_advanced(consumer))
		var/mob/living/advanced/A = consumer
		if(!A.labeled_organs[BODY_STOMACH])
			consumer.to_chat(span("warning","You don't know how you can [consume_verb] \the [src]!"))
			return FALSE

	return TRUE




/obj/item/container/food/consume(var/mob/caller,var/mob/living/consumer)

	var/reagent_container/reagents_to_consume = get_reagents_to_eat()

	var/final_flavor_text = reagents_to_consume.get_flavor()

	if(final_flavor_text && (consumer.last_flavor_time + SECONDS_TO_DECISECONDS(3) <= world.time || consumer.last_flavor != final_flavor_text) )
		consumer.last_flavor = final_flavor_text
		consumer.last_flavor_time = world.time
		final_flavor_text = "You taste [final_flavor_text]."
	else
		final_flavor_text = null

	consumer.to_chat(span("notice","You [consume_verb] \the [src.name]."))

	if(final_flavor_text)
		consumer.to_chat(span("notice",final_flavor_text))

	bite_count += 1

	var/reagent_container/reagents_to_transfer_to

	if(is_advanced(consumer))
		var/mob/living/advanced/A = consumer
		if(A.labeled_organs[BODY_STOMACH] && A.labeled_organs[BODY_STOMACH].reagents)
			reagents_to_transfer_to = A.labeled_organs[BODY_STOMACH].reagents

	var/returning = reagents_to_consume.transfer_reagents_to(reagents_to_transfer_to,bite_size)

	if(remove_on_no_reagents && (!reagents || !length(reagents.stored_reagents) || reagents.volume_current <= 0))
		consumer.to_chat(span("notice","You finish eating \the [src.name]."))
		qdel(src)

	return returning