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

/obj/item/container/syringe/get_examine_list(var/mob/examiner)
	return ..() + div("notice",reagents.get_contents_english())

/obj/item/container/syringe/on_pickup(var/atom/old_location,var/obj/hud/inventory/new_location) //When the item is picked up.
	update_sprite()
	return ..()


/obj/item/container/syringe/drop_item(var/atom/desired_loc,var/pixel_x_offset = 0,var/pixel_y_offset = 0)
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
	injecting = !injecting
	update_sprite()
	return TRUE


/obj/item/container/syringe/proc/can_inject(var/mob/caller,var/atom/target)

	if(get_dist(caller,target) > 1)
		caller.to_chat("You're too far away!")
		return FALSE

	if(!target || !target.reagents)
		caller.to_chat("You can't target this!")
		return FALSE

	return TRUE


/obj/item/container/syringe/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	object = object.defer_click_on_object(location,control,params)

	if(is_inventory(object))
		return ..()

	if(istype(object,/obj/item/container/))
		inject(caller,object,injecting ? inject_amount : -draw_amount)
		return TRUE

	else if(can_inject(caller,object))

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

		PROGRESS_BAR(caller,src,SECONDS_TO_DECISECONDS(3),.proc/inject,caller,object,transfer_amount)
		PROGRESS_BAR_CONDITIONS(caller,src,.proc/can_inject,caller,object)

	return TRUE

/obj/item/container/syringe/proc/inject(var/mob/caller,var/atom/object,var/amount=5)

	if(object.reagents)
		if(amount > 0)
			var/transfer_amount = reagents.transfer_reagents_to(object.reagents,amount)
			if(transfer_amount)
				caller.to_chat(span("notice","You inject [transfer_amount] units of liquid into \the [object]."))
				return TRUE

		else if(amount < 0)
			var/transfer_amount = object.reagents.transfer_reagents_to(reagents,-amount)
			if(transfer_amount)
				caller.to_chat(span("notice","You draw [transfer_amount] units of liquid from \the [object]."))
				return TRUE

	if(is_organ(object) && is_living(object.loc))
		var/mob/living/L = object.loc
		L.to_chat("You feel a tiny prick.")
	else if(is_living(object))
		var/mob/living/L = object
		L.to_chat("You feel a tiny prick.")

	return FALSE

/obj/item/container/syringe/epinephrine/
	name = "syringe (epinephrine)"

/obj/item/container/syringe/epinephrine/Generate()
	reagents.add_reagent(/reagent/medicine/adrenaline/epinephrine,reagents.volume_max)
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

