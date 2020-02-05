/obj/item/container/syringe
	name = "syringe"
	desc = "For the mad scientist in all of us."
	desc_extended = "Holds reagents. Can be toggled to inject or draw."
	crafting_id = "syringe"

	icon = 'icons/obj/items/container/syringe.dmi'
	icon_state = "syringe"

	var/consume_verb = "drink out of"

	reagents = /reagent_container/syringe/

	var/icon_count = 7

	var/inject_amount = 15
	var/draw_amount = 15

	var/injecting = FALSE


/obj/item/container/syringe/get_examine_text(var/mob/examiner)
	return ..() + div("notice",reagents.get_contents_english())

/obj/item/container/syringe/transfer_item(var/obj/hud/inventory/new_inventory)
	. = ..()
	update_icon()
	return .

/obj/item/container/syringe/drop_item(var/atom/desired_loc,var/pixel_x_offset = 0,var/pixel_y_offset = 0)
	. = ..()
	update_icon()
	return .

/obj/item/container/syringe/update_icon()

	icon = initial(icon)
	icon_state = initial(icon_state)

	var/num_state = ceiling(Clamp(reagents.volume_current/reagents.volume_max,0,1)*icon_count,1)

	var/icon/I = icon(icon,"[icon_state]_[num_state]")
	var/icon/I2 = icon(icon,"liquid")

	if(reagents && reagents.volume_current)
		I2.Blend(reagents.color,ICON_MULTIPLY)
		I.Blend(I2,ICON_UNDERLAY)

	if(src.loc && is_inventory(src.loc))
		var/icon/I3 = icon(icon,"action_[injecting]")
		I.Blend(I3,ICON_OVERLAY)

	icon = I

	return ..()

/obj/item/container/syringe/click_self(var/mob/caller,location,control,params)
	injecting = !injecting
	update_icon()
	return TRUE


/obj/item/container/syringe/proc/can_inject(var/mob/caller,var/atom/target)

	if(get_dist(caller,target) > 1)
		caller.to_chat("You're too far away!")
		return FALSE

	if(!target || !target.reagents)
		caller.to_chat("You can't target this!")
		return FALSE

	var/area/A = get_area(target)
	if(caller != target && A.flags_area & FLAGS_AREA_NO_DAMAGE) //TODO: IFF.
		return FALSE

	return TRUE


/obj/item/container/syringe/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(is_advanced(caller))
		var/mob/living/advanced/A = caller
		var/list/new_x_y = A.get_current_target_cords(params)
		params[PARAM_ICON_X] = new_x_y[1]
		params[PARAM_ICON_Y] = new_x_y[2]
		object = A.get_object_to_damage(caller,params)

	if(can_inject(caller,object))

		var/real_object_name = object.name

		if(is_organ(object) && is_living(object.loc))
			real_object_name = "[object.loc.name]'s [object.name]"

		var/transfer_amount = 0
		if(injecting)
			transfer_amount = inject_amount
			caller.visible_message("\The [caller.name] tries to inject \the [real_object_name] with \the [src.name]!")
		else
			caller.visible_message("\The [caller.name] tries to inject \the [real_object_name] with \the [src.name]!")
			transfer_amount = -draw_amount

		if(is_organ(object) && is_living(object.loc))
			var/mob/living/L = object.loc
			L.to_chat("You feel a tiny prick.")
		else if(is_living(object))
			var/mob/living/L = object
			L.to_chat("You feel a tiny prick.")

		PROGRESS_BAR(caller,SECONDS_TO_DECISECONDS(3),.proc/inject,caller,object,transfer_amount)
		PROGRESS_BAR_CONDITIONS(caller,.proc/can_inject,caller,object)


	return TRUE

/obj/item/container/syringe/proc/inject(var/mob/caller,var/atom/object,var/amount=5)

	if(object.reagents)
		if(amount > 0)
			var/transfer_amount = reagents.transfer_reagents_to(object.reagents,amount)
			if(transfer_amount)
				caller.to_chat(span("notice","You inject [transfer_amount] units of liquid into \the [object]."))
		else if(amount < 0)
			var/transfer_amount = object.reagents.transfer_reagents_to(reagents,-amount)
			if(transfer_amount)
				caller.to_chat(span("notice","You draw [transfer_amount] units of liquid from \the [object]."))

		return TRUE

	return ..()