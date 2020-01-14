//Medicine like band-aids and the such.

/obj/item/container/medicine
	name = "medicine"
	desc = "For when you have a boo-boo."
	desc_extended = "Apply to your wounds or damaged limbs to treat."
	icon = 'icons/obj/items/medicine.dmi'

	var/heal_brute = 0
	var/heal_burn = 0

	var/verb_to_use = "treat"

	var/treatment_time = 5

	item_count_current = 5
	item_count_max = 10

	var/icon_state_max = 3

	reagents = /reagent_container/medicine

	var/override_icon_state = FALSE



/obj/item/container/medicine/New(var/desired_loc)

	. = ..()

	if(reagents)
		reagents.volume_max = item_count_current*10

	return .

/obj/item/container/medicine/update_icon()

	if(!override_icon_state)
		icon = initial(icon)
		icon_state = "[initial(icon_state)]_[Clamp(item_count_current,1,icon_state_max)]"

	return ..()

/obj/item/container/medicine/proc/treat_organ(var/mob/caller,var/obj/item/organ/O)

	if(heal_brute)
		O.health.adjust_brute_loss(-heal_brute)

	if(heal_burn)
		O.health.adjust_burn_loss(-heal_burn)

	if(heal_brute || heal_burn)
		O.health.update_health()

	var/reagent_transfer = ceiling((1/item_count_max)*reagents.volume_current)
	reagents.transfer_reagents_to(O.reagents,reagent_transfer)
	reagents.volume_max = item_count_current*10

	if(caller == O.loc)
		caller.visible_message("\The [caller.name] bandages their [O.name].")
	else
		caller.visible_message("\The [caller.name] bandages \the [O.loc.name]'s [O.name].")

	item_count_current--

	if(item_count_current <= 0)
		qdel(src)

	update_icon()

	return TRUE

/obj/item/container/medicine/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(get_dist(caller,object) > 1)
		return FALSE

	if(is_advanced(object) && is_advanced(caller))
		var/mob/living/advanced/victim = object
		var/mob/living/advanced/attacker = caller
		var/obj/item/organ/O = victim.get_object_to_damage(attacker,params)

		if(!O || !O.health)
			return TRUE

		caller.to_chat(span("notice","You begin to [verb_to_use] [caller == object ? "your" : "\the [object]'s"] [O.name] with \the [src.name]."))

		var/list/callback_list = list()
		callback_list["target"] = O
		callback_list["target_start_turf"] = get_turf(O)
		callback_list["object"] = src
		callback_list["start_turf"] = get_turf(src)
		add_progress_bar(attacker,"medicine",treatment_time,callback_list)
		return TRUE
