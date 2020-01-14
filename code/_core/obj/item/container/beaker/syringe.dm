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

	var/inject_amount = 5
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


/obj/item/container/syringe/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(get_dist(caller,object) > 1)
		return FALSE

	if(is_advanced(object) && is_advanced(caller))
		var/mob/living/advanced/A = object
		var/mob/living/advanced/A2 = caller
		var/list/new_x_y = A2.get_current_target_cords(params)

		params[PARAM_ICON_X] = new_x_y[1]
		params[PARAM_ICON_Y] = new_x_y[2]

		var/obj/item/organ/O = A.get_object_to_damage(caller,params)

		if(!O || !O.reagents)
			return FALSE

		var/area/A3 = get_area(object)

		var/verb_to_use = injecting ? "inject" : "draw blood from"

		if(caller != object && A3.safe)
			caller.to_chat(span("notice","For some reason you can't bring yourself to [verb_to_use] \the [object]..."))
			return FALSE

		caller.to_chat(span("notice","You begin to [verb_to_use] \the [src.name] into [caller == object ? "your" : "\the [object]'s"] [O.name]."))

		var/list/callback_list = list()
		callback_list["target"] = O
		callback_list["target_start_turf"] = get_turf(O)
		callback_list["object"] = src
		callback_list["start_turf"] = get_turf(src)
		callback_list["injecting"] = injecting
		add_progress_bar(caller,"inject",10 + inject_amount*5,callback_list)
		return TRUE

	if(object.reagents)

		if(injecting)
			var/transfer_amount = reagents.transfer_reagents_to(object.reagents,inject_amount)
			caller.to_chat(span("notice","You inject [transfer_amount] units of liquid into \the [object]."))
		else
			var/transfer_amount = object.reagents.transfer_reagents_to(reagents,draw_amount)
			caller.to_chat(span("notice","You draw [transfer_amount] units of liquid from \the [object]."))

		return TRUE

	return ..()