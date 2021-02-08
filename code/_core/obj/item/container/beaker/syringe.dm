/obj/item/container/syringe
	name = "syringe"
	desc = "For when you want to poke holes into people and get away with it."
	desc_extended = "Holds reagents. Can be toggled to inject or draw."
	crafting_id = "syringe"

	icon = 'icons/obj/item/container/syringe.dmi'
	icon_state = "syringe"

	reagents = /reagent_container/syringe/

	var/icon_count = 7

	var/inject_amount = 15
	var/draw_amount = 5

	var/injecting = FALSE

	value = 15

	//Contains special snowflake code.
	allow_reagent_transfer_to = FALSE
	allow_reagent_transfer_from = FALSE

	weight = 0.1

/obj/item/container/syringe/get_examine_list(var/mob/examiner)
	return ..() + div("notice",reagents.get_contents_english())

/obj/item/container/syringe/on_pickup(var/atom/old_location,var/obj/hud/inventory/new_location) //When the item is picked up.
	update_sprite()
	return ..()


/obj/item/container/syringe/drop_item(var/atom/desired_loc,var/pixel_x_offset = 0,var/pixel_y_offset = 0,var/silent=FALSE)
	. = ..()
	update_sprite()
	return .

/obj/item/container/syringe/update_icon()

	icon = initial(icon)
	icon_state = initial(icon_state)

	var/num_state = CEILING(clamp(reagents.volume_current/reagents.volume_max,0,1)*icon_count,1)

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
	INTERACT_CHECK
	INTERACT_DELAY(1)
	injecting = !injecting
	update_sprite()
	return TRUE

/obj/item/container/syringe/proc/can_inject(var/mob/caller,var/atom/target)

	INTERACT_CHECK_NO_DELAY(src)
	INTERACT_CHECK_NO_DELAY(target)

	if(!target.reagents)
		caller.to_chat(span("warning","You can't target \the [target.name]!"))
		return FALSE

	return TRUE

/obj/item/container/syringe/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)



	if(is_advanced(caller))
		var/mob/living/advanced/A = caller
		var/list/new_x_y = A.get_current_target_cords(params)
		params[PARAM_ICON_X] = new_x_y[1]
		params[PARAM_ICON_Y] = new_x_y[2]
		object = object.get_object_to_damage(caller,src,params,TRUE,TRUE)

	if(!object.reagents)
		return ..()

	INTERACT_CHECK
	INTERACT_CHECK_OBJECT
	INTERACT_DELAY(1)

	if(istype(object,/obj/item/container/))
		inject(caller,object,injecting ? inject_amount : -draw_amount)
		return TRUE

	if(can_inject(caller,object))

		var/self_inject = FALSE

		var/real_object_name = object.name

		if(is_organ(object) && is_living(object))
			real_object_name = "[object.name]'s [object.name]"
			if(object == caller)
				self_inject = TRUE

		var/transfer_amount = 0
		if(injecting)
			transfer_amount = inject_amount
			caller.visible_message(span("danger","\The [caller.name] tries to inject \the [real_object_name] with \the [src.name]!"),span("warning","You try to inject \the [real_object_name] with \the [src.name]."))
		else
			caller.visible_message(span("danger","\The [caller.name] tries to draw blood from \the [real_object_name] with \the [src.name]!"),span("warnning","You try to draw blood from \the [real_object_name] with \the [src.name]."))
			transfer_amount = -draw_amount

		PROGRESS_BAR(caller,src,self_inject ? BASE_INJECT_TIME_SELF : BASE_INJECT_TIME,.proc/inject,caller,object,transfer_amount)
		PROGRESS_BAR_CONDITIONS(caller,src,.proc/can_inject,caller,object)

	return TRUE

/obj/item/container/syringe/proc/inject(var/mob/caller,var/atom/object,var/amount=5)

	if(amount < 0) //Draw
		if(is_organ(object))
			if(is_living(object.loc))
				var/mob/living/L = object.loc
				L.draw_blood(caller,src,-amount)
			else
				caller.to_chat(span("warning","You can't seem to find a way to draw anything from \the [object] with \the [src]!"))
		else if(is_living(object))
			var/mob/living/L = object
			L.draw_blood(caller,src,-amount)
		else if(object.reagents)
			var/transfer_amount = object.reagents.transfer_reagents_to(reagents,-amount, caller = caller)
			if(transfer_amount)
				caller.visible_message(span("warning","\The [caller.name] draws liquid from \the [object.name]."),span("notice","You draw [transfer_amount] units of liquid from \the [object.name]."))
				return TRUE
		else
			caller.to_chat(span("warning","You can't seem to find a way to draw anything from \the [object.name] with \the [src.name]!"))

	else if(amount > 0) //Inject
		if(object.reagents)
			var/transfer_amount = reagents.transfer_reagents_to(object.reagents,amount, caller = caller)
			if(transfer_amount)
				caller.visible_message(span("warning","\The [caller.name] injects \the [src.name] into \the [object.name]."),span("notice","You inject [transfer_amount] units of liquid into \the [object.name]."))
				return TRUE
		else
			caller.to_chat(span("warning","You can't seem to find a way to inject \the [object.name] with \the [src.name]!"))

	if(is_organ(object) && is_living(object.loc))
		var/mob/living/L = object.loc
		L.to_chat(span("warning","You feel a tiny prick on your [object.name]."))
	else if(is_living(object))
		var/mob/living/L = object
		L.to_chat(span("warning","You feel a tiny prick."))

	return FALSE

/obj/item/container/syringe/epinephrine/
	name = "syringe (epinephrine)"

/obj/item/container/syringe/epinephrine/Generate()
	reagents.add_reagent(/reagent/medicine/adrenaline/epinephrine,reagents.volume_max)
	return ..()

/obj/item/container/syringe/opium/
	name = "syringe (opium)"

/obj/item/container/syringe/opium/Generate()
	reagents.add_reagent(/reagent/medicine/painkiller/opium,reagents.volume_max)
	return ..()

/obj/item/container/syringe/medipen
	name = "medipen"
	desc = "For when you want to poke holes in people and overdose them even faster than with the syringe."
	desc_extended = "Holds reagents. Can't draw and is used for quick injections. Type of contents could be seen by looking at the medipen's marker's color and guessing what does it mean."
	crafting_id = "medipen"
	icon = 'icons/obj/item/container/medipen.dmi'
	icon_state = "medipen"

	reagents = /reagent_container/syringe/medipen

	allow_reagent_transfer_to = FALSE
	allow_reagent_transfer_from = FALSE

	inject_amount = 30
	draw_amount = 0

	injecting = TRUE

	value = 30

/obj/item/container/syringe/medipen/adminomnizine
	name = "god's medipen"
	value_burgerbux = 1000

/obj/item/container/syringe/medipen/adminomnizine/Generate()
	reagents.add_reagent(/reagent/medicine/adminomnizine,reagents.volume_max)
	return ..()

/obj/item/container/syringe/medipen/bicaridine
	name = "anti-brute medipen"

/obj/item/container/syringe/medipen/bicaridine/Generate()
	reagents.add_reagent(/reagent/medicine/bicaridine_plus,reagents.volume_max)
	return ..()

/obj/item/container/syringe/medipen/kelotane
	name = "anti-burn medipen"

/obj/item/container/syringe/medipen/kelotane/Generate()
	reagents.add_reagent(/reagent/medicine/kelotane,reagents.volume_max)
	return ..()

/obj/item/container/syringe/medipen/dylovene
	name = "anti-toxin medipen"

/obj/item/container/syringe/medipen/dylovene/Generate()
	reagents.add_reagent(/reagent/medicine/dylovene,reagents.volume_max)
	return ..()

/obj/item/container/syringe/medipen/dexaline
	name = "anti-suffocation medipen"

/obj/item/container/syringe/medipen/dexaline/Generate()
	reagents.add_reagent(/reagent/medicine/dexalin,reagents.volume_max)
	return ..()

/obj/item/container/syringe/medipen/epinephrine
	name = "epipen"

/obj/item/container/syringe/medipen/epinephrine/Generate()
	reagents.add_reagent(/reagent/medicine/adrenaline/epinephrine,reagents.volume_max)
	return ..()

/obj/item/container/syringe/medipen/iron
	name = "iron medipen"

/obj/item/container/syringe/medipen/iron/Generate()
	reagents.add_reagent(/reagent/iron,reagents.volume_max)
	return ..()

