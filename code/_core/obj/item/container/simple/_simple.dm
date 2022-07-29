/obj/item/container/simple/
	var/initial_reagent = null


/obj/item/container/simple/quick(var/mob/caller,var/atom/object,location,params)
	return try_transfer_reagents(caller,caller,location,null,params)

/obj/item/container/simple/get_consume_verb()
	return "drink" //this

/obj/item/container/simple/get_consume_sound()
	return 'sound/items/consumables/drink.ogg'

/obj/item/container/simple/get_examine_list(var/mob/examiner)
	return ..() + div("notice",reagents.get_contents_english())

/obj/item/container/simple/click_on_object(var/mob/caller,var/atom/object,location,control,params)

	if(allow_reagent_transfer_to && istype(object,/obj/item/weapon/melee))
		var/obj/item/weapon/melee/M = object
		if(!M.reagents)
			caller.to_chat(span("warning","\The [M.name] cannot be coated!"))
			return FALSE
		var/reagent_transfer = min(5,reagents.volume_current)
		if(reagent_transfer <= 0)
			caller.to_chat(span("warning","\The [src.name] is empty!"))
			return TRUE
		if(M.reagents.volume_current >= M.reagents.volume_max)
			caller.to_chat(span("warning","\The [M.name] is already coated!"))
			return TRUE
		reagents.transfer_reagents_to(M.reagents,reagent_transfer, caller = caller)
		caller.visible_message(span("warning","\The [caller.name] coats \the [M.name] with liquid from \the [src.name]."),span("notice","You carefully coat \the [M.name] with liquid from \the [src.name]."))
		return TRUE

	. = ..()

/obj/item/container/simple/click_self(var/mob/caller,location,control,params)

	if(allow_reagent_transfer_to || allow_reagent_transfer_from)
		INTERACT_CHECK
		INTERACT_DELAY(1)
		if(caller.attack_flags & CONTROL_MOD_DISARM)
			var/choice = input("How much do you want to transfer at once?","Min: 0.5 Max: [reagents.volume_max]") as null|num
			INTERACT_CHECK
			if(choice)
				transfer_amount = clamp(choice,0.5,reagents.volume_max)
				caller.to_chat(span("notice","You will now transfer [transfer_amount] units at a time with \the [src]."))
			return TRUE

		var/initial_amount = initial(transfer_amount)

		transfer_amount += initial_amount
		if(transfer_amount > reagents.volume_max)
			transfer_amount = initial_amount

		caller.to_chat(span("notice","You will now transfer [transfer_amount] units at a time with \the [src]."))

		return TRUE

	. = ..()


/obj/item/container/simple/Generate()
	. = ..()
	if(initial_reagent)
		reagents.add_reagent(initial_reagent,reagents.volume_max)
