/obj/item/container/spray
	name = "medical spray"
	desc = "Spray and Pray."
	desc_extended = "A Spray. Can be used to infuse bandages or and ointments, highening their effectiveness, or applied directly to wounds. Of course, be sure it contains a medicine, and not polytrinic acid, before you do either"

	icon = 'icons/obj/item/container/spray.dmi'
	icon_state = "spray"

	var/icon_count = 8

	var/glass_color = "#FFFFFF"

	reagents = /reagent_container/spray/medical

	value = 5

/obj/item/container/spray/update_overlays()

	. = ..()

	var/image/I_liquid = new/image(initial(icon),"liquid_[CEILING(clamp(reagents.volume_current/reagents.volume_max,0,1)*icon_count,1)]")
	I_liquid.appearance_flags = RESET_COLOR
	I_liquid.color = reagents.color
	add_overlay(I_liquid)

	var/image/I_glass = new/image(icon,"glass")
	I_glass.appearance_flags = RESET_COLOR
	I_glass.color = glass_color
	add_overlay(I_glass)



/obj/item/container/spray/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(object.plane >= PLANE_HUD)
		return ..()

	if(istype(object,/obj/item/container/healing))
		var/obj/item/container/healing/M = object
		var/reagent_transfer = min(5,reagents.volume_current)
		if(reagent_transfer <= 0)
			caller.to_chat(span("warning","\The [src.name] is empty!"))
			return TRUE
		if(M.reagents.volume_current >= M.reagents.volume_max)
			caller.to_chat(span("warning","\The [M.name] is full!"))
			return TRUE
		reagents.transfer_reagents_to(M.reagents,reagent_transfer, caller = caller)
		caller.visible_message(span("warning","\The [caller.name] sprays \the [M.name] with \the [src.name], infusing it."),span("notice","You spray \the [M.name] with \the [src.name], infusing it."))
		return TRUE

	if(is_advanced(object) && is_advanced(caller))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(2)
		var/mob/living/advanced/victim = object
		var/mob/living/advanced/attacker = caller

		if(victim != attacker && reagents.contains_lethal && !allow_hostile_action(attacker.loyalty_tag,victim))
			attacker.to_chat(span("warning","Your loyalty tag prevents you from harming \the [victim.name]!"))
			return FALSE

		var/list/new_x_y = attacker.get_current_target_cords(params)

		params[PARAM_ICON_X] = new_x_y[1]
		params[PARAM_ICON_Y] = new_x_y[2]

		var/obj/item/organ/O = victim.get_object_to_damage(attacker,src,null,params,TRUE,TRUE)

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