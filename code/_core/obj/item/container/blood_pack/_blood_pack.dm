/obj/item/container/blood_pack
	name = "blood pack"
	desc = "Keep away from Vampires."
	desc_extended = "A special plastic blood pack that comes with it's own butterfly needle. Can be attached to living beings to draw or inject blood at a steady rate. Alt-Click to toggle mode."
	icon = 'icons/obj/item/container/bloodpack.dmi'
	icon_state = "regular"
	var/icon_count = 15

	var/injecting = FALSE

	var/mob/living/attached_to

/obj/item/container/blood_pack/proc/detach(var/mob/caller)
	var/turf/T = get_turf(src)
	if(caller)
		T.visible_message("\The [caller.name] detaches \the [src.name] from [attached_to.name].")
	else
		T.visible_message("\The [src.name] detaches itself from \the [attached_to.name].")
	attached_to = null
	stop_thinking(src)
	return TRUE

/obj/item/container/blood_pack/proc/attach(var/mob/caller,var/mob/living/target)
	var/turf/T = get_turf(src)
	attached_to = target
	T.visible_message("\The [caller.name] attaches \the [src.name] to \the [attached_to.name].")
	start_thinking(src)
	return TRUE

/obj/item/container/blood_pack/click_self(var/mob/caller)

	if(caller.movement_flags == MOVEMENT_WALKING)
		injecting = !injecting
		caller.to_chat(span("notice","You toggle \the [src.name] to [injecting ? "inject" : "draw"] its contents."))
	else if(attached_to)
		detach(caller)

	return TRUE

/obj/item/container/blood_pack/proc/try_attach(var/mob/caller,var/mob/living/target)

	if(!can_attach_to(caller,target))
		return FALSE

	PROGRESS_BAR(caller,src,SECONDS_TO_DECISECONDS(3),.proc/attach,caller,target)
	PROGRESS_BAR_CONDITIONS(caller,src,.proc/can_attach_to,caller,target)

	return TRUE

/obj/item/container/blood_pack/proc/can_attach_to(var/mob/caller,var/mob/living/target)

	INTERACT_CHECK
	INTERACT_CHECK_OTHER(target)

	if(!target.reagents)
		caller.to_chat(span("warning","You can't find a way to attach \the [src.name] to \the [target.name]!"))
		return FALSE

	return TRUE

/obj/item/container/blood_pack/think()

	. = ..()

	if(!attached_to || attached_to.qdeleting || get_dist(src,attached_to) > 1)
		detach()
		return FALSE

	if(reagents && reagents.volume_current)
		if(injecting)
			if(!src.reagents.transfer_reagents_to(attached_to.reagents,1))
				return FALSE
		else
			if(!attached_to.draw_blood(null,src,1))
				return FALSE

	return .


/obj/item/container/blood_pack/update_icon()

	icon = initial(icon)
	icon_state = initial(icon_state)

	var/icon/I = new/icon(icon,icon_state)
	var/icon/I2 = new/icon(icon,"liquid_[CEILING(clamp(reagents.volume_current/reagents.volume_max,0,1)*icon_count,1)]")

	I2.Blend(reagents.color,ICON_MULTIPLY)
	I.Blend(I2,ICON_UNDERLAY)

	icon = I

	return ..()