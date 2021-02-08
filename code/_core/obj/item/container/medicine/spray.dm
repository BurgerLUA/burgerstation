/obj/item/container/spray
	name = "medical spray"
	desc = "Spray and Pray."
	desc_extended = "A Spray. Can be used to infuse bandages or and ointments, highening their effectiveness, or applied directly to wounds. Of course, be sure it contains a medicine, and not polytrinic acid, before you do either"

	icon = 'icons/obj/item/container/spray.dmi'
	icon_state = "spray"

	var/icon_count = 8

	var/base_color = "#FFFFFF"
	var/glass_color = "#FFFFFF"

	reagents = /reagent_container/medical_spray

	value = 5

/obj/item/container/spray/update_icon()

	icon = initial(icon)
	icon_state = initial(icon_state)

	var/icon/I = new/icon(icon,icon_state)
	I.Blend(base_color,ICON_MULTIPLY)

	var/icon/I2 = new/icon(icon,"liquid_[CEILING(clamp(reagents.volume_current/reagents.volume_max,0,1)*icon_count,1)]")
	I2.Blend(reagents.color,ICON_MULTIPLY)

	var/icon/I3 = new/icon(icon,"glass")
	I3.Blend(glass_color,ICON_MULTIPLY)

	I.Blend(I2,ICON_UNDERLAY)
	I.Blend(I3,ICON_OVERLAY)

	icon = I

	return ..()


/obj/item/container/spray/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(object.plane >= PLANE_HUD)
		return ..()

	if(is_advanced(object) && is_advanced(caller))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(2)
		var/mob/living/advanced/victim = object
		var/mob/living/advanced/attacker = caller
		var/list/new_x_y = attacker.get_current_target_cords(params)

		params[PARAM_ICON_X] = new_x_y[1]
		params[PARAM_ICON_Y] = new_x_y[2]

		var/obj/item/organ/O = victim.get_object_to_damage(attacker,src,params,TRUE,TRUE)

		if(!O || !O.health || !O.reagents)
			return TRUE

		var/reagent_transfer = min(5,reagents.volume_current)
		if(reagent_transfer <= 0)
			caller.to_chat(span("warning","\The [src.name] is empty!"))
			return TRUE

		reagents.transfer_reagents_to(O.reagents,reagent_transfer, caller = caller)

		if(caller == O.loc)
			caller.visible_message(span("notice","\The [caller.name] sprays their [O.name] with \the [src]."),span("notice","You spray your [O.name] with \the [src.name]."))
		else
			caller.visible_message(span("warning","\The [caller.name] sprays \the [O.loc.name]'s [O.name] with \the [src]."),span("notice","You spray \the [O.loc.name]'s [O.name] with \the [src.name]."))

		update_sprite()

		return TRUE


	return ..()