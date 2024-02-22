/obj/item/consumable/food/
	name = "food"
	desc = "FOOD!"

	var/heal_amount_health = 0
	var/heal_amount_stamina = 0
	var/heal_amount_mana = 0

	var/uses_left = 1

	var/consume_verb = "take a bite out of"

	has_quick_function = TRUE
	quick_function_type =  FLAG_QUICK_INSTANT

/obj/item/consumable/food/quick(var/mob/living/advanced/caller,var/atom/object,location,control,params)
	click_on_object(caller,caller)
	return TRUE

/obj/item/consumable/food/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(get_dist(caller,object) > 1)
		return FALSE

	if(!is_advanced(object) || !is_advanced(caller))
		return ..()

	var/mob/living/advanced/A1 = caller
	var/mob/living/advanced/A2 = object

	if(A1 == A2)
		var/list/callback_list = list()
		callback_list["object"] = src
		//callback_list["start_turf"] = get_turf(src)

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

/obj/item/consumable/food/proc/consume(var/mob/living/consumer)

	if(heal_amount_health)
		consumer.health_regen_buffer += heal_amount_health

	if(heal_amount_stamina)
		consumer.stamina_regen_buffer += heal_amount_stamina

	if(heal_amount_mana)
		consumer.mana_regen_buffer += heal_amount_mana

	consumer.update_health_element_icons(heal_amount_health,heal_amount_stamina,heal_amount_mana)

	uses_left -= 1

	if(uses_left <= 0)
		qdel(src)

	return TRUE

/obj/item/consumable/food/get_examine_text(var/mob/examiner)

	. = ..()
	if(uses_left)
		. += div("notice","It has about [uses_left] bites left.")
	if(heal_amount_health)
		. += div("notice","Health Restore: [heal_amount_health].")
	if(heal_amount_stamina)
		. += div("notice","Stamina Restore: [heal_amount_stamina].")
	if(heal_amount_mana)
		. += div("notice","Mana Restore: [heal_amount_mana].")

	