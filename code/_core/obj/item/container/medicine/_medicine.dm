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

/obj/item/container/medicine/proc/treat(var/mob/caller,var/atom/A)

	if(heal_brute)
		A.health.adjust_brute_loss(-heal_brute)

	if(heal_burn)
		A.health.adjust_burn_loss(-heal_burn)

	if(heal_brute || heal_burn)
		A.health.update_health()

	var/reagent_transfer = ceiling((1/item_count_max)*reagents.volume_current)
	reagents.transfer_reagents_to(A.reagents,reagent_transfer)
	reagents.volume_max = item_count_current*10

	if(caller == A.loc)
		caller.visible_message("\The [caller.name] bandages their [A.name].")
	else
		caller.visible_message("\The [caller.name] bandages \the [A.loc.name]'s [A.name].")

	item_count_current--

	if(item_count_current <= 0)
		qdel(src)

	update_icon()

	return TRUE

/obj/item/container/medicine/proc/can_treat(var/mob/caller,var/atom/target)

	if(get_dist(caller,target) > 1)
		caller.to_chat("You're too far away!")
		return FALSE

	if(!target || !target.health)
		caller.to_chat("You cannot treat this!")
		return FALSE


	return TRUE

/obj/item/container/medicine/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	object = object.get_object_to_damage(caller,params)

	if(can_treat(caller,object))
		PROGRESS_BAR(caller,src,SECONDS_TO_DECISECONDS(1),.proc/treat,caller,object)

	return TRUE