/obj/item/container/blood_pack
	name = "blood pack"
	desc = "Keep away from Vampires."
	desc_extended = "A special plastic blood pack that comes with it's own butterfly needle. Can be attached to living beings to draw or inject blood at a steady rate. Alt-Click to toggle mode."
	icon = 'icons/obj/item/container/bloodpack.dmi'
	icon_state = "regular"
	var/icon_count = 15

	var/injecting = FALSE

	var/mob/living/attached_to

	reagents = /reagent_container/beaker/large

	var/draw_delay = 10

	value = 20

/obj/item/container/blood_pack/get_examine_list(var/mob/examiner)
	return ..() + div("notice",reagents.get_contents_english())

/obj/item/container/blood_pack/drop_item(var/atom/desired_loc,var/pixel_x_offset = 0,var/pixel_y_offset = 0,var/silent=FALSE)
	. = ..()
	update_sprite()
	return .

/obj/item/container/blood_pack/on_pickup(var/atom/old_location,var/obj/hud/inventory/new_location) //When the item is picked up.
	update_sprite()
	return ..()

/obj/item/container/blood_pack/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)



	if(is_living(object))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(1)
		var/mob/living/L = object
		if(attached_to == L)
			detach(caller)
			return TRUE
		if(attached_to) //This statement and the above is weird and I hate it.
			detach(caller)
		try_attach(caller,object)
		return TRUE

	return ..()

/obj/item/container/blood_pack/proc/detach(var/mob/caller)
	var/turf/T = get_turf(src)
	if(caller)
		T.visible_message(span("notice","\The [caller.name] detaches \the [src.name] from [attached_to.name]."))
	else
		T.visible_message(span("notice","\The [src.name] detaches itself from \the [attached_to.name]."))
	attached_to = null
	stop_thinking(src)
	update_sprite()
	return TRUE

/obj/item/container/blood_pack/proc/attach(var/mob/caller,var/mob/living/target)
	draw_delay = initial(draw_delay)
	var/turf/T = get_turf(src)
	attached_to = target
	T.visible_message(span("notice","\The [caller.name] attaches \the [src.name] to \the [attached_to.name]."),span("notice","You attach \the [src.name] to \the [attached_to.name]."))
	start_thinking(src)
	update_sprite()
	return TRUE

/obj/item/container/blood_pack/click_self(var/mob/caller)

	INTERACT_CHECK
	INTERACT_DELAY(1)

	if(caller.attack_flags & CONTROL_MOD_ALT)
		if(attached_to)
			detach(caller)
		else
			caller.to_chat(span("warning","There is nothing to detach \the [src.name] from!"))
	else
		injecting = !injecting
		caller.to_chat(span("notice","You toggle \the [src.name] to [injecting ? "inject" : "draw"] its contents."))
		update_sprite()

	return TRUE

/obj/item/container/blood_pack/proc/try_attach(var/mob/caller,var/mob/living/target)

	if(!can_attach_to(caller,target))
		return FALSE

	caller.visible_message(span("warning","\The [caller.name] begins to attach \the [src.name] to \the [target.name]..."),span("notice","You begin to attach \the [src.name] to \the [target.name]..."))

	PROGRESS_BAR(caller,src,SECONDS_TO_DECISECONDS(3),.proc/attach,caller,target)
	PROGRESS_BAR_CONDITIONS(caller,src,.proc/can_attach_to,caller,target)

	return TRUE

/obj/item/container/blood_pack/proc/can_attach_to(var/mob/caller,var/mob/living/target)

	INTERACT_CHECK_NO_DELAY(src)
	INTERACT_CHECK_NO_DELAY(target)

	if(!target.reagents)
		caller.to_chat(span("warning","You can't find a way to attach \the [src.name] to \the [target.name]!"))
		return FALSE

	return TRUE

/obj/item/container/blood_pack/think()

	. = ..()

	if(!attached_to || attached_to.qdeleting || get_dist(src,attached_to) > 1)
		detach()
		return FALSE

	if(attached_to.dead)
		return FALSE

	if(attached_to.is_afk())
		return FALSE

	if(draw_delay <= 0)
		if(reagents)
			if(injecting)
				if(!reagents.volume_current || !src.reagents.transfer_reagents_to(attached_to.reagents,1))
					return FALSE
				draw_delay = initial(draw_delay)*0.25
			else
				if(!attached_to.draw_blood(null,src,1))
					return FALSE
				draw_delay = initial(draw_delay)
	else
		draw_delay--

	return .

/obj/item/container/blood_pack/update_icon()
	icon = initial(icon)
	icon_state = "liquid_[CEILING(clamp(reagents.volume_current/reagents.volume_max,0,1)*icon_count,1)]"
	color = reagents.color
	return ..()

/obj/item/container/blood_pack/update_overlays()

	var/image/I = new/image(icon,initial(icon_state))
	I.appearance_flags = RESET_COLOR
	add_overlay(I)

	if(src.loc && is_inventory(src.loc))
		var/image/I2 = image(icon,"action_[injecting]")
		I2.appearance_flags = RESET_COLOR
		add_overlay(I2)

	return ..()

/obj/item/container/blood_pack/full


/obj/item/container/blood_pack/full/o_negative/
	name = "blood pack (O-)"

/obj/item/container/blood_pack/full/o_negative/Generate()
	reagents.add_reagent(/reagent/blood/human/o_negative,reagents.volume_max)
	return ..()

/obj/item/container/blood_pack/full/reptile/
	name = "blood pack (L)"

/obj/item/container/blood_pack/full/reptile/Generate()
	reagents.add_reagent(/reagent/blood/reptile,reagents.volume_max)
	return ..()
